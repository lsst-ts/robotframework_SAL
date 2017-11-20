*** Settings ***
Documentation    M1M3_ApplyAOSCorrectionByForces commander/controller tests.
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
${component}    ApplyAOSCorrectionByForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 95.2845 25.3691 30.3168 74.4501 81.0476 95.5933 26.4944 33.1292 28.218 23.9127 91.6152 5.2059 18.5571 37.9794 67.5695 94.114 60.4521 97.8875 32.6136 53.3125 62.9115 9.1678 61.3631 54.9682 54.1287 34.7192 78.4506 22.8458 50.3961 81.369 22.8629 17.5905 25.711 4.081 0.0229 40.5079 36.2024 81.1617 98.5213 44.7287 31.7866 3.3221 51.9654 51.3086 58.3918 21.1516 89.2417 78.1571 5.3733 99.3714 44.693 97.7523 62.4979 47.9827 33.0324 15.861 20.5906 11.128 78.2166 55.4512 21.744 91.5449 16.8156 6.8879 36.118 84.9881 99.3957 73.2303 79.4911 68.0625 64.1283 44.5385 55.3036 40.1708 39.5021 65.0274 25.0709 2.7032 2.4766 12.8524 17.8592 47.9171 86.9887 5.2232 18.8661 54.047 31.1614 59.7753 59.6838 25.0041 40.9968 71.617 15.1807 94.3548 15.7631 1.9738 88.1464 9.804 48.0978 31.3961 82.1934 57.6772 51.8069 34.7468 47.677 18.385 73.4228 10.1008 6.1216 70.4843 86.7494 89.3432 89.9645 80.7055 87.9835 25.6474 74.3748 51.5654 48.3378 28.1957 15.2709 53.4276 98.852 91.6922 75.4198 30.7636 51.7628 53.2499 50.2331 92.5261 34.5597 10.9125 51.9975 58.9837 28.142 76.5103 48.2071 64.0322 59.5384 50.0947 14.2568 5.3067 59.1595 36.1923 94.0442 87.739 31.0655 63.9585 67.4079 72.9112 78.6191 6.6185 83.3632 90.544 41.9705 30.3463
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 95.2845 25.3691 30.3168 74.4501 81.0476 95.5933 26.4944 33.1292 28.218 23.9127 91.6152 5.2059 18.5571 37.9794 67.5695 94.114 60.4521 97.8875 32.6136 53.3125 62.9115 9.1678 61.3631 54.9682 54.1287 34.7192 78.4506 22.8458 50.3961 81.369 22.8629 17.5905 25.711 4.081 0.0229 40.5079 36.2024 81.1617 98.5213 44.7287 31.7866 3.3221 51.9654 51.3086 58.3918 21.1516 89.2417 78.1571 5.3733 99.3714 44.693 97.7523 62.4979 47.9827 33.0324 15.861 20.5906 11.128 78.2166 55.4512 21.744 91.5449 16.8156 6.8879 36.118 84.9881 99.3957 73.2303 79.4911 68.0625 64.1283 44.5385 55.3036 40.1708 39.5021 65.0274 25.0709 2.7032 2.4766 12.8524 17.8592 47.9171 86.9887 5.2232 18.8661 54.047 31.1614 59.7753 59.6838 25.0041 40.9968 71.617 15.1807 94.3548 15.7631 1.9738 88.1464 9.804 48.0978 31.3961 82.1934 57.6772 51.8069 34.7468 47.677 18.385 73.4228 10.1008 6.1216 70.4843 86.7494 89.3432 89.9645 80.7055 87.9835 25.6474 74.3748 51.5654 48.3378 28.1957 15.2709 53.4276 98.852 91.6922 75.4198 30.7636 51.7628 53.2499 50.2331 92.5261 34.5597 10.9125 51.9975 58.9837 28.142 76.5103 48.2071 64.0322 59.5384 50.0947 14.2568 5.3067 59.1595 36.1923 94.0442 87.739 31.0655 63.9585 67.4079 72.9112 78.6191 6.6185 83.3632 90.544 41.9705 30.3463
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    ZForces : 95.2845    1
    Should Contain    ${output}    === command ApplyAOSCorrectionByForces issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command ApplyAOSCorrectionByForces received =
    Should Contain    ${output}    device : 
    Should Contain    ${output}    property : 
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    ZForces : 95.2845    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyAOSCorrectionByForces] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
