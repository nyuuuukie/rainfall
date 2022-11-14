
; 
p:
    push   %ebp
    mov    %esp,%ebp

    sub    $0x1018,%esp             ; 4120 bytes allocated on stack

    mov    0xc(%ebp),%eax
    mov    %eax,(%esp)
    call   0x80483b0 <puts@plt>

    movl   $0x1000,0x8(%esp)        ; size = 4096
    lea    -0x1008(%ebp),%eax
    mov    %eax,0x4(%esp)           ; buf = 4104 bytes array
    movl   $0x0,(%esp)              ; 0, stdin
    call   0x8048380 <read@plt>

    movl   $0xa,0x4(%esp)           ; c = 0xA ('\n')
    lea    -0x1008(%ebp),%eax
    mov    %eax,(%esp)              ; buf = 4104 bytes array
    call   0x80483d0 <strchr@plt>
    movb   $0x0,(%eax)              ; *match = '\0'

    lea    -0x1008(%ebp),%eax
    movl   $0x14,0x8(%esp)          ; n = 20
    mov    %eax,0x4(%esp)           ; src = 4104 bytes array
    mov    0x8(%ebp),%eax
    mov    %eax,(%esp)              ; dst = s1
    call   0x80483f0 <strncpy@plt>

    leave  
    ret    


; void pp(char *str)
pp:
    push   %ebp
    mov    %esp, %ebp
    push   %edi
    push   %ebx

    sub    $0x50, %esp              ; 80 bytes allocated on stack

    movl   $0x80486a0,0x4(%esp)     ; " - "
    lea    -0x30(%ebp),%eax
    mov    %eax,(%esp)              ; buf[20]
    call   0x80484b4 <p>

    movl   $0x80486a0,0x4(%esp)     ; " - "
    lea    -0x1c(%ebp),%eax
    mov    %eax,(%esp)              ; buf[20]
    call   0x80484b4 <p>

    lea    -0x30(%ebp),%eax
    mov    %eax,0x4(%esp)           ; src = buf[20]
    mov    0x8(%ebp),%eax       
    mov    %eax,(%esp)              ; dst = str
    call   0x80483a0 <strcpy@plt>

    mov    $0x80486a4,%ebx          ; " "

    ; inlined strlen
    mov    0x8(%ebp),%eax
    movl   $0xffffffff,-0x3c(%ebp)  ; init counter
    mov    %eax,%edx         
    mov    $0x0,%eax                ; al = 0
    mov    -0x3c(%ebp),%ecx         ; init counter 
    mov    %edx,%edi                ; str
    repnz scas %es:(%edi),%al
    mov    %ecx,%eax
    not    %eax
    sub    $0x1,%eax

    add    0x8(%ebp),%eax           ; str += strlen(str)
    movzwl (%ebx),%edx              ; *str = ' ' && *(str + 1) = '\0'
    mov    %dx,(%eax)               ; transferring 2 bytes (word) into str

    lea    -0x1c(%ebp),%eax
    mov    %eax,0x4(%esp)           ; buf[28]
    mov    0x8(%ebp),%eax
    mov    %eax,(%esp)              ; str
    call   0x8048390 <strcat@plt>

    add    $0x50,%esp
    pop    %ebx
    pop    %edi
    pop    %ebp
    ret 

main:
    push   %ebp
    mov    %esp,%ebp
    and    $0xfffffff0,%esp

    sub    $0x40,%esp            ; 64 bytes allocated on stack 
    lea    0x16(%esp),%eax  
    mov    %eax,(%esp)           ; 42 bytes array
    call   0x804851e <pp>
    lea    0x16(%esp),%eax 
    mov    %eax,(%esp)           ; 42 bytes array
    call   0x80483b0 <puts@plt>
   
    mov    $0x0,%eax
    leave  
    ret   