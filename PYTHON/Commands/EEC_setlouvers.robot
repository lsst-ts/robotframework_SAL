*** Settings ***
Documentation    EEC_setlouvers commander/controller tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    eec
${component}    setlouvers
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -4581 -14837 13886 -11493 16396 -17716 -17284 -5460 -9760 -29791 8412 -10060 -8753 -7051 21493 -2422 -23776 21370 15680 4849 16963 -21647 -17930 23017 -3986 -25794 -2485 10116 27683 -18004 21332 -7517 28878 18251 20476 74 22131 -1443 -4655 -27632 19198 -7796 -15117 28858 8017 -20208 19900 -17458 9952 -10375 -31753 9953 -4814 13064 -17634 442 4723 1973 -30098 12737
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -4581 -14837 13886 -11493 16396 -17716 -17284 -5460 -9760 -29791 8412 -10060 -8753 -7051 21493 -2422 -23776 21370 15680 4849 16963 -21647 -17930 23017 -3986 -25794 -2485 10116 27683 -18004 21332 -7517 28878 18251 20476 74 22131 -1443 -4655 -27632 19198 -7796 -15117 28858 8017 -20208 19900 -17458 9952 -10375 -31753 9953 -4814 13064 -17634 442 4723 1973 -30098 12737
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    position : -4581    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    position(60) = [-4581, -14837, 13886, -11493, 16396, -17716, -17284, -5460, -9760, -29791, 8412, -10060, -8753, -7051, 21493, -2422, -23776, 21370, 15680, 4849, 16963, -21647, -17930, 23017, -3986, -25794, -2485, 10116, 27683, -18004, 21332, -7517, 28878, 18251, 20476, 74, 22131, -1443, -4655, -27632, 19198, -7796, -15117, 28858, 8017, -20208, 19900, -17458, 9952, -10375, -31753, 9953, -4814, 13064, -17634, 442, 4723, 1973, -30098, 12737]    1
    Should Contain X Times    ${output}    === [ackCommand_setlouvers] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
