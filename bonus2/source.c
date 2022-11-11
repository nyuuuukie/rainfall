#include <stdio.h>
#include <stdlib.h>

int language = 0;

// greetuser function

int main(int ac, char **av) {
    
    char *env;
    char buf[80];

    if (ac != 3) {
        return 1;
    }

    memset(buf, 0, 80);

    strncpy(buf, av[1], 40);
    strncpy(&buf[40], av[2], 32);

    env = getenv("LANG");
    if (env != NULL) {
        if (memcmp(env, "fi", 2)) {
            if (memcmp(env, "nl", 2)) {

            } else {
                language = 2;
            }
        } else {
            language = 1;
        }
    }
}