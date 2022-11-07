#include <stdio.h>

void o() {
    system("/bin/sh");
    exit(1);
}

void n(void) {
    char buf[520];
    fgets(buf, 512, stdin);
    printf(buf);
    exit(1);
}

void main() {
    n();
}