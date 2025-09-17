#!/bin/bash
#  Shellscript to create test suites for the C++
#  Commander/Controller pairs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

# Source common functions
source $ROBOTFRAMEWORK_SAL_DIR/scripts/_common.sh
source $ROBOTFRAMEWORK_SAL_DIR/scripts/_parameters.sh

#  Define variables to be used in script
workDir=$ROBOTFRAMEWORK_SAL_DIR/Separate/CPP/Commands
workDirCombined=$ROBOTFRAMEWORK_SAL_DIR/Combined/CPP/Commands
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
    file=($TS_XML_DIR/python/lsst/ts/xml/data/sal_interfaces/$subSystem/*_Commands.xml)


    # Get the RuntimeLanguages list
    rtlang=($(getRuntimeLanguages $subSystem))

    # Now generate the test suites.
    if [[ "$rtlang" =~ "cpp" ]]; then
        # Delete all test associated test suites first, to catch any removed topics.
        clearTestSuites $subSystem "CPP" "Commands" || exit 1
        # Create test suite.
        createTestSuite $subSystem $file || exit 1
    else
        echo Skipping: $subSystem has no C++ Command topics.
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
        timeout="300s"
    else
        timeout="3s"
    fi
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${component}    $topic" >> $testSuite
    echo "\${timeout}    $timeout" >> $testSuite
    echo "" >> $testSuite
}

function verifyCommanderController() {
    local testSuite=$1
    echo "Verify Component Commander and Controller" >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    if [ $topic ]; then
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_\${component}_commander" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_\${component}_controller" >> $testSuite
    else
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_all_commander" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_all_controller" >> $testSuite
    fi
    echo "" >> $testSuite
}

function startController() {
    local testSuite=$1
    echo "Start Controller" >> $testSuite
    echo "    [Tags]    functional    controller" >> $testSuite
    echo "    Comment    Start Controller." >> $testSuite
    if [ $topic ]; then
        echo "    \${output}=    Start Process    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_\${component}_controller    alias=\${subSystem}_Controller    stdout=\${EXECDIR}\${/}stdout.txt    stderr=\${EXECDIR}\${/}stderr.txt" >> $testSuite
        echo "    Log    \${output}" >> $testSuite
        echo "    Should Be Equal    \${output.returncode}   \${NONE}" >> $testSuite
        echo "    Wait Until Keyword Succeeds    60s    5s    File Should Contain    \${EXECDIR}\${/}stdout.txt    === \${component} controller ready =" >> $testSuite
    else
        echo "    \${output}=    Start Process    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_all_controller    alias=\${subSystem}_Controller     stdout=\${EXECDIR}\${/}stdout.txt    stderr=\${EXECDIR}\${/}stderr.txt" >> $testSuite
        echo "    Log    \${output}" >> $testSuite
        echo "    Should Be Equal    \${output.returncode}   \${NONE}" >> $testSuite
        echo "    Wait Until Keyword Succeeds    90s    5s    File Should Contain    \${EXECDIR}\${/}stdout.txt    === \${subSystem} all controllers ready" >> $testSuite
    fi
    echo "    \${output}=    Get File    \${EXECDIR}\${/}stdout.txt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "" >> $testSuite
}

function startCommander() {
    i=0
    local file=$1
    local topicIndex=$2
    local testSuite=$3
    if [ "$subSystem" == "ATMCS" ] || [ "$subSystem" == "ATPtg" ] || [ "$subSystem" == "ESS" ] || [ "$subSystem" == "Guider" ] || [ "$subSystem" == "MTM1M3" ] || [ "$subSystem" == "MTM1M3TS" ] || [ "$subSystem" == "MTMount" ] || [ "$subSystem" == "MTPtg" ] || [ "$subSystem" == "MTRotator" ] || [ "$subSystem" == "MTVMS" ] || [ "$subSystem" == "Test" ]; then
        jira="DM-49462"
    fi
    echo "Start Commander" >> $testSuite
    echo "    [Tags]    functional    commander    ${jira}    robot:continue-on-failure" >> $testSuite
    echo "    Comment    Start Commander." >> $testSuite
    if [ $topic ]; then
        echo "    \${output}=    Run Process    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_\${component}_commander     $( printf '%b    ' ${argumentsArray[@]} )" >> $testSuite
    else
         echo "    \${output}=    Run Process    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_all_commander" >> $testSuite
    fi
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Not Contain    \${output.stderr}    1/1 brokers are down" >> $testSuite
    echo "    @{full_list}=    Split To Lines    \${output.stdout}    start=0" >> $testSuite
    echo "    Log Many    @{full_list}" >> $testSuite
    if [ $topic ]; then
        echo "    Comment    ======= Verify \${subSystem}_${topic} test messages =======" >> $testSuite
    else
        for item in "${topicsArray[@]}"; do
            ## Redirect the topic definition file to SALGenerics.xml if $item is Generic.
            for generic in "${generic_commands[@]}"; do
                [[ $generic == "$item" ]] && file=$TS_XML_DIR/python/lsst/ts/xml/data/sal_interfaces/SALGenerics.xml
            done
            echo "    Comment    ======= Verify \${subSystem}_${item} test messages =======" >> $testSuite
            echo "    Should Contain    \${output.stdout}    ==== \${subSystem} all commanders ready ====" >> $testSuite
            ## Get the slice, then test the output.
            echo "    \${${item}_start}=    Get Index From List    \${full_list}    === ${subSystem}_${item} start of topic ===" >> $testSuite
            echo "    \${line}=    Get Lines Matching Pattern    \${output.stdout}    === waitForCompletion_${item} command*" >> $testSuite
            echo "    \${${item}_end}=    Get Index From List    \${full_list}    \${line}" >> $testSuite
            echo "    \${${item}_list}=    Get Slice From List    \${full_list}    start=\${${item}_start}    end=\${${item}_end+3}" >> $testSuite
            echo "    Log    \${${item}_list}" >> $testSuite
            echo "    Should Contain X Times    \${${item}_list}    === \${subSystem}_${item} start of topic ===    1" >> $testSuite
            CommanderController_params $file $item $topicIndex $testSuite
            echo "    Should Contain    \${${item}_list}    === issueCommand_${item} writing a command containing :" >> $testSuite
            echo "    Should Contain    \${line}    completed ok" >> $testSuite
            echo "    Should Contain    \${${item}_list}[-2]    Command roundtrip was" >> $testSuite
            echo "    Should Be Equal    \${${item}_list}[-1]    303" >> $testSuite
            echo "    Should Contain    \${${item}_list}    === \${subSystem}_${item} end of topic ===" >> $testSuite
        done
    fi
    echo "" >> $testSuite
}

function readController() {
    local file=$1
    local topicIndex=$2
    local testSuite=$3
    #local device=$4
    #local property=$5
    if [ "$subSystem" == "MTM1M3" ] || [ "$subSystem" == "MTM1M3TS" ] || [ "$subSystem" == "MTVMS" ]; then
        jira="DM-49462"
    fi
    echo "Read Controller" >> $testSuite
    echo "    [Tags]    functional    controller    ${jira}    robot:continue-on-failure" >> $testSuite
    echo "    Switch Process    \${subSystem}_Controller" >> $testSuite
    echo "    \${output}=    Wait For Process    handle=\${subSystem}_Controller    timeout=\${timeout}    on_timeout=terminate" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Not Contain    \${output.stderr}    1/1 brokers are down" >> $testSuite
    echo "    Should Not Contain    \${output.stderr}    Consume failed" >> $testSuite
    echo "    Should Not Contain    \${output.stderr}    Broker: Unknown topic or partition" >> $testSuite
    echo "    @{full_list}=    Split To Lines    \${output.stdout}    start=0" >> $testSuite
    echo "    Log Many    @{full_list}" >> $testSuite
    if [ $topic ]; then
        echo "    Should Contain    \${output.stdout}    === \${subSystem}_\${component} controller ready" >> $testSuite
        CommanderController_params $file $topic $topicIndex $testSuite
    else
        echo "    Should Contain    \${output.stdout}    ==== \${subSystem} all controllers ready ====" >> $testSuite
        itemIndex=1
        for topic in "${topicsArray[@]}"; do
            ## Redirect the topic definition file to SALGenerics.xml if $topic is Generic.
            for generic in "${generic_commands[@]}"; do
                [[ $generic == "$topic" ]] && file=$TS_XML_DIR/python/lsst/ts/xml/data/sal_interfaces/SALGenerics.xml 
            done
            ## Get the slice, then test the output.
            echo "    \${${topic}_start}=    Get Index From List    \${full_list}    === ${subSystem}_${topic} start of topic ===" >> $testSuite
            echo "    \${${topic}_end}=    Get Index From List    \${full_list}    === ${subSystem}_${topic} end of topic ===" >> $testSuite
            echo "    \${${topic}_list}=    Get Slice From List    \${full_list}    start=\${${topic}_start}    end=\${${topic}_end+1}" >> $testSuite
            echo "    Log    \${${topic}_list}" >> $testSuite
            echo "    Should Contain X Times    \${${topic}_list}    === \${subSystem}_${topic} start of topic ===    1" >> $testSuite
            CommanderController_params $file $topic $itemIndex $testSuite
            echo "    Should Contain X Times    \${${topic}_list}    === ackCommand_${topic} acknowledging a command with :    2" >> $testSuite
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}ack\${SPACE}\${SPACE}\${SPACE}\${SPACE}\${SPACE}\${SPACE}: 301    1" >> $testSuite
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}ack\${SPACE}\${SPACE}\${SPACE}\${SPACE}\${SPACE}\${SPACE}: 303    1" >> $testSuite
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}result\${SPACE}\${SPACE}\${SPACE}: Ack : OK    1" >> $testSuite
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}result\${SPACE}\${SPACE}\${SPACE}: Done : OK    1" >> $testSuite
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}error\${SPACE}\${SPACE}\${SPACE}\${SPACE}: 0    2" >> $testSuite
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}timeout\${SPACE}\${SPACE}: 0    2" >> $testSuite
            echo "    Should Contain X Times    \${${topic}_list}    === \${subSystem}_${topic} end of topic ===    1" >> $testSuite
            (( itemIndex++ ))
        done
    fi
}

function CommanderController_params() {
    local file=$1
    local topic=$2
    local topicIndex=$3
    local testSuite=$4
    unset parametersArray
    parametersArray=($(getTopicParameters $subSystem $file $topic "Commands"))
    for parameter in "${parametersArray[@]}"; do
        parameterIndex=$(getParameterIndex $parameter ${parametersArray[@]})
        parameterType="$(getParameterType $subSystem $file $topic $parameterIndex "Command")"
        parameterCount=$(getParameterCount $subSystem $file $topic $parameterIndex "Command")
        #echo "topic: $topic parameter:"$parameter "parameterIndex:"$parameterIndex "parameterType:"$parameterType "parameterCount:"$parameterCount "file:"$file""
        if [[ $testSuite == *"$topic"* ]]; then
            topic="full"
        fi
        #echo "Parameter details: $parameter $parameterType $parameterCount"
        if [[ ( $parameterCount -ne 1 ) && (( "$parameterType" == "byte" ) || ( "$parameterType" == "octet" )) ]]; then
            #echo "$parameter $parameterType Byte"
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : 0    1" >>$testSuite
        elif [[ ( $parameterCount -eq 1 ) && (( "$parameterType" == "byte" ) || ( "$parameterType" == "octet" )) ]]; then
            #echo "$parameter $parameterType Byte"
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : 1    1" >>$testSuite
        elif [[ ( $parameterCount -eq 1 ) && ( "$parameterType" == "boolean" ) ]]; then
            #echo "$parameter $parameterType boolean Count == 1"
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : 1    1" >>$testSuite
        elif [[ ( "$parameterType" == "string" ) || ( "$parameterType" == "char" ) ]]; then
            #echo "$parameter $parameterType String or Char"
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : RO    1" >>$testSuite
        elif [[ ( $parameterCount -eq 1 ) && ( "$parameterType" != "string" ) ]]; then
            #echo "$parameter $parameterType Count 1"
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : 1    1" >>$testSuite
        elif [[ ( $parameterCount -ne 1 ) && (( "$parameterType" == "boolean" ) ||  ( "$parameterType" == "float" ) || ( "$parameterType" == "double" ) || ( "$parameterType" == *"short"* ) || ( "$parameterType" == *"int"* ) || ( "$parameterType" == *"long"* )) ]]; then
            #echo "$parameter $parameterType Count != 1"
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : 0    1" >>$testSuite
        else
            #echo "$parameter $parameterType Else"
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : 1    1" >>$testSuite
        fi
    done
}

function createTestSuite() {
    subSystem=$1
    messageType="commands"
    file=$2
    topicIndex=1

    # Get the topics for the CSC.
    topicsArray=($(getTopics $subSystem $file $messageType))

    if [ ${#topicsArray[@]} -eq 0 ]; then
        echo Skipping: $subSystem has no Commands.
    else
        # Generate the test suite for each topic.
        echo ==== Generating Combined messaging test suite ====
        echo "RuntimeLanguages: $rtlang"
        echo "C++ Command Topics: ${topicsArray[@]}"
        testSuiteCombined=$workDirCombined/${subSystem}_$(tr '[:lower:]' '[:upper:]' <<< ${messageType:0:1})${messageType:1}.robot
        echo $testSuiteCombined
        createSettings $subSystem $messageType $testSuiteCombined
        createVariables $subSystem $testSuiteCombined "all"
        echo "*** Test Cases ***" >> $testSuiteCombined
        verifyCommanderController $testSuiteCombined
        startController $testSuiteCombined
        startCommander $file $topicIndex $testSuiteCombined
        readController $file $topicIndex $testSuiteCombined
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
