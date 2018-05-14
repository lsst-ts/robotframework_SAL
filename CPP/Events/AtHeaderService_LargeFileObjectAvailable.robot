*** Settings ***
Documentation    AtHeaderService_LargeFileObjectAvailable sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atHeaderService
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send ocngOqVHFllyAkWxLLDdUpvGTlCDJsuQPzPHjIRUtdzLOaZRJkikylDwXlvglleHfeTEeduKGbLQRwUUBRaSGmCdcpijxhDBVbONfvTbxqnFRLEyKJJDuFtZDRTcdcnhPrcAjKpaOUDLnEWTTRskgeaDKhIdaEsOJOOyDWTYcKLmZxEpWZLGZUREJHVbwniXCMZfBefNsyWevBpMKXETILoUcEuVIQXraPUxPWBAqlfIbaLtyUoTnrrpDCOyMZcA aPTlnUduJtTXrIRiAEVAMavkmuVKMGBM 0.109187123226 pmCuSvnMRQAXaJmDuZFYeLFWXmLNXaKG UfMwDHuCXyCRvOzneBvIMpaUsOOKPorP 1563004198 UrWhRvyDnROwrVyOBXPKFSnyJSxEcsLi 117349930
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atHeaderService::logevent_LargeFileObjectAvailable writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event LargeFileObjectAvailable generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 117349930
    Log    ${output}
    Should Contain X Times    ${output}    === Event LargeFileObjectAvailable received =     1
    Should Contain    ${output}    URL : ocngOqVHFllyAkWxLLDdUpvGTlCDJsuQPzPHjIRUtdzLOaZRJkikylDwXlvglleHfeTEeduKGbLQRwUUBRaSGmCdcpijxhDBVbONfvTbxqnFRLEyKJJDuFtZDRTcdcnhPrcAjKpaOUDLnEWTTRskgeaDKhIdaEsOJOOyDWTYcKLmZxEpWZLGZUREJHVbwniXCMZfBefNsyWevBpMKXETILoUcEuVIQXraPUxPWBAqlfIbaLtyUoTnrrpDCOyMZcA
    Should Contain    ${output}    Generator : aPTlnUduJtTXrIRiAEVAMavkmuVKMGBM
    Should Contain    ${output}    Version : 0.109187123226
    Should Contain    ${output}    Checksum : pmCuSvnMRQAXaJmDuZFYeLFWXmLNXaKG
    Should Contain    ${output}    Mime_Type : UfMwDHuCXyCRvOzneBvIMpaUsOOKPorP
    Should Contain    ${output}    Byte_Size : 1563004198
    Should Contain    ${output}    ID : UrWhRvyDnROwrVyOBXPKFSnyJSxEcsLi
    Should Contain    ${output}    priority : 117349930
