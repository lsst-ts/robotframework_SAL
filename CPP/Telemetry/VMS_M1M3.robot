*** Settings ***
Documentation    VMS_M1M3 communications tests.
Force Tags    cpp    TSS-2618
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Publisher    AND    Create Session    Subscriber
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    vms
${component}    M1M3
${timeout}    30s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_sub

Start Subscriber
    [Tags]    functional
    Switch Connection    Subscriber
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}_${component}/cpp/standalone
    Comment    Start Subscriber.
    ${input}=    Write    ./sacpp_${subSystem}_sub
    ${output}=    Read Until    [Subscriber] Ready
    Log    ${output}
    Should Contain    ${output}    [Subscriber] Ready

Start Publisher
    [Tags]    functional
    Switch Connection    Publisher
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}_${component}/cpp/standalone
    Comment    Start Publisher.
    ${input}=    Write    ./sacpp_${subSystem}_pub
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    [putSample] ${subSystem}::${component} writing a message containing :    9
    Should Contain X Times    ${output}    revCode \ : LSST TEST REVCODE    9

Read Subscriber
    [Tags]    functional
    Switch Connection    Subscriber
    ${output}=    Read    delay=1s
    Log    ${output}
    @{list}=    Split To Lines    ${output}    start=1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Timestamp : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1XAcceleration : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1XAcceleration : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1XAcceleration : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1XAcceleration : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1XAcceleration : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1XAcceleration : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1XAcceleration : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1XAcceleration : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1XAcceleration : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1YAcceleration : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1YAcceleration : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1YAcceleration : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1YAcceleration : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1YAcceleration : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1YAcceleration : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1YAcceleration : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1YAcceleration : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1YAcceleration : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1ZAcceleration : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1ZAcceleration : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1ZAcceleration : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1ZAcceleration : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1ZAcceleration : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1ZAcceleration : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1ZAcceleration : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1ZAcceleration : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor1ZAcceleration : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2XAcceleration : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2XAcceleration : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2XAcceleration : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2XAcceleration : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2XAcceleration : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2XAcceleration : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2XAcceleration : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2XAcceleration : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2XAcceleration : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2YAcceleration : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2YAcceleration : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2YAcceleration : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2YAcceleration : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2YAcceleration : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2YAcceleration : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2YAcceleration : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2YAcceleration : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2YAcceleration : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2ZAcceleration : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2ZAcceleration : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2ZAcceleration : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2ZAcceleration : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2ZAcceleration : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2ZAcceleration : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2ZAcceleration : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2ZAcceleration : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor2ZAcceleration : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3XAcceleration : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3XAcceleration : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3XAcceleration : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3XAcceleration : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3XAcceleration : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3XAcceleration : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3XAcceleration : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3XAcceleration : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3XAcceleration : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3YAcceleration : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3YAcceleration : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3YAcceleration : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3YAcceleration : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3YAcceleration : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3YAcceleration : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3YAcceleration : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3YAcceleration : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3YAcceleration : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3ZAcceleration : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3ZAcceleration : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3ZAcceleration : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3ZAcceleration : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3ZAcceleration : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3ZAcceleration : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3ZAcceleration : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3ZAcceleration : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor3ZAcceleration : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4XAcceleration : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4XAcceleration : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4XAcceleration : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4XAcceleration : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4XAcceleration : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4XAcceleration : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4XAcceleration : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4XAcceleration : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4XAcceleration : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4YAcceleration : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4YAcceleration : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4YAcceleration : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4YAcceleration : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4YAcceleration : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4YAcceleration : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4YAcceleration : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4YAcceleration : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4YAcceleration : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4ZAcceleration : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4ZAcceleration : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4ZAcceleration : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4ZAcceleration : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4ZAcceleration : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4ZAcceleration : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4ZAcceleration : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4ZAcceleration : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor4ZAcceleration : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5XAcceleration : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5XAcceleration : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5XAcceleration : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5XAcceleration : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5XAcceleration : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5XAcceleration : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5XAcceleration : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5XAcceleration : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5XAcceleration : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5YAcceleration : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5YAcceleration : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5YAcceleration : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5YAcceleration : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5YAcceleration : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5YAcceleration : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5YAcceleration : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5YAcceleration : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5YAcceleration : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5ZAcceleration : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5ZAcceleration : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5ZAcceleration : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5ZAcceleration : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5ZAcceleration : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5ZAcceleration : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5ZAcceleration : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5ZAcceleration : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor5ZAcceleration : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6XAcceleration : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6XAcceleration : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6XAcceleration : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6XAcceleration : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6XAcceleration : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6XAcceleration : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6XAcceleration : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6XAcceleration : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6XAcceleration : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6YAcceleration : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6YAcceleration : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6YAcceleration : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6YAcceleration : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6YAcceleration : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6YAcceleration : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6YAcceleration : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6YAcceleration : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6YAcceleration : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6ZAcceleration : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6ZAcceleration : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6ZAcceleration : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6ZAcceleration : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6ZAcceleration : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6ZAcceleration : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6ZAcceleration : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6ZAcceleration : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Sensor6ZAcceleration : 9    1
