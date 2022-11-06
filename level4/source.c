#include <stdio.h>

// maybe in another file;
int m;

void v(void) {
    char buf[520];
    fgets(buf, 512, stdin);
    printf(buf);
    if (m == 0x1025544) {
        system("/bin/cat /home/user/level5/.pass");
    }
}

void main() {
    v();
}