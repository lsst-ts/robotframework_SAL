*** Settings ***
Documentation    M1M3_ApplyActiveOpticForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    ApplyActiveOpticForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 0.741097 0.400028 0.359507 0.587119 0.655556 0.46491 0.409954 0.375975 0.983869 0.418821 0.809063 0.24153 0.922838 0.104988 0.982441 0.9335 0.587354 0.946145 0.720803 0.828708 0.326257 0.13053 0.725587 0.648657 0.157544 0.587739 0.110825 0.49891 0.285137 0.390634 0.020635 0.76986 0.762556 0.055744 0.383718 0.913696 0.153307 0.407566 0.397139 0.211244 0.229016 0.593496 0.235082 0.375734 0.739308 0.367552 0.067114 0.179122 0.46163 0.944803 0.452268 0.386453 0.691639 0.773703 0.955612 0.336808 0.845755 0.121737 0.7949 0.522532 0.728822 0.331888 0.827763 0.843216 0.684804 0.914466 0.917742 0.205227 0.184461 0.858678 0.727058 0.696112 0.361838 0.355452 0.429849 0.352071 0.192665 0.657585 0.90437 0.496605 0.670694 0.257141 0.465741 0.447705 0.060648 0.977406 0.695092 0.483016 0.251181 0.195974 0.994565 0.220996 0.4351 0.754654 0.87001 0.221839 0.772483 0.233089 0.813602 0.26185 0.228238 0.871102 0.515541 0.399673 0.942096 0.495388 0.24287 0.408338 0.449485 0.027283 0.198694 0.619328 0.20497 0.080855 0.635019 0.102828 0.870238 0.431011 0.55332 0.869436 0.427215 0.25766 0.570598 0.716773 0.337998 0.121849 0.837062 0.989626 0.054433 0.858003 0.463439 0.323522 0.616095 0.002556 0.660234 0.419024 0.165627 0.236737 0.34839 0.184299 0.911849 0.705017 0.348524 0.03215 0.265471 0.229076 0.245642 0.574565 0.823545 0.643288 0.540527 0.51795 0.020069 0.232361 0.494432 0.180717
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 0.741097 0.400028 0.359507 0.587119 0.655556 0.46491 0.409954 0.375975 0.983869 0.418821 0.809063 0.24153 0.922838 0.104988 0.982441 0.9335 0.587354 0.946145 0.720803 0.828708 0.326257 0.13053 0.725587 0.648657 0.157544 0.587739 0.110825 0.49891 0.285137 0.390634 0.020635 0.76986 0.762556 0.055744 0.383718 0.913696 0.153307 0.407566 0.397139 0.211244 0.229016 0.593496 0.235082 0.375734 0.739308 0.367552 0.067114 0.179122 0.46163 0.944803 0.452268 0.386453 0.691639 0.773703 0.955612 0.336808 0.845755 0.121737 0.7949 0.522532 0.728822 0.331888 0.827763 0.843216 0.684804 0.914466 0.917742 0.205227 0.184461 0.858678 0.727058 0.696112 0.361838 0.355452 0.429849 0.352071 0.192665 0.657585 0.90437 0.496605 0.670694 0.257141 0.465741 0.447705 0.060648 0.977406 0.695092 0.483016 0.251181 0.195974 0.994565 0.220996 0.4351 0.754654 0.87001 0.221839 0.772483 0.233089 0.813602 0.26185 0.228238 0.871102 0.515541 0.399673 0.942096 0.495388 0.24287 0.408338 0.449485 0.027283 0.198694 0.619328 0.20497 0.080855 0.635019 0.102828 0.870238 0.431011 0.55332 0.869436 0.427215 0.25766 0.570598 0.716773 0.337998 0.121849 0.837062 0.989626 0.054433 0.858003 0.463439 0.323522 0.616095 0.002556 0.660234 0.419024 0.165627 0.236737 0.34839 0.184299 0.911849 0.705017 0.348524 0.03215 0.265471 0.229076 0.245642 0.574565 0.823545 0.643288 0.540527 0.51795 0.020069 0.232361 0.494432 0.180717
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    ZForces : 0.741097    1
    Should Contain    ${output}    === command ApplyActiveOpticForces issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command ApplyActiveOpticForces received =
    Should Contain    ${output}    device : 
    Should Contain    ${output}    property : 
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    ZForces : 0.741097    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyActiveOpticForces] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
