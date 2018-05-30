#!/usr/local/bin/python

import subprocess
import os
import inspect
import argparse

# This array defines the list of CSCs, in all lowercase, for ease of string comparison.
## atcs calibrationelectrometer promptprocessing (TSS-2608, TSS-2606, TSS-2633)
csc_array = ["archiver", "atarchiver", "atcamera", "atheaderservice", "atmonochromator", "atscheduler", "camera", "catchuparchiver", "dome", "domeadb", "domeaps", "domelouvers", "domelws", "domemoncs", "domethcs", "eec", "efd", "headerservice", "hexapod", "m1m3", "m2ms", "mtmount", "ocs", "rotator", "scheduler", "sequencer", "summitfacility", "tcs", "tcsofc", "tcswep", "vms"]

def GenerateTests(csc, language):
	if  csc == "all":
		for csc in csc_array:
			if (language=='cpp') or (language=='all'):
				subprocess.check_call(["./CppPubSub.sh", csc])
				subprocess.check_call(["./CppComCon.sh", csc])
				subprocess.check_call(["./CppEvents.sh", csc])
			if (language=='java') or (language=='all'):
				subprocess.check_call(["./JavaPubSub.sh", csc])
				subprocess.check_call(["./JavaComCon.sh", csc])
				subprocess.check_call(["./JavaEvents.sh", csc])
			if (language=='python') or (language=='all'):
				subprocess.check_call(["./PythonPubSub.sh", csc])
				subprocess.check_call(["./PythonComCon.sh", csc])
				subprocess.check_call(["./PythonEvents.sh", csc])
		print("COMPLETED ALL test suites for ALL CSCs.")
	elif csc in csc_array:
		if (language=='cpp') or (language=='all'):
			subprocess.check_call(["./CppPubSub.sh", csc])
			subprocess.check_call(["./CppComCon.sh", csc])
			subprocess.check_call(["./CppEvents.sh", csc])
		if (language=='java') or (language=='all'):
			subprocess.check_call(["./JavaPubSub.sh", csc])
			subprocess.check_call(["./JavaComCon.sh", csc])
			subprocess.check_call(["./JavaEvents.sh", csc])
		if (language=='python') or (language=='all'):
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
		choices=['cpp', 'python', 'java', 'all'],
		default='all',
		help='''Do you want to generate the C++ (cpp), Python (python) or Java (java) tests? (Default is ALL)''')
	args = parser.parse_args()
	return args

args = DefineArguments()
working_dir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
print(working_dir)
os.chdir(working_dir)
GenerateTests(args.csc, args.language)
