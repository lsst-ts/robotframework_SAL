#!/bin/bash
#  Shell script to generate login test case.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org


###  FUNCTIONS  ###


function getRuntimeLanguages() {
    local subsystem=$1
    local output=$( xml sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subsystem']/RuntimeLanguages" -v . -n $HOME/trunk/ts_xml/sal_interfaces/SALSubsystems.xml )
    echo $output | tr '[:upper:]' '[:lower:]'
}


function getTopics() {
    local subSystem=$1
    local file=$2
    local topic_type=$(tr '[:lower:]' '[:upper:]' <<< ${3:0:1})${3:1} #Topic type is capitalized 
    local lower_topic=$(echo $topic_type |tr '[:upper:]' '[:lower:]')
    local generics=""
    if [[ $topic_type == "Telemetry" ]]; then
        keep_num=2
    elif [[ $topic_type == "Events" ]]; then
        topic_type="Event"
        lower_topic="logevent"
        keep_num=3
    else
        keep_num=3
    fi
    output=$( xml sel -t -m "//SAL${topic_type}Set/SAL${topic_type}/EFDB_Topic" -v . -n $file |cut -d"_" -f ${keep_num}- |tr '\r\n' ' ' |awk '{$1=$1};1')
    topics=$output

    # If CSC uses the Generic Commands or Events, add those.
    if [[ $topic_type == "Command" || $topic_type == "Event" ]]; then
        generics_field=$( xml sel -t -m "//SALSubsystemSet/SALSubsystem/Name[text()='${subSystem}']/../Generics" -v . -n $TS_XML_DIR/sal_interfaces/SALSubsystems.xml )
        if [[ $generics_field == "yes" ]]; then
            local generics=$( xml sel -t -m "//SALObjects/SAL${topic_type}Set/SAL${topic_type}/EFDB_Topic" -v . -n $HOME/trunk/ts_xml/sal_interfaces/SALGenerics.xml |sed "s/SALGeneric_${lower_topic}_//" |tr '\r\n' ' ' )
        elif [[ $generics_field == "no" ]]; then
            local generics=()
        else
            local array=($(xml sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subSystem']" -v Generics $HOME/trunk/ts_xml/sal_interfaces/SALSubsystems.xml |sed 's/,//g' ))
            for topic in ${array[@]}; do
                if [[ "$topic" == *"${lower_topic}_"* ]]; then
                    generics+=$(echo "$topic " |sed "s/${lower_topic}_//g")
                fi
            done
        fi
    fi
    echo "$topics $generics"
}


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


function clearTestSuites() {
    # Get the terms into the correct capitalization.
    local slash="/"
    local subsystem=$1
    local language=$(echo $2 |tr [a-z] [A-Z]) #Programming language is fully capitalized
    if [ -n "$3" ]; then local topic_type=$(tr '[:lower:]' '[:upper:]' <<< ${3:0:1})${3:1}; else local topic_type=""; fi #Topic type is capitalized 
        echo "==================================== ${subsystem} ${language} ${topic_type} tests ===================================="
        #files=$(ls -1 $ROBOTFRAMEWORK_SAL_DIR/Separate/$language/$topic_type/${subsystem}_* ; ls -1 $ROBOTFRAMEWORK_SAL_DIR/Combined/$language/$topic_type/${subsystem}_${topic_type}*)
        files=$(ls -1 $ROBOTFRAMEWORK_SAL_DIR/Combined/$language/$topic_type/${subsystem}_${topic_type}*)
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
    if [[ ("$subsystem" == "atmonochromator") && ("$topic" == "internalcommand") ]]; then
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

