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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -15662 -270 1006 24799 -31634 -25969 -15795 13384 -8981 0.622849965646 0.0929683237409 0.828832357818 0.723885379821 0.910838110561 0.263051676037 0.0449293041333 0.0583840940357 0.29169531427 0.463386029865 0.18319591358 0.792329408065 0.319264122546 0.940828109613 0.772533993912 0.520344792487 0.602604017569 0.759546104883 0.433665613496 0.894694509896 0.150115107926 0.181029021718 0.406870785177 0.803135554948 0.508704042642 0.151164022734 0.79188913339 0.761689303593 0.261026637363 0.416162232125 0.147952819235 0.107879239239 0.387775806583 0.438390985371 0.992784846824 0.257042714945 0.570496869524 0.00955045959444 0.910974989802 0.383904789394 0.622788267923 0.412437404193 0.458933254619 0.0106866695522 0.240130086297 0.706867466164 0.341180362012 0.400312186923 0.80303111607 0.363935361721 0.244659636873 0.597523475044 0.628988134382 0.641397040126
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -15662 -270 1006 24799 -31634 -25969 -15795 13384 -8981 0.622849965646 0.0929683237409 0.828832357818 0.723885379821 0.910838110561 0.263051676037 0.0449293041333 0.0583840940357 0.29169531427 0.463386029865 0.18319591358 0.792329408065 0.319264122546 0.940828109613 0.772533993912 0.520344792487 0.602604017569 0.759546104883 0.433665613496 0.894694509896 0.150115107926 0.181029021718 0.406870785177 0.803135554948 0.508704042642 0.151164022734 0.79188913339 0.761689303593 0.261026637363 0.416162232125 0.147952819235 0.107879239239 0.387775806583 0.438390985371 0.992784846824 0.257042714945 0.570496869524 0.00955045959444 0.910974989802 0.383904789394 0.622788267923 0.412437404193 0.458933254619 0.0106866695522 0.240130086297 0.706867466164 0.341180362012 0.400312186923 0.80303111607 0.363935361721 0.244659636873 0.597523475044 0.628988134382 0.641397040126
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    tempIndex : -15662    1
    Should Contain X Times    ${output}    rx : 0.622849965646    1
    Should Contain X Times    ${output}    ry : 0.463386029865    1
    Should Contain X Times    ${output}    rz : 0.433665613496    1
    Should Contain X Times    ${output}    tx : 0.761689303593    1
    Should Contain X Times    ${output}    ty : 0.570496869524    1
    Should Contain X Times    ${output}    tz : 0.706867466164    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    tempIndex = -15662    1
    Should Contain X Times    ${output}    rx = 0.622849965646    1
    Should Contain X Times    ${output}    ry = 0.463386029865    1
    Should Contain X Times    ${output}    rz = 0.433665613496    1
    Should Contain X Times    ${output}    tx = 0.761689303593    1
    Should Contain X Times    ${output}    ty = 0.570496869524    1
    Should Contain X Times    ${output}    tz = 0.706867466164    1
    Should Contain X Times    ${output}    === [ackCommand_configureTemperatureRawLUT] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
