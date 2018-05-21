*** Settings ***
Documentation    OCS_ocsEntityStartup sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    ocs
${component}    ocsEntityStartup
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send hBSuQRoTXrnfJeAOplFjQCAyDYkfELtsQDbZFMFZeIsVrLwiPGnyVtonjHxJfrpEeOyuBdeGbQghsUDaYWXAxhCidDISoFtgsbJeDpKVLCCLqEDapbKJlOmjjTJPkYBT 67.801 OusPGmLFPsgSpWXdcPuoJilShXoxAqamakecNTwyoLYFBHcCUJdCnGJpuwxrAfLtdOlvtKmeBkeSIQpHWoTrLOBFaROEFtVBcLGNZkwSIemcEtfkGIHdnRSBaXlqihdiybMQRHyihcAaJKiNJGPLIeUrRlycpIrQHBRSqokzZGoPnTveoLJeiIMNrDKqiLNFqQGesXoQRYORFgmzywksxWNXZZmFGdIoiLghyrGAFNnYhJJiDgsLnAXBAXDKzRKk -831930900 -1057011641
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] ocs::logevent_ocsEntityStartup writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ocsEntityStartup generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1057011641
    Log    ${output}
    Should Contain X Times    ${output}    === Event ocsEntityStartup received =     1
    Should Contain    ${output}    Name : hBSuQRoTXrnfJeAOplFjQCAyDYkfELtsQDbZFMFZeIsVrLwiPGnyVtonjHxJfrpEeOyuBdeGbQghsUDaYWXAxhCidDISoFtgsbJeDpKVLCCLqEDapbKJlOmjjTJPkYBT
    Should Contain    ${output}    Identifier : 67.801
    Should Contain    ${output}    Timestamp : OusPGmLFPsgSpWXdcPuoJilShXoxAqamakecNTwyoLYFBHcCUJdCnGJpuwxrAfLtdOlvtKmeBkeSIQpHWoTrLOBFaROEFtVBcLGNZkwSIemcEtfkGIHdnRSBaXlqihdiybMQRHyihcAaJKiNJGPLIeUrRlycpIrQHBRSqokzZGoPnTveoLJeiIMNrDKqiLNFqQGesXoQRYORFgmzywksxWNXZZmFGdIoiLghyrGAFNnYhJJiDgsLnAXBAXDKzRKk
    Should Contain    ${output}    Address : -831930900
    Should Contain    ${output}    priority : -1057011641
