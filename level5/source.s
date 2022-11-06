o:
   push   %ebp
   mov    %esp,%ebp
   sub    $0x18,%esp
   movl   $0x80485f0,(%esp)
   call   0x80483b0 <system@plt>
   movl   $0x1,(%esp)
   call   0x8048390 <_exit@plt>

n:
   push   %ebp
   mov    %esp,%ebp

   sub    $0x218,%esp         ; 536 bytes allocated
   mov    0x8049848,%eax      ; stdin
   mov    %eax,0x8(%esp)
   movl   $0x200,0x4(%esp)    ; size - 512
   lea    -0x208(%ebp),%eax   ; buf - 520 bytes
   mov    %eax,(%esp)
   call   0x80483a0 <fgets@plt>
   ; char *fgets(char *s, int size, FILE *stream);

   lea    -0x208(%ebp),%eax
   mov    %eax,(%esp)
   call   0x8048380 <printf@plt>

   movl   $0x1,(%esp)
   call   0x80483d0 <exit@plt>

main:
   push   %ebp
   mov    %esp,%ebp
   and    $0xfffffff0,%esp
   call   0x80484c2 <n>
   leave  
   ret
