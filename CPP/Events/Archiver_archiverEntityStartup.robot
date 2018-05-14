*** Settings ***
Documentation    Archiver_archiverEntityStartup sender/logger tests.
Force Tags    cpp    TSS-2623
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    archiver
${component}    archiverEntityStartup
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send vdNBOOdejoNefpdIJlMTQGsbtBuVZfVqNsjDwPXQKzogNzKDTrfpiwFaMyAuxLiBmFdmFxvVSkcBCUgENTsZbcrPCDNzYsOYzYdaXBmmmsVULXbUWmAdQspnudNNbIyE 32.0603 LszgthXwOqgIWRAhtfeGntGWyQydslkIVwUTNQkQotRKrkQTONifSrwWpBDPzXZvfyPtXRJcJaNjPFAiAPBNKpZiqWOcbftnYPVZpbjgXpfJuUugsqRrvGjfHQQDeTAPzKzXTUNOjHrDXTYNtLaPImKblcYeQrYjXJOJnatSSIlGILuXeBnDYeSrQqvINTwOJuFAtGrayMRPCNCIXWfKMKOeTrjUGMPidtxQHuXUmnjWyEJOvnFjDJvMHqcgvleB 532645763 182098246 651344148
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] archiver::logevent_archiverEntityStartup writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event archiverEntityStartup generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 651344148
    Log    ${output}
    Should Contain X Times    ${output}    === Event archiverEntityStartup received =     1
    Should Contain    ${output}    Name : vdNBOOdejoNefpdIJlMTQGsbtBuVZfVqNsjDwPXQKzogNzKDTrfpiwFaMyAuxLiBmFdmFxvVSkcBCUgENTsZbcrPCDNzYsOYzYdaXBmmmsVULXbUWmAdQspnudNNbIyE
    Should Contain    ${output}    Identifier : 32.0603
    Should Contain    ${output}    Timestamp : LszgthXwOqgIWRAhtfeGntGWyQydslkIVwUTNQkQotRKrkQTONifSrwWpBDPzXZvfyPtXRJcJaNjPFAiAPBNKpZiqWOcbftnYPVZpbjgXpfJuUugsqRrvGjfHQQDeTAPzKzXTUNOjHrDXTYNtLaPImKblcYeQrYjXJOJnatSSIlGILuXeBnDYeSrQqvINTwOJuFAtGrayMRPCNCIXWfKMKOeTrjUGMPidtxQHuXUmnjWyEJOvnFjDJvMHqcgvleB
    Should Contain    ${output}    Address : 532645763
    Should Contain    ${output}    priority : 182098246
    Should Contain    ${output}    priority : 651344148
