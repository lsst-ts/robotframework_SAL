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

function getTopicItems {
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

    subSystem=$(getEntity $1)
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${component}    $topic" >> $testSuite
    echo "\${timeout}    30s" >> $testSuite
    echo "" >> $testSuite
}

function verifyCompPubSub {
    echo "Verify Component Publisher and Subscriber" >> $testSuite
    echo "    [Tags]    smoke" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}_\${component}/java/standalone/saj_\${subSystem}_\${component}_pub.jar" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}_\${component}/java/standalone/saj_\${subSystem}_\${component}_sub.jar" >> $testSuite
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
    echo "    \${subscriberOutput}=    Start Process    mvn    -Dtest\=\${subSystem}Subscriber_all.java    test    cwd=\${SALWorkDir}/maven/\${subSystem}_\${SALVersion}/    alias=logger    stdout=\${EXECDIR}\${/}stdoutSubscriber.txt    stderr=\${EXECDIR}\${/}stderrSubscriber.txt" >> $testSuite    
    echo "    Wait Until Keyword Succeeds    30    1s    File Should Not Be Empty    \${EXECDIR}\${/}stdoutSubscriber.txt" >> $testSuite
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
    
    echo "    Comment    Publisher program waiting for Subscriber program to be Ready." >> $testSuite
    echo "    \${subscriberOutput}=    Get File    \${EXECDIR}\${/}stdoutSubscriber.txt" >> $testSuite
    echo "    :FOR    \${i}    IN RANGE    30" >> $testSuite
    echo "    \\    Exit For Loop If     '${subSystem} all subscribers ready' in \$subscriberOutput" >> $testSuite
    echo "    \\    \${subscriberOutput}=    Get File    \${EXECDIR}\${/}stdoutSubscriber.txt" >> $testSuite
    echo "    \\    Sleep    3s" >> $testSuite
    
    echo "    Comment    Executing Combined Java Sender Program." >> $testSuite
    echo "    \${publisherOutput}=    Start Process    mvn    -Dtest\=\${subSystem}Publisher_all.java    test    cwd=\${SALWorkDir}/maven/\${subSystem}_\${SALVersion}/    alias=sender    stdout=\${EXECDIR}\${/}stdoutPublisher.txt    stderr=\${EXECDIR}\${/}stderrPublisher.txt" >> $testSuite    
    echo "    :FOR    \${i}    IN RANGE    30" >> $testSuite
    echo "    \\    \${subscriberOutput}=    Get File    \${EXECDIR}\${/}stdoutSubscriber.txt" >> $testSuite
    echo "    \\    Run Keyword If    'message received :200' in \$subscriberOutput    Set Test Variable    \${publisherCompletionTextFound}    \"TRUE\"" >> $testSuite
    echo "    \\    Exit For Loop If     'BUILD SUCCESS' in \$subscriberOutput" >> $testSuite
    echo "    \\    Sleep    3s" >> $testSuite
    
    echo "    Should Be True    \${publisherCompletionTextFound} == \"TRUE\"" >> $testSuite
}

function readSubscriber {
    echo "Read Subscriber" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Subscriber" >> $testSuite
    echo "    \${output}=    Read    delay=1s" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain X Times    \${output}    [\${component} Subscriber] samples    5" >> $testSuite
    echo "    Should Contain X Times    \${output}    [\${component} Subscriber] message received :    5" >> $testSuite
}

function createTestSuite {
	subSystem=$1
    messageType="telemetry"
	file=$2
	index=1

    # Get the topics for the CSC.
    getTopics $subSystem $file

    # Generate the test suite for each topic.
    echo ============== Generating Combined messaging test suite ==============
    testSuiteCombined=$workDirCombined/$(capitializeSubsystem $subSystem)_$(tr '[:lower:]' '[:upper:]' <<< ${messageType:0:1})${messageType:1}.robot
    echo $testSuiteCombined
    createSettings $subSystem $messageType $testSuiteCombined
    createVariables $subSystem $testSuiteCombined "all"

    echo "*** Test Cases ***" >> $testSuiteCombined
    startJavaCombinedSubscriberProcess $subSystem $messageType $testSuiteCombined
    startJavaCombinedPublisherProcess $subSystem $messageType $testSuiteCombined

 #    echo Generating:
	# for topic in "${topicsArray[@]}"; do
	# 	#  Define test suite name
	# 	testSuite=$workDir/$(capitializeSubsystem $subSystem)_${topic}.robot
		
	# 	#  Get EFDB EFDB_Topic telemetry items
	# 	getTopicItems $file $index

 #        #  Check if test suite should be skipped.
 #        skipped=$(checkIfSkipped $subSystem $topic $messageType)

	# 	#  Create test suite.
	# 	echo $testSuite
	# 	createSettings $subSystem
	# 	createVariables $subSystem
	# 	echo "*** Test Cases ***" >> $testSuite
 #        verifyCompPubSub
	# 	startSubscriber
	# 	startPublisher
	# 	readSubscriber

 #    	(( index++ ))
	# done
 #    echo ""
}

#### Call the main() function ####
main $1
