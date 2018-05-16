*** Settings ***
Documentation    Camera_startSetFilter sender/logger tests.
Force Tags    cpp    TSS-2677
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    camera
${component}    startSetFilter
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send WLHuXKDMVjKvtQxLgQVeJkNTtejfFAFpJUgIVlSqlccMcAPznemKfkLqrDyxteYpNzNJmtVOOSaXgSnwnVrDGCajTkbVBHvGjtLQYposzxlLczFcTfHYmMLtQQYFTluUFyrSOYeQeHbEhQLzvaxrcyVOliIHThAdSJVYjBbTaEvxMxXPkfPeEtcbmOsQTRxmgFCuaBkPrkKohonQmZJzDOtUCnrHlbhYOvtaGGhHPiwrIFDOmipRxxcayenPsGCF 959781277 272487720
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] camera::logevent_startSetFilter writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event startSetFilter generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 272487720
    Log    ${output}
    Should Contain X Times    ${output}    === Event startSetFilter received =     1
    Should Contain    ${output}    filterName : WLHuXKDMVjKvtQxLgQVeJkNTtejfFAFpJUgIVlSqlccMcAPznemKfkLqrDyxteYpNzNJmtVOOSaXgSnwnVrDGCajTkbVBHvGjtLQYposzxlLczFcTfHYmMLtQQYFTluUFyrSOYeQeHbEhQLzvaxrcyVOliIHThAdSJVYjBbTaEvxMxXPkfPeEtcbmOsQTRxmgFCuaBkPrkKohonQmZJzDOtUCnrHlbhYOvtaGGhHPiwrIFDOmipRxxcayenPsGCF
    Should Contain    ${output}    priority : 959781277
    Should Contain    ${output}    priority : 272487720
