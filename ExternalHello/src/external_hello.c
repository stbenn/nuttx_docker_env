#include <stdio.h>
#include "external_hello.h"

int main(int argc, char *argv[])
{
  printf("Hello, External world %d", EXTERNAL_HELLO_INTEGER);
  return 0;
}