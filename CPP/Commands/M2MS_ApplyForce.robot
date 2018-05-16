*** Settings ***
Documentation    M2MS_ApplyForce commander/controller tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m2ms
${component}    ApplyForce
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 93.9445 29.3024 26.8205 80.1059 24.7265 35.4211 12.8232 99.1362 89.9746 22.7884 92.606 19.4526 17.7948 54.6847 41.82 18.734 70.7693 58.7823 61.2904 93.7058 34.5957 29.7537 33.3489 22.3536 28.7357 84.1018 12.1606 71.3654 78.1824 30.9446 60.9696 58.5813 70.2461 24.1281 13.8362 66.9257 39.4005 87.4067 97.5221 84.2607 28.3008 98.6429 93.1154 99.1353 21.1453 50.7721 42.6005 29.1969 76.4638 1.6163 25.9822 10.4786 63.5246 88.4697 39.8267 23.2415 48.747 49.604 78.6266 62.0187 10.2374 45.5255 11.6295 78.2506 99.1138 53.8042 59.6751 74.1981 37.9572 71.2362 60.5782 46.3871
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 93.9445 29.3024 26.8205 80.1059 24.7265 35.4211 12.8232 99.1362 89.9746 22.7884 92.606 19.4526 17.7948 54.6847 41.82 18.734 70.7693 58.7823 61.2904 93.7058 34.5957 29.7537 33.3489 22.3536 28.7357 84.1018 12.1606 71.3654 78.1824 30.9446 60.9696 58.5813 70.2461 24.1281 13.8362 66.9257 39.4005 87.4067 97.5221 84.2607 28.3008 98.6429 93.1154 99.1353 21.1453 50.7721 42.6005 29.1969 76.4638 1.6163 25.9822 10.4786 63.5246 88.4697 39.8267 23.2415 48.747 49.604 78.6266 62.0187 10.2374 45.5255 11.6295 78.2506 99.1138 53.8042 59.6751 74.1981 37.9572 71.2362 60.5782 46.3871
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : support    1
    Should Contain X Times    ${output}    property : actuators    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    forceSetPoint : 93.9445    1
    Should Contain    ${output}    === command ApplyForce issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command ApplyForce received =
    Should Contain    ${output}    device : support
    Should Contain    ${output}    property : actuators
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    forceSetPoint : 93.9445    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
