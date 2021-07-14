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


function getParameterIndex() {
    value=$1
    shift
    array=("$@")
    for i in "${!array[@]}"; do
        if [[ "${array[$i]}" = "${value}" ]]; then
            index=$i
        fi
    done
    echo $index
}


function getParameterType() {
    local subSystem=$1
    local file=$2
    local topic=$3
    local index=$(($4 + 1))    # Item indices start at 1, while bash arrays start at 0. Add 1 to index to compensate.
    local topic_type=$(tr '[:lower:]' '[:upper:]' <<< ${5:0:1})${5:1} #Topic type is capitalized 
    if [[ $topic_type == "Telemetry" ]]; then
        topic_complete=$topic
    elif [[ $topic_type == "Events" ]]; then
        topic_type="Event"
        topic_complete="logevent_${topic}"
    else
        topic_type="Command"
        topic_complete="command_${topic}"
    fi
    if [[ ${generic_events[@]} =~ "${topic}<" ]]; then
        local subSystem=SALGeneric
        local file=$TS_XML_DIR/sal_interfaces/SALGenerics.xml 
    fi
    #echo "xml sel -t -m \"//SAL${topic_type}Set/SAL${topic_type}/EFDB_Topic[text()='${subSystem}_${topic_complete}']/../item[$index]/IDL_Type\" -v . -n $file"
    parameterType=$( xml sel -t -m "//SAL${topic_type}Set/SAL${topic_type}/EFDB_Topic[text()='${subSystem}_${topic_complete}']/../item[$index]/IDL_Type" -v . -n $file )
    echo $parameterType
}


function getParameterCount() {
    local subSystem=$1
    local file=$2
    local topic=$3
    local index=$(($4 + 1))    # Item indices start at 1, while bash arrays start at 0. Add 1 to index to compensate.
    local topic_type=$(tr '[:lower:]' '[:upper:]' <<< ${5:0:1})${5:1} #Topic type is capitalized 
    if [[ $topic_type == "Telemetry" ]]; then
        topic_complete=$topic
    elif [[ $topic_type == "Events" ]]; then
        topic_type="Event"
        topic_complete="logevent_${topic}"
    else
        topic_type="Command"
        topic_complete="command_${topic}"
    fi
    if [[ ${generic_events[@]} =~ "${topic}<" ]]; then
        local subSystem=SALGeneric
        local file=$TS_XML_DIR/sal_interfaces/SALGenerics.xml 
    fi
    #echo "xml sel -t -m \"//SAL${topic_type}Set/SAL${topic_type}/EFDB_Topic[text()='${subSystem}_${topic_complete}']/../item[$index]/Count\" -v . -n $file"
    count=$( xml sel -t -m "//SAL${topic_type}Set/SAL${topic_type}/EFDB_Topic[text()='${subSystem}_${topic_complete}']/../item[$index]/Count" -v . -n $file )
    echo $count
}
