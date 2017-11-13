#!/bin/bash
#  Shell script to generate login test case.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

#  FUNCTIONS
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
	if [ -n "$3" ]; then local topic_type=$(tr '[:lower:]' '[:upper:]' <<< ${3:0:1})${3:1}${slash}; else local topic_type=""; fi #Topic type is capitalized 
	echo "============================================================================================"
	files=$(ls -1 $HOME/trunk/robotframework_SAL/$language/$topic_type${subsystem}_*)
    if [ $? -eq 0 ]; then
    	echo "Deleting:"
		echo "$files"
    	rm $HOME/trunk/robotframework_SAL/$language/$topic_type${subsystem}_*
	else
    	echo "Nothing to delete. Continuing."
	fi
	echo ""
}

function subsystemArray() {
	echo "archiver camera catchuparchiver dmheaderservice dome domeadb domeaps domelws domelouvers domemoncs domethcs \
eec environment hexapod m1m3 m2ms mtmount ocs processingcluster rotator scheduler sequencer tcs"
}

function stateArray() {
	echo "enable disable abort enterControl exitControl standby start stop"
}

function capitializeSubsystem() {
    local subSystem=$1
	if [ "$subSystem" == "m1m3" ]; then
        echo "M1M3"
    elif [ "$subSystem" == "m2ms" ]; then
        echo "M2MS"
    elif [ "$subSystem" == "ocs" ]; then
        echo "OCS"
    elif [ "$subSystem" == "tcs" ]; then
        echo "TCS"
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
	elif [ "$subSystem" == "processingcluster" ]; then
        echo "ProcessingCluster"
	elif [ "$subSystem" == "eec" ]; then
        echo "EEC"
	elif [ "$subSystem" == "dmheaderservice" ]; then
        echo "DMHeaderService"
	elif [ "$subSystem" == "dmHeaderService" ]; then
        echo "DMHeaderService"
    else
        local var="$(tr '[:lower:]' '[:upper:]' <<< ${subSystem:0:1})${subSystem:1}"
		echo $var
    fi
}

function getEntity() {
	local entity=$1
	if [ "$entity" == "mtmount" ]; then
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
	elif [ "$entity" == "dmheaderservice" ]; then
		echo "dmHeaderService"
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
	if [[ (-z $parameterIDLSize) || ($parameterIDLSize == "1") && ($parameterType == "char" || $parameterType == "string") ]]; then
		parameterIDLSize=$((1 + RANDOM % 1000))
		echo $parameterIDLSize
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
	if [[ ("$subsystem" == "scheduler") && ("$topic" == "blockPusher") ]]; then
		skipped="    TSS-859"
	else
		skipped=""
	fi
	echo $skipped
}

