*** Settings ***
Documentation    HeaderService_LargeFileObjectAvailable sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    headerService
${component}    LargeFileObjectAvailable
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send ZSnXyFFxxYTMElORjOvbXGantRGIlJGEjSMqpAQPzmXIQEyQnflHygkWmcTaqZeWgsdxbRbvSZXjdaUBPkyYrLyMzXegaCGRVxZfjUrdvyiRySdJWTNyEiDheyZrYJlxtGsHHyphnNvflpWESxeNpBFkTOUieZhdgcSVaNrsjDGkKMOWkUwoiqVNKNmviHnCNKvzGmvrsNMNKDZWRJRfMlDhqDseQDdfvLTYGhnkUbVlOTnhqSOQBfgEtgtnnTfz cMqrChzvOFKteJExWgwDRgNdFnBdnPbo 0.254295344755 zVtQhEKDBzdZJeQUVCKumJRMoRJjKFtO TorqMDihxFGtDDgLCHrkYMirtlaFDCuA 1174925751 lUDcErKpLmXcjDMtkCAbfmEZDgomOtTR -1903132395
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] headerService::logevent_LargeFileObjectAvailable writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event LargeFileObjectAvailable generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1903132395
    Log    ${output}
    Should Contain X Times    ${output}    === Event LargeFileObjectAvailable received =     1
    Should Contain    ${output}    URL : ZSnXyFFxxYTMElORjOvbXGantRGIlJGEjSMqpAQPzmXIQEyQnflHygkWmcTaqZeWgsdxbRbvSZXjdaUBPkyYrLyMzXegaCGRVxZfjUrdvyiRySdJWTNyEiDheyZrYJlxtGsHHyphnNvflpWESxeNpBFkTOUieZhdgcSVaNrsjDGkKMOWkUwoiqVNKNmviHnCNKvzGmvrsNMNKDZWRJRfMlDhqDseQDdfvLTYGhnkUbVlOTnhqSOQBfgEtgtnnTfz
    Should Contain    ${output}    Generator : cMqrChzvOFKteJExWgwDRgNdFnBdnPbo
    Should Contain    ${output}    Version : 0.254295344755
    Should Contain    ${output}    Checksum : zVtQhEKDBzdZJeQUVCKumJRMoRJjKFtO
    Should Contain    ${output}    Mime_Type : TorqMDihxFGtDDgLCHrkYMirtlaFDCuA
    Should Contain    ${output}    Byte_Size : 1174925751
    Should Contain    ${output}    ID : lUDcErKpLmXcjDMtkCAbfmEZDgomOtTR
    Should Contain    ${output}    priority : -1903132395
