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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send jZxsttdoCkBubIZSbDPfzbFekSMVCbRwdAsmyDIXEcyfVezSqGhpXiJapeuDoUpFMxjnftCTFbHwFzgQNiOxzMqmpUZpSppmvdRwxeyvTINWpausvgYcSGThCClhyaFZyUgrHusDMDRIiIYhKXOolfoWqVrYhzWtiRyWLVwEOIkbTnkacVURVuUryeMvcjPgOHozofsZDxLmQLdbtlgytwzCjFLCfiBOmuFVxTMnXXcZZQhAlOspKAYNFwvRpEft DiQkDLNAnyBkYCTnoBDYlrqlzaTeGgpq 0.799509912692 NgPxevbdcQzWbjRbEipyWKOULzOrNnTj YSxCjdnlzczyCLjMUrHwGuIaGQayIuwt -1867073758 eRkMHMDnibhTzCKQGBEwXRXLsQSMTmFL -2028503256
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] headerService::logevent_LargeFileObjectAvailable writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event LargeFileObjectAvailable generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -2028503256
    Log    ${output}
    Should Contain X Times    ${output}    === Event LargeFileObjectAvailable received =     1
    Should Contain    ${output}    URL : jZxsttdoCkBubIZSbDPfzbFekSMVCbRwdAsmyDIXEcyfVezSqGhpXiJapeuDoUpFMxjnftCTFbHwFzgQNiOxzMqmpUZpSppmvdRwxeyvTINWpausvgYcSGThCClhyaFZyUgrHusDMDRIiIYhKXOolfoWqVrYhzWtiRyWLVwEOIkbTnkacVURVuUryeMvcjPgOHozofsZDxLmQLdbtlgytwzCjFLCfiBOmuFVxTMnXXcZZQhAlOspKAYNFwvRpEft
    Should Contain    ${output}    Generator : DiQkDLNAnyBkYCTnoBDYlrqlzaTeGgpq
    Should Contain    ${output}    Version : 0.799509912692
    Should Contain    ${output}    Checksum : NgPxevbdcQzWbjRbEipyWKOULzOrNnTj
    Should Contain    ${output}    Mime_Type : YSxCjdnlzczyCLjMUrHwGuIaGQayIuwt
    Should Contain    ${output}    Byte_Size : -1867073758
    Should Contain    ${output}    ID : eRkMHMDnibhTzCKQGBEwXRXLsQSMTmFL
    Should Contain    ${output}    priority : -2028503256
