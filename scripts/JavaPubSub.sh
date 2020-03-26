#!/bin/bash
#  Shellscript to create test suites for the C++
#  Publisher/Subscribers pairs.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org


# Source common functions
source $ROBOTFRAMEWORK_SAL_DIR/scripts/_common.sh

#  Define variables to be used in script
workDir=$ROBOTFRAMEWORK_SAL_DIR/Java/Telemetry
workDirCombined=$ROBOTFRAMEWORK_SAL_DIR/Combined/JAVA/Telemetry
arg=${1-all}
#arg="$(echo ${arg} |tr 'A-Z' 'a-z')"
declare -a topicsArray=($EMPTY)
declare -a itemsArray=($EMPTY)

#  Determine what tests to generate. Call _common.sh.generateTests()
function main() {
    arg=$1
        
    # Get the XML definition file. This requires the CSC be capitalized properly. This in done in the _common.sh.getEntity() function.
    subsystem=$(getEntity $arg)
    file=($TS_XML_DIR/sal_interfaces/$subsystem/*_Telemetry.xml)
        
    # Delete all test associated test suites first, to catch any removed topics.
    clearTestSuites $arg "JAVA" "Telemetry" || exit 1
        
    # Now generate the test suites.
    createTestSuite $arg $file || exit 1
}

#  Local FUNCTIONS

#  Get EFDB_Topics from Telemetry XML.
function getTopics {
    subSystem=$(getEntity $1)
    file=$2
    output=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry/EFDB_Topic" -v . -n $file |sed "s/${subSystem}_//g" )
    topicsArray=($output)
}

function getTopicParameters {
    file=$1
    index=$2
    output=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry[$index]/item/EFDB_Name" -v . -n $file )
    itemsArray=($output)
}

function clearTestSuite {
    if [ -f $testSuite ]; then
        echo $testSuite exists.  Deleting it before creating a new one.
        rm -rf $testSuite
    fi
}

function createSettings {
    local subSystem=$1
    local topic=$(tr '[:lower:]' '[:upper:]' <<< ${2:0:1})${2:1}
    local testSuite=$3
    echo "*** Settings ***" >> $testSuite
    echo "Documentation    $(capitializeSubsystem $subSystem)_${topic} communications tests." >> $testSuite
    echo "Force Tags    java    $skipped" >> $testSuite
    echo "Suite Setup    Log Many    \${Host}    \${subSystem}    \${component}    \${timeout}" >> $testSuite
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
    local subSystem=$(getEntity $1)
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${component}    $topic" >> $testSuite
    echo "\${timeout}    600s" >> $testSuite
    echo "" >> $testSuite
}

function verifyCompPubSub {
    local testSuite=$1
    echo "Verify Component Publisher and Subscriber" >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    if [ $topic ]; then
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}_\${component}/java/standalone/saj_\${subSystem}_\${component}_pub.jar" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}_\${component}/java/standalone/saj_\${subSystem}_\${component}_sub.jar" >> $testSuite
    else
        echo "    File Should Exist    \${SALWorkDir}/maven/\${subSystem}_\${SALVersion}/src/test/java/\${subSystem}Publisher_all.java" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/maven/\${subSystem}_\${SALVersion}/src/test/java/\${subSystem}Subscriber_all.java" >> $testSuite
    fi
    echo "" >> $testSuite
}

function startJavaCombinedSubscriberProcess {
    # Starts the Java Combined Subscriber program in the background. Verifies that 
    # the process is executing. Since "Start Process" is being used, the 
    # startJavaCombinedSubscriberProcess function creates a robot test that will 
    # wait for text indicating that the Subscriber is ready to appear or timeout. 
    # This is necessary otherwise the robot program will close before any of the 
    # processes have time to complete and communicate with each other which is 
    # what these robot files are testing.
    local subSystem=$1
    local topic=$2
    local testSuite=$3
    echo "Start Subscriber" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Comment    Executing Combined Java Subscriber Program." >> $testSuite
    echo "    \${output}=    Start Process    mvn    -Dtest\=\${subSystem}Subscriber_all.java    test    cwd=\${SALWorkDir}/maven/\${subSystem}_\${SALVersion}/    alias=Subscriber    stdout=\${EXECDIR}\${/}\${subSystem}_stdoutSubscriber.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderrSubscriber.txt" >> $testSuite    
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \"\${subscriberOutput}\"   \"1\"" >> $testSuite
    echo "    Wait Until Keyword Succeeds    30    1s    File Should Not Be Empty    \${EXECDIR}\${/}\${subSystem}_stdoutSubscriber.txt" >> $testSuite
    echo "    Comment    Wait for Subscriber program to be ready." >> $testSuite
    echo "    \${subscriberOutput}=    Get File    \${EXECDIR}\${/}\${subSystem}_stdoutSubscriber.txt" >> $testSuite
    echo "    :FOR    \${i}    IN RANGE    30" >> $testSuite
    echo "    \\    Exit For Loop If     '\${subSystem} all subscribers ready' in \$subscriberOutput" >> $testSuite
    echo "    \\    \${subscriberOutput}=    Get File    \${EXECDIR}\${/}\${subSystem}_stdoutSubscriber.txt" >> $testSuite
    echo "    \\    Sleep    3s" >> $testSuite
    echo "    Log    \${subscriberOutput}" >> $testSuite
    echo "    Should Contain    \${subscriberOutput}    ===== \${subSystem} all subscribers ready =====" >> $testSuite
    echo "" >> $testSuite
}

function startJavaCombinedPublisherProcess {
    # Wait for the Subscriber program to be ready. It will know by a specific text
    # that the program generates. 
    local subSystem=$1
    local topic=$2
    local testSuite=$3
    echo "Start Publisher" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Comment    Executing Combined Java Publisher Program." >> $testSuite
    echo "    \${output}=    Run Process    mvn    -Dtest\=\${subSystem}Publisher_all.java    test    cwd=\${SALWorkDir}/maven/\${subSystem}_\${SALVersion}/    alias=Publisher    stdout=\${EXECDIR}\${/}\${subSystem}_stdoutPublisher.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderrPublisher.txt" >> $testSuite    
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${publisherOutput.stdout}    ===== \${subSystem} all publishers ready =====" >> $testSuite
    echo "    Should Contain    \${publisherOutput.stdout}    [INFO] BUILD SUCCESS" >> $testSuite
    #echo "    :FOR    \${i}    IN RANGE    30" >> $testSuite
    #echo "    \\    \${subscriberOutput}=    Get File    \${EXECDIR}\${/}stdoutSubscriber.txt" >> $testSuite
    #echo "    \\    Run Keyword If    'message received :200' in \$subscriberOutput    Set Test Variable    \${publisherCompletionTextFound}    \"TRUE\"" >> $testSuite
    #echo "    \\    Exit For Loop If     'BUILD SUCCESS' in \$subscriberOutput" >> $testSuite
    #echo "    \\    Sleep    3s" >> $testSuite
    #echo "    Should Be True    \${publisherCompletionTextFound} == \"TRUE\"" >> $testSuite
    echo "" >> $testSuite
}

function readSubscriber {
    local testSuite=$1
    echo "Read Subscriber" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Process    Subscriber" >> $testSuite
    echo "    \${output}=    Wait For Process    Subscriber    timeout=\${timeout}    on_timeout=terminate" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    ===== $subSystem all subscribers ready =====" >> $testSuite
    echo "    @{full_list}=    Split To Lines    \${output.stdout}    start=29" >> $testSuite
    itemIndex=1
    for item in "${topicsArray[@]}"; do
        echo "    \${${item}_start}=    Get Index From List    \${full_list}    === ${subSystem}_${item} start of topic ===" >> $testSuite
        echo "    \${${item}_end}=    Get Index From List    \${full_list}    === ${subSystem}_${item} end of topic ===" >> $testSuite
        echo "    \${${item}_list}=    Get Slice From List    \${full_list}    start=\${${item}_start}    end=\${${item}_end + 1}" >> $testSuite
        echo "    Log Many    \${${item}_list}" >> $testSuite
        echo "    Should Contain    \${${item}_list}    === ${subSystem}_${item} start of topic ===" >> $testSuite
        echo "    Should Contain    \${${item}_list}    === ${subSystem}_${item} end of topic ===" >> $testSuite
        #echo "    Should Contain    \${${item}_list}    === [$item Subscriber] samples" >> $testSuite
        #echo "    Should Contain    \${${item}_list}    === [$item Subscriber] message received :1" >> $testSuite
        #getTopicParameters $file $itemIndex
        #readSubscriber_params $file $item $itemIndex $testSuite
        (( itemIndex++ ))
    done
}

function createTestSuite {
    subSystem=$1
    messageType="telemetry"
    file=$2
    index=1

    # Get the topics for the CSC.
    getTopics $subSystem $file

    if [ ${#topicsArray[@]} -eq 0 ]; then
        echo Skipping: $subSystem has no telemetry.
    else
        # Generate the test suite for each topic.
        echo ============== Generating Combined messaging test suite ==============
        testSuiteCombined=$workDirCombined/$(capitializeSubsystem $subSystem)_$(tr '[:lower:]' '[:upper:]' <<< ${messageType:0:1})${messageType:1}.robot
        echo $testSuiteCombined
        createSettings $subSystem $messageType $testSuiteCombined
        createVariables $subSystem $testSuiteCombined "all"

        echo "*** Test Cases ***" >> $testSuiteCombined
        verifyCompPubSub $testSuiteCombined
        startJavaCombinedSubscriberProcess $subSystem $messageType $testSuiteCombined
        startJavaCombinedPublisherProcess $subSystem $messageType $testSuiteCombined
    readSubscriber $testSuiteCombined
    fi

 #    echo Generating:
    # for topic in "${topicsArray[@]}"; do
    #     #  Define test suite name
    #     testSuite=$workDir/$(capitializeSubsystem $subSystem)_${topic}.robot
        
    #     #  Get EFDB EFDB_Topic telemetry items
    #     getTopicItems $file $index

 #        #  Check if test suite should be skipped.
 #        skipped=$(checkIfSkipped $subSystem $topic $messageType)

    #     #  Create test suite.
    #     echo $testSuite
    #     createSettings $subSystem
    #     createVariables $subSystem
    #     echo "*** Test Cases ***" >> $testSuite
 #        verifyCompPubSub
    #     startSubscriber
    #     startPublisher
    #     readSubscriber

 #        (( index++ ))
    # done
 #    echo ""
}

#### Call the main() function ####
main $1
