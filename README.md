# rainfall

This project continues the cybersecurity branch.
The goal is to pass all the 14 levels:

| Level | Exploit\Technique\Breach |
| ----- | ------- |
| [level0](/level0/walkthrough.md) | Passing right parameter |
| [level1](/level1/walkthrough.md) | Overwriting return address (to function) |
| [level2](/level2/walkthrough.md) | Overwriting return address (to shellcode) |
| [level3](/level3/walkthrough.md) | Format string attack |
| [level4](/level4/walkthrough.md) | Format string attack |
| [level5](/level5/walkthrough.md) | Format string attack, GOT rewriting |
| [level6](/level6/walkthrough.md) | Buffer overflow |
| [level7](/level7/walkthrough.md) | Buffer overflow, GOT rewriting |
| [level8](/level8/walkthrough.md) | Buffer overflow (almost) |
| [level9](/level9/walkthrough.md) | |
| [bonus0](/bonus0/walkthrough.md) | |
| [bonus1](/bonus1/walkthrough.md) | |
| [bonus2](/bonus2/walkthrough.md) | Buffer overflow, ret2libc |
| [bonus3](/bonus3/walkthrough.md) | |

In all scripts, I used ip address that is set into $IP env variable:  
```
export IP=192.168.64.9
```

## References
- [stack protection](https://developers.redhat.com/articles/2022/06/02/use-compiler-flags-stack-protection-gcc-and-clang#control_flow_integrity)
- [asm instructions at the beginning of the frame](https://reverseengineering.stackexchange.com/questions/15173/what-is-the-purpose-of-these-instructions-before-the-main-preamble)
- [frame structure](https://reverseengineering.stackexchange.com/questions/14880/basic-reversing-question-about-local-variable/14883#14883)
- [rpath vs runpath](https://medium.com/obscure-system/rpath-vs-runpath-883029b17c45)
- [compiling a shared library](https://amir.rachum.com/blog/2016/09/17/shared-libraries/#compiling-a-shared-library)
- [ret2shellcode](https://wiki.bi0s.in/pwning/stack-overflow/return-to-shellcode/)
- [stack protector](https://mudongliang.github.io/2016/05/24/stack-protector.html)
