#include <stdio.h>
#include <string.h>

inline unsigned int ft_strlen(const char *s) {

    unsigned int len = 0xffffffff; 
    while (*s++ != '\0' & len-- != 0);
    len = ~len - 1;

    return len;
}

void p(char *s1, char *s2) {

    char *match;
    char buf[4104];

    puts(s2);
    read(0, buf, 4096);
    match = strchr(buf, '\n');
    * match = '\0';
    strncpy(s1, buf, 20);
}

void pp(char *str) {

    char buf1[20];
    char buf2[28];

    p(buf1, " - ");
    p(buf2, " - ");

    strcpy(str, buf1);

    str += ft_strlen(str);
    *str = ' ';
    *(str + 1) = '\0';

    strcat(str, buf2);
}


int main() {
    char buf[42];

    pp(buf);
    puts(buf);

    return 0;
}