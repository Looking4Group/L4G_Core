#ifndef _M_DELAY_EXECUTOR_H
#define    _M_DELAY_EXECUTOR_H

#include <ace/Task.h>
#include <ace/Activation_Queue.h>
#include <ace/Method_Request.h>

class DelayExecutor : protected ACE_Task_Base
{
public:
  DelayExecutor();
  virtual ~DelayExecutor();

  static DelayExecutor* instance();

  /// example
  /// DelayExecutor::instance ()->execute(new MyRequest(myarg));
  /// returns -1 on failures
  int execute(ACE_Method_Request* new_req);

  int activate(int num_threads = 1,
                ACE_Method_Request* pre_svc_hook = NULL,
                ACE_Method_Request* post_svc_hook = NULL);

  int deactivate();

  bool activated();

  virtual int svc(void);
private:
  ACE_Activation_Queue queue_;
  ACE_Method_Request* pre_svc_hook_;
  ACE_Method_Request* post_svc_hook_;

  void activated(bool s);
  bool activated_;
};

#endif // _M_DELAY_EXECUTOR_H