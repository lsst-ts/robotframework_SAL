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
    echo "*** Settings ***" >> $testSuite
    echo "Documentation    $(capitializeSubsystem $subSystem)_${topic} communications tests." >> $testSuite
	echo "Force Tags    java    $skipped" >> $testSuite
	echo "Suite Setup    Run Keywords    Log Many    \${Host}    \${subSystem}    \${component}    \${timeout}" >> $testSuite
	echo "...    AND    Create Session    Publisher    AND    Create Session    Subscriber" >> $testSuite
    echo "Suite Teardown    Close All Connections" >> $testSuite
    echo "Library    SSHLibrary" >> $testSuite
    echo "Resource    ../../Global_Vars.robot" >> $testSuite
    echo "Resource    ../../common.robot" >> $testSuite
	echo "" >> $testSuite
}

function createVariables {
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

function startSubscriber {
    echo "Start Subscriber" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Subscriber" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}_\${component}/java/standalone" >> $testSuite
    echo "    Comment    Start Subscriber." >> $testSuite
    echo "    \${input}=    Write    java -cp \$SAL_HOME/lib/saj_\${subSystem}_types.jar:./classes:\$OSPL_HOME/jar/dcpssaj.jar:saj_\${subSystem}_\${component}_sub.jar \${subSystem}_\${component}DataSubscriber" >> $testSuite
    echo "    \${output}=    Read Until    [\${component} Subscriber] Ready ..." >> $testSuite
    echo "    Log    \${output}" >> $testSuite
	echo "    Should Contain    \${output}    [createTopic] : topicName \${subSystem}_\${component} type = \${subSystem}::\${component}">> $testSuite
	if [ $subSystem == "hexapod" ]; then
		ContentFiltered="ContentFiltered"
	else
		ContentFiltered=""
	fi
	echo "    Should Contain    \${output}    [createreader idx] : topic org.opensplice.dds.dcps.${ContentFiltered}TopicImpl@ ">> $testSuite
    echo "    Should Contain    \${output}    reader = \${subSystem}.\${component}DataReaderImpl@">> $testSuite
    echo "    Should Contain    \${output}    [\${component} Subscriber] Ready" >> $testSuite
    echo "" >> $testSuite
}

function startPublisher {
    echo "Start Publisher" >> $testSuite
    echo "    [Tags]    functional" >> $testSuite
    echo "    Switch Connection    Publisher" >> $testSuite
    echo "    Comment    Move to working directory." >> $testSuite
    echo "    Write    cd \${SALWorkDir}/\${subSystem}_\${component}/java/standalone" >> $testSuite
    echo "    Comment    Start Publisher." >> $testSuite
    echo "    \${input}=    Write    java -cp \$SAL_HOME/lib/saj_\${subSystem}_types.jar:./classes:\$OSPL_HOME/jar/dcpssaj.jar:saj_\${subSystem}_\${component}_pub.jar \${subSystem}_\${component}DataPublisher" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}    [createTopic] : topicName \${subSystem}_\${component} type = \${subSystem}::\${component}">> $testSuite
    echo "    Should Contain    \${output}    [createwriter idx] : topic org.opensplice.dds.dcps.TopicImpl@ ">> $testSuite
    echo "    Should Contain    \${output}    writer = \${subSystem}.\${component}DataWriterImpl@">> $testSuite
    echo "    Should Contain X Times    \${output}    [\${component} Publisher] message sent    5" >> $testSuite
    echo "" >> $testSuite
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
    echo Generating:
	for topic in "${topicsArray[@]}"; do
		#  Define test suite name
		testSuite=$workDir/$(capitializeSubsystem $subSystem)_${topic}.robot
		
		#  Get EFDB EFDB_Topic telemetry items
		getTopicItems $file $index

        #  Check if test suite should be skipped.
        skipped=$(checkIfSkipped $subSystem $topic $messageType)

		#  Create test suite.
		echo $testSuite
		createSettings $subSystem
		createVariables $subSystem
		echo "*** Test Cases ***" >> $testSuite
        verifyCompPubSub
		startSubscriber
		startPublisher
		readSubscriber

    	(( index++ ))
	done
    echo ""
}


#### Call the main() function ####
main $1
