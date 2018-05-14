*** Settings ***
Documentation    AtCamera_imageReadoutParameters sender/logger tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atcamera
${component}    imageReadoutParameters
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : imageName ccdNames ccdType overRows overCols readRows readCols readCols2 preCols preRows postCols priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py JGeDNikYYOUOMipIokSwYylQEOSIpWsOmvpjrVXSKfyNnfGGYWANNBQISHtIaQGzphqzbesAFChXiRQyyQLTmFaWjzSmCkfLmCFaINSvGnlbhIwlrbwFytCMresVLkvkvgkNFtbqJWAdcgoKGwgFovlPxjwArjWdgSTRLqWNtUbMGlcHQlJWvoJHevOFirNsaOULJGEICuuSJAxXMAksYmNfHFnaRHyPKsGBWlKreVzUxrotPYOxDBehYsUJLlYa SDNhUdGpaxyFZcXyFCmVgIqQbsnNdSEVtxNzYkFPuPEiRzLkloXtNWZkllTRMMaetxINtGHKCIJlkNeIYXancnfbmZIoxADQfkQikJmqvgmSTvANGYbdMKNEVjClxZwXZGYFAbLRUmshBliiabwvTYoPhQIwHTmqnOdQOcmXiVfGtqapPBstciaTXASsaNVodAIGDPlYOvbZuYjrdOJOrhhTuqkajiTmwaEzlClBbqlQvnbPlrsuALAsKnxIuhbC 613349573 1451368682 1856803708 3916626 -1628775266 750540133 1977318787 1772640016 -1402209036 1258080954
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atcamera::logevent_imageReadoutParameters writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
