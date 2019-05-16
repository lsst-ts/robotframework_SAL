#!/bin/bash
#  Shellscript to create test suite argument file
#  for the C++ Events tests.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

# Define filename
argfile=$HOME/trunk/robotframework_SAL/CppEvents_Tests.list

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
echo "--name CppEvents" >> $argfile
echo "--output CppEvents" >> $argfile
echo "" >> $argfile
echo "# List of test suites" >> $argfile

# Find test suites and add them to the argument file.
ls -1 $HOME/trunk/robotframework_SAL/CPP/Events |sed 's/^/CPP\/Events\//' >> $argfile

# Define Combined interface testig filename
argfile=$HOME/trunk/robotframework_SAL/CombinedCppEvents_Tests.list

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
echo "--name CombinedCppEvents" >> $argfile
echo "--output CombinedCppEvents" >> $argfile
echo "" >> $argfile
echo "# List of test suites" >> $argfile

# Find test suites and add them to the argument file.
ls -1 $HOME/trunk/robotframework_SAL/Combined/CPP/Events |sed 's/^/Combined\/CPP\/Events\//' >> $argfile
