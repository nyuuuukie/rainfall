p:
    push   %ebp
    mov    %esp,%ebp
    sub    $0x18,%esp
    mov    0x8(%ebp),%eax
    mov    %eax,(%esp)
    call   0x8048340 <printf@plt>
    leave  
    ret

n:
    push   %ebp
    mov    %esp, %ebp

    sub    $0x218, %esp        ; 536 bytes allocated

    mov    0x8049804, %eax     ; stdin
    mov    %eax, 0x8(%esp)   
    movl   $0x200, 0x4(%esp)   ; size - 512 bytes
    lea    -0x208(%ebp), %eax  
    mov    %eax, (%esp)        ; buf - 520 bytes
    call   0x8048350 <fgets@plt>
    ; char *fgets(char *s, int size, FILE *stream);

    lea    -0x208(%ebp), %eax
    mov    %eax, (%esp)
    call   0x8048444 <p>       ; passing buf to p

    mov    0x8049810, %eax
    cmp    $0x1025544, %eax    ; dec = 16930116
    jne    0x80484a5 <n+78>

    movl   $0x8048590,(%esp)
    call   0x8048360 <system@plt>
    leave  
    ret

main:
    push   %ebp
    mov    %esp,%ebp
    and    $0xfffffff0,%esp
    call   0x8048457 <n>
    leave  
    ret