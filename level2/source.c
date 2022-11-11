#include <stdio.h>

void p() {
    char buf[76];
    
    fflush(stdout);
    gets(buf);

    unsigned int ret = buf + 80;
    if (ret & 0xb0000000 == 0xb0000000) {
        printf("(%p)\n", ret);
        exit(1);
    }
    puts(buf);
    strdup(buf);
}

int main() {
    p();
    return 0;
}