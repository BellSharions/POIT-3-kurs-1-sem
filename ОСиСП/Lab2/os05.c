#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc, char **argv) 
{
	for(int i = 0; i < 1000; i++)
	{
		printf("%ld-%ld\n", (long)getpid(), (long)i);
		sleep(2);
	}
	return 0;
} 
