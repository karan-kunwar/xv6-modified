#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(void){
  printf(1, "Maximum Pid = %d\n", getMaxPid());
  exit();
}
