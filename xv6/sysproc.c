#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "processInfo.h"

int
sys_setprio(void){
  int n;
  if (argint(0, &n)<0) return -1;
  return setprio(n);
}

int
sys_getprio(void){
  return getprio();
}

int
sys_getProcInfo(void){
  int pid;
  struct processInfo * procInfo;
  if (argint(0, &pid)<0) return -1;
  if (argptr(1, (void *)&procInfo, sizeof(*procInfo))<0) return -1;

  return getProcInfo(pid, procInfo);
}

int
sys_getMaxPid(void){
  return getMaxPid();
}

int
sys_cgetNumProc(void){
	return cgetNumProc();
}

int
sys_cpd(void){
  int pid;
  if (argint(0, &pid)<0) return -1;
  return cpd(pid);
}

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}
