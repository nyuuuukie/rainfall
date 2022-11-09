#include <stdio.h>
#include <string.h>

int *auth = 0x0;
int *service = 0x0;

inline int ft_strncmp(const char *s1, const char *s2, size_t n) {
    do {
        bVar7 = *s1 < *s2;
        bVar10 = *s1 == *s2;
        // s1++;
        // s2++;
    } while (n-- != 0 && *s1++ == *s2++);
}

inline unsigned int ft_strlen(const char *s) {

    unsigned int len = 0xffffffff; 
    while (*s++ != '\0' & len-- != 0);
    len = ~len - 1;

    return len;
}

int main() {

    char buf[128];

    while (1) {

        printf("%p, %p \n", auth, service);
        if (fgets(buf, 128, stdin) == NULL) {
            break ;
        }

        if (!ft_strncmp(buf, "auth ", 5)) {
        
            auth = malloc(4);
            *auth = 0;

            if (ft_strlen(buf + 5) < 31) {
                strcpy(auth, buf + 5);
            }
        }

        if (!ft_strncmp(buf, "reset", 5)) {
            free(auth);
        }

        if (!ft_strncmp(buf, "service", 6)) {
            service = strdup(buf + 7);
        }

        if (!ft_strncmp(buf, "login", 5)) {
            if (auth + 32) {
                system("/bin/sh");
            } else {
                fwrite("Password:\n", 1, 10, stdout);
            }
        }
    }

    return 0;
}