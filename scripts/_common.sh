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

function createSession() {
	local SessionType=$1
    echo "Create $SessionType Session" >> $testSuite
    echo "    [Documentation]    Connect to the SAL host." >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    Comment    Connect to host." >> $testSuite
    echo "    Open Connection    host=\${Host}    alias=$SessionType    timeout=\${timeout}    prompt=\${Prompt}" >> $testSuite
    echo "    Comment    Login." >> $testSuite
    echo "    Log    \${ContInt}" >> $testSuite
    echo "    Login With Public Key    \${UserName}    keyfile=\${KeyFile}    password=\${PassWord}" >> $testSuite
    echo "    Directory Should Exist    \${SALInstall}" >> $testSuite
    echo "    Directory Should Exist    \${SALHome}" >> $testSuite
    echo "" >> $testSuite
}

function subsystemArray() {
	echo "archiver camera catchuparchiver dome domeadb domeaps domelws domelouvers domemoncs domethcs hexapod \
m1m3 m2ms mtmount ocs processingcluster rotator scheduler sequencer tcs"
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
	else
		echo "$entity"
	fi
}
