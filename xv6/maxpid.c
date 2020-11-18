#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#include "processInfo.h"

int main(void)
{

  printf(1, "Maximum PID: %d\n", getMaxPid());

  exit();
}
