#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main()
{
  for(int i=0; i<100; i++)
  {
      sleep(1);
      printf("%d:  %d\n", getpid(),i);
  }
}
