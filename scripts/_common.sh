#!/bin/bash
#  Library for common functions used by all the 
#  scripts.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org


###  FUNCTIONS  ###

function getRuntimeLanguages() {
    ## Returns the <RuntimeLanguages> values for the given CSC (subsystem).
    ##
    local subsystem=$1
    local output=$( xml sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subsystem']/RuntimeLanguages" -v . -n $HOME/trunk/ts_xml/sal_interfaces/SALSubsystems.xml )
    echo $output | tr '[:upper:]' '[:lower:]'
}


function getTopics() {
    ## Returns the Commands|Events|Telemetry topics (<EFDB_Topic>) 
    ## for the given CSC (subsystem).  This includes topics
    ## defined in the CSC interface definitions in ts_xml/sal_interfaces/<CSC> 
    ## AND any Generic topics, as defined in ts_xml/sal_interfaces/SALSubsystems.xml.
    ##
    local subSystem=$1
    local file=$2
    local topic_type=$(tr '[:lower:]' '[:upper:]' <<< ${3:0:1})${3:1} #Topic type is capitalized 
    local lower_topic=$(echo $topic_type |tr '[:upper:]' '[:lower:]')
    ## The format for Commands|Events|Telemetry topic names are 
    ## unique for each type.  This handles the different cases.
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

    ## If CSC uses the Generic Commands or Events, add those.
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


function clearTestSuites() {
    ## Delete the Test Suite, if it exists.  This ensures picking up all
    ## changes, including additions and deletions.
    ##
    local subsystem=$1
    local language=$(echo $2 |tr [a-z] [A-Z]) #Programming language is fully capitalized
    local slash="/"
    if [ -n "$3" ]; then local topic_type=$(tr '[:lower:]' '[:upper:]' <<< ${3:0:1})${3:1}; else local topic_type=""; fi #Topic type is capitalized 
    echo ""
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
}


function generateArgument() {
    ## Returns a random test-value for the given parameter. 
    ## For strings|chars it uses the randomString function.
    ## For all other data types it call the random_value.py
    ## module.
    ##
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


function randomString() {
    ## Returns a random string for the given `datatype` 
    ## of the given `count` length.
    ##
    datatype=$1
    count=$2
    value=$(cat /dev/random |base64 | tr -dc 'a-zA-Z' | fold -w $count | head -n 1)
    echo $value
}


function checkIfSkipped() {
    ## This function allows test cases to be skipped,
    ## using a Jira ticket TAG. To use, add an if clause
    ## usin the subsystem (CSC) and the specific topic
    ## causing issues and set the `skipped` value equal
    ## to the Jira ticket number.
    ##
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

