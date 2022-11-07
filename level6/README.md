# level6

## Header

```bash
ssh level6@192.168.64.9 -p 4242
...
  GCC stack protector support:            Enabled
  Strict user copy checks:                Disabled
  Restrict /dev/mem access:               Enabled
  Restrict /dev/kmem access:              Enabled
  grsecurity / PaX: No GRKERNSEC
  Kernel Heap Hardening: No KERNHEAP
 System-wide ASLR (kernel.randomize_va_space): Off (Setting: 0)
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/level6/level6
```

<hr>

## Solution

(gdb) b *0x080484a5
Breakpoint 1 at 0x80484a5
(gdb) r
The program being debugged has been started already.
Start it from the beginning? (y or n) y
Starting program: /home/user/level6/level6 < /tmp/payload

Breakpoint 1, 0x080484a5 in main ()
(gdb) x 0x18(%esp)
A syntax error in expression, near `%esp)'.
(gdb) x $esp + 0x18
0xbffff728:     0x0804a050
(gdb) x $esp + 0x1c
0xbffff72c:     0x0804a008

0x0804a050 - 0x0804a008 = 0x48 = 72 (dec)


## References
