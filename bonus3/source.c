#include <stdlib.h>
#include <stdio.h>

int main(int ac, char **av) {
    FILE *file;
    char buf[132];
    
    file = fopen("/home/user/end/.pass", "r");

    // inlined function
    memset(buf, 0, 132);

    if (file == NULL || ac != 2) {
        return -1;
    }

    fread(buf, 1, 66, file);
    buf[65] = '\0';

    *(buf + atoi(av[1])) = '\0';

    fread(&buf[66], 1, 65, file);

    fclose(file);

    if (!strcmp(buf, av[1])) {
        execl("/bin/sh", "sh", NULL);
    } else {
        puts(&buf[66]);
    }

    return 0;
}