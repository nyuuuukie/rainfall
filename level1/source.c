#include <stdio.h>

void run(void) {
    fwrite("Good... Wait what?\n", 13, 1, stdout);
    system("/bin/sh");
}

int main() {
    char buf[76];
    gets(buf);
    return 0;
}