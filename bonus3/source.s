main:
    push   %ebp
    mov    %esp,%ebp
    push   %edi
    push   %ebx
    and    $0xfffffff0,%esp

    sub    $0xa0,%esp           ; 160 bytes allocated on stack 

    mov    $0x80486f0,%edx  
    mov    $0x80486f2,%eax  
    mov    %edx,0x4(%esp)       ; "r"
    mov    %eax,(%esp)          ; "/home/user/end/.pass"
    call   0x8048410 <fopen@plt>
    mov    %eax,0x9c(%esp)

    ; inlined memset
    lea    0x18(%esp),%ebx  
    mov    $0x0,%eax        
    mov    $0x21,%edx
    mov    %ebx,%edi            ; 132 bytes array
    mov    %edx,%ecx            ; count = 33, but dwords are set to 0
    rep stos %eax,%es:(%edi)

    cmpl   $0x0,0x9c(%esp)
    je     0x8048543 <main+79>

    cmpl   $0x2,0x8(%ebp)       ; comparing ac to 2
    je     0x804854d <main+89>

    mov    $0xffffffff,%eax     ; je     0x8048543 <main+79>
    jmp    0x8048615 <main+289>

    lea    0x18(%esp),%eax      ; je     0x804854d <main+89>
    mov    0x9c(%esp),%edx
    mov    %edx,0xc(%esp)       ; opened file
    movl   $0x42,0x8(%esp)      ; count = 66
    movl   $0x1,0x4(%esp)       ; size = 1
    mov    %eax,(%esp)          ; ptr = 132 bytes array
    call   0x80483d0 <fread@plt>  

    movb   $0x0,0x59(%esp)      ; buf[65] = '\0'
   
    mov    0xc(%ebp),%eax
    add    $0x4,%eax
    mov    (%eax),%eax 
    mov    %eax,(%esp)          ; av[1]
    call   0x8048430 <atoi@plt>
    movb   $0x0,0x18(%esp,%eax,1) ; index of terminated null in 132 bytes array
   
    lea    0x18(%esp),%eax
    lea    0x42(%eax),%edx      ; offset of 66 bytes from 132 bytes array
    mov    0x9c(%esp),%eax  
    mov    %eax,0xc(%esp)       ; opened file
    movl   $0x41,0x8(%esp)      ; count = 65
    movl   $0x1,0x4(%esp)       ; size = 1
    mov    %edx,(%esp)          ; &buf[66]
    call   0x80483d0 <fread@plt>

    mov    0x9c(%esp),%eax
    mov    %eax,(%esp)
    call   0x80483c0 <fclose@plt>

    mov    0xc(%ebp),%eax
    add    $0x4,%eax
    mov    (%eax),%eax
    mov    %eax,0x4(%esp)       ; av[1]
    lea    0x18(%esp),%eax
    mov    %eax,(%esp)          ; 132 bytes array
    call   0x80483b0 <strcmp@plt>

    test   %eax,%eax
    jne    0x8048601 <main+269>

    movl   $0x0,0x8(%esp)       ; NULL
    movl   $0x8048707,0x4(%esp) ; "sh"
    movl   $0x804870a,(%esp)    ; "/bin/sh"
    call   0x8048420 <execl@plt>
    jmp    0x8048610 <main+284>

    lea    0x18(%esp),%eax      ; jne    0x8048601 <main+269>
    add    $0x42,%eax
    mov    %eax,(%esp)          ; &buf[66]
    call   0x80483e0 <puts@plt>
   
    mov    $0x0,%eax            ; jmp    0x8048610 <main+284>

    lea    -0x8(%ebp),%esp      ; jmp    0x8048615 <main+289>

    pop    %ebx
    pop    %edi
    pop    %ebp
    ret    