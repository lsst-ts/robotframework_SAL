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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -24107 13584 32446 -18522 20761 -5576 16678 -17882 15770 0.502000411365 0.00276989583009 0.635302818364 0.813794542467 0.676104544948 0.498175516599 0.792364032567 0.928809960763 0.632873849493 0.807675670021 0.433467762413 0.527034386117 0.0770800201911 0.462540774656 0.779855986399 0.459109774294 0.506694813424 0.924947597505 0.111129251369 0.737557853035 0.241193549446 0.682053077681 0.504202271726 0.723967431787 0.290747137785 0.654420997454 0.0816240719028 0.482403936706 0.280259046941 0.763222145797 0.736656060295 0.962773642449 0.650384935108 0.795591606047 0.596993066568 0.302816120106 0.648043660021 0.487691570327 0.986513570375 0.403954266355 0.177324746311 0.794866885491 0.94976682539 0.549647225096 0.801940065897 0.923399366758 0.0643681196838 0.536940833569 0.649433237567 0.693244560629 0.193285148648 0.997589889949 0.343088055715 0.136969794015
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -24107 13584 32446 -18522 20761 -5576 16678 -17882 15770 0.502000411365 0.00276989583009 0.635302818364 0.813794542467 0.676104544948 0.498175516599 0.792364032567 0.928809960763 0.632873849493 0.807675670021 0.433467762413 0.527034386117 0.0770800201911 0.462540774656 0.779855986399 0.459109774294 0.506694813424 0.924947597505 0.111129251369 0.737557853035 0.241193549446 0.682053077681 0.504202271726 0.723967431787 0.290747137785 0.654420997454 0.0816240719028 0.482403936706 0.280259046941 0.763222145797 0.736656060295 0.962773642449 0.650384935108 0.795591606047 0.596993066568 0.302816120106 0.648043660021 0.487691570327 0.986513570375 0.403954266355 0.177324746311 0.794866885491 0.94976682539 0.549647225096 0.801940065897 0.923399366758 0.0643681196838 0.536940833569 0.649433237567 0.693244560629 0.193285148648 0.997589889949 0.343088055715 0.136969794015
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    tempIndex : -24107    1
    Should Contain X Times    ${output}    rx : 0.502000411365    1
    Should Contain X Times    ${output}    ry : 0.807675670021    1
    Should Contain X Times    ${output}    rz : 0.111129251369    1
    Should Contain X Times    ${output}    tx : 0.482403936706    1
    Should Contain X Times    ${output}    ty : 0.648043660021    1
    Should Contain X Times    ${output}    tz : 0.923399366758    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    tempIndex = -24107    1
    Should Contain X Times    ${output}    rx = 0.502000411365    1
    Should Contain X Times    ${output}    ry = 0.807675670021    1
    Should Contain X Times    ${output}    rz = 0.111129251369    1
    Should Contain X Times    ${output}    tx = 0.482403936706    1
    Should Contain X Times    ${output}    ty = 0.648043660021    1
    Should Contain X Times    ${output}    tz = 0.923399366758    1
    Should Contain X Times    ${output}    === [ackCommand_configureTemperatureRawLUT] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
