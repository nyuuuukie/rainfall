main:
    push   %ebp
    mov    %esp, %ebp
    push   %edi
    push   %esi
    and    $0xfffffff0, %esp

    sub    $0xa0,%esp                ; 160 bytes allocated on stack
    jmp    0x8048575 <main+17>
    nop                              ; jmp    0x8048574 <main+16>

    mov    0x8049ab0,%ecx      
    mov    0x8049aac,%edx      
    mov    $0x8048810,%eax     
    mov    %ecx,0x8(%esp)            ; service var addr
    mov    %edx,0x4(%esp)            ; auth var addr 
    mov    %eax,(%esp)               ; "%p, %p \n"
    call   0x8048410 <printf@plt>

    mov    0x8049a80,%eax   
    mov    %eax,0x8(%esp)            ; stdin
    movl   $0x80,0x4(%esp)           ; size - 128
    lea    0x20(%esp),%eax      
    mov    %eax,(%esp)               ; 128 byte array
    call   0x8048440 <fgets@plt>

    test   %eax,%eax                 ; sets ZF (zero flag) if result is zero
    je     0x804872c <main+456>      ; jump to l1 if error occured (NULL returned)

    ; inlined strncmp
    lea    0x20(%esp),%eax          
    mov    %eax,%edx
    mov    $0x8048819,%eax          
    mov    $0x5,%ecx                 ; 5
    mov    %edx,%esi                 ; 128 byte array
    mov    %eax,%edi                 ; "auth "
    repz cmpsb %es:(%edi),%ds:(%esi) ; strncmp (buf, "auth ", 5)
    seta   %dl                       ; dl =     ;   set if above (CF=0 and ZF=0)
    setb   %al                       ; al = *rsi < *rdi;   set if below (CF=1)
    mov    %edx,%ecx                 
    sub    %al,%cl                   ; al = al - cl, 
    ; (*rsi < *rdi && !(*rsi > *rdi)) => 1
    ; (*rsi > *rdi && *rsi < *rdi) || !(*rsi > *rdi && *rsi < *rdi) => 0
    ; (!(*rsi < *rdi) && *rsi > *rdi) => -1
    mov    %ecx,%eax
    movsbl %al,%eax

    test   %eax,%eax
    jne    0x8048642 <main+222>

    movl   $0x4,(%esp)
    call   0x8048470 <malloc@plt>
    mov    %eax,0x8049aac
    mov    0x8049aac,%eax           ; auth = malloc(4)
    movl   $0x0,(%eax)              ; *auth = 0 (4 bytes only)

    ; inlined strlen
    lea    0x20(%esp),%eax          ; loading buf (128 bytes)
    add    $0x5,%eax                ; adding offset of 5 bytes
    movl   $0xffffffff,0x1c(%esp)   ; init value, unsigned int max
    mov    %eax,%edx                
    mov    $0x0,%eax                ; second comparison operand (al)
    mov    0x1c(%esp),%ecx          ; init counter
    mov    %edx,%edi                ; buf[128] is not here
    repnz scas %es:(%edi),%al       ; compare until element or counter is not equal 0
    mov    %ecx,%eax                ; moving inverted value to the eax
    not    %eax
    sub    $0x1,%eax                ; inverse the value and subtracting 1 gives actual length
   
    cmp    $0x1e,%eax               ; string len compared to 31
    ja     0x8048642 <main+222>

    lea    0x20(%esp),%eax
    lea    0x5(%eax),%edx
    mov    0x8049aac,%eax           ; 
    mov    %edx,0x4(%esp)           ; dst - auth
    mov    %eax,(%esp)              ; src - buf + 5
    call   0x8048460 <strcpy@plt>

    ; inlined strncmp
    lea    0x20(%esp),%eax         ; jne    0x8048642 <main+222>
    mov    %eax,%edx               
    mov    $0x804881f,%eax         ; 
    mov    $0x5,%ecx               ; count = 5
    mov    %edx,%esi               ; buf[128]
    mov    %eax,%edi               ; "reset"
    repz cmpsb %es:(%edi),%ds:(%esi)
    seta   %dl
    setb   %al
    mov    %edx,%ecx
    sub    %al,%cl
    mov    %ecx,%eax
    movsbl %al,%eax

    test   %eax,%eax
    jne    0x8048678 <main+276>
   
    mov    0x8049aac,%eax
    mov    %eax,(%esp)
    call   0x8048420 <free@plt>     ; free(auth)

    ; inlined strncmp
    lea    0x20(%esp),%eax          ; jne    0x8048678 <main+276>
    mov    %eax,%edx
    mov    $0x8048825,%eax          
    mov    $0x6,%ecx                ; count = 6
    mov    %edx,%esi                ; buf[128]
    mov    %eax,%edi                ; "service"
    repz cmpsb %es:(%edi),%ds:(%esi)
    seta   %dl
    setb   %al
    mov    %edx,%ecx
    sub    %al,%cl
    mov    %ecx,%eax
    movsbl %al,%eax

    test   %eax,%eax
    jne    0x80486b5 <main+337>

    lea    0x20(%esp),%eax
    add    $0x7,%eax
    mov    %eax,(%esp)
    call   0x8048430 <strdup@plt>   ; strdup(buf + 7)
    mov    %eax,0x8049ab0

    ; inlined strncmp
    lea    0x20(%esp),%eax          ; jne    0x80486b5 <main+337>
    mov    %eax,%edx
    mov    $0x804882d,%eax
    mov    $0x5,%ecx                ; count = 5
    mov    %edx,%esi                ; buf[128]
    mov    %eax,%edi                ; "login"
    repz cmpsb %es:(%edi),%ds:(%esi)
    seta   %dl
    setb   %al
    mov    %edx,%ecx
    sub    %al,%cl
    mov    %ecx,%eax
    movsbl %al,%eax
   
    test   %eax,%eax
    jne    0x8048574 <main+16>

    mov    0x8049aac,%eax
    mov    0x20(%eax),%eax       ; auth + 32

    test   %eax,%eax             ; jump if auth + 32 is equal 0
    je     0x80486ff <main+411>

    movl   $0x8048833,(%esp)     ; "/bin/sh"
    call   0x8048480 <system@plt>
    jmp    0x8048574 <main+16>

    mov    0x8049aa0,%eax        ; je     0x80486ff <main+411>
    mov    %eax,%edx
    mov    $0x804883b,%eax      
    mov    %edx,0xc(%esp)        ; stdout
    movl   $0xa,0x8(%esp)        ; count = 10
    movl   $0x1,0x4(%esp)        ; size = 1
    mov    %eax,(%esp)           ; ptr = "Password:\n"
    call   0x8048450 <fwrite@plt>
    ; size_t fwrite(const void *ptr, size_t size, size_t nmemb, FILE *stream); 
    
    jmp    0x8048574 <main+16>
   
    nop                          ; je     0x804872c <main+456>
    mov    $0x0,%eax
    lea    -0x8(%ebp),%esp
    pop    %esi
    pop    %edi
    pop    %ebp
    ret 