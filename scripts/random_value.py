#!/usr/local/bin/python

import random
import argparse


parser = argparse.ArgumentParser(description='Create some test data.')
parser.add_argument('datatype', metavar='T', type=str,
                   help='The type of data, e.g. string, number (int, double, long)')

args = parser.parse_args()


if args.datatype == "double":
        value=round(random.uniform(0,100),4)
elif args.datatype == "long":
        value=random.randint(0,2147483647)
elif args.datatype == "short":
        value=random.randint(0,32767)
elif args.datatype == "int":
        value=random.randint(0,32767)
elif args.datatype == "boolean":
		temp=random.randint(0,1)
		if temp == 1:
        		value="true"
		else:
				value="false"
else:
        value="test"

print value
