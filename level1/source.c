#include <stdio.h>

void run(void) {
    fwrite("Good... Wait what?\n", 13, 1, stdout);
    system("/bin/sh");
}

int main() {
    // There's alignment of 8 bytes as well, made by 'and' instruction.
    // 64 bytes of array + 8 bytes alignment + 4 bytes saved EBP + 4 bytes EIP
    char buf[80];
    gets(&buf[16]);
    return 0;
}
