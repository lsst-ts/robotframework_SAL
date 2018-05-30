*** Settings ***
Documentation    Archiver_archiverEntityShutdown communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    archiver
${component}    archiverEntityShutdown
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_log

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage :  input parameters...

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Logger.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_log
    ${output}=    Read Until    logger ready =
    Log    ${output}
    Should Contain    ${output}    Event ${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send QuvJVhrSjwTKgOQvCMxirsYyAoOeLfsYHmVJNWLhgRKAmnLjkPufKnIpYKMXRnerELBJfiqLJxJcjOmuPreFpHERJtXUDCRYfzFGoYEQJLQaSkBTlYDiHjhKcsfHJOoz 72.2691 ZBNqzeVekKYCvdSMdVLZxUWmmHvEOpLqhpDGwAHPZmKdOCBNVHHViMksbxAatWSrLsmiIsFOwvCaIpXlzQjjijcYmIOAwQEScLyjJrADOnFmKhGtsIOahFhCVQafDEppUpfbcxreIiYaIFwiOmkQnONIDHYohZdVgpQWBhSxScIXuhusolbZnmfQalmrYfotNaeYlrlJwHaKIniblqNwuERYGHPWfDyoBSZPnqsyJiKrIkwlKnyjQpQfPwmyefic 1954026608 -1901125229
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] archiver::logevent_archiverEntityShutdown writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event archiverEntityShutdown generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1901125229
    Log    ${output}
    Should Contain X Times    ${output}    === Event archiverEntityShutdown received =     1
    Should Contain    ${output}    Name : QuvJVhrSjwTKgOQvCMxirsYyAoOeLfsYHmVJNWLhgRKAmnLjkPufKnIpYKMXRnerELBJfiqLJxJcjOmuPreFpHERJtXUDCRYfzFGoYEQJLQaSkBTlYDiHjhKcsfHJOoz
    Should Contain    ${output}    Identifier : 72.2691
    Should Contain    ${output}    Timestamp : ZBNqzeVekKYCvdSMdVLZxUWmmHvEOpLqhpDGwAHPZmKdOCBNVHHViMksbxAatWSrLsmiIsFOwvCaIpXlzQjjijcYmIOAwQEScLyjJrADOnFmKhGtsIOahFhCVQafDEppUpfbcxreIiYaIFwiOmkQnONIDHYohZdVgpQWBhSxScIXuhusolbZnmfQalmrYfotNaeYlrlJwHaKIniblqNwuERYGHPWfDyoBSZPnqsyJiKrIkwlKnyjQpQfPwmyefic
    Should Contain    ${output}    Address : 1954026608
    Should Contain    ${output}    priority : -1901125229
