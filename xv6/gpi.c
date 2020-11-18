#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#include "processInfo.h"

int main(int argc, char *argv[]) {
	if(argc != 2) {
		printf(2, "Usage: gpi <pid>\n");
		exit();
	}
	struct processInfo *pfo = malloc(sizeof(struct processInfo));
	int pid = atoi(argv[1]);
	if(getProcInfo(pid, pfo) == -1) {
		printf(2, "Invalid Pid\n");
		exit();
	}
	printf(1, "Pid : %d\nNo. Of Context Switches : %d\nProcess Size : %d\n", pfo->ppid, pfo->numberContextSwitches, pfo->psize);
	exit();
}
