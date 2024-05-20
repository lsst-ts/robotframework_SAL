#!/usr/local/bin/python

import subprocess
import os
import inspect
import argparse

# This array defines the list of current CSCs.
csc_array = ['ATAOS', 'ATBuilding', 'ATCamera', 'ATDome', 'ATDomeTrajectory', 'ATHeaderService', 'ATHexapod', 'ATMCS', 'ATMonochromator', 'ATOODS', 'ATPneumatics', 'ATPtg', 'ATSpectrograph', 'ATWhiteLight', 'CBP', 'CCCamera', 'CCHeaderService', 'CCOODS', 'DIMM', 'DREAM', 'DSM', 'EAS', 'Electrometer', 'EPM', 'ESS', 'FiberSpectrograph', 'GCHeaderService', 'GenericCamera', 'GIS', 'Guider', 'HVAC', 'LaserTracker', 'LEDProjetor', 'LinearStage', 'LOVE', 'MTAirCompressor', 'MTAOS', 'MTCamera', 'MTDome', 'MTDomeTrajectory', 'MTEEC', 'MTHeaderService', 'MTHexapod', 'MTM1M3', 'MTM1M3TS', 'MTM2', 'MTMount', 'MTOODS', 'MTPtg', 'MTRotator', 'MTVMS', 'OCPS', 'PMD', 'Scheduler', 'Script', 'ScriptQueue', 'SummitFacility', 'Test', 'TunableLaser', 'Watcher', 'WeatherForecast']

def GenerateTests(csc, language, dds):
    """Test Suite generator."""
    complete=True
    print("Starting test suite generation...\n")
    if dds:
        print(f"This is a DDS build.")
        path = "DDS_"
    else:
        print(f"This is a Kafka build.")
        path = ""
    if csc == "all":
        for csc in csc_array:
            if ('cpp' in language) or ('all' in language):
                subprocess.check_call([f"./{path}CppPubSub.sh", csc])
                subprocess.check_call([f"./{path}CppEvents.sh", csc])
                #subprocess.check_call([f"./{path}CppState.sh", csc])
                #subprocess.check_call([f"./{path}CppComCon.sh", csc])
            if ('java' in language) or ('all' in language):
                subprocess.check_call([f"./{path}JavaPubSub.sh", csc])
                subprocess.check_call([f"./{path}JavaEvents.sh", csc])
                #subprocess.check_call([f"./{path}JavaState.sh", csc])
                #subprocess.check_call([f"./{path}JavaComCon.sh", csc])
            if ('cpp' not in language) and ('java' not in language) and ('all' not in language):
                complete=False
        print("\nCOMPLETED ALL test suites for ALL CSCs.") if complete else print("This was a " + str(language))
    elif csc in csc_array:
            if ('cpp' in language) or ('all' in language):
                subprocess.check_call([f"./{path}CppPubSub.sh", csc])
                subprocess.check_call([f"./{path}CppEvents.sh", csc])
                #subprocess.check_call([f"./CppState.sh", csc])
                #subprocess.check_call([f"./CppComCon.sh", csc])
            if ('java' in language) or ('all' in language):
                subprocess.check_call([f"./{path}JavaPubSub.sh", csc])
                subprocess.check_call([f"./{path}JavaEvents.sh", csc])
                #subprocess.check_call([f"./{path}JavaState.sh", csc])
                #subprocess.check_call([f"./{path}JavaComCon.sh", csc])
            if ('cpp' not in language) and ('java' not in language) and ('all' not in language):
                complete=False
            print("\nCOMPLETED all test suites for the " + csc + " CSC") if complete else print("This was a " + str(language))
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
        type = str,
        required=False,
        choices=csc_list,
        default='all',
        help='''For which CSC do you want to generate tests? (Default is ALL)''',
    )
    parser.add_argument(
        '-l',
        '--language',
        metavar='LANGUAGE',
        dest='language',
        type = str.lower,
        required=False,
        nargs='+',
        choices=['cpp', 'java', 'all', 'test'],
        default='all',
        help='''Do you want to generate the C++ (cpp), or Java (java) tests? (Default is ALL)''',
    )
    parser.add_argument(
        '-d',
        '--dds',
        action="store_true",
        help='''If True, build the DDS messaging tests, otherwise, build the Kafka messaging tests.''',
    )
    args = parser.parse_args()
    return args

# Get the arguments.
args = DefineArguments()

# Change directory to that of this script. It assumes the other generator scripts are in the same location.
working_dir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
os.chdir(working_dir)

# Now, generate the tests.
if __name__ == "__main__":
    GenerateTests(args.csc, args.language, args.dds)
