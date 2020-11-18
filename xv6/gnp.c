#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(void){
  printf(1, "No. Of Process(s) = %d\n", getNumProc());
  exit();
}
