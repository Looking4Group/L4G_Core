#include "PipeWrapper.h"
#include "Config/Config.h"
#include "Log.h"

#include <ace/OS_NS_unistd.h>

namespace VMAP
{
    template<>
    void _SendPipeWrapper<ACE_SPIPE_Stream>::Connect(const char* name, int32 *id)
    {
        if(m_connected)
            return;

        ACE_SPIPE_Addr addr;
        if (id)
        {
            char addr_buf[50];
            sprintf(addr_buf, "%s_%u", name, *id);
            addr.set(addr_buf);
        }
        else
            addr.set(name);

        ACE_SPIPE_Connector connetor = ACE_SPIPE_Connector();


        m_stream = new ACE_SPIPE_Stream();

        // block until connected
        while(true)
        {
            if (connetor.connect(*m_stream, addr) == -1)
            {
                if(ACE_OS::last_error() != ERROR_CONNECT_NO_PIPE)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: Connect: failed to connect to stream %s because of error %d", addr.get_path_name(), ACE_OS::last_error());
                    return;
                }
            }
            else
            {
                m_connected = true;
                return;
            }
            ACE_Thread::yield();
        }
    }

    template<>
    void _SendPipeWrapper<ACE_FIFO_Send>::Connect(const char* name, int32 *id)
    {
        if(m_connected)
            return;

        char addr_buf[50];
        if (id)
            sprintf(addr_buf, "%s_%u", name, *id);
        else
            sprintf(addr_buf, "%s", name);



        m_stream = new ACE_FIFO_Send();
        while(true)
        {

            if(m_stream->open(addr_buf) == -1)
            {
                if(ACE_OS::last_error() != ERROR_CONNECT_NO_PIPE)
                {
                    sLog.outLog(LOG_DEFAULT, "ERROR: Connect: failed to connect to stream %s because of error %d", addr_buf, ACE_OS::last_error());
                    delete m_stream;
                    m_stream = 0;
                }

            }
            else
            {
                m_connected = true;
                return;
            }
            ACE_Thread::yield();
        }
    }

    template<>
    void _RecvPipeWrapper<ACE_SPIPE_Stream>::Accept(const char* name, int32 *id)
    {
        if(m_connected)
            return;

        ACE_SPIPE_Addr addr;
        if (id)
        {
            char addr_buf[50];
            sprintf(addr_buf, "%s_%u", name, *id);
            addr.set(addr_buf);
        }
        else
            addr.set(name);

        m_stream = new ACE_SPIPE_Stream();

        ACE_SPIPE_Acceptor acceptor = ACE_SPIPE_Acceptor(addr);
        if(acceptor.accept(*m_stream) == -1)
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Accept: failed to accept on stream %s becaus of error %d", addr.get_path_name(), ACE_OS::last_error());
            delete m_stream;
            m_stream = 0;
        }
        else
            m_connected = true;
    }

    template<>
    void _RecvPipeWrapper<ACE_FIFO_Recv>::Accept(const char *name, int32 *id)
    {
        if(m_connected)
            return;

        char addr_buf[50];
        if (id)
            sprintf(addr_buf, "%s_%u", name, *id);
        else
            sprintf(addr_buf, "%s", name);

        m_stream = new ACE_FIFO_Recv();

        if(m_stream->open(addr_buf) == -1)
        {
            sLog.outLog(LOG_DEFAULT, "ERROR: Connect: failed to accept to stream %s because of error %d", addr_buf, ACE_OS::last_error());
            delete m_stream;
            m_stream = 0;
        }
        m_connected = true;
    }

    MultiProcessLog::MultiProcessLog() : m_logFile(NULL)
    {
        std::string logsDir = sConfig.GetStringDefault("LogsDir","");
        if(!logsDir.empty())
        {
            if((logsDir.at(logsDir.length()-1)!='/') && (logsDir.at(logsDir.length()-1)!='\\'))
                logsDir.append("/");
        }

        std::string logfn = sConfig.GetStringDefault("LogFile", "");
        if(logfn.empty())
            return;

        std::stringstream postfix;
        postfix << "_" << ACE_OS::getpid();

        if(sConfig.GetBoolDefault("LogTimestamp",false))
            postfix << "_" << Log::GetTimestampStr();

        size_t dot_pos = logfn.find_last_of(".");
        if(dot_pos != logfn.npos)
            logfn.insert(dot_pos, postfix.str());
        else
            logfn += postfix.str();

        m_logFile = fopen((logsDir+logfn).c_str(), "w");

        m_includeTime  = sConfig.GetBoolDefault("LogTime", false);
    }

    MultiProcessLog::~MultiProcessLog()
    {
        if(m_logFile)
            fclose(m_logFile);
    }

    void MultiProcessLog::outString(const char *str, ...)
    {
        if( !str )
            return;

        UTF8PRINTF(stdout,str,);
        printf( "\n" );

        if(m_logFile)
        {
            Log::outTimestamp(m_logFile);

            va_list ap;
            va_start(ap, str);
            vfprintf(m_logFile, str, ap);
            fprintf(m_logFile, "\n" );
            va_end(ap);

            fflush(m_logFile);
        }
        fflush(stdout);
    }

    void MultiProcessLog::outError(const char *str, ...)
    {
        if( !str )
            return;

        UTF8PRINTF(stdout,str,);
        printf( "\n" );

        if(m_logFile)
        {
            Log::outTimestamp(m_logFile);
            fprintf(m_logFile, "ERROR:" );

            va_list ap;
            va_start(ap, str);
            vfprintf(m_logFile, str, ap);
            va_end(ap);

            fprintf(m_logFile, "\n" );
            fflush(m_logFile);
        }
    }
}

