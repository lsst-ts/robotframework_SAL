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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -1583 31009 5332 -5353 -1774 -10873 2906 26750 -30220 0.0820011767585 0.32296002251 0.53554206052 0.588291610937 0.415616524169 0.207796560708 0.773783318104 0.070406080531 0.22062842665 0.0334910922778 0.893257419702 0.826606675426 0.0561786419598 0.18077284199 0.635819092773 0.454237241846 0.473699215868 0.523335120639 0.896390248139 0.0887430669325 0.775076658242 0.470185432632 0.475699752887 0.465143517771 0.215085347614 0.154524441503 0.231301373984 0.533006019075 0.544283790725 0.205751799183 0.989932820976 0.134033337293 0.188918583819 0.0548858684675 0.0723590527832 0.75329374618 0.137323891535 0.524704826438 0.00508075123513 0.314622676098 0.132631826618 0.865792742379 0.310569909694 0.651659399022 0.733335021106 0.0292326372654 0.656150308253 0.166815701037 0.153331106998 0.0699083812142 0.962092301551 0.86559293275 0.230092678545 0.140097137647
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -1583 31009 5332 -5353 -1774 -10873 2906 26750 -30220 0.0820011767585 0.32296002251 0.53554206052 0.588291610937 0.415616524169 0.207796560708 0.773783318104 0.070406080531 0.22062842665 0.0334910922778 0.893257419702 0.826606675426 0.0561786419598 0.18077284199 0.635819092773 0.454237241846 0.473699215868 0.523335120639 0.896390248139 0.0887430669325 0.775076658242 0.470185432632 0.475699752887 0.465143517771 0.215085347614 0.154524441503 0.231301373984 0.533006019075 0.544283790725 0.205751799183 0.989932820976 0.134033337293 0.188918583819 0.0548858684675 0.0723590527832 0.75329374618 0.137323891535 0.524704826438 0.00508075123513 0.314622676098 0.132631826618 0.865792742379 0.310569909694 0.651659399022 0.733335021106 0.0292326372654 0.656150308253 0.166815701037 0.153331106998 0.0699083812142 0.962092301551 0.86559293275 0.230092678545 0.140097137647
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    tempIndex : -1583    1
    Should Contain X Times    ${output}    rx : 0.0820011767585    1
    Should Contain X Times    ${output}    ry : 0.0334910922778    1
    Should Contain X Times    ${output}    rz : 0.896390248139    1
    Should Contain X Times    ${output}    tx : 0.533006019075    1
    Should Contain X Times    ${output}    ty : 0.137323891535    1
    Should Contain X Times    ${output}    tz : 0.0292326372654    1
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
    Should Contain X Times    ${output}    tempIndex : -1583    1
    Should Contain X Times    ${output}    rx : 0.0820011767585    1
    Should Contain X Times    ${output}    ry : 0.0334910922778    1
    Should Contain X Times    ${output}    rz : 0.896390248139    1
    Should Contain X Times    ${output}    tx : 0.533006019075    1
    Should Contain X Times    ${output}    ty : 0.137323891535    1
    Should Contain X Times    ${output}    tz : 0.0292326372654    1
    Should Contain X Times    ${output}    === [ackCommand_configureTemperatureRawLUT] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
