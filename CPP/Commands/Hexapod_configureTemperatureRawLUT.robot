*** Settings ***
Documentation    Hexapod_configureTemperatureRawLUT communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    hexapod
${component}    configureTemperatureRawLUT
${timeout}    30s

*** Test Cases ***
Verify Component Commander and Controller
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_controller

Start Commander - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage : \ input parameters...

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -10778 6974 20205 27302 20359 18425 15398 8955 -22588 0.656294 0.172665 0.153273 0.618899 0.473208 0.91648 0.93115 0.511652 0.54647 0.711353 0.243507 0.834732 0.400144 0.159272 0.523894 0.24069 0.988523 0.541314 0.443558 0.005301 0.740847 0.626367 0.642181 0.071141 0.146287 0.584311 0.223192 0.075174 0.030477 0.157906 0.699483 0.228641 0.40131 0.619293 0.425899 0.28725 0.253869 0.390075 0.399459 0.686128 0.306762 0.09415 0.02224 0.106592 0.188387 0.019288 0.42148 0.384103 0.218263 0.038305 0.136679 0.694405 0.103102 0.875956
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Controller.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_controller
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -10778 6974 20205 27302 20359 18425 15398 8955 -22588 0.656294 0.172665 0.153273 0.618899 0.473208 0.91648 0.93115 0.511652 0.54647 0.711353 0.243507 0.834732 0.400144 0.159272 0.523894 0.24069 0.988523 0.541314 0.443558 0.005301 0.740847 0.626367 0.642181 0.071141 0.146287 0.584311 0.223192 0.075174 0.030477 0.157906 0.699483 0.228641 0.40131 0.619293 0.425899 0.28725 0.253869 0.390075 0.399459 0.686128 0.306762 0.09415 0.02224 0.106592 0.188387 0.019288 0.42148 0.384103 0.218263 0.038305 0.136679 0.694405 0.103102 0.875956
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    tempIndex : -10778    1
    Should Contain X Times    ${output}    rx : 0.656294    1
    Should Contain X Times    ${output}    ry : 0.711353    1
    Should Contain X Times    ${output}    rz : 0.443558    1
    Should Contain X Times    ${output}    tx : 0.075174    1
    Should Contain X Times    ${output}    ty : 0.253869    1
    Should Contain X Times    ${output}    tz : 0.019288    1
    Should Contain    ${output}    === command configureTemperatureRawLUT issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command configureTemperatureRawLUT received =
    Should Contain    ${output}    device : 
    Should Contain    ${output}    property : 
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    tempIndex : -10778    1
    Should Contain X Times    ${output}    rx : 0.656294    1
    Should Contain X Times    ${output}    ry : 0.711353    1
    Should Contain X Times    ${output}    rz : 0.443558    1
    Should Contain X Times    ${output}    tx : 0.075174    1
    Should Contain X Times    ${output}    ty : 0.253869    1
    Should Contain X Times    ${output}    tz : 0.019288    1
    Should Contain X Times    ${output}    === [ackCommand_configureTemperatureRawLUT] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
