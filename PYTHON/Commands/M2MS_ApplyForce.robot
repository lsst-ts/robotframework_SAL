*** Settings ***
Documentation    M2MS_ApplyForce commander/controller tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    m2ms
${component}    ApplyForce
${timeout}    30s

*** Test Cases ***
Create Commander Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Commander    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}

Create Controller Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Controller    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}

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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 27.3702 69.5881 42.4746 70.014 44.4951 97.1073 98.6763 26.6507 45.8672 44.2942 49.3995 93.163 94.19 79.8347 16.8726 42.5221 89.1747 41.2244 62.0943 34.6671 58.5447 80.1318 72.8841 54.5731 34.5127 56.6193 34.1664 33.0775 74.7411 6.1264 49.6923 44.1665 92.868 16.6636 94.7935 55.6385 87.4388 17.8499 23.2161 8.3288 18.7461 75.089 34.0001 7.137 17.1887 12.5627 79.5243 75.9604 88.5498 3.4784 18.5321 27.1083 93.4283 15.3804 42.537 65.2547 93.2056 52.6324 96.2203 60.4321 13.9062 83.805 53.4526 21.0113 63.4272 99.7915 80.1931 67.929 78.1185 59.9785 99.8884 41.2627
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 27.3702 69.5881 42.4746 70.014 44.4951 97.1073 98.6763 26.6507 45.8672 44.2942 49.3995 93.163 94.19 79.8347 16.8726 42.5221 89.1747 41.2244 62.0943 34.6671 58.5447 80.1318 72.8841 54.5731 34.5127 56.6193 34.1664 33.0775 74.7411 6.1264 49.6923 44.1665 92.868 16.6636 94.7935 55.6385 87.4388 17.8499 23.2161 8.3288 18.7461 75.089 34.0001 7.137 17.1887 12.5627 79.5243 75.9604 88.5498 3.4784 18.5321 27.1083 93.4283 15.3804 42.537 65.2547 93.2056 52.6324 96.2203 60.4321 13.9062 83.805 53.4526 21.0113 63.4272 99.7915 80.1931 67.929 78.1185 59.9785 99.8884 41.2627
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetPoint : 27.3702    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetPoint(72) = [27.3702, 69.5881, 42.4746, 70.014, 44.4951, 97.1073, 98.6763, 26.6507, 45.8672, 44.2942, 49.3995, 93.163, 94.19, 79.8347, 16.8726, 42.5221, 89.1747, 41.2244, 62.0943, 34.6671, 58.5447, 80.1318, 72.8841, 54.5731, 34.5127, 56.6193, 34.1664, 33.0775, 74.7411, 6.1264, 49.6923, 44.1665, 92.868, 16.6636, 94.7935, 55.6385, 87.4388, 17.8499, 23.2161, 8.3288, 18.7461, 75.089, 34.0001, 7.137, 17.1887, 12.5627, 79.5243, 75.9604, 88.5498, 3.4784, 18.5321, 27.1083, 93.4283, 15.3804, 42.537, 65.2547, 93.2056, 52.6324, 96.2203, 60.4321, 13.9062, 83.805, 53.4526, 21.0113, 63.4272, 99.7915, 80.1931, 67.929, 78.1185, 59.9785, 99.8884, 41.2627]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
