#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>

#include <openssl/rand.h>

static void dump_random(void)
{
    int i;
    unsigned char buf[4];

    //does the 'trick'
    memset(buf, 0, sizeof(buf));
    
    RAND_bytes(buf, sizeof(buf));
    printf("pid=%d ", getpid());
    for (i = 0; i < sizeof(buf); i++)
	printf("\\x%02x", buf[i]);
    puts("");
}

int main(void)
{
    pid_t pid, xpid;

    /* PRNG needs to be initialized in original process to reproduce */
    RAND_bytes((unsigned char *)&pid, sizeof(pid));

    pid = fork();
    if (pid == 0) {
	dump_random();
	return 0;
    } else if (pid > 0) {
	wait(NULL);

	do {
	    xpid = fork();
	    if (xpid == 0) {
		if (getpid() == pid) {
		    dump_random();
		}
		return 0;
	    } else if (xpid > 0) {
		wait(NULL);
	    } else {
		perror("fork");
	    }
	} while (pid != xpid);
    } else {
	perror("fork");
	return 1;
    }

    return 0;
}
