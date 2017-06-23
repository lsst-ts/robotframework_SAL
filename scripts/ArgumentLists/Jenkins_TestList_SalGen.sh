#!/bin/bash
#  Shellscript to create test suite argument file
#  for the salgenerator tests.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

# Define filename
argfile=$HOME/trunk/robotframework_SAL/Jenkins_SALGEN.list

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
echo "--name SALGENERATOR" >> $argfile
echo "--output SALGENERATOR" >> $argfile
echo "" >> $argfile
echo "# List of test suites" >> $argfile
echo "rbtsal/Version.robot" >> $argfile
echo "rbtsal/SALGEN/Camera_salgenerator.robot" >> $argfile
echo "rbtsal/SALGEN/M2MS_salgenerator.robot" >> $argfile
echo "rbtsal/SALGEN/MTMount_salgenerator.robot" >> $argfile

