*** Settings ***
Documentation    TCS_target commander/controller tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    tcs
${component}    target
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -1832934868 560622735 351918858 LjTKLtESHyREAOFPISBirNEVtYkqjVlpkLEjuJUfnQqrRFuqfvxECEUUHTAwLBiN 62.5265 46.5135 85.005 5.4205 1021324550 -474493942 84.9448
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -1832934868 560622735 351918858 LjTKLtESHyREAOFPISBirNEVtYkqjVlpkLEjuJUfnQqrRFuqfvxECEUUHTAwLBiN 62.5265 46.5135 85.005 5.4205 1021324550 -474493942 84.9448
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    targetId : -1832934868    1
    Should Contain X Times    ${output}    fieldId : 560622735    1
    Should Contain X Times    ${output}    groupId : 351918858    1
    Should Contain X Times    ${output}    filter : LjTKLtESHyREAOFPISBirNEVtYkqjVlpkLEjuJUfnQqrRFuqfvxECEUUHTAwLBiN    1
    Should Contain X Times    ${output}    requestTime : 62.5265    1
    Should Contain X Times    ${output}    ra : 46.5135    1
    Should Contain X Times    ${output}    decl : 85.005    1
    Should Contain X Times    ${output}    angle : 5.4205    1
    Should Contain X Times    ${output}    num_exposures : 1021324550    1
    Should Contain X Times    ${output}    exposure_times : -474493942    1
    Should Contain X Times    ${output}    slew_time : 84.9448    1
    Should Contain    ${output}    === command target issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command target received =
    Should Contain    ${output}    device : 
    Should Contain    ${output}    property : 
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    targetId : -1832934868    1
    Should Contain X Times    ${output}    fieldId : 560622735    1
    Should Contain X Times    ${output}    groupId : 351918858    1
    Should Contain X Times    ${output}    filter : LjTKLtESHyREAOFPISBirNEVtYkqjVlpkLEjuJUfnQqrRFuqfvxECEUUHTAwLBiN    1
    Should Contain X Times    ${output}    requestTime : 62.5265    1
    Should Contain X Times    ${output}    ra : 46.5135    1
    Should Contain X Times    ${output}    decl : 85.005    1
    Should Contain X Times    ${output}    angle : 5.4205    1
    Should Contain X Times    ${output}    num_exposures : 1021324550    1
    Should Contain X Times    ${output}    exposure_times : -474493942    1
    Should Contain X Times    ${output}    slew_time : 84.9448    1
    Should Contain X Times    ${output}    === [ackCommand_target] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
