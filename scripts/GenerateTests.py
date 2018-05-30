#!/usr/local/bin/python

import subprocess
import os
import inspect
import argparse

# This array defines the list of CSCs, in all lowercase, for ease of string comparison.
## atcs calibrationelectrometer promptprocessing (TSS-2608, TSS-2606, TSS-2633)
csc_array = ["archiver", "atarchiver", "atcamera", "atheaderservice", "atmonochromator", "atscheduler", "camera", "catchuparchiver", "dome", "domeadb", "domeaps", "domelouvers", "domelws", "domemoncs", "domethcs", "eec", "efd", "headerservice", "hexapod", "m1m3", "m2ms", "mtmount", "ocs", "rotator", "scheduler", "sequencer", "summitfacility", "tcs", "tcsofc", "tcswep", "vms"]

def GenerateTests(csc, language):
	"""Test Suite generator."""
	if  csc == "all":
		for csc in csc_array:
			if ('cpp' in language) or ('all' in language):
				subprocess.check_call(["./CppPubSub.sh", csc])
				subprocess.check_call(["./CppComCon.sh", csc])
				subprocess.check_call(["./CppEvents.sh", csc])
			if ('java' in language) or ('all' in language):
				subprocess.check_call(["./JavaPubSub.sh", csc])
				subprocess.check_call(["./JavaComCon.sh", csc])
				subprocess.check_call(["./JavaEvents.sh", csc])
			if ('python' in language) or ('all' in language):
				subprocess.check_call(["./PythonPubSub.sh", csc])
				subprocess.check_call(["./PythonComCon.sh", csc])
				subprocess.check_call(["./PythonEvents.sh", csc])
		print("COMPLETED ALL test suites for ALL CSCs.")
	elif csc in csc_array:
		if ('cpp' in language) or ('all' in language):
			subprocess.check_call(["./CppPubSub.sh", csc])
			subprocess.check_call(["./CppComCon.sh", csc])
			subprocess.check_call(["./CppEvents.sh", csc])
		if ('java' in language) or ('all' in language):
			subprocess.check_call(["./JavaPubSub.sh", csc])
			subprocess.check_call(["./JavaComCon.sh", csc])
			subprocess.check_call(["./JavaEvents.sh", csc])
		if ('python' in language) or ('all' in language):
			subprocess.check_call(["./PythonPubSub.sh", csc])
			subprocess.check_call(["./PythonComCon.sh", csc])
			subprocess.check_call(["./PythonEvents.sh", csc])
		print("COMPLETED all test suites for the " + csc)
	else:
		print("Nope")

def DefineArguments():
	"""Argument parser."""
	parser = argparse.ArgumentParser(
		description='Determine which CSC and languages for which to generate tests.')
	parser.add_argument(
		'-c',
		'--csc',
		metavar='CSC',
		dest='csc',
		type = str.lower,
		required=False,
		default='all',
		help='''For which CSC do you want to generate tests? (Default is ALL)''')
	parser.add_argument(
		'-l',
		'--language',
		metavar='LANGUAGE',
		dest='language',
		type = str.lower,
		required=False,
		nargs='+',
		choices=['cpp', 'python', 'java', 'all', 'test'],
		default='all',
		help='''Do you want to generate the C++ (cpp), Python (python) or Java (java) tests? (Default is ALL)''')
	args = parser.parse_args()
	return args

# Get the arguments.
args = DefineArguments()

# Change directory to that of this script. It assumes the other generator scripts are in the same location.
working_dir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
os.chdir(working_dir)

# Now, generate the tests.
GenerateTests(args.csc, args.language)
