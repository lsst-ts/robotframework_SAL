*** Settings ***
Documentation    CatchupArchiver_catchuparchiverEntityStartup communications tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    catchuparchiver
${component}    catchuparchiverEntityStartup
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Name Identifier Timestamp Address priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py TEDbPudYYkgfljVozLQaLBSQFwaJRwTGyvJZhYksfNPQQSeyooARtaHaXTQSXZEPAOvhgkArDskXEeVXLBlHFRJDhZnMBUEPtFHhPNTgfDqlymEBOkXlvwUiUXScCXEX 39.5793 EVbOSdkNkrGFgsOmQXNTrWaBJHcyykHTmXmrmnroqqaADsBQpobZiAVGUKsyloOytSWRdmHFbwGeEnXPGVxMEBuEfuNOTwMegjIIVHbRZbyeDLveagNoyHodoNAcYPmvCVREWVllElIZvduKDKcLmpOPmSnnFgGlKqlUlGGfcERZTqpfvneUNNhcTjinrMLopsIJhQSptRxIsLMNfLpkycJWPuniTiRIEjcapzxxvzdzMdpdSflttKByYEWzwOhk -1052287434 -1100067278
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] catchuparchiver::logevent_catchuparchiverEntityStartup writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
