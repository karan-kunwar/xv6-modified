#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int
main(int argc, char **argv){
  if (argc < 2){
    cpd(-1);
    exit();
  }
  int i;
  for (i=1; i<argc; i++){
    cpd(atoi(argv[i]));
  }
  exit();
}
