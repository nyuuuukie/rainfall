# rainfall

This project continues the cybersecurity branch.
The goal is to pass all the 14 levels:

| Level | Exploit\Technique\Breach |
| ----- | ------- |
| [level0](/level0/README.md) | Passing exact parameter |
| [level1](/level1/README.md) | Overwriting return address |
| [level2](/level2/README.md) | Ret2Shellcode (on the heap) |
| [level3](/level3/README.md) | Format string attack |
| [level4](/level4/README.md) | Format string attack |
| [level5](/level5/README.md) | Format string attack, GOT rewriting |
| [level6](/level6/README.md) | |
| [level7](/level7/README.md) | |
| [level8](/level8/README.md) | |
| [level9](/level9/README.md) | |
| [bonus0](/level10/README.md) | |
| [bonus1](/level11/README.md) | |
| [bonus2](/level12/README.md) | |
| [bonus3](/level13/README.md) | |

In all scripts, I used ip address that is set into $IP env variable:  
```
export IP=192.168.64.9
```

## References
- [stack protection](https://developers.redhat.com/articles/2022/06/02/use-compiler-flags-stack-protection-gcc-and-clang#control_flow_integrity)


asm instructions at the beginning of the frame
https://reverseengineering.stackexchange.com/questions/15173/what-is-the-purpose-of-these-instructions-before-the-main-preamble
https://reverseengineering.stackexchange.com/questions/14880/basic-reversing-question-about-local-variable/14883#14883

rpath runpath and ld_preload
https://medium.com/obscure-system/rpath-vs-runpath-883029b17c45
https://amir.rachum.com/blog/2016/09/17/shared-libraries/#compiling-a-shared-library


https://wiki.bi0s.in/pwning/stack-overflow/return-to-shellcode/


https://mudongliang.github.io/2016/05/24/stack-protector.html