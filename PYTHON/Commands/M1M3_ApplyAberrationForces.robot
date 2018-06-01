*** Settings ***
Documentation    M1M3_ApplyAberrationForces communications tests.
Force Tags    python    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    ApplyAberrationForces
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 0.916593 0.883342 0.49824 0.547668 0.21569 0.905525 0.009335 0.101559 0.283668 0.789124 0.032463 0.750158 0.421262 0.287885 0.549809 0.866952 0.369112 0.808039 0.851945 0.480294 0.173289 0.040189 0.295472 0.414135 0.5559 0.085164 0.545166 0.224523 0.78006 0.72823 0.768008 0.201061 0.136477 0.555137 0.986391 0.367376 0.761053 0.323454 0.749607 0.261866 0.776903 0.437372 0.864541 0.320637 0.871759 0.456359 0.243276 0.633233 0.292288 0.887457 0.894156 0.217501 0.765295 0.730157 0.31101 0.974871 0.284219 0.942513 0.942352 0.896396 0.431175 0.783696 0.958916 0.246508 0.790749 0.931122 0.744086 0.423932 0.767965 0.822566 0.989679 0.72009 0.376491 0.386788 0.140499 0.770057 0.797299 0.699486 0.233911 0.74926 0.008046 0.958613 0.895762 0.689047 0.206425 0.965823 0.172228 0.491736 0.222992 0.703788 0.48528 0.816674 0.950538 0.085161 0.816446 0.761197 0.654581 0.18855 0.135719 0.406284 0.482048 0.542143 0.303498 0.606611 0.700986 0.141184 0.594873 0.16653 0.469261 0.39454 0.081253 0.111856 0.364268 0.728651 0.932921 0.51908 0.988527 0.264267 0.07814 0.237535 0.527404 0.251959 0.473036 0.443682 0.356818 0.103011 0.990821 0.713659 0.064824 0.117023 0.725769 0.250923 0.515095 0.885918 0.439965 0.37783 0.132005 0.042783 0.648876 0.581502 0.086611 0.926293 0.218138 0.730834 0.705992 0.40707 0.606056 0.023531 0.711215 0.953495 0.043138 0.846703 0.067711 0.047903 0.856352 0.662015
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 0.916593 0.883342 0.49824 0.547668 0.21569 0.905525 0.009335 0.101559 0.283668 0.789124 0.032463 0.750158 0.421262 0.287885 0.549809 0.866952 0.369112 0.808039 0.851945 0.480294 0.173289 0.040189 0.295472 0.414135 0.5559 0.085164 0.545166 0.224523 0.78006 0.72823 0.768008 0.201061 0.136477 0.555137 0.986391 0.367376 0.761053 0.323454 0.749607 0.261866 0.776903 0.437372 0.864541 0.320637 0.871759 0.456359 0.243276 0.633233 0.292288 0.887457 0.894156 0.217501 0.765295 0.730157 0.31101 0.974871 0.284219 0.942513 0.942352 0.896396 0.431175 0.783696 0.958916 0.246508 0.790749 0.931122 0.744086 0.423932 0.767965 0.822566 0.989679 0.72009 0.376491 0.386788 0.140499 0.770057 0.797299 0.699486 0.233911 0.74926 0.008046 0.958613 0.895762 0.689047 0.206425 0.965823 0.172228 0.491736 0.222992 0.703788 0.48528 0.816674 0.950538 0.085161 0.816446 0.761197 0.654581 0.18855 0.135719 0.406284 0.482048 0.542143 0.303498 0.606611 0.700986 0.141184 0.594873 0.16653 0.469261 0.39454 0.081253 0.111856 0.364268 0.728651 0.932921 0.51908 0.988527 0.264267 0.07814 0.237535 0.527404 0.251959 0.473036 0.443682 0.356818 0.103011 0.990821 0.713659 0.064824 0.117023 0.725769 0.250923 0.515095 0.885918 0.439965 0.37783 0.132005 0.042783 0.648876 0.581502 0.086611 0.926293 0.218138 0.730834 0.705992 0.40707 0.606056 0.023531 0.711215 0.953495 0.043138 0.846703 0.067711 0.047903 0.856352 0.662015
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    ZForces : 0.916593    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    ZForces(156) = [0.916593, 0.883342, 0.49824, 0.547668, 0.21569, 0.905525, 0.009335, 0.101559, 0.283668, 0.789124, 0.032463, 0.750158, 0.421262, 0.287885, 0.549809, 0.866952, 0.369112, 0.808039, 0.851945, 0.480294, 0.173289, 0.040189, 0.295472, 0.414135, 0.5559, 0.085164, 0.545166, 0.224523, 0.78006, 0.72823, 0.768008, 0.201061, 0.136477, 0.555137, 0.986391, 0.367376, 0.761053, 0.323454, 0.749607, 0.261866, 0.776903, 0.437372, 0.864541, 0.320637, 0.871759, 0.456359, 0.243276, 0.633233, 0.292288, 0.887457, 0.894156, 0.217501, 0.765295, 0.730157, 0.31101, 0.974871, 0.284219, 0.942513, 0.942352, 0.896396, 0.431175, 0.783696, 0.958916, 0.246508, 0.790749, 0.931122, 0.744086, 0.423932, 0.767965, 0.822566, 0.989679, 0.72009, 0.376491, 0.386788, 0.140499, 0.770057, 0.797299, 0.699486, 0.233911, 0.74926, 0.008046, 0.958613, 0.895762, 0.689047, 0.206425, 0.965823, 0.172228, 0.491736, 0.222992, 0.703788, 0.48528, 0.816674, 0.950538, 0.085161, 0.816446, 0.761197, 0.654581, 0.18855, 0.135719, 0.406284, 0.482048, 0.542143, 0.303498, 0.606611, 0.700986, 0.141184, 0.594873, 0.16653, 0.469261, 0.39454, 0.081253, 0.111856, 0.364268, 0.728651, 0.932921, 0.51908, 0.988527, 0.264267, 0.07814, 0.237535, 0.527404, 0.251959, 0.473036, 0.443682, 0.356818, 0.103011, 0.990821, 0.713659, 0.064824, 0.117023, 0.725769, 0.250923, 0.515095, 0.885918, 0.439965, 0.37783, 0.132005, 0.042783, 0.648876, 0.581502, 0.086611, 0.926293, 0.218138, 0.730834, 0.705992, 0.40707, 0.606056, 0.023531, 0.711215, 0.953495, 0.043138, 0.846703, 0.067711, 0.047903, 0.856352, 0.662015]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyAberrationForces] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
