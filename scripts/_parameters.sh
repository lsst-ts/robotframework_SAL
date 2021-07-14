#!/bin/bash
#  Bash library that defines all the 
#  parameter-related the functions.  Parameters
#  are the arguments to the Command and Event
#  test programs.  The publishers transmit the 
#  parameters to the subscribers.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

###  Variables ###
##
## Arrays that contain all the Generic Commands and Events.
##
declare -a generic_commands=($(xml sel -t -m "//SALObjects/SALCommandSet/SALCommand/EFDB_Topic" -v . -n $TS_XML_DIR/sal_interfaces/SALGenerics.xml |cut -d"_" -f 3 ))
declare -a generic_events=($(xml sel -t -m "//SALObjects/SALEventSet/SALEvent/EFDB_Topic" -v . -n $TS_XML_DIR/sal_interfaces/SALGenerics.xml |cut -d"_" -f 3 ))


###  FUNCTIONS  ###

function getTopicParameters() {
    ## Returns all the parameters (<items>) for the given topic.
    ##
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
    ## Returns the index value for the given parameter.
    ##
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
    ## Returns the data-type (<IDL_Type>) for the given parameter.
    ##
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
    ## Returns the count (<Count>) for the given parameter.
    ##
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
