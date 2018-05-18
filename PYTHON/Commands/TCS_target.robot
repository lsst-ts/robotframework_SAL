*** Settings ***
Documentation    TCS_target commander/controller tests.
Force Tags    python    
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 956548497 444564849 -1751216908 kCiXAgFOCgFQOKDNGdIcFBwxETIxZYJUPLARvkVUWyoWqLWaimMvdokGijhNWUss 32.9941 35.0696 3.0639 85.7719 -1882709532 757051039 77.8993
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 956548497 444564849 -1751216908 kCiXAgFOCgFQOKDNGdIcFBwxETIxZYJUPLARvkVUWyoWqLWaimMvdokGijhNWUss 32.9941 35.0696 3.0639 85.7719 -1882709532 757051039 77.8993
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    targetId : 956548497    1
    Should Contain X Times    ${output}    fieldId : 444564849    1
    Should Contain X Times    ${output}    groupId : -1751216908    1
    Should Contain X Times    ${output}    filter : kCiXAgFOCgFQOKDNGdIcFBwxETIxZYJUPLARvkVUWyoWqLWaimMvdokGijhNWUss    1
    Should Contain X Times    ${output}    requestTime : 32.9941    1
    Should Contain X Times    ${output}    ra : 35.0696    1
    Should Contain X Times    ${output}    decl : 3.0639    1
    Should Contain X Times    ${output}    angle : 85.7719    1
    Should Contain X Times    ${output}    num_exposures : -1882709532    1
    Should Contain X Times    ${output}    exposure_times : 757051039    1
    Should Contain X Times    ${output}    slew_time : 77.8993    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    targetId = 956548497    1
    Should Contain X Times    ${output}    fieldId = 444564849    1
    Should Contain X Times    ${output}    groupId = -1751216908    1
    Should Contain X Times    ${output}    filter = kCiXAgFOCgFQOKDNGdIcFBwxETIxZYJUPLARvkVUWyoWqLWaimMvdokGijhNWUss    1
    Should Contain X Times    ${output}    requestTime = 32.9941    1
    Should Contain X Times    ${output}    ra = 35.0696    1
    Should Contain X Times    ${output}    decl = 3.0639    1
    Should Contain X Times    ${output}    angle = 85.7719    1
    Should Contain X Times    ${output}    num_exposures = -1882709532    1
    Should Contain X Times    ${output}    exposure_times = 757051039    1
    Should Contain X Times    ${output}    slew_time = 77.8993    1
    Should Contain X Times    ${output}    === [ackCommand_target] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
