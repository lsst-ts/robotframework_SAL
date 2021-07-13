#!/bin/bash
#  Shellscript to create test suites for the C++
#  Publisher/Subscribers pairs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org


# Source common functions
source $ROBOTFRAMEWORK_SAL_DIR/scripts/_common.sh
source $ROBOTFRAMEWORK_SAL_DIR/scripts/_parameters.sh


#  Define variables to be used in script
workDir=$ROBOTFRAMEWORK_SAL_DIR/Separate/CPP/Telemetry
workDirCombined=$ROBOTFRAMEWORK_SAL_DIR/Combined/CPP/Telemetry
declare -a topicsArray=($EMPTY)
declare -a parametersArray=($EMPTY)

#  Determine what tests to generate. Call _common.sh.generateTests()
function main() {
    subSystem=$1

    # Get the XML definition file.
    file=($TS_XML_DIR/sal_interfaces/$subSystem/*_Telemetry.xml)


    # Get the RuntimeLanguages list
    rtlang=($(getRuntimeLanguages $subSystem))

    # Now generate the test suites.
    if [[ "$rtlang" =~ "cpp" ]]; then
        # Delete all test associated test suites first, to catch any removed topics.
        clearTestSuites $subSystem "CPP" "Telemetry" || exit 1
        # Create test suite.
        createTestSuite $subSystem $file || exit 1
    else
        echo Skipping: $subSystem has no C++ Telemetry topics.
        return 0
    fi
}

### Local FUNCTIONS ###

function createSettings {
    local subSystem=$1
    local topic=$(tr '[:lower:]' '[:upper:]' <<< ${2:0:1})${2:1}
    local testSuite=$3
    echo "*** Settings ***" >> $testSuite
    echo "Documentation    $(capitializeSubsystem $subSystem) ${topic} communications tests." >> $testSuite
    echo "Force Tags    messaging    cpp    $skipped" >> $testSuite
    echo "Suite Setup    Log Many    \${timeout}    \${subSystem}    \${component}" >> $testSuite
    echo "Suite Teardown    Terminate All Processes" >> $testSuite
    echo "Library    OperatingSystem" >> $testSuite
    echo "Library    Collections" >> $testSuite
    echo "Library    Process" >> $testSuite
    echo "Library    String" >> $testSuite
    echo "Resource    \${EXECDIR}\${/}Global_Vars.robot" >> $testSuite
    echo "" >> $testSuite
}

function createVariables {
    local subSystem=$1
    local testSuite=$2
    local topic=$3
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${component}    $topic" >> $testSuite
    echo "\${timeout}    15s" >> $testSuite
    echo "" >> $testSuite
}

function verifyCompPubSub {
    local testSuite=$1
    echo "Verify Component Publisher and Subscriber" >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    if [ $topic ]; then
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}_\${component}/cpp/standalone/sacpp_\${subSystem}_pub" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}_\${component}/cpp/standalone/sacpp_\${subSystem}_sub" >> $testSuite
    else
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_all_publisher" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_all_subscriber" >> $testSuite
    fi
    echo "" >> $testSuite
}

function startSubscriber {
    local testSuite=$1
    echo "Start Subscriber" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Comment    Start Subscriber." >> $testSuite
    if [ $topic ]; then
        echo "    \${output}=    Start Process    \${SALWorkDir}/\${subSystem}_\${component}/cpp/standalone/sacpp_\${subSystem}_sub    alias=\${subSystem}_Subscriber" >> $testSuite
    else
        echo "    \${output}=    Start Process    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_all_subscriber    alias=\${subSystem}_Subscriber    stdout=\${EXECDIR}\${/}\${subSystem}_stdout.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    fi
    echo "    Should Contain    \"\${output}\"   \"1\"" >> $testSuite
    echo "    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    \${EXECDIR}\${/}\${subSystem}_stdout.txt" >> $testSuite
	echo "    Comment    Sleep for 6s to allow DDS time to register all the topics." >> $testSuite
    echo "    Sleep    6s" >> $testSuite
    echo "    \${output}=    Get File    \${EXECDIR}\${/}\${subSystem}_stdout.txt" >> $testSuite
    echo "    Should Contain    \${output}    ===== ${subSystem} subscribers ready =====" >> $testSuite
    echo "" >> $testSuite
}

function startPublisher {
    local testSuite=$1
    echo "Start Publisher" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Comment    Start Publisher." >> $testSuite
    if [ $topic ]; then
        echo "    \${output}=    Run Process    \${SALWorkDir}/\${subSystem}_\${component}/cpp/standalone/sacpp_\${subSystem}_pub" >> $testSuite
    else
        echo "    \${output}=    Run Process    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_all_publisher" >> $testSuite
    fi
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    if [ $topic ]; then
        echo "    Comment    ======= Verify \${subSystem}_${item} test messages =======" >> $testSuite
        echo "    \${line}=    Grep File    \${SALWorkDir}/idl-templates/validated/\${subSystem}_revCodes.tcl    \${subSystem}_${topic}" >> $testSuite
        echo "    @{words}=    Split String    \${line}" >> $testSuite
        echo "    \${revcode}=    Set Variable    \${words}[2]" >> $testSuite
        echo "    Should Contain X Times    \${output.stdout}    [putSample] \${subSystem}::\${component}_\${revcode} writing a message containing :    9" >> $testSuite
        echo "    Should Contain X Times    \${output.stdout}    revCode \ : \${revcode}    9" >> $testSuite
    else
        for item in "${topicsArray[@]}"; do
            echo "    Comment    ======= Verify \${subSystem}_${item} test messages =======" >> $testSuite
            echo "    \${line}=    Grep File    \${SALWorkDir}/idl-templates/validated/\${subSystem}_revCodes.tcl    \${subSystem}_${item}" >> $testSuite
            echo "    @{words}=    Split String    \${line}" >> $testSuite
            echo "    \${revcode}=    Set Variable    \${words}[2]" >> $testSuite
            echo "    Should Contain    \${output.stdout}    === ${subSystem}_${item} start of topic ===" >> $testSuite
            echo "    Should Contain X Times    \${output.stdout}    [putSample] \${subSystem}::${item}_\${revcode} writing a message containing :    10" >> $testSuite
            echo "    Should Contain X Times    \${output.stdout}    revCode \ : \${revcode}    10" >> $testSuite
            echo "    Should Contain    \${output.stdout}    === ${subSystem}_${item} end of topic ===" >> $testSuite
        done
    fi
    echo "" >> $testSuite
}

function readSubscriber {
    file=$1
    topicIndex=$2
    local testSuite=$3
    echo "Read Subscriber" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Process    \${subSystem}_Subscriber" >> $testSuite
    echo "    \${output}=    Wait For Process    \${subSystem}_Subscriber    timeout=\${timeout}    on_timeout=terminate" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    ===== $subSystem subscribers ready =====" >> $testSuite
    echo "    @{full_list}=    Split To Lines    \${output.stdout}    start=1" >> $testSuite
    if [ $topic ]; then
        readSubscriber_params $file $topic $topicIndex $testSuite
    else
        itemIndex=1
        for item in "${topicsArray[@]}"; do
            echo "    \${${item}_start}=    Get Index From List    \${full_list}    === ${subSystem}_${item} start of topic ===" >> $testSuite
            echo "    \${${item}_end}=    Get Index From List    \${full_list}    === ${subSystem}_${item} end of topic ===" >> $testSuite
            echo "    \${${item}_list}=    Get Slice From List    \${full_list}    start=\${${item}_start}    end=\${${item}_end}" >> $testSuite
            parametersArray=($(getTopicParameters $subSystem $file $item "Telemetry"))
            readSubscriber_params $file $item $itemIndex $testSuite
            (( itemIndex++ ))
        done
    fi
}

function readSubscriber_params {
    local file=$1
    local topic=$2
    local topicIndex=$3
    local testSuite=$4
    for parameter in "${parametersArray[@]}"; do
        #if [ $topic ]; then
            #n=1
        #else
            #n=$(xml sel -t -m "//SALTelemetrySet/SALTelemetry/item/EFDB_Name" -v . -n $file |sort |grep -cw $parameter)
        #fi
        parameterIndex=$(getParameterIndex $parameter ${parametersArray[@]})
        parameterType="$(getParameterType $subSystem $file $topic $parameterIndex "Telemetry")"
        parameterCount=$(getParameterCount $subSystem $file $topic $parameterIndex "Telemetry")
        #echo "parameter:"$parameter "parameterIndex:"$parameterIndex "parameterType:"$parameterType "parameterCount:"$parameterCount "file:"$file""
        if [[ ( $parameterCount -eq 1 ) && (( "$parameterType" == "byte" ) || ( "$parameterType" == "octet" )) ]]; then
            #echo "$parameter $parameterType Byte"
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : \\x01    10" >>$testSuite
        elif [[ ( $parameterCount -eq 1 ) && ( "$parameterType" == "boolean" ) ]]; then
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : 1    10" >>$testSuite
        elif [[ ( "$parameterType" == "string" ) || ( "$parameterType" == "char" ) ]]; then
            #echo "$parameter $parameterType String or Char"
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : RO    10" >>$testSuite
        elif [[ ( $parameterCount -eq 1 ) && ( "$parameterType" != "string" ) ]]; then
            #echo "$parameter $parameterType Count 1"
            echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : 1    10" >>$testSuite
        elif [[ ( $parameterCount -ne 1 ) && (( "$parameterType" == "byte" ) || ( "$parameterType" == "octet" )) ]]; then
            for num in `seq 0 9`; do
                echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : \\x0${num}    1" >>$testSuite
            done
        else
            #echo "$parameter $parameterType Else"
            for num in `seq 0 9`; do
                echo "    Should Contain X Times    \${${topic}_list}    \${SPACE}\${SPACE}\${SPACE}\${SPACE}$parameter : $num    1" >>$testSuite
            done
        fi
    done
}

function createTestSuite {
    subSystem=$1
    messageType="telemetry"
    file=$2
    topicIndex=1

    # Get the topics for the CSC.
    topicsArray=($(getTopics $subSystem $file $messageType))

    if [ ${#topicsArray[@]} -eq 0 ]; then
        echo Skipping: $subSystem has no telemetry.
    else
        # Generate the test suite for each message type.
        echo Generating test suite:
        testSuiteCombined=$workDirCombined/$(capitializeSubsystem $subSystem)_$(tr '[:lower:]' '[:upper:]' <<< ${messageType:0:1})${messageType:1}.robot
        echo $testSuiteCombined
        createSettings $subSystem $messageType $testSuiteCombined
        createVariables $subSystem $testSuiteCombined "all"
        echo "*** Test Cases ***" >> $testSuiteCombined
        verifyCompPubSub $testSuiteCombined
        startSubscriber $testSuiteCombined
        startPublisher $testSuiteCombined
        readSubscriber $file $topicIndex $testSuiteCombined
        echo ==== Combined Telemetry test generation complete ====
        echo ""
    fi
    # Generate the test suite for each topic.
    #echo ============== Generating Separate messaging test suites ==============
    #topicIndex=1
    #for topic in "${topicsArray[@]}"; do
    ##  Define test suite name
    #testSuite=$workDir/$(capitializeSubsystem $subSystem)_${topic}.robot
        
    #  Get EFDB_Topic Telemetry parameters
    #getTopicParameters $file $topicIndex

    #  Check if test suite should be skipped.
    #skipped=$(checkIfSkipped $subSystem $topic $messageType)

    #  Create test suite.
    #echo $testSuite
    #createSettings $subSystem $topic $testSuite
    #createVariables $subSystem $testSuite $topic
    #echo "*** Test Cases ***" >> $testSuite
    #verifyCompPubSub $testSuite
    #startSubscriber $testSuite
    #startPublisher $testSuite
    #readSubscriber $file $topicIndex $testSuite
    #(( topicIndex++ ))
    #done
    #echo Generation complete
    #echo ""
}

#### Call the main() function ####
main $1
