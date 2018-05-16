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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send ZCAHtmGBqTdkvUYzqXjQykZBmvazdFSvktQekGNmVCcoYxiIwayiSXolzghYGTPvdAyZQzpHFNuhlGmcueWPuFADBDpqhSiNZSVbTxCiUqoSZfNCSOQnfaiumlKmnLPGZqCsPParIeChntmWedYDRjOwGrnlNzkepDXeluvpShbqyifbxyBcUeGRJRmVwJWaZQlRYDRboPVkDlbzlPdKRByvfRyBNOggkXycjUkgbMYlPdGQmTDGOOJsmDDsERrp LGwMHgQeosURxlcDbMrFDilvxFaevbSg 0.71486865945 TStxYuDnqwjsmdWslKMiTFckezeUbgAH LyfMgkgkdGGxTmXaLagGslQIQTvjMeWn -755940103 aKktmRtkUTkwFEAZzcPJJoOVDkRNBDfi -943294658
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] headerService::logevent_LargeFileObjectAvailable writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event LargeFileObjectAvailable generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -943294658
    Log    ${output}
    Should Contain X Times    ${output}    === Event LargeFileObjectAvailable received =     1
    Should Contain    ${output}    URL : ZCAHtmGBqTdkvUYzqXjQykZBmvazdFSvktQekGNmVCcoYxiIwayiSXolzghYGTPvdAyZQzpHFNuhlGmcueWPuFADBDpqhSiNZSVbTxCiUqoSZfNCSOQnfaiumlKmnLPGZqCsPParIeChntmWedYDRjOwGrnlNzkepDXeluvpShbqyifbxyBcUeGRJRmVwJWaZQlRYDRboPVkDlbzlPdKRByvfRyBNOggkXycjUkgbMYlPdGQmTDGOOJsmDDsERrp
    Should Contain    ${output}    Generator : LGwMHgQeosURxlcDbMrFDilvxFaevbSg
    Should Contain    ${output}    Version : 0.71486865945
    Should Contain    ${output}    Checksum : TStxYuDnqwjsmdWslKMiTFckezeUbgAH
    Should Contain    ${output}    Mime_Type : LyfMgkgkdGGxTmXaLagGslQIQTvjMeWn
    Should Contain    ${output}    Byte_Size : -755940103
    Should Contain    ${output}    ID : aKktmRtkUTkwFEAZzcPJJoOVDkRNBDfi
    Should Contain    ${output}    priority : -943294658
