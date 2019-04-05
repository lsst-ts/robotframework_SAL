#!/bin/bash
#  Shell script to generate login test case.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

#  FUNCTIONS
function generateTests() {
	csc=$( echo "$arg" |tr '[:upper:]' '[:lower:]' )
	if [ "$csc" == "all" ]; then
    	for subsystem in "${subSystemArray[@]}"; do
        	createTestSuite $subsystem
    	done
    	echo COMPLETED ALL test suites for ALL CSCs.
	elif [[ ${subSystemArray[*]} =~ $csc ]]; then
    	createTestSuite $csc
    	echo COMPLETED all test suites for the $csc.
	else
    	echo USAGE - Argument must be one of: ALL or \[ ${subSystemArray[*]} \].
	fi
}

function getTelemetryTopics() {
	local subSystem=$(getEntity $1)
    local output=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry/EFDB_Topic" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml |sed "s/${subSystem}_//" )
    echo $output
}

function getCommandTopics() {
	local subSystem=$1
    local output=$( xml sel -t -m "//SALCommandSet/SALCommand/EFDB_Topic" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Commands.xml |sed "s/${subSystem}_command_//" )
    echo $output
}

function getEventTopics() {
	local subSystem=$1
    local output=$( xml sel -t -m "//SALEventSet/SALEvent/EFDB_Topic" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Events.xml |sed "s/${subSystem}_logevent_//" )
    echo $output
}

function clearTestSuites() {
	# Get the terms into the correct capitalization.
	local slash="/"
	local subsystem=$1
	local language=$(echo $2 |tr [a-z] [A-Z]) #Programming language is fully capitalized
	if [ -n "$3" ]; then local topic_type=$(tr '[:lower:]' '[:upper:]' <<< ${3:0:1})${3:1}; else local topic_type=""; fi #Topic type is capitalized 
	echo "==================================== ${subsystem} ${language} ${topic_type} tests ===================================="
	files=$(ls -1 $HOME/trunk/robotframework_SAL/Separate/$language/$topic_type/${subsystem}_* ; ls -1 $HOME/trunk/robotframework_SAL/Combined/$language/$topic_type/${subsystem}_${topic_type}*)
    if [ $? -eq 0 ]; then
    	echo "Deleting:"
		echo "$files"
    	rm $files
	else
    	echo "Nothing to delete. Continuing..."
	fi
	echo ""
}

function stateArray() {
	echo "enable disable standby start stop enterControl exitControl abort SetValue"
}

function capitializeSubsystem() {
	# This function returns the CSC name in a pretty-print pattern used only for Test Suite naming.
	echo $1
}

function getEntity() {
	# This function returns the CSC is the defined capitalized convention.
	# ... This corresponds to the folder and file names in ts_xml.
	local entity=$1
	echo "$entity"
}

function randomString() {
	datatype=$1
	count=$2
	value=$(cat /dev/random |base64 | tr -dc 'a-zA-Z' | fold -w $count | head -n 1)
	echo $value
}

function generateArgument() {
	parameterType=$1
	parameterIDLSize=$2
	# For string and char, an IDL_Size of 1 means arbitrary size, so set parameterIDLSize to a random, positive number.
	if [[ (-z $parameterIDLSize || $parameterIDLSize == "1") && ($parameterType == "char" || $parameterType == "string") ]]; then
		parameterIDLSize=$((1 + RANDOM % 1000))
	fi	

	###### Set the test value. ######
	# For char and string, the ONE argument is of length IDL_Size.
	if [[ ($parameterType == "char") || ($parameterType == "string") ]]; then
		testValue=$(randomString "$parameterType" $parameterIDLSize)
	# For everything else, arrays are allowed.  This is handled in the calling script.
	else
		testValue=$(python random_value.py "$parameterType")
	fi
	echo $testValue
}

function checkIfSkipped() {
	subsystem=$(echo $1 |tr '[:upper:]' '[:lower:]')
	topic=$(echo $2 |tr '[:upper:]' '[:lower:]')
	messageType=$(echo $3 |tr '[:upper:]' '[:lower:]')
	if [[ ("$subsystem" == "summitfacility") ]]; then
		skipped="TSS-2622"
    elif [[ ("$subsystem" == "hexapod") && ("$messageType" == "events") ]]; then
        skipped="TSS-2680"
    elif [[ ("$subsystem" == "hexapod") && ("$messageType" == "telemetry") ]]; then
        skipped="TSS-2679"
	elif [[ ("$subsystem" == "promptprocessing") ]]; then
		skipped="TSS-2633"
	elif [[ ("$subsystem" == "calibrationelectrometer") ]]; then
		skipped="TSS-2619"
	elif [[ ("$subsystem" == "m1m3") ]]; then
		skipped="TSS-2617"
	elif [[ ("$subsystem" == "vms") ]]; then
		skipped="TSS-2618"
	elif [[ ("$subsystem" == "atmonochromator") && ("$topic" == "internalcommand") ]]; then
		skipped="TSS-2724"
	elif [[ ("$subsystem" == "eec") && ("$topic" == "internalcommand") ]]; then
		skipped="TSS-2724"
	elif [[ ("$subsystem" == "tcs") && ("$topic" == "internalcommand") ]]; then
		skipped="TSS-2724"
	else
		skipped=""
	fi
	echo $skipped
}

