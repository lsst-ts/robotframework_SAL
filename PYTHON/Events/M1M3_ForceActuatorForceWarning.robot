*** Settings ***
Documentation    M1M3_ForceActuatorForceWarning sender/logger tests.
Force Tags    python    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    ForceActuatorForceWarning
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp AnyWarning AnyPrimaryAxisMeasuredForceWarning PrimaryAxisMeasuredForceWarning AnySecondaryAxisMeasuredForceWarning SecondaryAxisMeasuredForceWarning AnyPrimaryAxisFollowingErrorWarning PrimaryAxisFollowingErrorWarning AnySecondaryAxisFollowingErrorWarning SecondaryAxisFollowingErrorWarning priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 68.7848 0 1 0 1 0 0 0 1 0 0 1 1 0 0 1 1 0 0 1 1 1 1 0 0 0 1 0 0 1 1 1 1 1 1 0 1 1 1 1 0 0 0 1 0 1 1 0 1 1 1 1 1 1 1 0 1 0 0 1 1 0 1 1 1 0 1 1 0 1 1 1 0 0 1 1 0 1 0 1 0 1 0 1 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0 1 1 1 1 0 1 1 0 1 1 0 0 1 1 1 0 1 1 1 0 1 1 0 0 0 1 0 1 0 0 1 0 0 0 1 1 1 1 0 1 0 1 0 0 0 0 1 0 1 1 0 1 0 1 1 0 1 1 0 0 0 1 1 1 0 1 0 0 0 1 1 1 0 0 0 0 0 0 0 0 1 1 1 1 0 0 1 1 1 1 0 0 0 0 1 1 0 0 0 0 0 0 1 1 0 0 0 1 0 0 0 0 0 0 1 1 1 0 0 1 0 0 0 1 1 0 1 0 1 1 1 1 0 1 1 0 0 1 1 1 1 0 1 0 1 1 1 0 1 0 0 0 0 0 1 1 1 1 0 1 0 1 1 0 0 0 1 1 0 1 0 0 1 1 0 1 1 0 0 0 0 1 0 1 1 1 1 1 0 0 1 0 0 0 1 1 0 0 1 0 0 0 1 0 1 1 0 0 0 0 0 0 1 1 1 0 1 0 0 0 0 0 0 0 1 0 0 0 1 1 1 0 1 0 0 1 1 1 1 0 1 0 1 1 1 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 1 0 0 1 0 1 0 1 0 1 0 0 1 1 1 1 1 0 1 1 1 0 1 1 0 0 1 0 1 0 0 0 1 1 1 0 0 1 1 1 0 0 1 1 0 0 0 1 1 1 1 1 0 1 0 1 0 1 0 0 0 1 1 1 0 0 1 0 1 1 0 0 0 1 1 0 0 0 0 1 1 0 1 0 0 0 0 1 1 0 0 0 1 1 0 0 1 1 0 1 0 1 0 1 0 1 0 0 1 0 1 0 1 1 0 1 1 1 0 1 1 1 0 0 1 1 1 1 0 0 1 0 1 1 0 1 0 1 0 0 0 0 0 0 1 0 1 0 1 0 0 0 1 0 1 0 0 1 1 1 0 1 1 0 1 1 0 0 1 1 1 0 1 0 0 1 1 0 0 1 1 1 0 1 1 1 0 0 0 0 1 0 1 1 0 1 0 0 0 1 1 0 0 1 0 0 1 1 0 0 0 0 0 1 0 1 0 0 0 0 0 1 1 0 0 0 1 0 0 0 0 1 0 1 1 1 0 0 0 0 1 0 0 0 1 0 1 1 1 0 1 0 0 1 1 1 0 0 1 297105558
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_ForceActuatorForceWarning writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
*** Settings ***
Documentation    M1M3_ForceActuatorForceWarning communications tests.
Force Tags    python    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    ForceActuatorForceWarning
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp AnyWarning AnyPrimaryAxisMeasuredForceWarning PrimaryAxisMeasuredForceWarning AnySecondaryAxisMeasuredForceWarning SecondaryAxisMeasuredForceWarning AnyPrimaryAxisFollowingErrorWarning PrimaryAxisFollowingErrorWarning AnySecondaryAxisFollowingErrorWarning SecondaryAxisFollowingErrorWarning priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 63.3185 0 1 0 0 1 0 1 0 1 0 1 1 0 1 0 1 0 1 0 0 0 1 1 0 1 0 1 0 1 0 1 1 0 0 1 0 1 0 0 0 1 1 1 0 1 0 1 1 1 0 1 1 0 0 1 0 1 1 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 1 0 0 0 0 0 1 1 1 1 0 0 1 1 1 1 0 0 0 0 0 0 1 1 0 0 1 1 0 0 0 1 0 0 0 1 1 1 0 0 1 0 1 0 0 1 1 1 0 1 0 1 0 1 0 1 0 1 0 1 1 0 0 1 1 0 0 1 0 0 0 0 1 0 1 0 1 1 0 0 0 1 1 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 0 1 0 1 1 0 1 0 0 0 1 0 0 0 0 1 1 0 1 0 0 0 1 0 0 0 1 1 1 1 0 0 0 1 1 1 0 0 0 1 1 1 0 0 0 1 0 1 0 1 1 1 0 0 1 0 1 0 1 0 0 1 0 1 1 0 1 1 0 1 0 1 1 1 1 0 0 0 0 0 0 0 0 0 0 1 0 1 0 0 0 1 1 0 0 1 1 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 0 1 0 1 1 1 1 1 0 1 1 1 1 1 0 1 0 0 1 0 0 0 0 0 0 0 1 1 0 0 0 1 0 0 1 0 1 0 0 1 1 1 1 0 1 1 0 1 1 0 0 1 0 0 0 0 1 0 1 1 1 0 0 0 0 1 1 0 1 0 0 1 1 0 1 0 1 0 1 1 1 1 1 0 0 0 0 1 1 1 1 0 0 1 1 0 0 0 0 1 0 0 0 1 1 1 1 0 1 0 0 1 1 0 0 0 0 0 0 1 0 0 1 0 0 0 0 1 0 0 1 1 1 1 0 0 1 0 0 1 1 0 0 0 1 0 1 1 0 1 1 1 0 0 0 1 1 1 1 1 0 1 1 0 1 0 0 0 1 0 0 0 1 1 0 0 0 1 0 0 0 1 1 1 1 1 0 1 1 0 0 0 0 1 1 0 1 0 1 1 0 0 1 1 1 0 1 1 1 0 1 0 0 1 0 0 1 1 1 1 0 1 0 1 1 1 0 1 1 1 0 1 0 0 0 1 0 0 0 0 1 0 0 0 0 1 1 1 0 1 1 1 1 1 0 0 0 1 0 0 0 0 0 0 0 0 1 1 1 0 1 0 1 1 1 0 1 1 0 0 0 1 0 1 0 0 1 0 1 1 0 1 0 0 1 0 0 0 0 0 1 0 1 1 1 1 0 0 1 0 0 0 0 0 0 1 1 0 0 0 0 1 0 0 1 0 1 1 0 1 1 0 0 0 0 1 1 1 0 0 1 1 0 951559785
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_ForceActuatorForceWarning writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
