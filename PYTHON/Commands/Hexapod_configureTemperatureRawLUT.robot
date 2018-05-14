*** Settings ***
Documentation    Hexapod_configureTemperatureRawLUT commander/controller tests.
Force Tags    python    
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -32604 11698 -4303 17079 10839 14998 -17404 -18496 -9939 0.986641070134 0.605619384143 0.281050686404 0.849963624697 0.956315313227 0.641149650175 0.364925961867 0.895669836355 0.678381410219 0.321498018595 0.456335947278 0.22247685035 0.184880739078 0.781083869002 0.827931956255 0.295234389084 0.0817433128258 0.818258451376 0.325043741688 0.179296725601 0.122972289417 0.78651550237 0.191839955827 0.780720444414 0.124107211338 0.829024669386 0.342139286774 0.376869731397 0.796827479785 0.224680691386 0.863066373841 0.286825040307 0.871909130974 0.150290158703 0.362486331223 0.323546771837 0.727843725625 0.264551153014 0.360095437244 0.371949694033 0.904141374705 0.154865461916 0.664793089262 0.448206747829 0.639028156596 0.264256875213 0.986609131965 0.262962991116 0.0929175244393 0.356532693337 0.980230194025 0.274104226779 0.0845484721717 0.120764193382
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -32604 11698 -4303 17079 10839 14998 -17404 -18496 -9939 0.986641070134 0.605619384143 0.281050686404 0.849963624697 0.956315313227 0.641149650175 0.364925961867 0.895669836355 0.678381410219 0.321498018595 0.456335947278 0.22247685035 0.184880739078 0.781083869002 0.827931956255 0.295234389084 0.0817433128258 0.818258451376 0.325043741688 0.179296725601 0.122972289417 0.78651550237 0.191839955827 0.780720444414 0.124107211338 0.829024669386 0.342139286774 0.376869731397 0.796827479785 0.224680691386 0.863066373841 0.286825040307 0.871909130974 0.150290158703 0.362486331223 0.323546771837 0.727843725625 0.264551153014 0.360095437244 0.371949694033 0.904141374705 0.154865461916 0.664793089262 0.448206747829 0.639028156596 0.264256875213 0.986609131965 0.262962991116 0.0929175244393 0.356532693337 0.980230194025 0.274104226779 0.0845484721717 0.120764193382
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    tempIndex : -32604    1
    Should Contain X Times    ${output}    rx : 0.986641070134    1
    Should Contain X Times    ${output}    ry : 0.321498018595    1
    Should Contain X Times    ${output}    rz : 0.325043741688    1
    Should Contain X Times    ${output}    tx : 0.376869731397    1
    Should Contain X Times    ${output}    ty : 0.727843725625    1
    Should Contain X Times    ${output}    tz : 0.264256875213    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    tempIndex = -32604    1
    Should Contain X Times    ${output}    rx = 0.986641070134    1
    Should Contain X Times    ${output}    ry = 0.321498018595    1
    Should Contain X Times    ${output}    rz = 0.325043741688    1
    Should Contain X Times    ${output}    tx = 0.376869731397    1
    Should Contain X Times    ${output}    ty = 0.727843725625    1
    Should Contain X Times    ${output}    tz = 0.264256875213    1
    Should Contain X Times    ${output}    === [ackCommand_configureTemperatureRawLUT] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
