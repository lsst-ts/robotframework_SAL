*** Settings ***
Documentation    HeaderService_LargeFileObjectAvailable communications tests.
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send alepoojsVoCFhAbnnMKdquSoQtexrIvBNvsTQnWSuchthmOsbaTJJPvXEwlaBvWiweeTvxapgjjHtoVrpGuINmicyGONawjzLcXovFBtEMjoGYItGXhbgjckzWxuNrIuMDwQsLqVpyATSudyHglsGwPjhcJFnTwevxIeXylhTVAxHRVWJIcPHqNChrxuLmOigTWALfldlthKpZsVTBkuJMqLAsWVPCJTrPukcWXWsqixzUjyBroHbGxMwFlLxvOW yRUHdbaILJpeZoUULCpKzujRmITlmncr 0.355687 YYzCKwIZRjEGNEqgTUqONoXAyPbFbkaR EJESNYWfyIwkJcgbpYPFQtyIYLYYMMGP -339211293 VNXYUKcCcUjHvxXDmlURhbNPShhonbzh 637916919
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] headerService::logevent_LargeFileObjectAvailable writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event LargeFileObjectAvailable generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 637916919
    Log    ${output}
    Should Contain X Times    ${output}    === Event LargeFileObjectAvailable received =     1
    Should Contain    ${output}    URL : alepoojsVoCFhAbnnMKdquSoQtexrIvBNvsTQnWSuchthmOsbaTJJPvXEwlaBvWiweeTvxapgjjHtoVrpGuINmicyGONawjzLcXovFBtEMjoGYItGXhbgjckzWxuNrIuMDwQsLqVpyATSudyHglsGwPjhcJFnTwevxIeXylhTVAxHRVWJIcPHqNChrxuLmOigTWALfldlthKpZsVTBkuJMqLAsWVPCJTrPukcWXWsqixzUjyBroHbGxMwFlLxvOW
    Should Contain    ${output}    Generator : yRUHdbaILJpeZoUULCpKzujRmITlmncr
    Should Contain    ${output}    Version : 0.355687
    Should Contain    ${output}    Checksum : YYzCKwIZRjEGNEqgTUqONoXAyPbFbkaR
    Should Contain    ${output}    Mime_Type : EJESNYWfyIwkJcgbpYPFQtyIYLYYMMGP
    Should Contain    ${output}    Byte_Size : -339211293
    Should Contain    ${output}    ID : VNXYUKcCcUjHvxXDmlURhbNPShhonbzh
    Should Contain    ${output}    priority : 637916919
