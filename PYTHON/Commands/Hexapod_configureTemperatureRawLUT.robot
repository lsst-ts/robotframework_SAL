*** Settings ***
Documentation    Hexapod_configureTemperatureRawLUT commander/controller tests.
Force Tags    python    Checking if skipped: hexapod
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 5645 15035 27155 -24444 -26700 -14566 -18156 -29141 11678 0.386669233163 0.454036386111 0.249270064449 0.624144989127 0.313646927842 0.407734219408 0.941159177248 0.664802803264 0.0162906218788 0.141253300744 0.605653864912 0.633060223266 0.612742760346 0.290903356568 0.424823973289 0.292958758087 0.0897948418386 0.357522920201 0.86951315377 0.0462303085747 0.950601143327 0.426542288794 0.761334545535 0.799155356204 0.983637327835 0.810164653382 0.265261241203 0.292076414098 0.133311972278 0.503083325458 0.21860633348 0.622227694708 0.783952098216 0.0144254590088 0.0175612475045 0.420206617368 0.792562607986 0.865111194273 0.485687160143 0.998841893004 0.259595117789 0.553382704621 0.993742312148 0.387825531609 0.16475717007 0.879646881814 0.602063088546 0.476834642518 0.998712489372 0.914697340455 0.214780443934 0.675228470215 0.977524940347 0.622633220265
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 5645 15035 27155 -24444 -26700 -14566 -18156 -29141 11678 0.386669233163 0.454036386111 0.249270064449 0.624144989127 0.313646927842 0.407734219408 0.941159177248 0.664802803264 0.0162906218788 0.141253300744 0.605653864912 0.633060223266 0.612742760346 0.290903356568 0.424823973289 0.292958758087 0.0897948418386 0.357522920201 0.86951315377 0.0462303085747 0.950601143327 0.426542288794 0.761334545535 0.799155356204 0.983637327835 0.810164653382 0.265261241203 0.292076414098 0.133311972278 0.503083325458 0.21860633348 0.622227694708 0.783952098216 0.0144254590088 0.0175612475045 0.420206617368 0.792562607986 0.865111194273 0.485687160143 0.998841893004 0.259595117789 0.553382704621 0.993742312148 0.387825531609 0.16475717007 0.879646881814 0.602063088546 0.476834642518 0.998712489372 0.914697340455 0.214780443934 0.675228470215 0.977524940347 0.622633220265
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    tempIndex : 5645    1
    Should Contain X Times    ${output}    rx : 0.386669233163    1
    Should Contain X Times    ${output}    ry : 0.141253300744    1
    Should Contain X Times    ${output}    rz : 0.86951315377    1
    Should Contain X Times    ${output}    tx : 0.292076414098    1
    Should Contain X Times    ${output}    ty : 0.792562607986    1
    Should Contain X Times    ${output}    tz : 0.879646881814    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    tempIndex = 5645    1
    Should Contain X Times    ${output}    rx = 0.386669233163    1
    Should Contain X Times    ${output}    ry = 0.141253300744    1
    Should Contain X Times    ${output}    rz = 0.86951315377    1
    Should Contain X Times    ${output}    tx = 0.292076414098    1
    Should Contain X Times    ${output}    ty = 0.792562607986    1
    Should Contain X Times    ${output}    tz = 0.879646881814    1
    Should Contain X Times    ${output}    === [ackCommand_configureTemperatureRawLUT] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
