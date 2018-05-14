*** Settings ***
Documentation    AtMonochromator_SettingsAppliedMonoCommunication sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atMonochromator
${component}    SettingsAppliedMonoCommunication
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send RLyBfrAeDyiGUAM -1022715438 0.954830964213 0.773695020412 0.986563069342 -36575652
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atMonochromator::logevent_SettingsAppliedMonoCommunication writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event SettingsAppliedMonoCommunication generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -36575652
    Log    ${output}
    Should Contain X Times    ${output}    === Event SettingsAppliedMonoCommunication received =     1
    Should Contain    ${output}    IP : RLyBfrAeDyiGUAM
    Should Contain    ${output}    portRange : -1022715438
    Should Contain    ${output}    readTimeout : 0.954830964213
    Should Contain    ${output}    writeTimeout : 0.773695020412
    Should Contain    ${output}    connectionTimeout : 0.986563069342
    Should Contain    ${output}    priority : -36575652
