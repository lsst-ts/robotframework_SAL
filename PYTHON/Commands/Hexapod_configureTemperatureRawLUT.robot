*** Settings ***
Documentation    Hexapod_configureTemperatureRawLUT communications tests.
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 1752 -14722 -16509 15160 31867 15109 30249 -25673 1140 0.76996 0.574565 0.163647 0.765089 0.137813 0.792089 0.826613 0.641298 0.10976 0.121268 0.356908 0.185782 0.510244 0.957811 0.61728 0.431669 0.437497 0.359043 0.477296 0.192741 0.878717 0.066677 0.272284 0.538875 0.832606 0.26952 0.865973 0.078095 0.886788 0.860987 0.80649 0.953415 0.548209 0.705804 0.056068 0.689337 0.536683 0.661484 0.945769 0.877886 0.041122 0.431744 0.478307 0.254867 0.640864 0.466118 0.817144 0.286201 0.485521 0.436673 0.350136 0.060824 0.749917 0.118264
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 1752 -14722 -16509 15160 31867 15109 30249 -25673 1140 0.76996 0.574565 0.163647 0.765089 0.137813 0.792089 0.826613 0.641298 0.10976 0.121268 0.356908 0.185782 0.510244 0.957811 0.61728 0.431669 0.437497 0.359043 0.477296 0.192741 0.878717 0.066677 0.272284 0.538875 0.832606 0.26952 0.865973 0.078095 0.886788 0.860987 0.80649 0.953415 0.548209 0.705804 0.056068 0.689337 0.536683 0.661484 0.945769 0.877886 0.041122 0.431744 0.478307 0.254867 0.640864 0.466118 0.817144 0.286201 0.485521 0.436673 0.350136 0.060824 0.749917 0.118264
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    tempIndex : 1752    1
    Should Contain X Times    ${output}    rx : 0.76996    1
    Should Contain X Times    ${output}    ry : 0.121268    1
    Should Contain X Times    ${output}    rz : 0.477296    1
    Should Contain X Times    ${output}    tx : 0.078095    1
    Should Contain X Times    ${output}    ty : 0.536683    1
    Should Contain X Times    ${output}    tz : 0.466118    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    tempIndex = 1752    1
    Should Contain X Times    ${output}    rx = 0.76996    1
    Should Contain X Times    ${output}    ry = 0.121268    1
    Should Contain X Times    ${output}    rz = 0.477296    1
    Should Contain X Times    ${output}    tx = 0.078095    1
    Should Contain X Times    ${output}    ty = 0.536683    1
    Should Contain X Times    ${output}    tz = 0.466118    1
    Should Contain X Times    ${output}    === [ackCommand_configureTemperatureRawLUT] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
