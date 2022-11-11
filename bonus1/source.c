#include <string.h>
#include <stdlib.h>

int main(int ac, char **av) {
    
    int res;
    char buf[40];

    res = atoi(av[1]);

    if (res <= 9) {
        memcpy(buf, av[2], res * 4);

        if (res == 0x574f4c46) {
            execl("/bin/sh", "sh", NULL);
        }
    }

    return 0;
}