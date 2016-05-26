#include "VMapCluster.h"
#include "Config/Config.h"
#include "ByteBuffer.h"
#include "IVMapManager.h"
#include "VMapFactory.h"

#include <stdio.h>
#include <ace/Process.h>
#include <ace/OS_NS_sys_wait.h>
#include <ace/OS_NS_unistd.h>
#include <ace/Thread.h>

#include "Log.h"
#include "Util.h"
#include "GridDefines.h"

namespace VMAP
{
    int VMapClusterManager::SpawnVMapProcesses(const char* runnable, const char* cfg_file, int count)
    {
        SpawnVMapProcess(runnable, cfg_file, VMAP_CLUSTER_MANAGER_PROCESS);
        for(int i = 0; i < count; i++)
            SpawnVMapProcess(runnable, cfg_file, VMAP_CLUSTER_PROCESS, i);

        VMAP::VMapFactory::createOrGetVMapManager()->setEnableClusterComputing(true);

        ByteBuffer packet;
        packet << (uint8)(1+sizeof(pid_t));
        packet << ACE_OS::getpid();
        sLoSProxy.Init();
        sLoSProxy.Send(packet);

        return 0;
    }

    int VMapClusterManager::SpawnVMapProcess(const char* runnable, const char* cfg_file, const char* name, int32 id)
    {
        ACE_Process process;
        ACE_Process_Options options;
        if (id >= 0)
            options.command_line("%s -c \"%s\" -p %s -i %d", runnable, cfg_file, name, id);
        else
            options.command_line("%s -c \"%s\" -p %s", runnable, cfg_file, name);

        if(process.spawn(options) == -1)
            sLog.outLog(LOG_DEFAULT, "ERROR: SpawnVMapProcess: failed to create process %s with id %d because of error %d", name, id, ACE_OS::last_error());

        return 0;
    }

    VMapClusterManager::VMapClusterManager(uint32 processNumber) : m_processNumber(processNumber), m_masterPid(0)
    {
        m_coreStream.Accept(VMAP_CLUSTER_MANAGER_PROCESS);
        ByteBuffer packet = m_coreStream.RecvPacket();
        if(packet.size() != 1+sizeof(pid_t))
            sLog.outLog(LOG_DEFAULT, "ERROR: VMapClusterManager: failed to receive master pid, invalid packet size %d (%d)", packet.size(), 1+sizeof(pid_t));
        else
        {
            packet.read_skip(1);
            packet >> m_masterPid;
        }

        for(int32 i = 0; i < processNumber; i++)
        {
            packet.rpos(0);
            LoSProcess* process = new LoSProcess();
            process->GetOutPipe()->Connect(VMAP_CLUSTER_PROCESS, (int32*)&i);
            process->GetInPipe()->Accept(VMAP_CLUSTER_PROCESS_REPLY, (int32*)&i);
            process->GetOutPipe()->SendPacket(packet);
            m_losProcess.push_back(process);
        }
    }


    VMapClusterManager::~VMapClusterManager()
    {
        while(!m_losProcess.empty())
        {
            delete m_losProcess.front();
            m_losProcess.pop_front();
        }

        while(!m_callbackStreams.empty())
        {
            ThreadSendCallback::iterator it = m_callbackStreams.begin();
            delete (*it).second;
            m_callbackStreams.erase(it);
        }
    }

    LoSProcess* VMapClusterManager::FindProcess()
    {
        Guard g(m_processLock);
        if(!g.locked())
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: FindProcess: failed to aquire lock");
            return NULL;
        }
        std::list<LoSProcess*>::iterator it;
        for(it = m_losProcess.begin(); it != m_losProcess.end(); ++it)
        {
            if(!(*it)->InUse())
            {
                (*it)->SetInUse(true);
                return *it;
            }
        }
        return NULL;
    }

    SendPipeWrapper* VMapClusterManager::GetCallbackPipe(ACE_thread_t tid)
    {
        ThreadSendCallback::iterator it = m_callbackStreams.find(tid);
        if (it == m_callbackStreams.end())
        {
            SendPipeWrapper *pipe = new SendPipeWrapper();
            pipe->Connect(VMAP_CLUSTER_MANAGER_CALLBACK, (int32*)&tid);
            m_callbackStreams.insert(ThreadSendCallback::value_type(tid, pipe));
            return pipe;
        } else
            return (*it).second;

    }

    int VMapClusterManager::Start()
    {
        sLog.outString("VMapClusterManager process started");
        ACE_thread_t tids[100];
        ACE_hthread_t htids[100];

        int n = ACE_Thread::spawn_n(tids, m_processNumber, &VMapClusterManager::RunThread, this, THR_NEW_LWP|THR_JOINABLE, 0, 0, 0, htids);
        if(n != m_processNumber)
            sLog.outLog(LOG_DEFAULT, "ERROR: VMapClusterManager::Start(): started only %d out of %d threads because of error %d", n, m_processNumber, ACE_OS::last_error());

        if (m_masterPid)    // end when master ends
        {
            WAIT(m_masterPid);
            for(int i = 0; i < n; i++)
                ACE_Thread::cancel(tids[i]);
        }
        else // no master, just wait for threads to finish
        {
            for(int i = 0; i < n; i++)
                if(ACE_Thread::join(htids[i]) == -1)
                    sLog.outLog(LOG_DEFAULT, "ERROR: VMapClusterManager::Start(): failed to join thread id=%d tid=%d because of error %d", i, tids[i], ACE_OS::last_error());
        }

        return 0;
    }

    ACE_THR_FUNC_RETURN VMapClusterManager::RunThread(void *param)
    {
        ((VMapClusterManager*)param)->Run();

        return (ACE_THR_FUNC_RETURN)0;
    }

    void VMapClusterManager::SendFailCode(ACE_thread_t tid)
    {
        ByteBuffer packet;
        packet << (uint8)2;
        packet << (uint8)2;
        SendPipeWrapper *pipe = GetCallbackPipe(tid);
        pipe->SendPacket(packet);
    }

    void VMapClusterManager::Run()
    {
        ACE_thread_t tid;
        SendPipeWrapper *pipe;
        LoSProcess *process;
        ByteBuffer packet;
        while(true)
        {
            packet = m_coreStream.RecvPacket();
            if(m_coreStream.Eof())
                return;

            if (packet.size() != 1+4+4+sizeof(float)*6)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: VMapClusterManager::Run(): received packet with invalid size %d (%d)", packet.size(),  1+4+4+sizeof(float)*6);
                return;
            }
            packet.read_skip<uint8>();
            tid = packet.read<uint32>();

            packet.rpos(0);
            process = FindProcess();
            if(!process)
            {
                SendFailCode(tid);
                sLog.outLog(LOG_DEFAULT, "ERROR: VMapClusterManager::Run(): failed to find free vmap process", packet.size());
                return;
            }

            process->GetOutPipe()->SendPacket(packet);
            ACE_Thread::yield();

            packet = process->GetInPipe()->RecvPacket();
            process->SetInUse(false);

            if(process->GetInPipe()->Eof())
            {
                SendFailCode(tid);
                return;
            }
            if(packet.size() != 2)
            {
                SendFailCode(tid);
                sLog.outLog(LOG_DEFAULT, "ERROR: VMapClusterManager::Run(): received packet with invalid size %d (2)", packet.size());
                return;
            }

            pipe = GetCallbackPipe(tid);
            pipe->SendPacket(packet);
        }
        return;
    }

    VMapClusterProcess::VMapClusterProcess(uint32 processId) : m_processId(processId), m_masterPid(0)
    {
        // data path for vmaps loading
        m_dataPath = sConfig.GetStringDefault("DataDir","./");
        if (m_dataPath.at(m_dataPath.length()-1)!='/' && m_dataPath.at(m_dataPath.length()-1)!='\\')
            m_dataPath.append("/");

        m_inPipe.Accept(VMAP_CLUSTER_PROCESS, (int32*)&processId);
        m_outPipe.Connect(VMAP_CLUSTER_PROCESS_REPLY, (int32*)&processId);
        ByteBuffer packet = m_inPipe.RecvPacket();
        if(packet.size() != 1+sizeof(pid_t))
            sLog.outLog(LOG_DEFAULT, "ERROR: VMapClusterProcess: failed to receive master pid, invalid packet size %d (%d)", packet.size(), 1+sizeof(pid_t));
        else
        {
            packet.read_skip(1);
            packet >> m_masterPid;
        }
    }

    VMapClusterProcess::~VMapClusterProcess()
    {
        while(!m_gridLoaded.empty())
        {
            GridLoadedMap::iterator it = m_gridLoaded.begin();
            delete [] (*it).second;
            m_gridLoaded.erase(it);
        }
    }

    void VMapClusterProcess::EnsureVMapLoaded(uint32 mapId, float x, float y)
    {
        VMAP::IVMapManager *vMapManager = VMAP::VMapFactory::createOrGetVMapManager();
        GridLoadedMap::iterator it = m_gridLoaded.find(mapId);
        bool *grid;
        if (it == m_gridLoaded.end())
        {
            grid = new bool[MAX_NUMBER_OF_GRIDS*MAX_NUMBER_OF_GRIDS];
            for(int i = 0; i < MAX_NUMBER_OF_GRIDS*MAX_NUMBER_OF_GRIDS; i++)
                grid[i] = false;
            m_gridLoaded.insert(GridLoadedMap::value_type(mapId, grid));
        }
        else
            grid = it->second;

        GridPair p = Looking4group::ComputeGridPair(x, y);
        if (!grid[p.y_coord*MAX_NUMBER_OF_GRIDS+p.x_coord])
        {
            int gx = (MAX_NUMBER_OF_GRIDS - 1) - p.x_coord;
            int gy = (MAX_NUMBER_OF_GRIDS - 1) - p.y_coord;
            VMAPLoadResult res = vMapManager->loadMap((m_dataPath + "vmaps").c_str(),  mapId, gx, gy);
            grid[p.y_coord*MAX_NUMBER_OF_GRIDS+p.x_coord] = true;
        }

    }

    ACE_THR_FUNC_RETURN VMapClusterProcess::RunThread(void* arg)
    {
        ((VMapClusterProcess*)arg)->Run();

        return (ACE_THR_FUNC_RETURN)0;
    }

    int VMapClusterProcess::Start()
    {
        sLog.outString("VMapClusterProcess process no %d started", m_processId);
        ACE_thread_t tid;
        ACE_hthread_t htid;
        if(ACE_Thread::spawn(&VMapClusterProcess::RunThread, this, THR_NEW_LWP|THR_JOINABLE, &tid, &htid) == -1)
            sLog.outLog(LOG_DEFAULT, "ERROR: VMapClusterProcess::Start(): failed to start thread because of error %d", ACE_OS::last_error());

        if (m_masterPid)    // end when master ends
        {
            WAIT(m_masterPid);
            ACE_Thread::cancel(tid);
        }
        else // no master, just wait for thread to finish
        {
            if(ACE_Thread::join(htid) == -1)
                sLog.outLog(LOG_DEFAULT, "ERROR: VMapClusterProcess::Start(): failed to join thread because of error %d",  ACE_OS::last_error());
        }

        return 0;
    }

    int VMapClusterProcess::Run()
    {
        ByteBuffer packet;
        uint32 mapId;
        float x1, y1, z1, x2, y2, z2;

        IVMapManager* vMapManager = VMapFactory::createOrGetVMapManager();

        while(true)
        {
            packet = m_inPipe.RecvPacket();
            if(m_inPipe.Eof())
                return 0;
            if(packet.size() != 1+4+4+sizeof(float)*6)
            {
                sLog.outLog(LOG_DEFAULT, "ERROR: VMapClusterProcess::Run(): received packet with invalid size %d (%d)", packet.size(), 1+4+4+sizeof(float)*6);
                return 0;
            }
            packet.read_skip(1+4);
            packet >> mapId >> x1 >> y1 >> z1 >> x2 >> y2 >> z2;

            char buff[20];
            sprintf(buff, "%d", mapId);

            EnsureVMapLoaded(mapId, x1, y1);
            EnsureVMapLoaded(mapId, x2, y2);
            EnsureVMapLoaded(mapId, x2, y1);
            EnsureVMapLoaded(mapId, x1, y2);
            bool res = vMapManager->isInLineOfSight2(mapId, x1, y1, z1, x2, y2, z2);

            packet.clear();
            packet << (uint8)2;
            packet << (uint8)res;
            m_outPipe.SendPacket(packet);
        }
        return 0;
    }

    LoSProxy::~LoSProxy()
    {
        for(ThreadRecvCallback::iterator it = m_callbacks.begin(); it != m_callbacks.end(); ++it)
            delete (*it).second;
    }

    void LoSProxy::Init()
    {
        m_requester.Connect(VMAP_CLUSTER_MANAGER_PROCESS);
    }

    bool LoSProxy::isInLineOfSight(unsigned int pMapId, float x1, float y1, float z1, float x2, float y2, float z2)
    {
        ACE_thread_t tid = ACE_Thread::self();

        ByteBuffer packet;
        packet << (uint8)(1+4+4+sizeof(float)*6);
        packet << (int32)tid;
        packet << (uint32)pMapId;
        packet << x1 << y1 << z1 << x2 << y2 << z2;

        m_requester.SendPacket(packet);

        RecvPipeWrapper *pipe;
        {
            Guard g(m_lock);
            if(!g.locked())
                 sLog.outLog(LOG_DEFAULT, "ERROR: LoSProxy::isInLineOfSight: failed to aquire callback lock, unintended bahaviour possible\n");
            ThreadRecvCallback::iterator it = m_callbacks.find(tid);
            if (it == m_callbacks.end())
            {
                pipe = new RecvPipeWrapper();
                pipe->Accept(VMAP_CLUSTER_MANAGER_CALLBACK, (int32*)&tid);
                m_callbacks.insert(ThreadRecvCallback::value_type(tid, pipe));
            } else
                pipe = (*it).second;
        }

        packet = pipe->RecvPacket();
        uint8 response;
        if (packet.size() != 2)
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: LoSProxy::isInLineOfSight: received packet with invalid size %d (2)", packet.size());
            response = 2;
        }
        else
        {
            packet.read_skip(1);
            packet >> response;
        }

        if (response == 2)
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: LoSProxy::isInLineOfSight: cluster failed to check line of sight, checking locally");
            return VMapFactory::createOrGetVMapManager()->isInLineOfSight2(pMapId, x1, y1, z1, x2, y2, z2);
        }
        return response;
    }

    void LoSProxy::Send(ByteBuffer &packet)
    {
        m_requester.SendPacket(packet);
    }
}
