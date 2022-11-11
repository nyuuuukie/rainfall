
run:
    push   %ebp
    mov    %esp,%ebp

    sub    $0x18,%esp           ; 24 bytes allocated on stack

    mov    0x80497c0,%eax     
    mov    %eax,%edx
    mov    $0x8048570,%eax    
    mov    %edx,0xc(%esp)       ; stdout
    movl   $0x13,0x8(%esp)      ; count = 19
    movl   $0x1,0x4(%esp)       ; size = 1
    mov    %eax,(%esp)          ; "Good... Wait what?\n"
    call   0x8048350 <fwrite@plt>

    movl   $0x8048584,(%esp)    ; "/bin/sh"
    call   0x8048360 <system@plt>

    leave  
    ret  

main:
    push   %ebp
    mov    %esp, %ebp
    and    $0xfffffff0, %esp

    sub    $0x50,%esp           ; 80 bytes allocated on stack

    lea    0x10(%esp),%eax
    mov    %eax,(%esp)          ; arr[80]
    call   0x8048340 <gets@plt>

    leave  
    ret