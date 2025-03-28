#!/bin/bash
#  Library for common functions used by all the 
#  scripts.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

###  VARIABLES  ###
added_generics_mandatory_commands=()

added_generics_mandatory_events=(
    "heartbeat",
    "logLevel",
    "logMessage",
    "softwareVersions",
)

added_generics_csc_commands=(
    "disable",
    "enable",
    "exitControl",
    "setLogLevel",
    "standby",
    "start",
)

added_generics_csc_events=(
    "errorCode",
    "simulationMode",
    "summaryState",
)

added_generics_configurable_commands=()

added_generics_configurable_events=(
    "configurationApplied",
    "configurationsAvailable",
)

## The topics listed below must be listed explicitly
## in the AddedGenerics tag in SALSubsystems.xml.
## They are listed here for completeness only.
## The getCommandTopics() and getEventTopics()
## functions handle explicity named topics.

added_generics_NOT_mandatory_commands=(
    "abort",
    "enterControl",
)

added_generics_NOT_mandatory_events=(
    "largeFileObjectAvailable",
    "statusCode",
)


###  FUNCTIONS  ###

function getRuntimeLanguages() {
    ## Returns the <RuntimeLanguages> values for the given CSC (subsystem).
    ##
    local subsystem=$1
    local output=$( xmlstarlet sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subsystem']/RuntimeLanguages" -v . -n $TS_XML_DIR/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml )
    echo $output | tr '[:upper:]' '[:lower:]'
}


function getTopics() {
    ## Returns the Commands|Events|Telemetry topics (<EFDB_Topic>) 
    ## for the given CSC (subsystem).  This includes topics
    ## defined in the CSC interface definitions in $TS_XML_DIR/python/lsst/ts/xml/data/sal_interfaces/<CSC> 
    ## AND any Generic topics, as defined in $TS_XML_DIR/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml.
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
    elif [[ $topic_type == "Commands" ]]; then
        topic_type="Command"
        lower_topic="command"
        keep_num=3
    else
        keep_num=3
    fi
    if [[ -f $file ]]; then
        topics=( $( xmlstarlet sel -t -m "//SAL${topic_type}Set/SAL${topic_type}/EFDB_Topic" -v . -n $file |cut -d"_" -f ${keep_num}- |tr '\r\n' ',' |sed 's/,/, /g' ) )
    else
        topics=()
    fi

    ## If CSC uses the Generic Commands, add those.
    if [[ $topic_type == "Command" ]]; then
        generics=(${added_generics_mandatory_commands[@]})
        generics_field=$( xmlstarlet sel -t -m "//SALSubsystemSet/SALSubsystem/Name[text()='${subSystem}']/../AddedGenerics" -v . -n $TS_XML_DIR/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml )
        if [[ $generics_field == *"csc"* ]]; then
            generics+=("${added_generics_csc_commands[@]}")
        fi
        if [[ $generics_field == *"configurable"* ]]; then
            generics+=("${added_generics_configurable_commands[@]}")
        fi
        array=($(xmlstarlet sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subSystem']" -v AddedGenerics $TS_XML_DIR/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml |sed 's/,//g' ))
        for topic in ${array[@]}; do
            if [[ "$topic" == *"${lower_topic}_"* ]]; then
                str=$(echo " $topic," |sed "s/${lower_topic}_//g")
                generics+="$str"
            fi  
        done
    fi

    ## If CSC uses the Generic Events, add those.
    if [[ $topic_type == "Event" ]]; then
        generics=(${added_generics_mandatory_events[@]})
        generics_field=$( xmlstarlet sel -t -m "//SALSubsystemSet/SALSubsystem/Name[text()='${subSystem}']/../AddedGenerics" -v . -n $TS_XML_DIR/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml )
        if [[ $generics_field == *"csc"* ]]; then
            generics+=("${added_generics_csc_events[@]}")
        fi
        if [[ $generics_field == *"log"* ]]; then
            generics+=("${added_generics_log_events[@]}")
        fi
        if [[ $generics_field == *"configurable"* ]]; then
            generics+=("${added_generics_configurable_events[@]}")
        fi
        array=($(xmlstarlet sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subSystem']" -v AddedGenerics $TS_XML_DIR/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml |sed 's/,//g' ))
        for topic in ${array[@]}; do
            if [[ "$topic" == *"${lower_topic}_"* ]]; then
                str=$(echo " $topic," |sed "s/${lower_topic}_//g")
                generics+="$str"
            fi
        done
    fi
    echo "${topics[@]} ${generics[@]}" |sed 's/,//g'
}


function clearTestSuites() {
    ## Delete the Test Suite, if it exists.  This ensures picking up all
    ## changes, including additions and deletions.
    ##
    local subsystem=$1
    local language=$(echo $2 |tr [a-z] [A-Z]) #Programming language is fully capitalized
    if [ -n "$3" ]; then local topic_type=$(tr '[:lower:]' '[:upper:]' <<< ${3:0:1})${3:1}; else local topic_type=""; fi #Topic type is capitalized 
    echo "==================================== ${subsystem} ${language} ${topic_type} tests ===================================="
    #files=$(ls -1 $ROBOTFRAMEWORK_SAL_DIR/Separate/${path}$language/$topic_type/${subsystem}_* ; ls -1 $ROBOTFRAMEWORK_SAL_DIR/Combined/$language/$topic_type/${subsystem}_${topic_type}*)
    files=$(ls -1 $ROBOTFRAMEWORK_SAL_DIR/Combined/${path}$language/$topic_type/${subsystem}_${topic_type}*)
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

