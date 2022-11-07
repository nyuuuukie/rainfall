
m:
    push   %ebp
    mov    %esp,%ebp

    sub    $0x18,%esp

    movl   $0x80485d1,(%esp)     ; "Nope"
    call   0x8048360 <puts@plt>
    leave  
    ret 

n:
    push   %ebp
    mov    %esp,%ebp

    sub    $0x18,%esp

    movl   $0x80485b0,(%esp)       ; "/bin/cat /home/user/level7/.pass"
    call   0x8048370 <system@plt>
    leave  
    ret 
  
main:
    push   %ebp
    mov    %esp,%ebp
    and    $0xfffffff0,%esp

    sub    $0x20,%esp           ; 32 bytes allocated on stack

    movl   $0x40,(%esp)         ; Try to allocate 64 bytes on heap
    call   0x8048350 <malloc@plt>

    mov    %eax,0x1c(%esp)      ; write addr to stack var
    movl   $0x4,(%esp)          ; malloc 4 bytes
    call   0x8048350 <malloc@plt>
    mov    %eax,0x18(%esp)      ; write addr in the second var
    
    mov    $0x8048468,%edx      ; m function
    mov    0x18(%esp),%eax      ; 
    mov    %edx,(%eax)          ; writing m function addr at the address of the 2nd var

    mov    0xc(%ebp),%eax       ; skip saved ebp, saved eip and argc => av[0]
    add    $0x4,%eax            ; av + 4 
    mov    (%eax),%eax          ; => av[1]
    mov    %eax,%edx            ; av[1] to edx
    
    mov    0x1c(%esp),%eax      ; 64 bytes array 
    mov    %edx,0x4(%esp)
    mov    %eax,(%esp)
    call   0x8048340 <strcpy@plt> ; overwriting ptr using strcpy

    mov    0x18(%esp),%eax
    mov    (%eax),%eax
    call   *%eax                 ; double pointer -> calling function through pointer to pointer to function

    leave  
    ret  