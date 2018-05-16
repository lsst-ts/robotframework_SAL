*** Settings ***
Documentation    M2MS_ApplyBendingMode commander/controller tests.
Force Tags    python    Checking if skipped: m2ms
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m2ms
${component}    ApplyBendingMode
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -1561 24631 -21002 -21490 5534 6429 -19947 30330 12103 25446 29911 2184 18929 -19294 21642 14636 -22632 23965 -21390 22561 29505 27713 20513 -21880 -21405 23576 19731 1060 21109 -2788 -29119 5680 4.408 82.643 81.7884 14.3163 1.2122 65.1395 24.3152 40.0024 37.3311 31.2161 44.656 83.3182 14.4147 78.6214 36.4261 41.8599 2.5342 38.816 26.9248 95.6604 8.6565 97.0594 31.9784 18.1887 84.1938 38.1345 24.7776 90.7013 35.7189 18.5591 30.4808 3.4413
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -1561 24631 -21002 -21490 5534 6429 -19947 30330 12103 25446 29911 2184 18929 -19294 21642 14636 -22632 23965 -21390 22561 29505 27713 20513 -21880 -21405 23576 19731 1060 21109 -2788 -29119 5680 4.408 82.643 81.7884 14.3163 1.2122 65.1395 24.3152 40.0024 37.3311 31.2161 44.656 83.3182 14.4147 78.6214 36.4261 41.8599 2.5342 38.816 26.9248 95.6604 8.6565 97.0594 31.9784 18.1887 84.1938 38.1345 24.7776 90.7013 35.7189 18.5591 30.4808 3.4413
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    bendingModeNbr : -1561    1
    Should Contain X Times    ${output}    bendingModeValue : 4.408    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    bendingModeNbr(32) = [-1561, 24631, -21002, -21490, 5534, 6429, -19947, 30330, 12103, 25446, 29911, 2184, 18929, -19294, 21642, 14636, -22632, 23965, -21390, 22561, 29505, 27713, 20513, -21880, -21405, 23576, 19731, 1060, 21109, -2788, -29119, 5680]    1
    Should Contain X Times    ${output}    bendingModeValue(32) = [4.408, 82.643, 81.7884, 14.3163, 1.2122, 65.1395, 24.3152, 40.0024, 37.3311, 31.2161, 44.656, 83.3182, 14.4147, 78.6214, 36.4261, 41.8599, 2.5342, 38.816, 26.9248, 95.6604, 8.6565, 97.0594, 31.9784, 18.1887, 84.1938, 38.1345, 24.7776, 90.7013, 35.7189, 18.5591, 30.4808, 3.4413]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyBendingMode] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
