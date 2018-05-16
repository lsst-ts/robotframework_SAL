*** Settings ***
Documentation    EEC_setlouvers commander/controller tests.
Force Tags    python    Checking if skipped: eec
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    eec
${component}    setlouvers
${timeout}    30s

*** Test Cases ***
Verify Component Commander and Controller
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_${component}.py

Start Commander - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments :

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -770 -31423 -18542 13298 -30438 6701 27350 29640 484 31956 -8952 12920 82 31083 -9297 11533 11441 6422 -3889 30144 -26222 -27815 -32295 -27525 -23340 732 26935 -21016 19117 -30417 23340 4147 14607 3530 -8919 23046 19823 -12351 -16757 -9963 -4028 18189 10387 24068 24088 25655 -3330 2153 16714 21439 -791 24995 10304 29879 -32515 -6415 1049 16410 -1244 27090
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Controller.
    ${input}=    Write    python ${subSystem}_Controller_${component}.py
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -770 -31423 -18542 13298 -30438 6701 27350 29640 484 31956 -8952 12920 82 31083 -9297 11533 11441 6422 -3889 30144 -26222 -27815 -32295 -27525 -23340 732 26935 -21016 19117 -30417 23340 4147 14607 3530 -8919 23046 19823 -12351 -16757 -9963 -4028 18189 10387 24068 24088 25655 -3330 2153 16714 21439 -791 24995 10304 29879 -32515 -6415 1049 16410 -1244 27090
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    position : -770    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    position(60) = [-770, -31423, -18542, 13298, -30438, 6701, 27350, 29640, 484, 31956, -8952, 12920, 82, 31083, -9297, 11533, 11441, 6422, -3889, 30144, -26222, -27815, -32295, -27525, -23340, 732, 26935, -21016, 19117, -30417, 23340, 4147, 14607, 3530, -8919, 23046, 19823, -12351, -16757, -9963, -4028, 18189, 10387, 24068, 24088, 25655, -3330, 2153, 16714, 21439, -791, 24995, 10304, 29879, -32515, -6415, 1049, 16410, -1244, 27090]    1
    Should Contain X Times    ${output}    === [ackCommand_setlouvers] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
