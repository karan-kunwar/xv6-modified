#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#include "processInfo.h"

int main(void)
{
  printf(1, "Total Number of Active Processes: %d\n", cgetNumProc());

  printf(1, "Maximum PID: %d\n", getMaxPid());

  printf(1, "PID\tPPID\tSIZE\tNumber of Context Switch\n");
  for(int i=1; i<=getMaxPid(); i++)
  {
      struct processInfo info;
      int pid = i;
      int c = getProcInfo(pid, &info);
      if(c == 0)  
        printf(1, "%d\t%d\t%d\t%d\n", pid, info.ppid, info.psize, info.numberContextSwitches);
  }
  
  for(int i=1; i<10; i++){
        setprio(i);
        printf(1, "Priority : %d\n", getprio());
    }
    
  exit();
}
