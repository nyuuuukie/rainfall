greetuser:
   0x08048484 <+0>:     push   %ebp
   0x08048485 <+1>:     mov    %esp,%ebp
   0x08048487 <+3>:     sub    $0x58,%esp
   0x0804848a <+6>:     mov    0x8049988,%eax
   0x0804848f <+11>:    cmp    $0x1,%eax
   0x08048492 <+14>:    je     0x80484ba <greetuser+54>
   0x08048494 <+16>:    cmp    $0x2,%eax
   0x08048497 <+19>:    je     0x80484e9 <greetuser+101>
   0x08048499 <+21>:    test   %eax,%eax
   0x0804849b <+23>:    jne    0x804850a <greetuser+134>
   0x0804849d <+25>:    mov    $0x8048710,%edx
   0x080484a2 <+30>:    lea    -0x48(%ebp),%eax
   0x080484a5 <+33>:    mov    (%edx),%ecx
   0x080484a7 <+35>:    mov    %ecx,(%eax)
---Type <return> to continue, or q <return> to quit---
   0x080484a9 <+37>:    movzwl 0x4(%edx),%ecx
   0x080484ad <+41>:    mov    %cx,0x4(%eax)
   0x080484b1 <+45>:    movzbl 0x6(%edx),%edx
   0x080484b5 <+49>:    mov    %dl,0x6(%eax)
   0x080484b8 <+52>:    jmp    0x804850a <greetuser+134>
   0x080484ba <+54>:    mov    $0x8048717,%edx
   0x080484bf <+59>:    lea    -0x48(%ebp),%eax
   0x080484c2 <+62>:    mov    (%edx),%ecx
   0x080484c4 <+64>:    mov    %ecx,(%eax)
   0x080484c6 <+66>:    mov    0x4(%edx),%ecx
   0x080484c9 <+69>:    mov    %ecx,0x4(%eax)
   0x080484cc <+72>:    mov    0x8(%edx),%ecx
   0x080484cf <+75>:    mov    %ecx,0x8(%eax)
   0x080484d2 <+78>:    mov    0xc(%edx),%ecx
   0x080484d5 <+81>:    mov    %ecx,0xc(%eax)
---Type <return> to continue, or q <return> to quit---
   0x080484d8 <+84>:    movzwl 0x10(%edx),%ecx
   0x080484dc <+88>:    mov    %cx,0x10(%eax)
   0x080484e0 <+92>:    movzbl 0x12(%edx),%edx
   0x080484e4 <+96>:    mov    %dl,0x12(%eax)
   0x080484e7 <+99>:    jmp    0x804850a <greetuser+134>
   0x080484e9 <+101>:   mov    $0x804872a,%edx
   0x080484ee <+106>:   lea    -0x48(%ebp),%eax
   0x080484f1 <+109>:   mov    (%edx),%ecx
   0x080484f3 <+111>:   mov    %ecx,(%eax)
   0x080484f5 <+113>:   mov    0x4(%edx),%ecx
   0x080484f8 <+116>:   mov    %ecx,0x4(%eax)
   0x080484fb <+119>:   mov    0x8(%edx),%ecx
   0x080484fe <+122>:   mov    %ecx,0x8(%eax)
   0x08048501 <+125>:   movzwl 0xc(%edx),%edx
   0x08048505 <+129>:   mov    %dx,0xc(%eax)
---Type <return> to continue, or q <return> to quit---
   0x08048509 <+133>:   nop
   0x0804850a <+134>:   lea    0x8(%ebp),%eax
   0x0804850d <+137>:   mov    %eax,0x4(%esp)
   0x08048511 <+141>:   lea    -0x48(%ebp),%eax
   0x08048514 <+144>:   mov    %eax,(%esp)
   0x08048517 <+147>:   call   0x8048370 <strcat@plt>
   0x0804851c <+152>:   lea    -0x48(%ebp),%eax
   0x0804851f <+155>:   mov    %eax,(%esp)
   0x08048522 <+158>:   call   0x8048390 <puts@plt>
   0x08048527 <+163>:   leave  
   0x08048528 <+164>:   ret 


main:
    push   %ebp
    mov    %esp,%ebp
    push   %edi
    push   %esi
    push   %ebx
    and    $0xfffffff0,%esp

    sub    $0xa0,%esp        ; 160 bytes allocated on stack 

    cmpl   $0x3,0x8(%ebp)    ; compare ac to 3
    je     0x8048548 <main+31>
    mov    $0x1,%eax
    jmp    0x8048630 <main+263>

    ; inlined memset
    lea    0x50(%esp),%ebx
    mov    $0x0,%eax
    mov    $0x13,%edx  
    mov    %ebx,%edi    ; 80 bytes array
    mov    %edx,%ecx    ; count = 19 dwords = 76 bytes
    rep stos %eax,%es:(%edi)

    mov    0xc(%ebp),%eax
    add    $0x4,%eax
    mov    (%eax),%eax
    movl   $0x28,0x8(%esp)  ; n = 40
    mov    %eax,0x4(%esp)   ; src = av[1]
    lea    0x50(%esp),%eax  ; dst = buf[80]
    mov    %eax,(%esp)
    call   0x80483c0 <strncpy@plt>

    mov    0xc(%ebp),%eax
    add    $0x8,%eax
    mov    (%eax),%eax
    movl   $0x20,0x8(%esp)  ; n = 32
    mov    %eax,0x4(%esp)   ; src = av[2]
    lea    0x50(%esp),%eax
    add    $0x28,%eax
    mov    %eax,(%esp)      ; &buf[40]
    call   0x80483c0 <strncpy@plt>

    movl   $0x8048738,(%esp)   ; "LANG"
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

    movl   $0x1,0x8049988       ; language = 1
    jmp    0x8048618 <main+239>

    movl   $0x2,0x8(%esp)        ; jne    0x80485eb <main+194>
    movl   $0x8048740,0x4(%esp)
    mov    0x9c(%esp),%eax
    mov    %eax,(%esp)
    call   0x8048360 <memcmp@plt>
    test   %eax,%eax
    jne    0x8048618 <main+239>

    movl   $0x2,0x8049988       ; language = 2

    mov    %esp,%edx            ; je     0x8048618 <main+239>
    lea    0x50(%esp),%ebx
    mov    $0x13,%eax
    mov    %edx,%edi
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