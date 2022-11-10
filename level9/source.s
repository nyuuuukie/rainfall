; N::operator-(N&)
_ZN1NmiERS_:
    push   %ebp
    mov    %esp,%ebp

    mov    0x8(%ebp),%eax    ; eax = this
    mov    0x68(%eax),%edx   ; edx = this.number
    mov    0xc(%ebp),%eax    ; eax = other
    mov    0x68(%eax),%eax   ; eax = other.number
    mov    %edx,%ecx
    sub    %eax,%ecx         ; eax = this.number - other.number
    mov    %ecx,%eax

    pop    %ebp
    ret 

; N::operator+(N&)
_ZN1NplERS_:
    push   %ebp
    mov    %esp,%ebp

    mov    0x8(%ebp),%eax    ; eax = this
    mov    0x68(%eax),%edx   ; edx = this.number
    mov    0xc(%ebp),%eax    ; eax = other
    mov    0x68(%eax),%eax   ; eax = other.number

    add    %edx,%eax         ; eax = this.number + other.number

    pop    %ebp
    ret   

; N::setAnnotation(char *arg)
_ZN1N13setAnnotationEPc:
    push   %ebp
    mov    %esp,%ebp

    sub    $0x18,%esp
    mov    0xc(%ebp),%eax           ; getting arg (1st arg is implicitly passed this)
    mov    %eax,(%esp)
    call   0x8048520 <strlen@plt>   ; strlen(arg)

    mov    0x8(%ebp),%edx           ; this
    add    $0x4,%edx                ; this->buf, skipping ptr 

    mov    %eax,0x8(%esp)           ; strlen(arg)
    mov    0xc(%ebp),%eax           
    mov    %eax,0x4(%esp)           ; arg
    mov    %edx,(%esp)              ; 
    call   0x8048510 <memcpy@plt>

    leave  
    ret  

; N::N(int)
_ZN1NC2Ei:
    push   %ebp
    mov    %esp,%ebp

    mov    0x8(%ebp),%eax     ; getting arg1
    movl   $0x8048848,(%eax)  ; *arg1 = 0x8048848, pointing to 0x0804873a

    mov    0x8(%ebp),%eax     ; getting arg1
    mov    0xc(%ebp),%edx     ; getting arg2
    mov    %edx,0x68(%eax)    ; *(arg1 + 104) = arg2
    
    pop    %ebp
    ret  

main:
    push   %ebp
    mov    %esp,%ebp
    push   %ebx                   ; what for ?
    and    $0xfffffff0,%esp

    sub    $0x20,%esp             ; 32 bytes allocated on stack

    cmpl   $0x1,0x8(%ebp)
    jg     0x8048610 <main+28>
    movl   $0x1,(%esp)
    call   0x80484f0 <_exit@plt>

    movl   $0x6c,(%esp)             
    call   0x8048530 <_Znwj@plt>  ; operator new(108)
    mov    %eax,%ebx

    movl   $0x5,0x4(%esp)
    mov    %ebx,(%esp)
    call   0x80486f6 <_ZN1NC2Ei>  ; N::N(5)

    mov    %ebx,0x1c(%esp)        ; save addr1 to local var

    movl   $0x6c,(%esp)             
    call   0x8048530 <_Znwj@plt>  ; operator new(108)
    mov    %eax,%ebx

    movl   $0x6,0x4(%esp)
    mov    %ebx,(%esp)
    call   0x80486f6 <_ZN1NC2Ei>  ;  N::N(6)

    mov    %ebx,0x18(%esp)        ; save addr2 to local var

    mov    0x1c(%esp),%eax
    mov    %eax,0x14(%esp)
    mov    0x18(%esp),%eax         
    mov    %eax,0x10(%esp)
   
    mov    0xc(%ebp),%eax         ; 
    add    $0x4,%eax              ; 
    mov    (%eax),%eax            ; 
    mov    %eax,0x4(%esp)         ; av[1]
    mov    0x14(%esp),%eax   
    mov    %eax,(%esp)            ; passing n1 as this
    call   0x804870e <_ZN1N13setAnnotationEPc>

    mov    0x10(%esp),%eax        ; n2
    mov    (%eax),%eax            ; *n2
    mov    (%eax),%edx            ; **n2

    mov    0x14(%esp),%eax        
    mov    %eax,0x4(%esp)         ; n1
    mov    0x10(%esp),%eax          
    mov    %eax,(%esp)            ; n2
    call   *%edx                  ; calling operator+ through ptr to member function

    mov    -0x4(%ebp),%ebx
    leave  
    ret 
