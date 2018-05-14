*** Settings ***
Documentation    Hexapod_configureTemperatureRawLUT commander/controller tests.
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 4711 -12267 27469 28727 22619 8977 3618 -13402 -11107 0.86585596859 0.420609216331 0.600717394479 0.225347652773 0.304455447794 0.764220644881 0.577142403306 0.135368420372 0.0413825711571 0.628344663696 0.46663688573 0.964911605909 0.963255244743 0.835046902472 0.436934579631 0.943700764768 0.944231848813 0.693899005654 0.2400705299 0.350225309296 0.163791834377 0.207119014422 0.807267809137 0.522211815121 0.639738530927 0.971158353322 0.192518729306 0.0595919171737 0.907229505085 0.109583639075 0.646071968979 0.472551732106 0.504413492683 0.959880264693 0.623551420127 0.823082172532 0.559228940682 0.557288321571 0.964892956284 0.994841174594 0.550772650616 0.0978465716059 0.24967644398 0.361353620181 0.197279780423 0.176021652573 0.903907090921 0.718095244111 0.00951071956402 0.681325879388 0.88754383708 0.103797460046 0.454727472307 0.608843729493
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 4711 -12267 27469 28727 22619 8977 3618 -13402 -11107 0.86585596859 0.420609216331 0.600717394479 0.225347652773 0.304455447794 0.764220644881 0.577142403306 0.135368420372 0.0413825711571 0.628344663696 0.46663688573 0.964911605909 0.963255244743 0.835046902472 0.436934579631 0.943700764768 0.944231848813 0.693899005654 0.2400705299 0.350225309296 0.163791834377 0.207119014422 0.807267809137 0.522211815121 0.639738530927 0.971158353322 0.192518729306 0.0595919171737 0.907229505085 0.109583639075 0.646071968979 0.472551732106 0.504413492683 0.959880264693 0.623551420127 0.823082172532 0.559228940682 0.557288321571 0.964892956284 0.994841174594 0.550772650616 0.0978465716059 0.24967644398 0.361353620181 0.197279780423 0.176021652573 0.903907090921 0.718095244111 0.00951071956402 0.681325879388 0.88754383708 0.103797460046 0.454727472307 0.608843729493
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    tempIndex : 4711    1
    Should Contain X Times    ${output}    rx : 0.86585596859    1
    Should Contain X Times    ${output}    ry : 0.628344663696    1
    Should Contain X Times    ${output}    rz : 0.2400705299    1
    Should Contain X Times    ${output}    tx : 0.0595919171737    1
    Should Contain X Times    ${output}    ty : 0.559228940682    1
    Should Contain X Times    ${output}    tz : 0.176021652573    1
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
    Should Contain X Times    ${output}    tempIndex : 4711    1
    Should Contain X Times    ${output}    rx : 0.86585596859    1
    Should Contain X Times    ${output}    ry : 0.628344663696    1
    Should Contain X Times    ${output}    rz : 0.2400705299    1
    Should Contain X Times    ${output}    tx : 0.0595919171737    1
    Should Contain X Times    ${output}    ty : 0.559228940682    1
    Should Contain X Times    ${output}    tz : 0.176021652573    1
    Should Contain X Times    ${output}    === [ackCommand_configureTemperatureRawLUT] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
