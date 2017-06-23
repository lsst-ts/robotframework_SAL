#!/bin/bash
#  Shellscript to create test suite argument file
#  for the C++ Telemetry tests.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

# Define filename
argfile=$HOME/trunk/robotframework_SAL/Jenkins_Python.list

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
echo "--name PYTHON" >> $argfile
echo "--output PYTHON" >> $argfile
echo "" >> $argfile
echo "# List of test suites" >> $argfile
echo "" >> $argfile

# Find test suites and add them to the argument file.
echo "# PYTHON Publish/Subscribe Telemetry test suites" >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/PYTHON/Telemetry/M2MS_*` |sed 's/^/rbtsal\/PYTHON\/Telemetry\//' >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/PYTHON/Telemetry/MTMount_*` |sed 's/^/rbtsal\/PYTHON\/Telemetry\//' >> $argfile
echo "" >> $argfile
echo "# PYTHON State Machine test suites" >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/PYTHON/StateMachine/Camera_*` |sed 's/^/rbtsal\/PYTHON\/StateMachine\//' >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/PYTHON/StateMachine/M2MS_*` |sed 's/^/rbtsal\/PYTHON\/StateMachine\//' >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/PYTHON/StateMachine/MTMount_*` |sed 's/^/rbtsal\/PYTHON\/StateMachine\//' >> $argfile
echo "" >> $argfile
echo "# PYTHON Commander/Controller test suites" >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/PYTHON/Commands/M2MS_*` |sed 's/^/rbtsal\/PYTHON\/Commands\//' >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/PYTHON/Commands/MTMount_*` |sed 's/^/rbtsal\/PYTHON\/Commands\//' >> $argfile
echo "" >> $argfile
echo "# PYTHON Event Sender/Logger test suites" >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/PYTHON/Events/M2MS_*` |sed 's/^/rbtsal\/PYTHON\/Events\//' >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/PYTHON/Events/MTMount_*` |sed 's/^/rbtsal\/PYTHON\/Events\//' >> $argfile
