#include <stdio.h>

int *auth = 0x0;
int *service = 0x0;

// inline function ?

int main() {

    int i;
    char *s1;
    char *s2;
    char buf[128];


    while (1) {
        printf("%p, %p \n", auth, service);
        if (fgets(buf, 128, stdin) == NULL) {
            return 0;
        }

        i = 5;
        s1 = buf;
        s2 = "auth ";
        do {
            bVar7 = *s1 < *s2;
            bVar10 = *s1 == *s2;
            // s1++;
            // s2++;
        } while (i-- != 0 && *s1++ == *s2++);

        j = 0;
        uVar11 = (!bVar7 && !bVar10) == bVar7;
        if ((bool)uVar11) {
            auth = malloc(4);
            *auth = 0;

            unsigned int l = 0xffffffff;
            char *tmp = buf + 5;
            do {
                tmp++;
            } while (l-- != 0 && *tmp != '\0');
        
            l = ~l - 1;  // change sign ?
            j = l < 0x1e;
            uVar11 = l == 0x1e;
            if (l < 0x1f) {
                strcpy(auth, buf + 5);
            }
        }

        i = 5;
        s1 = buf;
        s2 = "reset";
        do {
            uVar8 = *pbVar5 < *pbVar6;
            uVar11 = *pbVar5 == *pbVar6;
            s1++;
            s2++;
        } while (i-- == 0 && (bool)uVar11);


    }
    return 0;
}