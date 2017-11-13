#!/bin/bash
#  Shellscript to create test suite argument file
#  for the C++ State tests.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

# Define filename
argfile=$HOME/trunk/robotframework_SAL/JavaStateMachine_Tests.list

# Find and remove old argument file.
ls $argfile 1>/dev/null
if [ $? -eq 0 ]; then
	echo "Deleteing $argfile"
	rm $argfile
else
	echo "$argfile does not exist.  Continuing."
fi

# Setup argument file
echo "###  Test Suite list ###" >> $argfile
echo "#  Change the title of the test results" >> $argfile
echo "--name JavaStateMachine" >> $argfile
echo "--output JavaStateMachine" >> $argfile
echo "" >> $argfile
echo "# List of test suites" >> $argfile

# Find test suites and add them to the argument file.
ls -1 $HOME/trunk/robotframework_SAL/JAVA/StateMachine |sed 's/^/JAVA\/StateMachine\//' >> $argfile
