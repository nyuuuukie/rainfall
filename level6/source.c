
void n(void) {
    system("/bin/cat /home/user/level7/.pass");
}

void m(void *param_1,int param_2,char *param_3,int param_4,int param_5) {
    puts("Nope");
}

void main(int ac, char **av) {
    char *dst;
    void (**ptr)(void);

    dst = malloc(64);
    ptr = malloc(4);
    *ptr = m;
    strcpy(dst, av[4]);
    (**ptr)();
}