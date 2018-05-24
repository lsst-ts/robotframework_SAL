*** Settings ***
Documentation    EEC_Timestamp communications tests.
Force Tags    java    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Publisher    AND    Create Session    Subscriber
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    eec
${component}    Timestamp
${timeout}    30s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/java/standalone/saj_${subSystem}_${component}_pub.jar
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/java/standalone/saj_${subSystem}_${component}_sub.jar

Start Subscriber
    [Tags]    functional
    Switch Connection    Subscriber
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}_${component}/java/standalone
    Comment    Start Subscriber.
    ${input}=    Write    java -cp $SAL_HOME/lib/saj_${subSystem}_types.jar:./classes:$OSPL_HOME/jar/dcpssaj.jar:saj_${subSystem}_${component}_sub.jar ${subSystem}_${component}DataSubscriber
    ${output}=    Read Until    [${component} Subscriber] Ready ...
    Log    ${output}
    Should Contain    ${output}    [createTopic] : topicName ${subSystem}_${component} type = ${subSystem}::${component}
    Should Contain    ${output}    [createreader idx] : topic org.opensplice.dds.dcps.TopicImpl@ 
    Should Contain    ${output}    reader = ${subSystem}.${component}DataReaderImpl@
    Should Contain    ${output}    [${component} Subscriber] Ready

Start Publisher
    [Tags]    functional
    Switch Connection    Publisher
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}_${component}/java/standalone
    Comment    Start Publisher.
    ${input}=    Write    java -cp $SAL_HOME/lib/saj_${subSystem}_types.jar:./classes:$OSPL_HOME/jar/dcpssaj.jar:saj_${subSystem}_${component}_pub.jar ${subSystem}_${component}DataPublisher
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    [createTopic] : topicName ${subSystem}_${component} type = ${subSystem}::${component}
    Should Contain    ${output}    [createwriter idx] : topic org.opensplice.dds.dcps.TopicImpl@ 
    Should Contain    ${output}    writer = ${subSystem}.${component}DataWriterImpl@
    Should Contain X Times    ${output}    [${component} Publisher] message sent    5

Read Subscriber
    [Tags]    functional
    Switch Connection    Subscriber
    ${output}=    Read    delay=1s
    Log    ${output}
    Should Contain X Times    ${output}    [${component} Subscriber] samples    5
    Should Contain X Times    ${output}    [${component} Subscriber] message received :    5
