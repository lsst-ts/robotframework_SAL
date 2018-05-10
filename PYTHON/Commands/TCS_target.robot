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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -1707129566 177447777 1654584587 FTJfQXTGiijzOAdNmWhzaPzwZjqKVaEoCUCiVeJUixZQJpGvbMWebhGdXUcQdMku 25.3991 36.9792 41.2171 14.2157 -2022993628 -701120626 72.1418
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -1707129566 177447777 1654584587 FTJfQXTGiijzOAdNmWhzaPzwZjqKVaEoCUCiVeJUixZQJpGvbMWebhGdXUcQdMku 25.3991 36.9792 41.2171 14.2157 -2022993628 -701120626 72.1418
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    targetId : -1707129566    1
    Should Contain X Times    ${output}    fieldId : 177447777    1
    Should Contain X Times    ${output}    groupId : 1654584587    1
    Should Contain X Times    ${output}    filter : FTJfQXTGiijzOAdNmWhzaPzwZjqKVaEoCUCiVeJUixZQJpGvbMWebhGdXUcQdMku    1
    Should Contain X Times    ${output}    requestTime : 25.3991    1
    Should Contain X Times    ${output}    ra : 36.9792    1
    Should Contain X Times    ${output}    decl : 41.2171    1
    Should Contain X Times    ${output}    angle : 14.2157    1
    Should Contain X Times    ${output}    num_exposures : -2022993628    1
    Should Contain X Times    ${output}    exposure_times : -701120626    1
    Should Contain X Times    ${output}    slew_time : 72.1418    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    targetId = -1707129566    1
    Should Contain X Times    ${output}    fieldId = 177447777    1
    Should Contain X Times    ${output}    groupId = 1654584587    1
    Should Contain X Times    ${output}    filter = FTJfQXTGiijzOAdNmWhzaPzwZjqKVaEoCUCiVeJUixZQJpGvbMWebhGdXUcQdMku    1
    Should Contain X Times    ${output}    requestTime = 25.3991    1
    Should Contain X Times    ${output}    ra = 36.9792    1
    Should Contain X Times    ${output}    decl = 41.2171    1
    Should Contain X Times    ${output}    angle = 14.2157    1
    Should Contain X Times    ${output}    num_exposures = -2022993628    1
    Should Contain X Times    ${output}    exposure_times = -701120626    1
    Should Contain X Times    ${output}    slew_time = 72.1418    1
    Should Contain X Times    ${output}    === [ackCommand_target] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
