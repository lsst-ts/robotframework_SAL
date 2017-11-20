*** Settings ***
Documentation    M1M3_ApplyAOSCorrectionByForces commander/controller tests.
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
${component}    ApplyAOSCorrectionByForces
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 37.9186 87.5423 95.1945 29.5108 70.0699 4.0666 12.5754 58.9239 39.0705 86.4881 23.8166 28.1727 20.9206 82.5035 75.6954 41.9664 55.389 56.9441 66.013 87.2789 19.152 6.8466 14.2535 26.8257 10.8442 34.7541 52.0109 73.1704 15.8613 42.6656 27.3998 17.8728 25.6848 24.3566 71.2749 32.1558 97.2989 48.1845 99.018 82.1632 11.5129 90.845 17.6925 86.3935 18.4186 51.6688 32.8613 44.5845 64.4538 39.2408 29.7416 53.4362 77.8387 55.2271 97.5031 54.722 4.6472 20.0455 53.6602 3.8263 6.6506 66.6815 88.9401 4.6081 93.3031 38.4223 96.8892 35.4722 79.3395 0.7696 83.8451 83.9002 70.0742 75.7248 36.015 27.1744 3.9818 24.8012 7.3452 99.5694 16.2494 49.5287 53.7256 21.6418 94.8988 79.5819 95.9801 95.3015 88.157 46.6741 34.1822 92.2911 63.872 4.658 36.7856 51.5209 80.8905 55.7399 13.4498 55.9561 14.2197 20.3985 33.1603 74.5021 87.624 50.7107 95.8474 14.7292 13.132 8.4176 5.9489 4.0005 79.2902 39.5681 93.4705 93.2026 62.3067 27.2018 16.367 82.9514 43.1314 24.9842 19.5071 37.6608 30.9927 44.5188 85.8598 16.5683 52.3305 34.1801 2.3029 7.9953 37.5996 40.5441 63.2479 3.9816 99.1992 93.6369 28.2129 93.7882 63.2101 91.4904 25.0633 95.8018 95.7624 59.8221 31.531 2.8418 70.2631 3.2108 71.8888 74.9143 83.0499 50.9646 27.9061 53.652
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 37.9186 87.5423 95.1945 29.5108 70.0699 4.0666 12.5754 58.9239 39.0705 86.4881 23.8166 28.1727 20.9206 82.5035 75.6954 41.9664 55.389 56.9441 66.013 87.2789 19.152 6.8466 14.2535 26.8257 10.8442 34.7541 52.0109 73.1704 15.8613 42.6656 27.3998 17.8728 25.6848 24.3566 71.2749 32.1558 97.2989 48.1845 99.018 82.1632 11.5129 90.845 17.6925 86.3935 18.4186 51.6688 32.8613 44.5845 64.4538 39.2408 29.7416 53.4362 77.8387 55.2271 97.5031 54.722 4.6472 20.0455 53.6602 3.8263 6.6506 66.6815 88.9401 4.6081 93.3031 38.4223 96.8892 35.4722 79.3395 0.7696 83.8451 83.9002 70.0742 75.7248 36.015 27.1744 3.9818 24.8012 7.3452 99.5694 16.2494 49.5287 53.7256 21.6418 94.8988 79.5819 95.9801 95.3015 88.157 46.6741 34.1822 92.2911 63.872 4.658 36.7856 51.5209 80.8905 55.7399 13.4498 55.9561 14.2197 20.3985 33.1603 74.5021 87.624 50.7107 95.8474 14.7292 13.132 8.4176 5.9489 4.0005 79.2902 39.5681 93.4705 93.2026 62.3067 27.2018 16.367 82.9514 43.1314 24.9842 19.5071 37.6608 30.9927 44.5188 85.8598 16.5683 52.3305 34.1801 2.3029 7.9953 37.5996 40.5441 63.2479 3.9816 99.1992 93.6369 28.2129 93.7882 63.2101 91.4904 25.0633 95.8018 95.7624 59.8221 31.531 2.8418 70.2631 3.2108 71.8888 74.9143 83.0499 50.9646 27.9061 53.652
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    ZForces : 37.9186    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    ZForces(156) = [37.9186, 87.5423, 95.1945, 29.5108, 70.0699, 4.0666, 12.5754, 58.9239, 39.0705, 86.4881, 23.8166, 28.1727, 20.9206, 82.5035, 75.6954, 41.9664, 55.389, 56.9441, 66.013, 87.2789, 19.152, 6.8466, 14.2535, 26.8257, 10.8442, 34.7541, 52.0109, 73.1704, 15.8613, 42.6656, 27.3998, 17.8728, 25.6848, 24.3566, 71.2749, 32.1558, 97.2989, 48.1845, 99.018, 82.1632, 11.5129, 90.845, 17.6925, 86.3935, 18.4186, 51.6688, 32.8613, 44.5845, 64.4538, 39.2408, 29.7416, 53.4362, 77.8387, 55.2271, 97.5031, 54.722, 4.6472, 20.0455, 53.6602, 3.8263, 6.6506, 66.6815, 88.9401, 4.6081, 93.3031, 38.4223, 96.8892, 35.4722, 79.3395, 0.7696, 83.8451, 83.9002, 70.0742, 75.7248, 36.015, 27.1744, 3.9818, 24.8012, 7.3452, 99.5694, 16.2494, 49.5287, 53.7256, 21.6418, 94.8988, 79.5819, 95.9801, 95.3015, 88.157, 46.6741, 34.1822, 92.2911, 63.872, 4.658, 36.7856, 51.5209, 80.8905, 55.7399, 13.4498, 55.9561, 14.2197, 20.3985, 33.1603, 74.5021, 87.624, 50.7107, 95.8474, 14.7292, 13.132, 8.4176, 5.9489, 4.0005, 79.2902, 39.5681, 93.4705, 93.2026, 62.3067, 27.2018, 16.367, 82.9514, 43.1314, 24.9842, 19.5071, 37.6608, 30.9927, 44.5188, 85.8598, 16.5683, 52.3305, 34.1801, 2.3029, 7.9953, 37.5996, 40.5441, 63.2479, 3.9816, 99.1992, 93.6369, 28.2129, 93.7882, 63.2101, 91.4904, 25.0633, 95.8018, 95.7624, 59.8221, 31.531, 2.8418, 70.2631, 3.2108, 71.8888, 74.9143, 83.0499, 50.9646, 27.9061, 53.652]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyAOSCorrectionByForces] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
