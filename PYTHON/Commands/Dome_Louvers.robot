*** Settings ***
Documentation    Dome_Louvers commander/controller tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    dome
${component}    Louvers
${timeout}    30s

*** Test Cases ***
Create Commander Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Commander    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

Create Controller Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Controller    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 51.2957 18.2724 91.4522 24.2612 86.0026 37.0037 56.7349 41.4938 98.7721 13.4748 31.6747 54.7403 23.8083 18.5859 65.7173 82.922 0.2693 66.5769 76.6534 94.7125 84.2996 60.305 60.5914 45.4956 0.1466 88.1436 58.8582 44.5106 82.4955 50.2573 4.6045 22.4431 46.6214 18.4472 13.2148 47.9221 39.2343 23.0423 27.5013 98.2921 88.8421 18.6951 10.6963 26.3267 2.142 34.7695 10.5036 30.527 12.7084 77.157 78.9114 92.8103 41.751 87.7207 66.6428 4.4918 43.6938 51.8912 30.0064 7.5749 66.1153 89.2348 78.1426 35.5509 52.2761 65.4451 2.0715 76.1091 12.383 5.6059 7.7388 86.9803
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 51.2957 18.2724 91.4522 24.2612 86.0026 37.0037 56.7349 41.4938 98.7721 13.4748 31.6747 54.7403 23.8083 18.5859 65.7173 82.922 0.2693 66.5769 76.6534 94.7125 84.2996 60.305 60.5914 45.4956 0.1466 88.1436 58.8582 44.5106 82.4955 50.2573 4.6045 22.4431 46.6214 18.4472 13.2148 47.9221 39.2343 23.0423 27.5013 98.2921 88.8421 18.6951 10.6963 26.3267 2.142 34.7695 10.5036 30.527 12.7084 77.157 78.9114 92.8103 41.751 87.7207 66.6428 4.4918 43.6938 51.8912 30.0064 7.5749 66.1153 89.2348 78.1426 35.5509 52.2761 65.4451 2.0715 76.1091 12.383 5.6059 7.7388 86.9803
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    openPercent : 51.2957    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    openPercent(72) = [51.2957, 18.2724, 91.4522, 24.2612, 86.0026, 37.0037, 56.7349, 41.4938, 98.7721, 13.4748, 31.6747, 54.7403, 23.8083, 18.5859, 65.7173, 82.922, 0.2693, 66.5769, 76.6534, 94.7125, 84.2996, 60.305, 60.5914, 45.4956, 0.1466, 88.1436, 58.8582, 44.5106, 82.4955, 50.2573, 4.6045, 22.4431, 46.6214, 18.4472, 13.2148, 47.9221, 39.2343, 23.0423, 27.5013, 98.2921, 88.8421, 18.6951, 10.6963, 26.3267, 2.142, 34.7695, 10.5036, 30.527, 12.7084, 77.157, 78.9114, 92.8103, 41.751, 87.7207, 66.6428, 4.4918, 43.6938, 51.8912, 30.0064, 7.5749, 66.1153, 89.2348, 78.1426, 35.5509, 52.2761, 65.4451, 2.0715, 76.1091, 12.383, 5.6059, 7.7388, 86.9803]    1
    Should Contain X Times    ${output}    === [ackCommand_Louvers] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
