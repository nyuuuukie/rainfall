main:
    push   %ebp
    mov    %esp,%ebp
    and    $0xfffffff0,%esp

    sub    $0x40,%esp             ; 64 bytes allocated on stack

    mov    0xc(%ebp),%eax         ; av
    add    $0x4,%eax              ; av + 1
    mov    (%eax),%eax      
    mov    %eax,(%esp)            ; av[1]
    call   0x8048360 <atoi@plt>

    mov    %eax,0x3c(%esp)
    cmpl   $0x9,0x3c(%esp)
    jle    0x804844f <main+43>    ; if (res <= 9)

    mov    $0x1,%eax
    jmp    0x80484a3 <main+127>   ; if (res > 9)

    mov    0x3c(%esp),%eax        ; jle    0x804844f <main+43>
    lea    0x0(,%eax,4),%ecx      ; res * 4, disp(base,index,scale) => (base + index * scale) 

    mov    0xc(%ebp),%eax
    add    $0x8,%eax
    mov    (%eax),%eax            ; getting av[2]
    mov    %eax,%edx
    lea    0x14(%esp),%eax
    mov    %ecx,0x8(%esp)         ; 
    mov    %edx,0x4(%esp)         ; av[2]
    mov    %eax,(%esp)            ; 40 bytes array
    call   0x8048320 <memcpy@plt>

    cmpl   $0x574f4c46,0x3c(%esp) ; compare res to 0x574f4c46
    jne    0x804849e <main+122>

    movl   $0x0,0x8(%esp)         ; NULL
    movl   $0x8048580,0x4(%esp)   ; "sh"
    movl   $0x8048583,(%esp)      ; "/bin/sh"
    call   0x8048350 <execl@plt>
   
    mov    $0x0,%eax              ; jne    0x804849e <main+122>
    leave                         ; jmp    0x80484a3 <main+127>
    ret    