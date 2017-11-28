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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -197972748 1148789804 -1667433625 sAAyjqEuIfRdpZfGJADqvsmqkaTlLraxaagIBEkShBJwLEUJBAuCgslDWBhKPswU 82.3374 72.6755 15.1689 90.1215 -864822466 -649419744 62.6704
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -197972748 1148789804 -1667433625 sAAyjqEuIfRdpZfGJADqvsmqkaTlLraxaagIBEkShBJwLEUJBAuCgslDWBhKPswU 82.3374 72.6755 15.1689 90.1215 -864822466 -649419744 62.6704
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    targetId : -197972748    1
    Should Contain X Times    ${output}    fieldId : 1148789804    1
    Should Contain X Times    ${output}    groupId : -1667433625    1
    Should Contain X Times    ${output}    filter : sAAyjqEuIfRdpZfGJADqvsmqkaTlLraxaagIBEkShBJwLEUJBAuCgslDWBhKPswU    1
    Should Contain X Times    ${output}    requestTime : 82.3374    1
    Should Contain X Times    ${output}    ra : 72.6755    1
    Should Contain X Times    ${output}    dec : 15.1689    1
    Should Contain X Times    ${output}    angle : 90.1215    1
    Should Contain X Times    ${output}    num_exposures : -864822466    1
    Should Contain X Times    ${output}    exposure_times : -649419744    1
    Should Contain X Times    ${output}    slew_time : 62.6704    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    targetId = -197972748    1
    Should Contain X Times    ${output}    fieldId = 1148789804    1
    Should Contain X Times    ${output}    groupId = -1667433625    1
    Should Contain X Times    ${output}    filter = sAAyjqEuIfRdpZfGJADqvsmqkaTlLraxaagIBEkShBJwLEUJBAuCgslDWBhKPswU    1
    Should Contain X Times    ${output}    requestTime = 82.3374    1
    Should Contain X Times    ${output}    ra = 72.6755    1
    Should Contain X Times    ${output}    dec = 15.1689    1
    Should Contain X Times    ${output}    angle = 90.1215    1
    Should Contain X Times    ${output}    num_exposures = -864822466    1
    Should Contain X Times    ${output}    exposure_times = -649419744    1
    Should Contain X Times    ${output}    slew_time = 62.6704    1
    Should Contain X Times    ${output}    === [ackCommand_target] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
