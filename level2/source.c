#include <stdio.h>

void p() {
    char buf[76];
    
    fflush(stdout);
    gets(buf);

    if (((unsigned int)(buf + 80) & 0xb0000000) == 0xb0000000) {
        printf("(%p)\n", buf + 80);
        exit(1);
    }
    puts(buf);
    strdup(buf);
}

int main() {
    p();
    return 0;
}