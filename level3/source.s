v:
    push   %ebp
    mov    %esp,%ebp

    sub    $0x218,%esp              ; 536 bytes allocated
  
    mov    0x8049860,%eax
    mov    %eax,0x8(%esp)           ; stdin (x/s 0x8049860 in gdb) 
    movl   $0x200,0x4(%esp)         ; size - 512
    lea    -0x208(%ebp),%eax   
    mov    %eax,(%esp)              ; 520 bytes buffer
    call   0x80483a0 <fgets@plt>
    ; char *fgets(char *s, int size, FILE *stream);

    lea    -0x208(%ebp),%eax
    mov    %eax,(%esp)
    call   0x8048390 <printf@plt>   ; printing the same buffer
    
    mov    0x804988c,%eax           ; what is in this address
    cmp    $0x40,%eax
    jne    0x8048518 <v+116>

    mov    0x8049880,%eax      
    mov    %eax,%edx
    mov    $0x8048600,%eax    
    mov    %edx,0xc(%esp)           ; stdout
    movl   $0xc,0x8(%esp)           ; count - 0xc - 12 
    movl   $0x1,0x4(%esp)           ; size - 1 bytes
    mov    %eax,(%esp)              ; "Wait what?!\n"
    call   0x80483b0 <fwrite@plt>
    ; size_t fwrite(const void *ptr, size_t size, size_t nmemb, FILE *stream); 

    movl   $0x804860d,(%esp)
    call   0x80483c0 <system@plt>   ; bingo - system("/bin/sh")

    leave  
    ret  

main:
    push   %ebp
    mov    %esp,%ebp
    and    $0xfffffff0,%esp
    call   0x80484a4 <v>
    leave  
    ret    
