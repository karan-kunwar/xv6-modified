#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#include "processInfo.h"

int main(void)
{
  printf(1,"Priority : %d\n", getprio());

  exit();
}
