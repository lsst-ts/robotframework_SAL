#!/bin/bash
#  Shellscript to create test suite argument file
#  for the C++ State tests.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

# Define filename
argfile=$ROBOTFRAMEWORK_SAL_DIR/PythonGenericEvents_Tests.list

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
echo "--name PythonGenericEvents" >> $argfile
echo "--output PythonGenericEvents" >> $argfile
echo "" >> $argfile
echo "# List of test suites" >> $argfile

# Find test suites and add them to the argument file.
ls -1 $ROBOTFRAMEWORK_SAL_DIR/PYTHON/GenericEvents/ |sed 's/^/PYTHON\/GenericEvents\//' >> $argfile
