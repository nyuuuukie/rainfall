#include <string.h>
#include <stdio.h>
#include <unistd.h>

int main(int ac, char **av) {

    int num = atoi(av[1]);
    if (num == 423) {
        char *s = strdup("/bin/sh");
        gid_t gid = getegid();
        uid_t uid = geteuid();
        setresgid(gid, gid, gid);
        setresuid(uid, uid, uid);
        execv("/bin/sh", &s);
    } else {
        fwrite("No !\n", 1, 5, (FILE *)stderr);
    }
    return 0;
}