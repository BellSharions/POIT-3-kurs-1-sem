#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <pthread.h>
#include <time.h>

int main()
{
	int i = 0;
	clock_t cl1 = clock();
	while(1)
	{
		i++;
		clock_t cl2 = clock();
		if((cl2 - cl1)/CLOCKS_PER_SEC == 2)
		{
			break;
		}
	}
	
	printf("end after 2 sec processor time: %d\n", i);
}
