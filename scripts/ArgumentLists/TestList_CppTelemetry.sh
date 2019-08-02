#!/bin/bash
#  Shellscript to create test suite argument file
#  for the C++ Telemetry tests.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

# Define filename
argfile=$ROBOT_FRAMEWORK_REPO_DIR/CppTelemetry_Tests.list

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
echo "--name CppTelemetry" >> $argfile
echo "--output CppTelemetry" >> $argfile
echo "" >> $argfile
echo "# List of test suites" >> $argfile

# Find test suites and add them to the argument file.
ls -1 $ROBOT_FRAMEWORK_REPO_DIR/CPP/Telemetry |sed 's/^/CPP\/Telemetry\//' >> $argfile

# Define Combined interface testig filename
argfile=$ROBOT_FRAMEWORK_REPO_DIR/CombinedCppTelemetry_Tests.list

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
echo "--name CombinedCppTelemetry" >> $argfile
echo "--output CombinedCppTelemetry" >> $argfile
echo "" >> $argfile
echo "# List of test suites" >> $argfile

# Find test suites and add them to the argument file.
ls -1 $ROBOT_FRAMEWORK_REPO_DIR/Combined/CPP/Telemetry |sed 's/^/Combined\/CPP\/Telemetry\//' >> $argfile

