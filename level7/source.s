m:
   push   %ebp
   mov    %esp,%ebp

   sub    $0x18,%esp

   movl   $0x0,(%esp)
   call   0x80483d0 <time@plt>     ; time(0)
   mov    $0x80486e0,%edx        
   mov    %eax,0x8(%esp)           ; seconds
   movl   $0x8049960,0x4(%esp)     ; c global var
   mov    %edx,(%esp)              ; "%s - %d\n"
   call   0x80483b0 <printf@plt>
   leave  
   ret 

main:
   push   %ebp
   mov    %esp,%ebp
   and    $0xfffffff0,%esp

   sub    $0x20,%esp

   movl   $0x8,(%esp)
   call   0x80483f0 <malloc@plt>    ; 8 bytes
   mov    %eax,0x1c(%esp)           ; write addr to arr1 
   mov    0x1c(%esp),%eax
   movl   $0x1,(%eax)               ; arr[0] = 1;

   movl   $0x8,(%esp)               ; 8 bytes
   call   0x80483f0 <malloc@plt>
   mov    %eax,%edx                 ; write addr2 to edx
   mov    0x1c(%esp),%eax
   mov    %edx,0x4(%eax)            ; write addr2 to arr1 + 4

   movl   $0x8,(%esp)               ; 8 bytes
   call   0x80483f0 <malloc@plt>
   mov    %eax,0x18(%esp)           ; write addr3 to arr2
   mov    0x18(%esp),%eax           ; arr2[0] = 2
   movl   $0x2,(%eax)

   movl   $0x8,(%esp)               ; 8 bytes
   call   0x80483f0 <malloc@plt>
   mov    %eax,%edx
   mov    0x18(%esp),%eax     
      
   mov    %edx,0x4(%eax)            ; write addr4 to arr3 + 4
   mov    0xc(%ebp),%eax            ; get av[0]
   add    $0x4,%eax                 ;
   mov    (%eax),%eax               ; => av[1]
   mov    %eax,%edx
   mov    0x1c(%esp),%eax           ; arr1 to eax
   mov    0x4(%eax),%eax            ; => arr1 + 4 
   mov    %edx,0x4(%esp)            ; av[1]
   mov    %eax,(%esp)               ; arr1 + 4, addr2
   call   0x80483e0 <strcpy@plt>

   mov    0xc(%ebp),%eax   
   add    $0x8,%eax                 
   mov    (%eax),%eax               
   mov    %eax,%edx                 
   mov    0x18(%esp),%eax              
   mov    0x4(%eax),%eax            
   mov    %edx,0x4(%esp)            ; av[2]
   mov    %eax,(%esp)               ; arr3 + 4, addr4
   call   0x80483e0 <strcpy@plt>
   mov    $0x80486e9,%edx
   mov    $0x80486eb,%eax
   mov    %edx,0x4(%esp)            ; "r"
   mov    %eax,(%esp)               ; "/home/user/level8/.pass"
   call   0x8048430 <fopen@plt>
   mov    %eax,0x8(%esp)            ; FILE * 
   movl   $0x44,0x4(%esp)           ; size = 68
   movl   $0x8049960,(%esp)         ; c global var
   call   0x80483c0 <fgets@plt>
   ; char *fgets(char *s, int size, FILE *stream);

   movl   $0x8048703,(%esp)
   call   0x8048400 <puts@plt>       ; call m instead
   mov    $0x0,%eax
   leave  
   ret 