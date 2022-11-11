main:
    push   %ebp
    mov    %esp,%ebp
    and    $0xfffffff0,%esp

    sub    $0x20,%esp           ; 32 bytes allocated on stack

    mov    0xc(%ebp),%eax
    add    $0x4,%eax
    mov    (%eax),%eax
    mov    %eax,(%esp)          ; av[1]
    call   0x8049710 <atoi>

    cmp    $0x1a7,%eax          ; compare with 423
    jne    0x8048f58 <main+152>

    movl   $0x80c5348,(%esp)    ; "/bin/sh"
    call   0x8050bf0 <strdup>
    mov    %eax,0x10(%esp)      ; save "/bin/sh" to local var

    movl   $0x0,0x14(%esp)

    call   0x8054680 <getegid>  ; getting effective group id
    mov    %eax,0x1c(%esp)
    
    call   0x8054670 <geteuid>  ; getting effective user id
    mov    %eax,0x18(%esp)
    
    mov    0x1c(%esp),%eax
    mov    %eax,0x8(%esp)
    mov    0x1c(%esp),%eax
    mov    %eax,0x4(%esp)
    mov    0x1c(%esp),%eax
    mov    %eax,(%esp)
    call   0x8054700 <setresgid>
    ; int setresgid(gid_t rgid, gid_t egid, gid_t sgid);

    mov    0x18(%esp),%eax
    mov    %eax,0x8(%esp)
    mov    0x18(%esp),%eax
    mov    %eax,0x4(%esp)
    mov    0x18(%esp),%eax
    mov    %eax,(%esp)
    call   0x8054690 <setresuid>
    ; int setresuid(uid_t ruid, uid_t euid, uid_t suid);

    lea    0x10(%esp),%eax
    mov    %eax,0x4(%esp)
    movl   $0x80c5348,(%esp)
    call   0x8054640 <execv>
    jmp    0x8048f80 <main+192>

    mov    0x80ee170,%eax   ; jne    0x8048f58 <main+152>
    mov    %eax,%edx
    mov    $0x80c5350,%eax  
    mov    %edx,0xc(%esp)   ; stderr
    movl   $0x5,0x8(%esp)   ; count = 5
    movl   $0x1,0x4(%esp)   ; size = 1 
    mov    %eax,(%esp)      ; "No !\n"
    call   0x804a230 <fwrite>

    mov    $0x0,%eax        ; jmp    0x8048f80 <main+192>
    leave  
    ret 