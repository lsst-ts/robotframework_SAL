*** Settings ***
Documentation    M1M3_ApplyActiveOpticForces communications tests.
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
${component}    ApplyActiveOpticForces
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 0.000425 0.714097 0.129064 0.52533 0.250627 0.466408 0.15953 0.478153 0.949868 0.990748 0.699878 0.632516 0.91031 0.854369 0.992848 0.843268 0.919863 0.467652 0.610383 0.501632 0.882663 0.791753 0.394014 0.575912 0.070924 0.548445 0.668248 0.396054 0.115645 0.257158 0.362313 0.70282 0.62111 0.951885 0.888148 0.251059 0.125147 0.713531 0.089263 0.378502 0.649993 0.487996 0.251247 0.457618 0.724292 0.963389 0.793711 0.775879 0.190993 0.147457 0.717834 0.71709 0.155465 0.135215 0.219249 0.899411 0.443931 0.152265 0.587962 0.104601 0.446871 0.831795 0.549147 0.002037 0.524944 0.283495 0.407526 0.644893 0.818575 0.229886 0.6681 0.778048 0.609679 0.935894 0.249064 0.447956 0.721036 0.707592 0.468848 0.989145 0.743966 0.844535 0.927619 0.928256 0.318199 0.890596 0.711104 0.715099 0.120161 0.457419 0.046803 0.541798 0.12865 0.622183 0.430638 0.053692 0.81092 0.388355 0.06246 0.47387 0.410478 0.795391 0.399007 0.392524 0.966836 0.955049 0.790432 0.490219 0.567581 0.513181 0.241376 0.244468 0.472856 0.894688 0.570317 0.992579 0.943885 0.995325 0.661147 0.693866 0.138288 0.594318 0.504346 0.825275 0.358363 0.487538 0.518903 0.442674 0.399068 0.877698 0.766225 0.569792 0.244491 0.287856 0.909386 0.671792 0.542924 0.097029 0.332927 0.314068 0.248936 0.52552 0.84191 0.743678 0.43033 0.043711 0.429314 0.737962 0.222059 0.615999 0.25914 0.173169 0.099884 0.324353 0.622221 0.993799
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 0.000425 0.714097 0.129064 0.52533 0.250627 0.466408 0.15953 0.478153 0.949868 0.990748 0.699878 0.632516 0.91031 0.854369 0.992848 0.843268 0.919863 0.467652 0.610383 0.501632 0.882663 0.791753 0.394014 0.575912 0.070924 0.548445 0.668248 0.396054 0.115645 0.257158 0.362313 0.70282 0.62111 0.951885 0.888148 0.251059 0.125147 0.713531 0.089263 0.378502 0.649993 0.487996 0.251247 0.457618 0.724292 0.963389 0.793711 0.775879 0.190993 0.147457 0.717834 0.71709 0.155465 0.135215 0.219249 0.899411 0.443931 0.152265 0.587962 0.104601 0.446871 0.831795 0.549147 0.002037 0.524944 0.283495 0.407526 0.644893 0.818575 0.229886 0.6681 0.778048 0.609679 0.935894 0.249064 0.447956 0.721036 0.707592 0.468848 0.989145 0.743966 0.844535 0.927619 0.928256 0.318199 0.890596 0.711104 0.715099 0.120161 0.457419 0.046803 0.541798 0.12865 0.622183 0.430638 0.053692 0.81092 0.388355 0.06246 0.47387 0.410478 0.795391 0.399007 0.392524 0.966836 0.955049 0.790432 0.490219 0.567581 0.513181 0.241376 0.244468 0.472856 0.894688 0.570317 0.992579 0.943885 0.995325 0.661147 0.693866 0.138288 0.594318 0.504346 0.825275 0.358363 0.487538 0.518903 0.442674 0.399068 0.877698 0.766225 0.569792 0.244491 0.287856 0.909386 0.671792 0.542924 0.097029 0.332927 0.314068 0.248936 0.52552 0.84191 0.743678 0.43033 0.043711 0.429314 0.737962 0.222059 0.615999 0.25914 0.173169 0.099884 0.324353 0.622221 0.993799
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    ZForces : 0.000425    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    ZForces(156) = [0.000425, 0.714097, 0.129064, 0.52533, 0.250627, 0.466408, 0.15953, 0.478153, 0.949868, 0.990748, 0.699878, 0.632516, 0.91031, 0.854369, 0.992848, 0.843268, 0.919863, 0.467652, 0.610383, 0.501632, 0.882663, 0.791753, 0.394014, 0.575912, 0.070924, 0.548445, 0.668248, 0.396054, 0.115645, 0.257158, 0.362313, 0.70282, 0.62111, 0.951885, 0.888148, 0.251059, 0.125147, 0.713531, 0.089263, 0.378502, 0.649993, 0.487996, 0.251247, 0.457618, 0.724292, 0.963389, 0.793711, 0.775879, 0.190993, 0.147457, 0.717834, 0.71709, 0.155465, 0.135215, 0.219249, 0.899411, 0.443931, 0.152265, 0.587962, 0.104601, 0.446871, 0.831795, 0.549147, 0.002037, 0.524944, 0.283495, 0.407526, 0.644893, 0.818575, 0.229886, 0.6681, 0.778048, 0.609679, 0.935894, 0.249064, 0.447956, 0.721036, 0.707592, 0.468848, 0.989145, 0.743966, 0.844535, 0.927619, 0.928256, 0.318199, 0.890596, 0.711104, 0.715099, 0.120161, 0.457419, 0.046803, 0.541798, 0.12865, 0.622183, 0.430638, 0.053692, 0.81092, 0.388355, 0.06246, 0.47387, 0.410478, 0.795391, 0.399007, 0.392524, 0.966836, 0.955049, 0.790432, 0.490219, 0.567581, 0.513181, 0.241376, 0.244468, 0.472856, 0.894688, 0.570317, 0.992579, 0.943885, 0.995325, 0.661147, 0.693866, 0.138288, 0.594318, 0.504346, 0.825275, 0.358363, 0.487538, 0.518903, 0.442674, 0.399068, 0.877698, 0.766225, 0.569792, 0.244491, 0.287856, 0.909386, 0.671792, 0.542924, 0.097029, 0.332927, 0.314068, 0.248936, 0.52552, 0.84191, 0.743678, 0.43033, 0.043711, 0.429314, 0.737962, 0.222059, 0.615999, 0.25914, 0.173169, 0.099884, 0.324353, 0.622221, 0.993799]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyActiveOpticForces] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
