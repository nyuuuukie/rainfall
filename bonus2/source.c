#include <stdio.h>
#include <stdlib.h>

int language = 0;

struct s_arg {
    char buf[76];
};

void greetuser(struct s_arg arg) {
    
    char buf[72];

    if (language == 1) {
        strcpy(buf, "Hyvää päivää ");
    } else if (language == 2) {
        strcpy(buf, "Goedemiddag! ");
    } else if (language == 0) {
        strcpy(buf, "Hello ");
    }

    strcat(buf, arg.buf);
    puts(buf);
}

int main(int ac, char **av) {
    
    char *env;
    struct s_arg arg;

    if (ac != 3) {
        return 1;
    }

    memset(arg.buf, 0, 76);

    strncpy(arg.buf, av[1], 40);
    strncpy(&(arg.buf[40]), av[2], 32);

    env = getenv("LANG");
    if (env != NULL) {
        if (!memcmp(env, "fi", 2)) {
            language = 1;
        }
        if (!memcmp(env, "nl", 2)) {
            language = 2;
        }
    }

    greetuser(arg);

    return 0;
}