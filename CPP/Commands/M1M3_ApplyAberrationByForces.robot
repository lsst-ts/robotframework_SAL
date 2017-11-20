*** Settings ***
Documentation    M1M3_ApplyAberrationByForces commander/controller tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    ApplyAberrationByForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 81.8718 91.8001 1.4812 41.1463 29.0453 19.9789 80.0467 69.0814 97.5778 53.5188 18.5162 51.051 61.5696 75.4038 17.1016 15.8737 66.101 0.0982 59.4362 38.1532 9.9188 35.14 73.0914 67.2629 95.8667 48.7266 77.7527 7.78 35.3285 13.9768 26.7791 9.1188 35.6821 7.0053 0.9336 80.8471 11.2014 84.4135 61.9647 97.3726 38.5369 10.8339 8.0996 45.0914 25.259 68.2955 83.6891 30.9407 64.9887 75.4618 71.9916 39.5356 59.2502 24.7869 60.0402 36.1828 56.4723 67.6052 33.4792 64.5476 60.6859 93.1022 19.2427 61.9415 9.5983 91.8934 42.8475 19.2746 86.8636 97.1766 58.627 24.5375 1.8918 19.802 88.23 26.8992 84.0517 91.8932 99.016 1.4944 1.5862 49.7828 99.6666 7.016 71.8838 51.2608 28.6793 8.2998 85.2344 65.6062 22.5308 73.0145 4.7172 38.0706 76.64 90.0508 44.1882 59.5122 77.265 31.026 76.155 40.0733 33.5794 17.3182 38.3151 79.0102 30.313 41.2661 47.1453 51.6552 38.3703 49.5904 6.8314 78.3538 68.1798 40.1922 15.5326 95.6041 12.953 42.0412 16.9391 71.102 83.5267 68.3866 59.6449 5.5779 25.6163 35.0242 21.3836 47.201 50.4648 34.7782 3.1706 17.7939 1.4462 61.0555 37.8773 90.5216 54.9935 57.896 86.0018 33.9613 79.2746 18.041 86.6547 94.2326 9.5749 46.8457 86.0469 62.0413 35.3158 89.3408 13.9886 24.3322 76.7744 90.1672
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 81.8718 91.8001 1.4812 41.1463 29.0453 19.9789 80.0467 69.0814 97.5778 53.5188 18.5162 51.051 61.5696 75.4038 17.1016 15.8737 66.101 0.0982 59.4362 38.1532 9.9188 35.14 73.0914 67.2629 95.8667 48.7266 77.7527 7.78 35.3285 13.9768 26.7791 9.1188 35.6821 7.0053 0.9336 80.8471 11.2014 84.4135 61.9647 97.3726 38.5369 10.8339 8.0996 45.0914 25.259 68.2955 83.6891 30.9407 64.9887 75.4618 71.9916 39.5356 59.2502 24.7869 60.0402 36.1828 56.4723 67.6052 33.4792 64.5476 60.6859 93.1022 19.2427 61.9415 9.5983 91.8934 42.8475 19.2746 86.8636 97.1766 58.627 24.5375 1.8918 19.802 88.23 26.8992 84.0517 91.8932 99.016 1.4944 1.5862 49.7828 99.6666 7.016 71.8838 51.2608 28.6793 8.2998 85.2344 65.6062 22.5308 73.0145 4.7172 38.0706 76.64 90.0508 44.1882 59.5122 77.265 31.026 76.155 40.0733 33.5794 17.3182 38.3151 79.0102 30.313 41.2661 47.1453 51.6552 38.3703 49.5904 6.8314 78.3538 68.1798 40.1922 15.5326 95.6041 12.953 42.0412 16.9391 71.102 83.5267 68.3866 59.6449 5.5779 25.6163 35.0242 21.3836 47.201 50.4648 34.7782 3.1706 17.7939 1.4462 61.0555 37.8773 90.5216 54.9935 57.896 86.0018 33.9613 79.2746 18.041 86.6547 94.2326 9.5749 46.8457 86.0469 62.0413 35.3158 89.3408 13.9886 24.3322 76.7744 90.1672
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    ZForces : 81.8718    1
    Should Contain    ${output}    === command ApplyAberrationByForces issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command ApplyAberrationByForces received =
    Should Contain    ${output}    device : 
    Should Contain    ${output}    property : 
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    ZForces : 81.8718    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyAberrationByForces] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
