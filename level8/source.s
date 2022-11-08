main:
    push   %ebp
    mov    %esp, %ebp
    push   %edi
    push   %esi
    and    $0xfffffff0, %esp

    sub    $0xa0,%esp                ; 160 bytes allocated on stack
    jmp    0x8048575 <main+17>
    nop                              ; jmp 0x8048574 probably here

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

    lea    0x20(%esp),%eax          
    mov    %eax,%edx
    mov    $0x8048819,%eax          
    mov    $0x5,%ecx                 ; 5
    mov    %edx,%esi                 ; 128 byte array
    mov    %eax,%edi                 ; "auth "
    repz cmpsb %es:(%edi),%ds:(%esi) ; strncmp (buf, "auth ", 5)

    seta   %dl                       ; set byte if above (CF=0 and ZF=0)
    setb   %al                       ; set byte if below (CF=1)
    mov    %edx,%ecx
    sub    %al,%cl
    mov    %ecx,%eax
    movsbl %al,%eax

    test   %eax,%eax
    jne    0x8048642 <main+222>

   0x080485e4 <+128>:   movl   $0x4,(%esp)
   0x080485eb <+135>:   call   0x8048470 <malloc@plt>
   0x080485f0 <+140>:   mov    %eax,0x8049aac
   0x080485f5 <+145>:   mov    0x8049aac,%eax           ; auth = malloc(4)
   0x080485fa <+150>:   movl   $0x0,(%eax)              ; *auth = 0 (4 bytes only)

   0x08048600 <+156>:   lea    0x20(%esp),%eax
   0x08048604 <+160>:   add    $0x5,%eax
   0x08048607 <+163>:   movl   $0xffffffff,0x1c(%esp)
   0x0804860f <+171>:   mov    %eax,%edx
   0x08048611 <+173>:   mov    $0x0,%eax
   0x08048616 <+178>:   mov    0x1c(%esp),%ecx
   0x0804861a <+182>:   mov    %edx,%edi
   0x0804861c <+184>:   repnz scas %es:(%edi),%al
   0x0804861e <+186>:   mov    %ecx,%eax
   0x08048620 <+188>:   not    %eax
   0x08048622 <+190>:   sub    $0x1,%eax
   0x08048625 <+193>:   cmp    $0x1e,%eax
   0x08048628 <+196>:   ja     0x8048642 <main+222>

   0x0804862a <+198>:   lea    0x20(%esp),%eax
   0x0804862e <+202>:   lea    0x5(%eax),%edx
   0x08048631 <+205>:   mov    0x8049aac,%eax
   0x08048636 <+210>:   mov    %edx,0x4(%esp)
   0x0804863a <+214>:   mov    %eax,(%esp)
   0x0804863d <+217>:   call   0x8048460 <strcpy@plt>

   0x08048642 <+222>:   lea    0x20(%esp),%eax         ; jne    0x8048642 <main+222>
   0x08048646 <+226>:   mov    %eax,%edx
   0x08048648 <+228>:   mov    $0x804881f,%eax
   0x0804864d <+233>:   mov    $0x5,%ecx
   0x08048652 <+238>:   mov    %edx,%esi
   0x08048654 <+240>:   mov    %eax,%edi
   0x08048656 <+242>:   repz cmpsb %es:(%edi),%ds:(%esi)

   0x08048658 <+244>:   seta   %dl
   0x0804865b <+247>:   setb   %al
   0x0804865e <+250>:   mov    %edx,%ecx
   0x08048660 <+252>:   sub    %al,%cl
   0x08048662 <+254>:   mov    %ecx,%eax
   0x08048664 <+256>:   movsbl %al,%eax

   0x08048667 <+259>:   test   %eax,%eax
   0x08048669 <+261>:   jne    0x8048678 <main+276>
   
   0x0804866b <+263>:   mov    0x8049aac,%eax
   0x08048670 <+268>:   mov    %eax,(%esp)
   0x08048673 <+271>:   call   0x8048420 <free@plt>

   0x08048678 <+276>:   lea    0x20(%esp),%eax
   0x0804867c <+280>:   mov    %eax,%edx
   0x0804867e <+282>:   mov    $0x8048825,%eax
   0x08048683 <+287>:   mov    $0x6,%ecx
   0x08048688 <+292>:   mov    %edx,%esi
   0x0804868a <+294>:   mov    %eax,%edi
   0x0804868c <+296>:   repz cmpsb %es:(%edi),%ds:(%esi)
   0x0804868e <+298>:   seta   %dl
   0x08048691 <+301>:   setb   %al
   0x08048694 <+304>:   mov    %edx,%ecx
   0x08048696 <+306>:   sub    %al,%cl
   0x08048698 <+308>:   mov    %ecx,%eax
   0x0804869a <+310>:   movsbl %al,%eax
   0x0804869d <+313>:   test   %eax,%eax
   0x0804869f <+315>:   jne    0x80486b5 <main+337>
   0x080486a1 <+317>:   lea    0x20(%esp),%eax
   0x080486a5 <+321>:   add    $0x7,%eax
   0x080486a8 <+324>:   mov    %eax,(%esp)
   0x080486ab <+327>:   call   0x8048430 <strdup@plt>
   0x080486b0 <+332>:   mov    %eax,0x8049ab0
   0x080486b5 <+337>:   lea    0x20(%esp),%eax
   0x080486b9 <+341>:   mov    %eax,%edx
   0x080486bb <+343>:   mov    $0x804882d,%eax
   0x080486c0 <+348>:   mov    $0x5,%ecx
   0x080486c5 <+353>:   mov    %edx,%esi
   0x080486c7 <+355>:   mov    %eax,%edi
   0x080486c9 <+357>:   repz cmpsb %es:(%edi),%ds:(%esi)
   0x080486cb <+359>:   seta   %dl
   0x080486ce <+362>:   setb   %al
   0x080486d1 <+365>:   mov    %edx,%ecx
   0x080486d3 <+367>:   sub    %al,%cl
   0x080486d5 <+369>:   mov    %ecx,%eax
   0x080486d7 <+371>:   movsbl %al,%eax
   0x080486da <+374>:   test   %eax,%eax
   0x080486dc <+376>:   jne    0x8048574 <main+16>
   0x080486e2 <+382>:   mov    0x8049aac,%eax
   0x080486e7 <+387>:   mov    0x20(%eax),%eax
   0x080486ea <+390>:   test   %eax,%eax
   0x080486ec <+392>:   je     0x80486ff <main+411>
   0x080486ee <+394>:   movl   $0x8048833,(%esp)
   0x080486f5 <+401>:   call   0x8048480 <system@plt>
   0x080486fa <+406>:   jmp    0x8048574 <main+16>
   0x080486ff <+411>:   mov    0x8049aa0,%eax
   0x08048704 <+416>:   mov    %eax,%edx
   0x08048706 <+418>:   mov    $0x804883b,%eax
   0x0804870b <+423>:   mov    %edx,0xc(%esp)
   0x0804870f <+427>:   movl   $0xa,0x8(%esp)
   0x08048717 <+435>:   movl   $0x1,0x4(%esp)
   0x0804871f <+443>:   mov    %eax,(%esp)
   0x08048722 <+446>:   call   0x8048450 <fwrite@plt>
   0x08048727 <+451>:   jmp    0x8048574 <main+16>
   
    nop                     ; 0x0804872c <+456>: label l1
    mov    $0x0,%eax
    lea    -0x8(%ebp),%esp
    pop    %esi
    pop    %edi
    pop    %ebp
    ret 