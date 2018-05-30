*** Settings ***
Documentation    M1M3_CommandRejectionWarning communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    CommandRejectionWarning
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 58.0281 ZrLWGIFoBHuFFnBxLHlQhlxcTMCFwYwPZuGKoyiQEcLIJRdbeMVPSQOTwSodinbQ ssbzMyocFojrICyLuSieTQPFtQxSwBLqiwTSRCmHDWlHfYBiLfUpfnKBYOqAiSiLzklvhgsxsuzOkPXcakXQKGPwpxAtxGJPZiKUNRkjNBKYqPEFwZvHOmuyBDYFjBGt 426587039
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_CommandRejectionWarning writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event CommandRejectionWarning generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 426587039
    Log    ${output}
    Should Contain X Times    ${output}    === Event CommandRejectionWarning received =     1
    Should Contain    ${output}    Timestamp : 58.0281
    Should Contain    ${output}    Command : ZrLWGIFoBHuFFnBxLHlQhlxcTMCFwYwPZuGKoyiQEcLIJRdbeMVPSQOTwSodinbQ
    Should Contain    ${output}    Reason : ssbzMyocFojrICyLuSieTQPFtQxSwBLqiwTSRCmHDWlHfYBiLfUpfnKBYOqAiSiLzklvhgsxsuzOkPXcakXQKGPwpxAtxGJPZiKUNRkjNBKYqPEFwZvHOmuyBDYFjBGt
    Should Contain    ${output}    priority : 426587039
