p:
   push   %ebp
   mov    %esp,%ebp
   sub    $0x68,%esp         ; 104 bytes

   mov    0x8049860,%eax     ; stdout
   mov    %eax,(%esp)
   call   0x80483b0 <fflush@plt>

   lea    -0x4c(%ebp),%eax   ; 76 bytes
   mov    %eax,(%esp)
   call   0x80483c0 <gets@plt>

   mov    0x4(%ebp),%eax     ; ret addr into eax
   mov    %eax,-0xc(%ebp)    ; eax into ebp - 12 (some local var contains ret addr)
   mov    -0xc(%ebp),%eax    ; write ret addr at the buf[len - 12] - buf[len - 9] elements
   and    $0xb0000000,%eax   ; b = 1011, addr should not start with b or f
   cmp    $0xb0000000,%eax
   jne    0x08048527 <p+83>
   mov    $0x8048620,%eax    ; "(%p)\n"
   mov    -0xc(%ebp),%edx
   mov    %edx,0x4(%esp)
   mov    %eax,(%esp)
   call   0x80483a0 <printf@plt>

   movl   $0x1,(%esp)
   call   0x80483d0 <_exit@plt>

   lea    -0x4c(%ebp),%eax
   mov    %eax,(%esp)
   call   0x80483f0 <puts@plt>

   lea    -0x4c(%ebp),%eax
   mov    %eax,(%esp)
   call   0x80483e0 <strdup@plt>

   leave  
   ret
   