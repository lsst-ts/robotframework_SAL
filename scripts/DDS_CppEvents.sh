#!/bin/bash
#  Shellscript to create test suites for the C++
#  Event/Logger pairs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

# Source common functions
source $ROBOTFRAMEWORK_SAL_DIR/scripts/_common.sh
source $ROBOTFRAMEWORK_SAL_DIR/scripts/_parameters.sh

#  Define variables to be used in script
workDir=$ROBOTFRAMEWORK_SAL_DIR/Separate/DDS_CPP/Events
workDirCombined=$ROBOTFRAMEWORK_SAL_DIR/Combined/DDS_CPP/Events
device=$EMPTY
property=$EMPTY
action=$EMPTY
value=$EMPTY
declare -a topicsArray=($EMPTY)
declare -a parametersArray=($EMPTY)
declare -a argumentsArray=($EMPTY)

#  Determine what tests to generate.
function main() {
    subSystem=$1

    # Get the XML definition file.
    file=($TS_XML_DIR/python/lsst/ts/xml/data/sal_interfaces/$subSystem/*_Events.xml)


    # Get the RuntimeLanguages list
    rtlang=($(getRuntimeLanguages $subSystem))

    # Now generate the test suites.
    if [[ "$rtlang" =~ "cpp" ]]; then
        # Delete all test associated test suites first, to catch any removed topics.
        clearTestSuites $subSystem "DDS_CPP" "Events" || exit 1
        # Create test suite.
        createTestSuite $subSystem $file || exit 1
    else
        echo Skipping: $subSystem has no C++ Event topics.
        return 0
    fi
}

#  Local FUNCTIONS

function createSettings() {
    local subSystem=$1
    local csc_tag=$(echo $subSystem |tr '[:upper:]' '[:lower:]')
    local topic=$(tr '[:lower:]' '[:upper:]' <<< ${2:0:1})${2:1}
    local testSuite=$3
    echo "*** Settings ***" >> $testSuite
    echo "Documentation    ${subSystem}_${topic} communications tests." >> $testSuite
    echo "Force Tags    messaging    cpp    $csc_tag    $skipped" >> $testSuite
    echo "Suite Setup    Log Many    \${subSystem}    \${component}    \${timeout}" >> $testSuite
    echo "Suite Teardown    Terminate All Processes" >> $testSuite
    echo "Library    OperatingSystem" >> $testSuite
    echo "Library    Collections" >> $testSuite
    echo "Library    Process" >> $testSuite
    echo "Library    String" >> $testSuite
    echo "Resource    \${EXECDIR}\${/}common.robot" >> $testSuite
    echo "Resource    \${EXECDIR}\${/}Global_Vars.robot" >> $testSuite
    echo "" >> $testSuite
}

function createVariables() {
    local subSystem=$1
    local testSuite=$2
    local topic=$3
    if [ "$topic" == "all" ]; then
        timeout="180s"
    else
        timeout="3s"
    fi
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${component}    $topic" >> $testSuite
    echo "\${timeout}    $timeout" >> $testSuite
    echo "" >> $testSuite
}

function verifyCompSenderLogger() {
    local testSuite=$1
    echo "Verify Component Sender and Logger" >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    if [ $topic ]; then
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_\${component}_send" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_\${component}_log" >> $testSuite
    else
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_all_sender" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_all_logger" >> $testSuite
    fi
    echo "" >> $testSuite
}

function startLogger() {
    local testSuite=$1
    echo "Start Logger" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Comment    Start Logger." >> $testSuite
    if [ $topic ]; then
        echo "    \${output}=    Start Process    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_\${component}_log    alias=\${subSystem}_Logger    stdout=\${EXECDIR}\${/}stdout.txt    stderr=\${EXECDIR}\${/}stderr.txt" >> $testSuite
        echo "    Log    \${output}" >> $testSuite
        echo "    Should Be Equal    \${output.returncode}   \${NONE}" >> $testSuite
        echo "    Wait Until Keyword Succeeds    60s    5s    File Should Contain    \${EXECDIR}\${/}stdout.txt    === Event \${component} logger ready =" >> $testSuite
    else
        echo "    \${output}=    Start Process    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_all_logger    alias=\${subSystem}_Logger     stdout=\${EXECDIR}\${/}stdout.txt    stderr=\${EXECDIR}\${/}stderr.txt" >> $testSuite
        echo "    Log    \${output}" >> $testSuite
        echo "    Should Be Equal    \${output.returncode}   \${NONE}" >> $testSuite
        echo "    Wait Until Keyword Succeeds    90s    5s    File Should Contain    \${EXECDIR}\${/}stdout.txt    === \${subSystem} loggers ready" >> $testSuite
    fi
    echo "    \${output}=    Get File    \${EXECDIR}\${/}stdout.txt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "" >> $testSuite
}

function startSender() {
    i=0
    #local device=$1
    #local property=$2
    local testSuite=$1
    echo "Start Sender" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Comment    Start Sender." >> $testSuite
    if [ $topic ]; then
        echo "    \${output}=    Run Process    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_\${component}_send     $( printf '%b    ' ${argumentsArray[@]} )" >> $testSuite
    else
         echo "    \${output}=    Run Process    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_all_sender" >> $testSuite
    fi
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    if [ $topic ]; then
        echo "    Comment    ======= Verify \${subSystem}_${item} test messages =======" >> $testSuite
        echo "    \${line}=    Grep File    \${SALWorkDir}/idl-templates/validated/\${subSystem}_revCodes.tcl    \${subSystem}_logevent_${topic}" >> $testSuite
        echo "    @{words}=    Split String    \${line}" >> $testSuite
        echo "    \${revcode}=    Set Variable    \${words}[2]" >> $testSuite
        echo "    Should Contain X Times    \${output.stdout}    [putSample] \${subSystem}::logevent_\${component}_\${revcode} writing a message containing :    1" >> $testSuite
        echo "    Should Contain X Times    \${output.stdout}    revCode \ : \${revcode}    1" >> $testSuite
    else
        for item in "${topicsArray[@]}"; do
            echo "    Comment    ======= Verify \${subSystem}_${item} test messages =======" >> $testSuite
            echo "    \${line}=    Grep File    \${SALWorkDir}/idl-templates/validated/\${subSystem}_revCodes.tcl    \${subSystem}_logevent_${item}" >> $testSuite
            echo "    @{words}=    Split String    \${line}" >> $testSuite
            echo "    \${revcode}=    Set Variable    \${words}[2]" >> $testSuite
            echo "    Should Contain X Times    \${output.stdout}    === Event ${item} iseq = 0    1" >> $testSuite
            echo "    Should Contain X Times    \${output.stdout}    === [putSample] \${subSystem}::logevent_${item}_\${revcode} writing a message containing :    1" >> $testSuite
            echo "    Should Contain    \${output.stdout}    revCode \ : \${revcode}    10" >>$testSuite
            echo "    Should Contain    \${output.stdout}    === Event ${item} generated =" >> $testSuite
        done
    fi
    echo "" >> $testSuite
}

function readLogger() {
    local file=$1
    local topicIndex=$2
    local testSuite=$3
    #local device=$4
    #local property=$5
    echo "Read Logger" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Process    \${subSystem}_Logger" >> $testSuite
    echo "    \${output}=    Wait For Process    handle=\${subSystem}_Logger    timeout=\${timeout}    on_timeout=terminate" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    @{full_list}=    Split To Lines    \${output.stdout}    start=0" >> $testSuite
    echo "    Log Many    @{full_list}" >> $testSuite
    if [ $topic ]; then
        echo "    Should Contain    \${output.stdout}    === Event \${component} logger ready =" >> $testSuite
        readLogger_params $file $topic $topicIndex $testSuite
    else
        echo "    Should Contain    \${output.stdout}    === \${subSystem} loggers ready" >> $testSuite
        itemIndex=1
        for topic in "${topicsArray[@]}"; do
            ## NOTE: Since the priority field was removed in SAL v6.2, there is no common last parameter for each topic.
            ## As such, this script now uses the length of the parametersArray to determine end of the slice.
            unset parametersArray
            parametersArray=($(getTopicParameters $subSystem $file $topic "Events"))
            length=${#parametersArray[@]}
            (( length++ )) ## The end index is exclusive, so increment by 1 to get the full slice.
            ## Redirect the topic definition file to SALGenerics.xml if $topic is Generic.
            for generic in "${generic_events[@]}"; do
                [[ $generic == "$topic" ]] && file=$TS_XML_DIR/python/lsst/ts/xml/data/sal_interfaces/SALGenerics.xml 
            done
            ## Get the slice, then test the output.
            echo "    \${${topic}_start}=    Get Index From List    \${full_list}    === Event ${topic} received =\${SPACE}" >> $testSuite
            echo "    \${end}=    Evaluate    \${${topic}_start}+\${${length}}" >> $testSuite
            echo "    \${${topic}_list}=    Get Slice From List    \${full_list}    start=\${${topic}_start}    end=\${end}" >> $testSuite
            for generic in "${generic_events[@]}"; do
                [[ $generic == "$topic" ]] && local subSystem=SALGeneric  && local file=$TS_XML_DIR/python/lsst/ts/xml/data/sal_interfaces/SALGenerics.xml 
            done
            readLogger_params $file $topic $itemIndex $testSuite
            (( itemIndex++ ))
        done
    fi
}

function readLogger_params() {
    local file=$1
    local topic=$2
    local topicIndex=$3
    local testSuite=$4
    for parameter in "${parametersArray[@]}"; do
        parameterIndex=$(getParameterIndex $parameter ${parametersArray[@]})
        parameterType="$(getParameterType $subSystem $file $topic $parameterIndex "Events")"
        parameterCount=$(getParameterCount $subSystem $file $topic $parameterIndex "Events")
        #echo "topic: $topic parameter:"$parameter "parameterIndex:"$parameterIndex "parameterType:"$parameterType "parameterCount:"$parameterCount "file:"$file""
        if [[ $testSuite == *"$topic"* ]]; then
            topic="full"
        fi
        if [[ ( $parameterCount -ne 1 ) && (( "$parameterType" == "byte" ) || ( "$parameterType" == "octet" )) ]]; then
            #echo "$parameter $parameterType Byte"
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : \\x00    1" >>$testSuite
        elif [[ ( $parameterCount -eq 1 ) && (( "$parameterType" == "byte" ) || ( "$parameterType" == "octet" )) ]]; then
            #echo "$parameter $parameterType Byte"
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : \\x01    1" >>$testSuite
        elif [[ ( $parameterCount -eq 1 ) && ( "$parameterType" == "boolean" ) ]]; then
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : 1    1" >>$testSuite
        elif [[ ( "$parameterType" == "string" ) || ( "$parameterType" == "char" ) ]]; then
            #echo "$parameter $parameterType String or Char"
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : RO    1" >>$testSuite
        elif [[ ( $parameterCount -eq 1 ) && ( "$parameterType" != "string" ) ]]; then
            #echo "$parameter $parameterType Count 1"
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : 1    1" >>$testSuite
    elif [[ ( $parameterCount -ne 1 ) && (( "$parameterType" == "boolean" ) ||  ( "$parameterType" == "float" ) || ( "$parameterType" == "double" ) || ( "$parameterType" == *"short"* ) || ( "$parameterType" == *"int"* ) || ( "$parameterType" == *"long"* )) ]]; then
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : 0    1" >>$testSuite
        else
            #echo "$parameter $parameterType Else"
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : 1    1" >>$testSuite
        fi
    done
}

function createTestSuite() {
    subSystem=$1
    messageType="events"
    file=$2
    topicIndex=1

    # Get the topics for the CSC.
    topicsArray=($(getTopics $subSystem $file $messageType))

    if [ ${#topicsArray[@]} -eq 0 ]; then
        echo Skipping: $subSystem has no Events.
    else
        # Generate the test suite for each topic.
        echo ==== Generating Combined messaging test suite ====
        echo "RuntimeLanguages: $rtlang"
        echo "C++ Events Topics: ${topicsArray[@]}"
        testSuiteCombined=$workDirCombined/${subSystem}_$(tr '[:lower:]' '[:upper:]' <<< ${messageType:0:1})${messageType:1}.robot
        echo $testSuiteCombined
        createSettings $subSystem $messageType $testSuiteCombined
        createVariables $subSystem $testSuiteCombined "all"
        echo "*** Test Cases ***" >> $testSuiteCombined
        verifyCompSenderLogger $testSuiteCombined
        startLogger $testSuiteCombined
        startSender $testSuiteCombined
        readLogger $file $topicIndex $testSuiteCombined
        echo ============== Combined test generation complete ==============
        echo ""
    fi
    # Generate the test suite for each topic.
    #echo ============== Generating Separate messaging test suites ==============
    #topicIndex=1
    #for topic in "${topicsArray[@]}"; do
        #device=$EMPTY
        #property=$EMPTY
        ##  Define test suite name
        #testSuite=$workDir/${subSystem}_${topic}.robot

        ##  Get correct topic source (SAlGenerics or Subsystem XML)
        #for generic in "${generic_events[@]}"; do
            #[[ $generic == "$topic" ]] && local file=$TS_XML_DIR/python/lsst/ts/xml/data/sal_interfaces/SALGenerics.xml
        #done

        ##  Get EFDB_Topic elements
        #getTopicParameters $file $topic
        #device=$( xml sel -t -m "//SALEventSet/SALEvent[$topicIndex]/Device" -v . -n $file )
        #property=$( xml sel -t -m "//SALEventSet/SALEvent[$topicIndex]/Property" -v . -n $file )

        ##  Check if test suite should be skipped.
        #skipped=$(checkIfSkipped $subSystem $topic $messageType)

        ##  Create test suite.
        #echo $testSuite
        #createSettings $subSystem $topic $testSuite
        #createVariables $subSystem $testSuite $topic
        #echo "*** Test Cases ***" >> $testSuite
        #verifyCompSenderLogger $testSuite
        #startLogger $testSuite

        ## Get the arguments to the sender.
        #unset argumentsArray
        ## Determine the parameter type and create a test value, accordingly.
        #for parameter in "${parametersArray[@]}"; do
            #parameterIndex=$(getParameterIndex $parameter)
            #parameterType=$(getParameterType $file $topic $parameterIndex)
            #parameterCount=$(getParameterCount $file $topic $parameterIndex)
            #parameterIDLSize=$(getParameterSize $file $topic $parameterIndex)
            ##echo "parameter:"$parameter "parameterIndex:"$parameterIndex "parameterType:"$parameterType "parameterCount:"$parameterCount "parameterIDLSize:"$parameterIDLSize
            #for i in $(seq 1 $parameterCount); do
                #testValue=$(generateArgument "$parameterType" $parameterIDLSize)
                #argumentsArray+=( $testValue )
            #done
        #done
        ## The Event priority is a required argument to ALL senders, but is not in the XML definitions.
        ## ... As such, manually add this argument as the first element in argumentsArray and parametersArray.
        #parametersArray=("${parametersArray[@]}" "priority")
        #priority=$(python random_value.py long)
        #argumentsArray=("${argumentsArray[@]}" "$priority")
        ## Create the Start Sender test case.
        #startSender $testSuite $device $property
        ## Create the Read Logger test case.
        #readLogger $file $topicIndex $testSuite $device $property
        ## Move to next Topic.
        #(( topicIndex++ ))
    #done
    #echo ==== Separate test generation complete ====
    #echo ""
}

#### Call the main() function ####
main $1
