#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#include "processInfo.h"

int main(void)
{
  printf(1, "Total Number of Active Processes: %d\n", cgetNumProc());

  exit();
}
