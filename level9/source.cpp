#include <stdlib.h>
#include <string.h>

struct N {

    int (N::*ptr)(const N &);
    char buf[100];
    int num;

    N(int n) {
        num = n;
        ptr = &N::operator+;
    }

    void setAnnotation(char *arg) {
        memcpy(buf, arg, strlen(arg));
    }

    int operator+(const N &other) {
        return num + other.num;
    }

    int operator-(const N &other) {
        return num - other.num;
    }
};

int main(int ac, char **av) {

    if (ac <= 1) {
        exit(1);
    }

    N *n1 = new N(5);
    N *n2 = new N(6);

    n1->setAnnotation(av[1]);

    (n2->*(n2->ptr))(*n1);

    return 0;
}