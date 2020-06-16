#!/usr/local/bin/python

import subprocess
import os
import inspect
import argparse

# This array defines the list of current CSCs.
csc_array = ['ATAOS', 'ATArchiver', 'ATBuilding', 'ATCamera', 'ATDome', 'ATDomeTrajectory', 'ATHeaderService', 'ATHexapod', 'ATMCS', 'ATMonochromator', 'ATOODS', 'ATPneumatics', 'ATPtg', 'ATSpectrograph', 'ATWhiteLight', 'CatchupArchiver', 'CBP', 'CCArchiver', 'CCCamera', 'CCHeaderService', 'CCOODS', 'DIMM', 'Dome', 'DSM', 'EAS', 'EFDTransformationServer', 'Electrometer', 'Environment', 'FiberSpectrograph', 'GenericCamera', 'Hexapod', 'HVAC', 'IOTA', 'LinearStage', 'LOVE', 'MTAOS', 'MTArchiver', 'MTCamera', 'MTDomeTrajectory', 'MTEEC', 'MTHeaderService', 'MTM1M3', 'MTM1M3TS', 'MTM2', 'NewMTMount', 'MTMount', 'MTPtg', 'MTVMS', 'PromptProcessing', 'Rotator', 'Scheduler', 'Script', 'ScriptQueue', 'SummitFacility', 'Test', 'TunableLaser', 'Watcher']

def GenerateTests(csc, language):
	"""Test Suite generator."""
	complete=True
	if  csc == "all":
		for csc in csc_array:
			if ('cpp' in language) or ('all' in language):
				subprocess.check_call(["./CppPubSub.sh", csc])
				subprocess.check_call(["./CppEvents.sh", csc])
				#subprocess.check_call(["./CppState.sh", csc])
				#subprocess.check_call(["./CppComCon.sh", csc])
			if ('java' in language) or ('all' in language):
				subprocess.check_call(["./JavaPubSub.sh", csc])
				subprocess.check_call(["./JavaEvents.sh", csc])
				#subprocess.check_call(["./JavaState.sh", csc])
				#subprocess.check_call(["./JavaComCon.sh", csc])
			if ('python' in language) or ('all' in language):
                                print("No python tests, yet.")
				#subprocess.check_call(["./PythonPubSub.sh", csc])
				#subprocess.check_call(["./PythonState.sh", csc])
				#subprocess.check_call(["./PythonComCon.sh", csc])
				#subprocess.check_call(["./PythonEvents.sh", csc])
			if ('cpp' not in language) and ('java' not in language) and ('python' not in language) and ('all' not in language):
				complete=False
		print("COMPLETED ALL test suites for ALL CSCs.") if complete else print("This was a " + str(language))
	elif csc in csc_array:
		if ('cpp' in language) or ('all' in language):
			#subprocess.check_call(["./CppPubSub.sh", csc])
			subprocess.check_call(["./CppState.sh", csc])
			#subprocess.check_call(["./CppComCon.sh", csc])
			#subprocess.check_call(["./CppEvents.sh", csc])
		if ('java' in language) or ('all' in language):
			#subprocess.check_call(["./JavaPubSub.sh", csc])
			subprocess.check_call(["./JavaState.sh", csc])
			#subprocess.check_call(["./JavaComCon.sh", csc])
			#subprocess.check_call(["./JavaEvents.sh", csc])
		if ('python' in language) or ('all' in language):
			#subprocess.check_call(["./PythonPubSub.sh", csc])
			subprocess.check_call(["./PythonState.sh", csc])
			#subprocess.check_call(["./PythonComCon.sh", csc])
			#subprocess.check_call(["./PythonEvents.sh", csc])
		if ('cpp' not in language) and ('java' not in language) and ('python' not in language) and ('all' not in language):
			complete=False
		print("COMPLETED all test suites for the " + csc) if complete else print("This was a " + str(language))
	else:
		print("Something has gone very wrong. CSC: " + csc + ", Language(s): " + str(language))

def DefineArguments():
	"""Argument parser."""
	csc_list = csc_array + ["all"]
	parser = argparse.ArgumentParser(
		description='Determine which CSC and languages for which to generate tests.')
	parser.add_argument(
		'-c',
		'--csc',
		metavar='CSC',
		dest='csc',
		type = str.lower,
		required=False,
		choices=str(csc_list)[1:-1],
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
if __name__ == "__main__":
	GenerateTests(args.csc, args.language)
