*** Settings ***
Documentation    M1M3_ApplyAberrationByForces commander/controller tests.
Force Tags    python    
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 79.3751 47.204 71.004 17.0593 47.3604 90.8441 88.6914 46.3561 2.968 63.2888 43.1403 53.5295 18.2341 51.3988 42.8801 36.2642 53.9104 42.0159 4.4223 48.1373 66.2433 93.0516 74.1394 51.5242 12.0917 89.4359 95.7644 67.1347 98.1594 20.3127 15.1599 60.7109 69.1944 7.7109 54.342 85.8509 51.8451 81.8248 97.7867 38.253 6.4012 79.7637 88.7845 80.3557 25.7302 20.1516 94.889 26.5988 98.7547 21.9831 51.4362 42.0391 74.3951 69.9901 59.5603 23.4943 70.0513 90.8605 37.926 59.787 82.5875 38.5351 96.952 81.6642 98.925 65.8768 87.6145 70.4672 67.0899 58.9276 31.5727 54.6686 31.7348 69.0668 56.3406 74.1354 14.0156 10.1916 82.0386 94.8495 68.0142 7.0686 55.1644 41.9125 17.1318 44.9915 4.0421 64.9793 76.5293 25.7966 39.3635 90.5239 75.0538 66.5394 52.349 34.9759 95.5571 93.5352 79.6476 1.7924 1.7054 81.2959 76.0872 28.6311 52.6632 95.5523 4.3834 5.2074 96.6305 67.7323 32.862 82.058 98.3218 96.2635 11.2512 83.3522 78.8554 96.6943 77.1019 2.0454 20.7782 72.4261 75.8587 38.0492 30.7001 47.2451 15.2045 7.8463 97.3192 9.0542 9.366 76.6784 77.983 26.2383 88.4521 59.8738 91.2526 84.3887 46.7189 40.0029 26.4843 43.2695 27.5464 66.9791 38.706 26.4611 71.9723 54.9845 53.7536 88.5916 31.9348 70.9845 57.0215 68.0269 50.8858 1.7168
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 79.3751 47.204 71.004 17.0593 47.3604 90.8441 88.6914 46.3561 2.968 63.2888 43.1403 53.5295 18.2341 51.3988 42.8801 36.2642 53.9104 42.0159 4.4223 48.1373 66.2433 93.0516 74.1394 51.5242 12.0917 89.4359 95.7644 67.1347 98.1594 20.3127 15.1599 60.7109 69.1944 7.7109 54.342 85.8509 51.8451 81.8248 97.7867 38.253 6.4012 79.7637 88.7845 80.3557 25.7302 20.1516 94.889 26.5988 98.7547 21.9831 51.4362 42.0391 74.3951 69.9901 59.5603 23.4943 70.0513 90.8605 37.926 59.787 82.5875 38.5351 96.952 81.6642 98.925 65.8768 87.6145 70.4672 67.0899 58.9276 31.5727 54.6686 31.7348 69.0668 56.3406 74.1354 14.0156 10.1916 82.0386 94.8495 68.0142 7.0686 55.1644 41.9125 17.1318 44.9915 4.0421 64.9793 76.5293 25.7966 39.3635 90.5239 75.0538 66.5394 52.349 34.9759 95.5571 93.5352 79.6476 1.7924 1.7054 81.2959 76.0872 28.6311 52.6632 95.5523 4.3834 5.2074 96.6305 67.7323 32.862 82.058 98.3218 96.2635 11.2512 83.3522 78.8554 96.6943 77.1019 2.0454 20.7782 72.4261 75.8587 38.0492 30.7001 47.2451 15.2045 7.8463 97.3192 9.0542 9.366 76.6784 77.983 26.2383 88.4521 59.8738 91.2526 84.3887 46.7189 40.0029 26.4843 43.2695 27.5464 66.9791 38.706 26.4611 71.9723 54.9845 53.7536 88.5916 31.9348 70.9845 57.0215 68.0269 50.8858 1.7168
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    ZForces : 79.3751    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    ZForces(156) = [79.3751, 47.204, 71.004, 17.0593, 47.3604, 90.8441, 88.6914, 46.3561, 2.968, 63.2888, 43.1403, 53.5295, 18.2341, 51.3988, 42.8801, 36.2642, 53.9104, 42.0159, 4.4223, 48.1373, 66.2433, 93.0516, 74.1394, 51.5242, 12.0917, 89.4359, 95.7644, 67.1347, 98.1594, 20.3127, 15.1599, 60.7109, 69.1944, 7.7109, 54.342, 85.8509, 51.8451, 81.8248, 97.7867, 38.253, 6.4012, 79.7637, 88.7845, 80.3557, 25.7302, 20.1516, 94.889, 26.5988, 98.7547, 21.9831, 51.4362, 42.0391, 74.3951, 69.9901, 59.5603, 23.4943, 70.0513, 90.8605, 37.926, 59.787, 82.5875, 38.5351, 96.952, 81.6642, 98.925, 65.8768, 87.6145, 70.4672, 67.0899, 58.9276, 31.5727, 54.6686, 31.7348, 69.0668, 56.3406, 74.1354, 14.0156, 10.1916, 82.0386, 94.8495, 68.0142, 7.0686, 55.1644, 41.9125, 17.1318, 44.9915, 4.0421, 64.9793, 76.5293, 25.7966, 39.3635, 90.5239, 75.0538, 66.5394, 52.349, 34.9759, 95.5571, 93.5352, 79.6476, 1.7924, 1.7054, 81.2959, 76.0872, 28.6311, 52.6632, 95.5523, 4.3834, 5.2074, 96.6305, 67.7323, 32.862, 82.058, 98.3218, 96.2635, 11.2512, 83.3522, 78.8554, 96.6943, 77.1019, 2.0454, 20.7782, 72.4261, 75.8587, 38.0492, 30.7001, 47.2451, 15.2045, 7.8463, 97.3192, 9.0542, 9.366, 76.6784, 77.983, 26.2383, 88.4521, 59.8738, 91.2526, 84.3887, 46.7189, 40.0029, 26.4843, 43.2695, 27.5464, 66.9791, 38.706, 26.4611, 71.9723, 54.9845, 53.7536, 88.5916, 31.9348, 70.9845, 57.0215, 68.0269, 50.8858, 1.7168]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyAberrationByForces] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
