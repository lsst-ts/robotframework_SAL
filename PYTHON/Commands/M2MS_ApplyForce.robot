*** Settings ***
Documentation    M2MS_ApplyForce commander/controller tests.
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 81.3067 14.7145 80.5764 24.0919 79.6359 87.1129 54.3257 1.8728 59.0991 64.2439 10.7259 61.6307 27.7162 42.7329 16.0607 39.741 73.2307 83.962 28.0995 52.5198 87.0108 48.7638 31.7467 86.0775 25.9887 78.6595 26.889 18.47 77.3184 61.4663 60.5689 4.3182 68.5878 22.5055 93.9923 80.2416 58.4316 31.6898 58.2047 93.0289 17.2906 64.3127 96.3906 17.4273 87.5084 21.971 61.3026 31.9704 73.3823 97.7434 79.6003 50.9719 95.8297 30.7992 69.4926 17.379 15.6643 21.1551 82.9166 77.0076 58.5256 37.2476 74.2993 2.7411 75.5871 35.2617 44.2659 64.902 82.316 8.5041 96.225 97.5446
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 81.3067 14.7145 80.5764 24.0919 79.6359 87.1129 54.3257 1.8728 59.0991 64.2439 10.7259 61.6307 27.7162 42.7329 16.0607 39.741 73.2307 83.962 28.0995 52.5198 87.0108 48.7638 31.7467 86.0775 25.9887 78.6595 26.889 18.47 77.3184 61.4663 60.5689 4.3182 68.5878 22.5055 93.9923 80.2416 58.4316 31.6898 58.2047 93.0289 17.2906 64.3127 96.3906 17.4273 87.5084 21.971 61.3026 31.9704 73.3823 97.7434 79.6003 50.9719 95.8297 30.7992 69.4926 17.379 15.6643 21.1551 82.9166 77.0076 58.5256 37.2476 74.2993 2.7411 75.5871 35.2617 44.2659 64.902 82.316 8.5041 96.225 97.5446
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    forceSetPoint : 81.3067    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    forceSetPoint(72) = [81.3067, 14.7145, 80.5764, 24.0919, 79.6359, 87.1129, 54.3257, 1.8728, 59.0991, 64.2439, 10.7259, 61.6307, 27.7162, 42.7329, 16.0607, 39.741, 73.2307, 83.962, 28.0995, 52.5198, 87.0108, 48.7638, 31.7467, 86.0775, 25.9887, 78.6595, 26.889, 18.47, 77.3184, 61.4663, 60.5689, 4.3182, 68.5878, 22.5055, 93.9923, 80.2416, 58.4316, 31.6898, 58.2047, 93.0289, 17.2906, 64.3127, 96.3906, 17.4273, 87.5084, 21.971, 61.3026, 31.9704, 73.3823, 97.7434, 79.6003, 50.9719, 95.8297, 30.7992, 69.4926, 17.379, 15.6643, 21.1551, 82.9166, 77.0076, 58.5256, 37.2476, 74.2993, 2.7411, 75.5871, 35.2617, 44.2659, 64.902, 82.316, 8.5041, 96.225, 97.5446]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyForce] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
