#!/bin/bash
#  Bash library to define functions that will 
#  generate test data for Command and Events
#  test programs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

###  Variables ###
declare -a generic_commands=($(xml sel -t -m "//SALObjects/SALCommandSet/SALCommand/EFDB_Topic" -v . -n $TS_XML_DIR/sal_interfaces/SALGenerics.xml |cut -d"_" -f 3 ))
declare -a generic_events=($(xml sel -t -m "//SALObjects/SALEventSet/SALEvent/EFDB_Topic" -v . -n $TS_XML_DIR/sal_interfaces/SALGenerics.xml |cut -d"_" -f 3 ))


###  FUNCTIONS  ###

function getTopicParameters() {
    local subSystem=$1
    local file=$2
    local topic=$3
    local topic_type=$(tr '[:lower:]' '[:upper:]' <<< ${4:0:1})${4:1} #Topic type is capitalized 
    if [[ $topic_type == "Telemetry" ]]; then
        topic_complete=$topic
    elif [[ $topic_type == "Events" ]]; then
        topic_type="Event"
        topic_complete="logevent_${topic}"
    else
        topic_type="Command"
        topic_complete="command_${topic}"
    fi
    output=$( xml sel -t -m "//SAL${topic_type}Set/SAL${topic_type}[EFDB_Topic='${subSystem}_${topic_complete}']/item/EFDB_Name" -v . -n $file |tr '\r\n' ' ' |awk '{$1=$1};1')
    echo $output
}
