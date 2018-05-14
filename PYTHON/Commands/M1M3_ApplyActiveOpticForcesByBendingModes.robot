*** Settings ***
Documentation    M1M3_ApplyActiveOpticForcesByBendingModes commander/controller tests.
Force Tags    python    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    ApplyActiveOpticForcesByBendingModes
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 0.266725852863 0.534608662825 0.058927508723 0.250833894353 0.519310706792 0.47948401785 0.0754137002297 0.867284970796 0.508196768462 0.10722170856 0.63855785254 0.296125051023 0.620177132482 0.555442551126 0.691500240384 0.636960840973 0.90508620074 0.684787878867 0.0759006937487 0.129131526864 0.179352179958 0.432259126768
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 0.266725852863 0.534608662825 0.058927508723 0.250833894353 0.519310706792 0.47948401785 0.0754137002297 0.867284970796 0.508196768462 0.10722170856 0.63855785254 0.296125051023 0.620177132482 0.555442551126 0.691500240384 0.636960840973 0.90508620074 0.684787878867 0.0759006937487 0.129131526864 0.179352179958 0.432259126768
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    Coefficients : 0.266725852863    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    Coefficients(22) = [0.266725852863, 0.534608662825, 0.058927508723, 0.250833894353, 0.519310706792, 0.47948401785, 0.0754137002297, 0.867284970796, 0.508196768462, 0.10722170856, 0.63855785254, 0.296125051023, 0.620177132482, 0.555442551126, 0.691500240384, 0.636960840973, 0.90508620074, 0.684787878867, 0.0759006937487, 0.129131526864, 0.179352179958, 0.432259126768]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyActiveOpticForcesByBendingModes] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
