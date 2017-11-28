#!/usr/local/bin/python

import random
import string
import argparse


parser = argparse.ArgumentParser(description='Create some test data.')
parser.add_argument('datatype', metavar='T', type=str,
                   help='The type of data, e.g. string, number (int, double, long)')

args = parser.parse_args()

if args.datatype == "boolean":
	value=random.randint(0,1)
elif args.datatype == "char":
	value=random.choice(string.letters)
elif args.datatype == "double":
	# Generate a random floating point number, and keep only 4 digits of precision.
	# ... str() and rstrip() to handle the case of XY.0, which SAL modifies to XY.
	value=str(round(random.uniform(0,100),4)).rstrip('0').rstrip('.')
elif args.datatype == "float":
	value=random.uniform(0,1)
elif args.datatype == "int":
	value=random.randint(-32767,32767)
elif args.datatype == "long":
	value=random.randint(-2147483647,2147483647)
elif args.datatype == "short":
	value=random.randint(-32767,32767)
elif args.datatype == "state":
	value=random.randint(0,1)
elif args.datatype == "unsigned long":
    value=random.randint(0,2147483647)
elif args.datatype == "unsigned short":
    value=random.randint(0,65534)
elif args.datatype == "byte":
	value=random.randint(0,255)
else:
        value="test"

print value
