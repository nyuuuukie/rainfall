#include <stdio.h>
#include <string.h>
#include <time.h>

char c[80];

void m(void) {
    time_t t = time(0);

    printf("%s - %d\n", c, t);
    return;
}

int main(int ac, char **av) {
    int *arr1;
    int *arr2;
    FILE *file;
    
    arr1 = (int *)malloc(8);
    arr1[0] = 1;
    arr1[1] = (int *)malloc(8); // int and int* have the same size in 32bit systems
    arr2 = (int *)malloc(8);
    arr2[0] = 2;
    arr2[1] = (int *)malloc(8);
    strcpy((char *)arr1[1], av[1]);
    strcpy((char *)arr2[1], av[2]);
    file = fopen("/home/user/level8/.pass", "r");
    fgets(c, 68, file);
    puts("~~");
    return 0;
}