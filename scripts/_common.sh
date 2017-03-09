#!/bin/bash
#  Shell script to generate login test case.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

#  FUNCTIONS
function getTelemetryTopics() {
	subSystem=$1
    output=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry/EFDB_Topic" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml |sed "s/${subSystem}_//" )
    echo $output
}

function getCommandTopics() {
	subSystem=$1
    output=$( xml sel -t -m "//SALCommandSet/SALCommand/EFDB_Topic" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Commands.xml |sed "s/${subSystem}_command_//" )
    echo $output
}

function getEventTopics() {
	subSystem=$1
    output=$( xml sel -t -m "//SALEventSet/SALEvent/EFDB_Topic" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Events.xml |sed "s/${subSystem}_logevent_//" )
    echo $output
}

function clearTestSuites() {
	# Get the terms into the correct capitalization.
	var=$3
	slash="/"
	subsystem=$(capitializeSubsystem $1)
	language=$(echo $2 |tr [a-z] [A-Z]) #Programming language is fully capitalized
	if [ -z ${var+x} ]; then topic_type=$(tr '[:lower:]' '[:upper:]' <<< ${3:0:1})${3:1}${slash}; else topic_type=""; fi #Topic type is capitalized 
	echo $subsystem
	echo $language
	echo $topic_type
	echo $HOME/trunk/robotframework_SAL/$language/$topic_type${subsystem}_*
	echo "============================================================================================"
	echo "Deleting: $(ls -1 $HOME/trunk/robotframework_SAL/$language/$topic_type${subsystem}_*)"
    rm $HOME/trunk/robotframework_SAL/$language/$topic_type${subsystem}_*
	echo "============================================================================================"
	echo ""
}

function createSession() {
	SessionType=$1
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
	echo "camera dome domeadb domeaps domelws domelouvers domemoncs domethcs dm hexapod m1m3 m2ms mtmount ocs rotator scheduler tcs"
}

function stateArray() {
	echo "enable disable abort enterControl exitControl standby start stop"
}

function capitializeSubsystem() {
    subSystem=$1
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
    elif [ "$subSystem" == "dm" ]; then
        echo "DM"
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
    else
        var="$(tr '[:lower:]' '[:upper:]' <<< ${subSystem:0:1})${subSystem:1}"
		echo $var
    fi
}
