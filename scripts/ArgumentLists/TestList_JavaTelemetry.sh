#!/bin/bash
#  Shellscript to create test suite argument file
#  for the Java Telemetry  tests.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

# Define filename
argfile=$ROBOTFRAMEWORK_SAL_DIR/JavaTelemetry_Tests.list

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
echo "--name JavaTelemetry" >> $argfile
echo "--output JavaTelemetry" >> $argfile
echo "" >> $argfile
echo "# List of test suites" >> $argfile

# Find test suites and add them to the argument file.
ls -1 $ROBOTFRAMEWORK_SAL_DIR/JAVA/Telemetry |sed 's/^/JAVA\/Telemetry\//' >> $argfile

# Define Combined interface testig filename
argfile=$ROBOTFRAMEWORK_SAL_DIR/CombinedJavaTelemetry_Tests.list

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
echo "--name CombinedJavaTelemetry" >> $argfile
echo "--output CombinedJavaTelemetry" >> $argfile
echo "" >> $argfile
echo "# List of test suites" >> $argfile

# Find test suites and add them to the argument file.
ls -1 $ROBOTFRAMEWORK_SAL_DIR/Combined/JAVA/Telemetry |sed 's/^/Combined\/JAVA\/Telemetry\//' >> $argfile
