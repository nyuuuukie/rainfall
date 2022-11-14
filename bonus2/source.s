
; greetuser(struct s_arg arg)
greetuser:
    push   %ebp
    mov    %esp,%ebp

    sub    $0x58,%esp          ; 88 bytes allocated on stack

    mov    0x8049988,%eax
    cmp    $0x1,%eax
    je     0x80484ba <greetuser+54>
    cmp    $0x2,%eax
    je     0x80484e9 <greetuser+101>
    test   %eax,%eax
    jne    0x804850a <greetuser+134>

    ; inlined strcpy or memcpy, if language == 0
    mov    $0x8048710,%edx     ; "Hello "
    lea    -0x48(%ebp),%eax    ; 72 bytes array
    mov    (%edx),%ecx         ; copy first 4 bytes of "Hello "
    mov    %ecx,(%eax)         ; transfer first 4 bytes of "Hello " to array
    movzwl 0x4(%edx),%ecx      ; copy last 2 bytes of "Hello " with padding zeroes
    mov    %cx,0x4(%eax)       ; transfer last 2 bytes
    movzbl 0x6(%edx),%edx      ; edx = 0
    mov    %dl,0x6(%eax)       ; arr[6] = 0

    jmp    0x804850a <greetuser+134>

    ; inlined strcpy or memcpy, if language == 1
    mov    $0x8048717,%edx     ; je     0x80484ba <greetuser+54>
    lea    -0x48(%ebp),%eax
    mov    (%edx),%ecx        
    mov    %ecx,(%eax)        
    mov    0x4(%edx),%ecx       
    mov    %ecx,0x4(%eax)
    mov    0x8(%edx),%ecx
    mov    %ecx,0x8(%eax)      ; copy "Hyvää päivää " to array
    mov    0xc(%edx),%ecx      ; 
    mov    %ecx,0xc(%eax)
    movzwl 0x10(%edx),%ecx
    mov    %cx,0x10(%eax)
    movzbl 0x12(%edx),%edx
    mov    %dl,0x12(%eax)

    jmp    0x804850a <greetuser+134>    

    ; inlined strcpy or memcpy, if language == 2
    mov    $0x804872a,%edx        ; 0x80484e9 <greetuser+101>
    lea    -0x48(%ebp),%eax 
    mov    (%edx),%ecx
    mov    %ecx,(%eax)
    mov    0x4(%edx),%ecx
    mov    %ecx,0x4(%eax)         ; copy "Goedemiddag! " to array
    mov    0x8(%edx),%ecx
    mov    %ecx,0x8(%eax)
    movzwl 0xc(%edx),%edx
    mov    %dx,0xc(%eax)
    nop

    lea    0x8(%ebp),%eax         ; 0x804850a <greetuser+134>
    mov    %eax,0x4(%esp)         ; arg1
    lea    -0x48(%ebp),%eax       
    mov    %eax,(%esp)            ; 72 bytes array
    call   0x8048370 <strcat@plt>

    lea    -0x48(%ebp),%eax       ; 72 bytes array
    mov    %eax,(%esp)
    call   0x8048390 <puts@plt>

    leave
    ret 

main:
    push   %ebp
    mov    %esp,%ebp
    push   %edi
    push   %esi
    push   %ebx
    and    $0xfffffff0,%esp

    sub    $0xa0,%esp           ; 160 bytes allocated on stack 

    cmpl   $0x3,0x8(%ebp)       ; compare ac to 3
    je     0x8048548 <main+31>
    mov    $0x1,%eax
    jmp    0x8048630 <main+263>

    ; inlined memset
    lea    0x50(%esp),%ebx
    mov    $0x0,%eax
    mov    $0x13,%edx  
    mov    %ebx,%edi            ; 76 bytes array
    mov    %edx,%ecx            ; count = 19 dwords = 76 bytes
    rep stos %eax,%es:(%edi)

    mov    0xc(%ebp),%eax
    add    $0x4,%eax
    mov    (%eax),%eax
    movl   $0x28,0x8(%esp)      ; n = 40
    mov    %eax,0x4(%esp)       ; src = av[1]
    lea    0x50(%esp),%eax      ; dst = buf[76]
    mov    %eax,(%esp)
    call   0x80483c0 <strncpy@plt>

    mov    0xc(%ebp),%eax
    add    $0x8,%eax
    mov    (%eax),%eax
    movl   $0x20,0x8(%esp)      ; n = 32
    mov    %eax,0x4(%esp)       ; src = av[2]
    lea    0x50(%esp),%eax
    add    $0x28,%eax
    mov    %eax,(%esp)          ; &buf[40]
    call   0x80483c0 <strncpy@plt>

    movl   $0x8048738,(%esp)    ; "LANG"
    call   0x8048380 <getenv@plt>
    mov    %eax,0x9c(%esp)

    cmpl   $0x0,0x9c(%esp)
    je     0x8048618 <main+239>

    movl   $0x2,0x8(%esp)
    movl   $0x804873d,0x4(%esp)
    mov    0x9c(%esp),%eax
    mov    %eax,(%esp)
    call   0x8048360 <memcmp@plt>
    test   %eax,%eax
    jne    0x80485eb <main+194>

    movl   $0x1,0x8049988        ; language = 1
    jmp    0x8048618 <main+239>

    movl   $0x2,0x8(%esp)        ; 0x80485eb <main+194>
    movl   $0x8048740,0x4(%esp)
    mov    0x9c(%esp),%eax
    mov    %eax,(%esp)
    call   0x8048360 <memcmp@plt>
    test   %eax,%eax
    jne    0x8048618 <main+239>

    movl   $0x2,0x8049988       ; language = 2

    mov    %esp,%edx            ; 0x8048618 <main+239>
    lea    0x50(%esp),%ebx
    mov    $0x13,%eax
    mov    %edx,%edi            ; passing parameter by value i.e. copying it
    mov    %ebx,%esi
    mov    %eax,%ecx
    rep movsl %ds:(%esi),%es:(%edi)
    call   0x8048484 <greetuser>

    lea    -0xc(%ebp),%esp
    pop    %ebx
    pop    %esi
    pop    %edi
    pop    %ebp
    ret