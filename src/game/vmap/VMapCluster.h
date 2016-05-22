#ifndef _VMAPCLUSTER_H
#define _VMAPCLUSTER_H

#include "PipeWrapper.h"
#include "Common.h"

#define VMAP_CLUSTER_PREFIX                 "VMAP_CLUSTER_"
#define VMAP_CLUSTER_MANAGER_PROCESS        VMAP_CLUSTER_PREFIX"MANAGER"
#define VMAP_CLUSTER_PROCESS                VMAP_CLUSTER_PREFIX"PROCESS"
#define VMAP_CLUSTER_PROCESS_REPLY          VMAP_CLUSTER_PREFIX"PROCESS_R"
#define VMAP_CLUSTER_MANAGER_CALLBACK       VMAP_CLUSTER_PREFIX"CALLBACK"

#if PLATFORM == PLATFORM_WINDOWS
#define WAIT(pid) ACE_OS::wait((pid), 0, 0, 0)
#else
#define WAIT(pid) while(true) { if(kill(pid, 0)==-1) if(ACE_OS::last_error() == ESRCH) break; ACE_OS::sleep(1); }
#endif

#define sLoSProxy (*ACE_Singleton<VMAP::LoSProxy, ACE_Null_Mutex>::instance())

namespace VMAP
{
    class LoSProcess
    {
    public:
        explicit LoSProcess() : m_inUse(false) {}

        RecvPipeWrapper* GetInPipe() { return &m_inPipe; }
        SendPipeWrapper* GetOutPipe() { return &m_outPipe; }

        void SetInUse(bool inUse) { m_inUse = inUse; }
        bool InUse() { return m_inUse; }

    private:
        RecvPipeWrapper m_inPipe;
        SendPipeWrapper m_outPipe;
        bool m_inUse;

    };

    typedef UNORDERED_MAP<ACE_thread_t, SendPipeWrapper*> ThreadSendCallback;
    typedef UNORDERED_MAP<ACE_thread_t, RecvPipeWrapper*> ThreadRecvCallback;

    class LoSProxy
    {
    public:
        explicit LoSProxy() {}
        ~LoSProxy();

        bool isInLineOfSight(unsigned int pMapId, float x1, float y1, float z1, float x2, float y2, float z2);
        void Send(ByteBuffer &packet);
        void Init();

    private:
        ThreadRecvCallback m_callbacks;
        SynchronizedSendPipeWrapper m_requester;
        LockType m_lock;
    };

    class VMapClusterManager
    {
    public:
        explicit VMapClusterManager(uint32 processNumber);
        ~VMapClusterManager();

        int Start();

        static int SpawnVMapProcesses(const char* runnable, const char* cfg_file, int count);

    private:
        uint32 m_processNumber;
        pid_t m_masterPid;

        SynchronizedRecvPipeWrapper m_coreStream;
        std::list<LoSProcess*> m_losProcess;
        ThreadSendCallback m_callbackStreams;

        LockType m_processLock;

        LoSProcess* FindProcess();
        SendPipeWrapper* GetCallbackPipe(ACE_thread_t tid);

        void SendFailCode(ACE_thread_t tid);

        void Run();
        static ACE_THR_FUNC_RETURN RunThread(void *arg);
        static int SpawnVMapProcess(const char* runnable, const char* cfg_file, const char* name, int32 id = -1);
    };

    typedef UNORDERED_MAP<uint32, bool*> GridLoadedMap;

    class VMapClusterProcess
    {
    public:
        explicit VMapClusterProcess(uint32 processId);
        ~VMapClusterProcess();

        int Start();
        void EnsureVMapLoaded(uint32 mapId, float x, float y);

    private:
        uint32 m_processId;
        RecvPipeWrapper m_inPipe;
        SendPipeWrapper m_outPipe;
        GridLoadedMap m_gridLoaded;
        std::string m_dataPath;
        pid_t m_masterPid;

        int Run();
        static ACE_THR_FUNC_RETURN RunThread(void *arg);
    };
}

#endif
