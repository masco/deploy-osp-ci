import re
import sys

def verifier():
    with open(sys.argv[1], 'r') as fp:
        line1 = fp.readline()
        line2 = fp.readline()
        r1 = re.search("failed=0", line1)
        r2 = re.search("failed=0", line2)
        if ((r1 is None) or (r2 is None)):
            exit(1)

verifier()
