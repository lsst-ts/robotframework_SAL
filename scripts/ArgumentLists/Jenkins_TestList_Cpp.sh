#!/bin/bash
#  Shellscript to create test suite argument file
#  for the C++ Telemetry tests.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

# Define filename
argfile=$HOME/trunk/robotframework_SAL/Jenkins_CPP.list

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
echo "--name CPP" >> $argfile
echo "--output CPP" >> $argfile
echo "" >> $argfile
echo "# List of test suites" >> $argfile
echo "" >> $argfile

# Find test suites and add them to the argument file.
echo "# CPP Publish/Subscribe Telemetry test suites" >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/CPP/Telemetry/Camera_*` |sed 's/^/rbtsal\/CPP\/Telemetry\//' >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/CPP/Telemetry/MTMount_*` |sed 's/^/rbtsal\/CPP\/Telemetry\//' >> $argfile
echo "" >> $argfile
echo "# CPP State Machine test suites" >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/CPP/StateMachine/Camera_*` |sed 's/^/rbtsal\/CPP\/StateMachine\//' >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/CPP/StateMachine/M2MS_*` |sed 's/^/rbtsal\/CPP\/StateMachine\//' >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/CPP/StateMachine/MTMount_*` |sed 's/^/rbtsal\/CPP\/StateMachine\//' >> $argfile
echo "" >> $argfile
echo "# CPP Commander/Controller test suites" >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/CPP/Commands/Camera_*` |sed 's/^/rbtsal\/CPP\/Commands\//' >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/CPP/Commands/MTMount_*` |sed 's/^/rbtsal\/CPP\/Commands\//' >> $argfile
echo "" >> $argfile
echo "# CPP Event Sender/Logger test suites" >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/CPP/Events/Camera_*` |sed 's/^/rbtsal\/CPP\/Events\//' >> $argfile
basename `ls -1 $HOME/trunk/robotframework_SAL/CPP/Events/MTMount_*` |sed 's/^/rbtsal\/CPP\/Events\//' >> $argfile
