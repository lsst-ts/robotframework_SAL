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
	local subsystem=$(capitializeSubsystem $1)
	local language=$(echo $2 |tr [a-z] [A-Z]) #Programming language is fully capitalized
	if [ -n "$3" ]; then local topic_type=$(tr '[:lower:]' '[:upper:]' <<< ${3:0:1})${3:1}; else local topic_type=""; fi #Topic type is capitalized 
	echo "==================================== ${subsystem} ${language} ${topic_type} tests ===================================="
	files=$(ls -1 $HOME/trunk/robotframework_SAL/$language/$topic_type/${subsystem}_*)
    if [ $? -eq 0 ]; then
    	echo "Deleting:"
		echo "$files"
    	rm $HOME/trunk/robotframework_SAL/$language/$topic_type/${subsystem}_*
	else
    	echo "Nothing to delete. Continuing..."
	fi
	echo ""
}

function stateArray() {
	echo "enable disable standby start enterControl exitControl abort SetValue"
}

function capitializeSubsystem() {
	# This function returns the CSC name in a pretty-print pattern used only for Test Suite naming.
    local subSystem=$(echo $1 |tr '[:upper:]' '[:lower:]')
	if [ "$subSystem" == "m1m3" ]; then
        echo "M1M3"
    elif [ "$subSystem" == "m2ms" ]; then
        echo "M2MS"
    elif [ "$subSystem" == "ocs" ]; then
        echo "OCS"
    elif [ "$subSystem" == "atcs" ]; then
        echo "ATCS"
	elif [ "$subSystem" == "atarchiver" ]; then
        echo "AtArchiver"
    elif [ "$subSystem" == "atcamera" ]; then
        echo "AtCamera"
	elif [ "$subSystem" == "atheaderservice" ]; then
        echo "AtHeaderService"
	elif [ "$subSystem" == "atmonochromator" ]; then
        echo "AtMonochromator"
	elif [ "$subSystem" == "atscheduler" ]; then
        echo "AtScheduler"
    elif [ "$subSystem" == "mtmount" ]; then
        echo "MTMount"
	elif [ "$subSystem" == "domeadb" ]; then
        echo "DomeADB"
    elif [ "$subSystem" == "domeaps" ]; then
        echo "DomeAPS"
    elif [ "$subSystem" == "domelws" ]; then
        echo "DomeLWS"
    elif [ "$subSystem" == "domelouvers" ]; then
        echo "DomeLouvers"
    elif [ "$subSystem" == "domemoncs" ]; then
        echo "DomeMONCS"
    elif [ "$subSystem" == "domethcs" ]; then
        echo "DomeTHCS"
	elif [ "$subSystem" == "catchuparchiver" ]; then
        echo "CatchupArchiver"
	elif [ "$subSystem" == "promptprocessing" ]; then
        echo "PromptProcessing"
	elif [ "$subSystem" == "efd" ]; then
        echo "EFD"
	elif [ "$subSystem" == "eec" ]; then
        echo "EEC"
	elif [ "$subSystem" == "headerservice" ]; then
        echo "HeaderService"
    elif [ "$subSystem" == "summitfacility" ]; then
        echo "SummitFacility"
    elif [ "$subSystem" == "tcs" ]; then
        echo "TCS"
	elif [ "$subSystem" == "tcsofc" ]; then
        echo "TcsOFC"
	elif [ "$subSystem" == "tcswep" ]; then
        echo "TcsWEP"
	elif [ "$subSystem" == "vms" ]; then
        echo "VMS"
    else
        local var="$(tr '[:lower:]' '[:upper:]' <<< ${subSystem:0:1})${subSystem:1}"
		echo $var
    fi
}

function getEntity() {
	# This function returns the CSC is the defined capitalized convention.
	# ... This corresponds to the folder and file names in ts_xml.
	local entity=$1
	if [ "$entity" == "all" ]; then
        echo "all"
	elif [ "$entity" == "atarchiver" ]; then
		echo "atArchiver"
	elif [ "$entity" == "atheaderservice" ]; then
		echo "atHeaderService"
	elif [ "$entity" == "headerservice" ]; then
		echo "headerService"
	elif [ "$entity" == "atmonochromator" ]; then
		echo "atMonochromator"
	elif [ "$entity" == "atscheduler" ]; then
		echo "atScheduler"
	elif [ "$entity" == "atwhitelight" ]; then
        echo "atWhiteLight"
	elif [ "$entity" == "summitfacility" ]; then
		echo "summitFacility"
	elif [ "$entity" == "calibrationelectrometer" ]; then
		echo "calibrationElectrometer"
	elif [ "$entity" == "promptprocessing" ]; then
		echo "promptprocessing"
	elif [ "$entity" == "mtmount" ]; then
        echo "MTMount"
    elif [ "$entity" == "domeadb" ]; then
        echo "domeADB"
    elif [ "$entity" == "domeaps" ]; then
		echo "domeAPS"
    elif [ "$entity" == "domelws" ]; then
		echo "domeLWS"
    elif [ "$entity" == "domelouvers" ]; then
		echo "domeLouvers"
    elif [ "$entity" == "domemoncs" ]; then
		echo "domeMONCS"
    elif [ "$entity" == "domethcs" ]; then
		echo "domeTHCS"
	elif [ "$entity" == "headerservice" ]; then
		echo "headerService"
	elif [ "$entity" == "tcsofc" ]; then
		echo "tcsOfc"
	elif [ "$entity" == "tcswep" ]; then
		echo "tcsWEP"
	else
		echo "$entity"
	fi
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
	subsystem=$1
	topic=$2
	messageType=$3
	if [[ ("$subsystem" == "summitFacility") ]]; then
		skipped="TSS-2622"
    elif [[ ("$subsystem" == "hexapod") && ("$messageType" == "events") ]]; then
        skipped="TSS-2680"
    elif [[ ("$subsystem" == "hexapod") && ("$messageType" == "telemetry") ]]; then
        skipped="TSS-2679"
	elif [[ ("$subsystem" == "tcsOfc") ]]; then
		skipped="TSS-2625"
	elif [[ ("$subsystem" == "tcsWEP") ]]; then
		skipped="TSS-2626"
	elif [[ ("$subsystem" == "promptprocessing") ]]; then
		skipped="TSS-2633"
	elif [[ ("$subsystem" == "calibrationElectrometer") ]]; then
		skipped="TSS-2619"
	elif [[ ("$subsystem" == "m1m3") ]]; then
		skipped="TSS-2617"
	elif [[ ("$subsystem" == "vms") ]]; then
		skipped="TSS-2618"
	elif [[ ("$subsystem" == "atMonochromator") && ("$topic" == "InternalCommand") ]]; then
		skipped="TSS-2724"
	elif [[ ("$subsystem" == "eec") && ("$topic" == "InternalCommand") ]]; then
		skipped="TSS-2724"
	elif [[ ("$subsystem" == "tcs") && ("$topic" == "InternalCommand") ]]; then
		skipped="TSS-2724"
	else
		skipped=""
	fi
	echo $skipped
}

