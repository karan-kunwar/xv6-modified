#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int
main(int argc, char **argv){
	int numProc = cgetNumProc();
	printf(1, "%d\n", numProc);
	exit();
}
