*** Settings ***
Documentation    M2MS_ApplyForce communications tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m2ms
${component}    ApplyForce
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 40.9805 92.5446 80.3298 79.7466 75.2585 50.3433 42.4942 89.78 87.5155 59.0064 48.0516 51.5466 86.3304 11.8901 5.9005 35.1737 13.6028 21.5944 10.0363 67.4994 67.6647 89.2293 75.9303 95.7704 43.6935 46.7984 48.2208 0.2464 85.3121 60.1189 23.9523 56.2201 91.9589 64.7867 52.851 3.5611 62.8198 25.113 12.4457 15.2003 69.5784 74.8802 93.9194 97.4195 90.0088 1.0988 83.1583 7.2587 85.0866 61.6791 43.8502 33.9187 53.2281 30.4122 20.0522 8.6611 35.6912 63.2827 14.522 65.8785 84.0081 49.8931 79.0784 82.0965 99.8949 81.9536 57.3986 30.4361 61.094 62.5533 21.4619 10.5206
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 40.9805 92.5446 80.3298 79.7466 75.2585 50.3433 42.4942 89.78 87.5155 59.0064 48.0516 51.5466 86.3304 11.8901 5.9005 35.1737 13.6028 21.5944 10.0363 67.4994 67.6647 89.2293 75.9303 95.7704 43.6935 46.7984 48.2208 0.2464 85.3121 60.1189 23.9523 56.2201 91.9589 64.7867 52.851 3.5611 62.8198 25.113 12.4457 15.2003 69.5784 74.8802 93.9194 97.4195 90.0088 1.0988 83.1583 7.2587 85.0866 61.6791 43.8502 33.9187 53.2281 30.4122 20.0522 8.6611 35.6912 63.2827 14.522 65.8785 84.0081 49.8931 79.0784 82.0965 99.8949 81.9536 57.3986 30.4361 61.094 62.5533 21.4619 10.5206
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetPoint : 40.9805    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetPoint(72) = [40.9805, 92.5446, 80.3298, 79.7466, 75.2585, 50.3433, 42.4942, 89.78, 87.5155, 59.0064, 48.0516, 51.5466, 86.3304, 11.8901, 5.9005, 35.1737, 13.6028, 21.5944, 10.0363, 67.4994, 67.6647, 89.2293, 75.9303, 95.7704, 43.6935, 46.7984, 48.2208, 0.2464, 85.3121, 60.1189, 23.9523, 56.2201, 91.9589, 64.7867, 52.851, 3.5611, 62.8198, 25.113, 12.4457, 15.2003, 69.5784, 74.8802, 93.9194, 97.4195, 90.0088, 1.0988, 83.1583, 7.2587, 85.0866, 61.6791, 43.8502, 33.9187, 53.2281, 30.4122, 20.0522, 8.6611, 35.6912, 63.2827, 14.522, 65.8785, 84.0081, 49.8931, 79.0784, 82.0965, 99.8949, 81.9536, 57.3986, 30.4361, 61.094, 62.5533, 21.4619, 10.5206]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
