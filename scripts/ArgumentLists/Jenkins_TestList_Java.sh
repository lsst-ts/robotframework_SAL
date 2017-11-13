#!/bin/bash
#  Shellscript to create test suite argument file
#  for the C++ Telemetry tests.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

# Define filename
argfile=$HOME/trunk/robotframework_SAL/Jenkins_Java.list

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
echo "--name JAVA" >> $argfile
echo "--output JAVA" >> $argfile
echo "" >> $argfile
echo "# List of test suites" >> $argfile
echo "" >> $argfile

# Find test suites and add them to the argument file.
echo "# JAVA Publish/Subscribe Telemetry test suites" >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/JAVA/Telemetry/Camera_*` |sed 's/^/rbtsal\/JAVA\/Telemetry\//' >> $argfile
echo "" >> $argfile
echo "# JAVA State Machine test suites" >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/JAVA/StateMachine/Camera_*` |sed 's/^/rbtsal\/JAVA\/StateMachine\//' >> $argfile
echo "" >> $argfile
echo "# JAVA Commander/Controller test suites" >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/JAVA/Commands/Camera_*` |sed 's/^/rbtsal\/JAVA\/Commands\//' >> $argfile
echo "" >> $argfile
echo "# JAVA Event Sender/Logger test suites" >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/JAVA/Events/Camera_*` |sed 's/^/rbtsal\/JAVA\/Events\//' >> $argfile

