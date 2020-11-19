#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#include "processInfo.h"

int main(int argc, char *argv[])
{
  printf(1,"%d\n",atoi(argv[1]));
        setprio(atoi(argv[1]));

  exit();
}
