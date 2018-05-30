*** Settings ***
Documentation    Hexapod_configureElevationRawLUT communications tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    hexapod
${component}    configureElevationRawLUT
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -4891 21014 -15271 19236 -16629 -8280 4897 5158 -910 29365 6374 726 17684 26363 9801 7311 17991 -14369 -5934 0.927506 0.014701 0.547506 0.16899 0.580795 0.662905 0.322877 0.115021 0.254863 0.940228 0.106883 0.288974 0.797591 0.958033 0.021876 0.566621 0.649277 0.558303 0.230187 0.561569 0.003681 0.911487 0.001326 0.931419 0.986892 0.800139 0.162372 0.529388 0.097152 0.075863 0.478312 0.814396 0.729227 0.917805 0.187862 0.938035 0.212935 0.44708 0.439512 0.909773 0.939065 0.09552 0.63313 0.097963 0.171277 0.825803 0.717959 0.075042 0.603907 0.772458 0.249674 0.889884 0.904294 0.433162 0.348748 0.609432 0.600761 0.733741 0.22072 0.574907 0.36117 0.321765 0.103108 0.269018 0.571894 0.709007 0.528068 0.46042 0.473966 0.954348 0.52007 0.870044 0.976498 0.731666 0.179859 0.501903 0.272715 0.501766 0.991213 0.307579 0.91637 0.936855 0.846581 0.184451 0.380663 0.729548 0.288838 0.565737 0.0497 0.458315 0.053497 0.701807 0.31333 0.510905 0.4944 0.552942 0.234327 0.102931 0.545972 0.731499 0.254755 0.074699 0.655108 0.347503 0.830817 0.111081 0.887882 0.897581 0.107176 0.630933 0.529938 0.355733 0.006626 0.261552
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -4891 21014 -15271 19236 -16629 -8280 4897 5158 -910 29365 6374 726 17684 26363 9801 7311 17991 -14369 -5934 0.927506 0.014701 0.547506 0.16899 0.580795 0.662905 0.322877 0.115021 0.254863 0.940228 0.106883 0.288974 0.797591 0.958033 0.021876 0.566621 0.649277 0.558303 0.230187 0.561569 0.003681 0.911487 0.001326 0.931419 0.986892 0.800139 0.162372 0.529388 0.097152 0.075863 0.478312 0.814396 0.729227 0.917805 0.187862 0.938035 0.212935 0.44708 0.439512 0.909773 0.939065 0.09552 0.63313 0.097963 0.171277 0.825803 0.717959 0.075042 0.603907 0.772458 0.249674 0.889884 0.904294 0.433162 0.348748 0.609432 0.600761 0.733741 0.22072 0.574907 0.36117 0.321765 0.103108 0.269018 0.571894 0.709007 0.528068 0.46042 0.473966 0.954348 0.52007 0.870044 0.976498 0.731666 0.179859 0.501903 0.272715 0.501766 0.991213 0.307579 0.91637 0.936855 0.846581 0.184451 0.380663 0.729548 0.288838 0.565737 0.0497 0.458315 0.053497 0.701807 0.31333 0.510905 0.4944 0.552942 0.234327 0.102931 0.545972 0.731499 0.254755 0.074699 0.655108 0.347503 0.830817 0.111081 0.887882 0.897581 0.107176 0.630933 0.529938 0.355733 0.006626 0.261552
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    elevIndex : -4891    1
    Should Contain X Times    ${output}    fz1 : 0.927506    1
    Should Contain X Times    ${output}    fz2 : 0.561569    1
    Should Contain X Times    ${output}    fz3 : 0.439512    1
    Should Contain X Times    ${output}    fz4 : 0.733741    1
    Should Contain X Times    ${output}    fz5 : 0.272715    1
    Should Contain X Times    ${output}    fz6 : 0.552942    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    elevIndex(19) = [-4891, 21014, -15271, 19236, -16629, -8280, 4897, 5158, -910, 29365, 6374, 726, 17684, 26363, 9801, 7311, 17991, -14369, -5934]    1
    Should Contain X Times    ${output}    fz1(19) = [0.927506, 0.014701, 0.547506, 0.16899, 0.580795, 0.662905, 0.322877, 0.115021, 0.254863, 0.940228, 0.106883, 0.288974, 0.797591, 0.958033, 0.021876, 0.566621, 0.649277, 0.558303, 0.230187]    1
    Should Contain X Times    ${output}    fz2(19) = [0.561569, 0.003681, 0.911487, 0.001326, 0.931419, 0.986892, 0.800139, 0.162372, 0.529388, 0.097152, 0.075863, 0.478312, 0.814396, 0.729227, 0.917805, 0.187862, 0.938035, 0.212935, 0.44708]    1
    Should Contain X Times    ${output}    fz3(19) = [0.439512, 0.909773, 0.939065, 0.09552, 0.63313, 0.097963, 0.171277, 0.825803, 0.717959, 0.075042, 0.603907, 0.772458, 0.249674, 0.889884, 0.904294, 0.433162, 0.348748, 0.609432, 0.600761]    1
    Should Contain X Times    ${output}    fz4(19) = [0.733741, 0.22072, 0.574907, 0.36117, 0.321765, 0.103108, 0.269018, 0.571894, 0.709007, 0.528068, 0.46042, 0.473966, 0.954348, 0.52007, 0.870044, 0.976498, 0.731666, 0.179859, 0.501903]    1
    Should Contain X Times    ${output}    fz5(19) = [0.272715, 0.501766, 0.991213, 0.307579, 0.91637, 0.936855, 0.846581, 0.184451, 0.380663, 0.729548, 0.288838, 0.565737, 0.0497, 0.458315, 0.053497, 0.701807, 0.31333, 0.510905, 0.4944]    1
    Should Contain X Times    ${output}    fz6(19) = [0.552942, 0.234327, 0.102931, 0.545972, 0.731499, 0.254755, 0.074699, 0.655108, 0.347503, 0.830817, 0.111081, 0.887882, 0.897581, 0.107176, 0.630933, 0.529938, 0.355733, 0.006626, 0.261552]    1
    Should Contain X Times    ${output}    === [ackCommand_configureElevationRawLUT] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
