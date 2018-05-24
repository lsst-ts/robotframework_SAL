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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 21434 32613 -16317 -25621 -9013 14164 16695 -14305 -21622 0.058325160982 0.437413388422 0.902348112873 0.35435061845 0.0261422251167 0.158024551225 0.932243241228 0.43358651216 0.975966713445 0.495038556148 0.815226906832 0.2175174933 0.413278758294 0.324263647745 0.717281922727 0.690200535844 0.543369762823 0.0318912719763 0.368595139011 0.740558446666 0.755974092396 0.666823269323 0.166776496564 0.828944059464 0.778044171573 0.120383256344 0.535959779651 0.287859182702 0.801214058909 0.385290440663 0.168078539519 0.994321201353 0.227137022623 0.140289309809 0.950061639124 0.818824280169 0.225899550852 0.579444289339 0.620441228884 0.574626454557 0.945805666329 0.928632221597 0.306465413595 0.953037982853 0.266904537726 0.230986578595 0.32966333634 0.0174464607372 0.806164484302 0.206934345515 0.90020312146 0.670090566046 0.0107201954984 0.90853277182
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 21434 32613 -16317 -25621 -9013 14164 16695 -14305 -21622 0.058325160982 0.437413388422 0.902348112873 0.35435061845 0.0261422251167 0.158024551225 0.932243241228 0.43358651216 0.975966713445 0.495038556148 0.815226906832 0.2175174933 0.413278758294 0.324263647745 0.717281922727 0.690200535844 0.543369762823 0.0318912719763 0.368595139011 0.740558446666 0.755974092396 0.666823269323 0.166776496564 0.828944059464 0.778044171573 0.120383256344 0.535959779651 0.287859182702 0.801214058909 0.385290440663 0.168078539519 0.994321201353 0.227137022623 0.140289309809 0.950061639124 0.818824280169 0.225899550852 0.579444289339 0.620441228884 0.574626454557 0.945805666329 0.928632221597 0.306465413595 0.953037982853 0.266904537726 0.230986578595 0.32966333634 0.0174464607372 0.806164484302 0.206934345515 0.90020312146 0.670090566046 0.0107201954984 0.90853277182
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    tempIndex : 21434    1
    Should Contain X Times    ${output}    rx : 0.058325160982    1
    Should Contain X Times    ${output}    ry : 0.495038556148    1
    Should Contain X Times    ${output}    rz : 0.368595139011    1
    Should Contain X Times    ${output}    tx : 0.287859182702    1
    Should Contain X Times    ${output}    ty : 0.225899550852    1
    Should Contain X Times    ${output}    tz : 0.230986578595    1
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
    Should Contain X Times    ${output}    tempIndex : 21434    1
    Should Contain X Times    ${output}    rx : 0.058325160982    1
    Should Contain X Times    ${output}    ry : 0.495038556148    1
    Should Contain X Times    ${output}    rz : 0.368595139011    1
    Should Contain X Times    ${output}    tx : 0.287859182702    1
    Should Contain X Times    ${output}    ty : 0.225899550852    1
    Should Contain X Times    ${output}    tz : 0.230986578595    1
    Should Contain X Times    ${output}    === [ackCommand_configureTemperatureRawLUT] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
