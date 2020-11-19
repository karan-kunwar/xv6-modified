#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#include "processInfo.h"

int main(int argc, char *argv[])
{
  printf(1, "PID\tPPID\tSIZE\tNumber of Context Switch\n");
  struct processInfo info;
  int pid = atoi(argv[1]);
  int c = getProcInfo(pid, &info);
  if(c == 0)
    printf(1, "%d\t%d\t%d\t%d\n", pid, info.ppid, info.psize, info.numberContextSwitches);

  exit();
}
