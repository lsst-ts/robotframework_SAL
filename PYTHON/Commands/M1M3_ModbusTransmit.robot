*** Settings ***
Documentation    M1M3_ModbusTransmit communications tests.
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
${component}    ModbusTransmit
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 1703102024 27379 16340 -159 -16969 -7917 -27784 -30066 -13092 -7815 -4084 -13942 26952 -32671 17290 23651 11643 7493 -13775 -13128 3968 32402 -20177 2351 -24205 -12847 27271 -23875 16332 7511 12481 -2847 -13248 -13357 -1126 -19731 20241 27330 25526 -29971 -4559 13864 12403 12503 -30322 -7787 30308 16766 19544 23713 -10810 5707 27231 16116 11562 -783 14410 28993 1758 -22274 -11332 -18167 5293 -26521 4427 -10462 11509 -14370 -11847 7314 -22289 -16604 -18519 26672 13859 -26471 532 -7429 5587 23827 -11432 -30406 -12603 -8922 -9600 8438 -9231 -7974 29534 17055 9180 -18705 19392 -28458 -26167 -22052 15314 1611 941 1607 -2873 -29886 -3845 1521 -18315 -23235 -28083 -3792 457 9586 7066 -14013 6336 2303 -26442 28773 32623 17363 4671 -15759 -2924 -9392 -32328 -7650 15446 -17680 3634 -30078 1640 24278 -22337 25208 30594 -15115 -16469 -4585 -28699 27728 10434 -13739 -18498 17422 12718 -6984 -12009 22706 20620 -6057 -7024 -11239 27544 23298 25401 4693 -24066 -26098 20276 15290 -17420 24219 25001 -25417 20749 -4835 20020 30487 -20565 -13491 2723 -5033 27562 18893 25420 -28241 12607 -12263 -4254 -549 -17191 859 14204 -14142 -22565 -4364 -6633 4868 -9157 -23469 -30608 -8353 8270 -14672 -5504 20795 24632 -21645 -6561 -13259 -21911 -9781 13527 -3921 27240 -9848 20011 28549 29817 1168 24929 -16527 19934 -15906 26093 27773 21725 15150 16035 21042 -20309 -2445 5104 31343 17261 -9225 -1819 -14082 31212 18247 27932 29466 -14118 -9809 -1999 -24447 -19335 14559 -5316 26832 1885 154 -20212 -26930 -30384 7751 -19675 -26326 23092 6438 -21300 6830 -32385 -3880 21227 29839 -22137
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 1703102024 27379 16340 -159 -16969 -7917 -27784 -30066 -13092 -7815 -4084 -13942 26952 -32671 17290 23651 11643 7493 -13775 -13128 3968 32402 -20177 2351 -24205 -12847 27271 -23875 16332 7511 12481 -2847 -13248 -13357 -1126 -19731 20241 27330 25526 -29971 -4559 13864 12403 12503 -30322 -7787 30308 16766 19544 23713 -10810 5707 27231 16116 11562 -783 14410 28993 1758 -22274 -11332 -18167 5293 -26521 4427 -10462 11509 -14370 -11847 7314 -22289 -16604 -18519 26672 13859 -26471 532 -7429 5587 23827 -11432 -30406 -12603 -8922 -9600 8438 -9231 -7974 29534 17055 9180 -18705 19392 -28458 -26167 -22052 15314 1611 941 1607 -2873 -29886 -3845 1521 -18315 -23235 -28083 -3792 457 9586 7066 -14013 6336 2303 -26442 28773 32623 17363 4671 -15759 -2924 -9392 -32328 -7650 15446 -17680 3634 -30078 1640 24278 -22337 25208 30594 -15115 -16469 -4585 -28699 27728 10434 -13739 -18498 17422 12718 -6984 -12009 22706 20620 -6057 -7024 -11239 27544 23298 25401 4693 -24066 -26098 20276 15290 -17420 24219 25001 -25417 20749 -4835 20020 30487 -20565 -13491 2723 -5033 27562 18893 25420 -28241 12607 -12263 -4254 -549 -17191 859 14204 -14142 -22565 -4364 -6633 4868 -9157 -23469 -30608 -8353 8270 -14672 -5504 20795 24632 -21645 -6561 -13259 -21911 -9781 13527 -3921 27240 -9848 20011 28549 29817 1168 24929 -16527 19934 -15906 26093 27773 21725 15150 16035 21042 -20309 -2445 5104 31343 17261 -9225 -1819 -14082 31212 18247 27932 29466 -14118 -9809 -1999 -24447 -19335 14559 -5316 26832 1885 154 -20212 -26930 -30384 7751 -19675 -26326 23092 6438 -21300 6830 -32385 -3880 21227 29839 -22137
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    ActuatorId : 1703102024    1
    Should Contain X Times    ${output}    FunctionCode : 27379    1
    Should Contain X Times    ${output}    Data : 16340    1
    Should Contain X Times    ${output}    DataLength :     1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    ActuatorId = 1703102024    1
    Should Contain X Times    ${output}    FunctionCode = 27379    1
    Should Contain X Times    ${output}    Data(252) = [16340, -159, -16969, -7917, -27784, -30066, -13092, -7815, -4084, -13942, 26952, -32671, 17290, 23651, 11643, 7493, -13775, -13128, 3968, 32402, -20177, 2351, -24205, -12847, 27271, -23875, 16332, 7511, 12481, -2847, -13248, -13357, -1126, -19731, 20241, 27330, 25526, -29971, -4559, 13864, 12403, 12503, -30322, -7787, 30308, 16766, 19544, 23713, -10810, 5707, 27231, 16116, 11562, -783, 14410, 28993, 1758, -22274, -11332, -18167, 5293, -26521, 4427, -10462, 11509, -14370, -11847, 7314, -22289, -16604, -18519, 26672, 13859, -26471, 532, -7429, 5587, 23827, -11432, -30406, -12603, -8922, -9600, 8438, -9231, -7974, 29534, 17055, 9180, -18705, 19392, -28458, -26167, -22052, 15314, 1611, 941, 1607, -2873, -29886, -3845, 1521, -18315, -23235, -28083, -3792, 457, 9586, 7066, -14013, 6336, 2303, -26442, 28773, 32623, 17363, 4671, -15759, -2924, -9392, -32328, -7650, 15446, -17680, 3634, -30078, 1640, 24278, -22337, 25208, 30594, -15115, -16469, -4585, -28699, 27728, 10434, -13739, -18498, 17422, 12718, -6984, -12009, 22706, 20620, -6057, -7024, -11239, 27544, 23298, 25401, 4693, -24066, -26098, 20276, 15290, -17420, 24219, 25001, -25417, 20749, -4835, 20020, 30487, -20565, -13491, 2723, -5033, 27562, 18893, 25420, -28241, 12607, -12263, -4254, -549, -17191, 859, 14204, -14142, -22565, -4364, -6633, 4868, -9157, -23469, -30608, -8353, 8270, -14672, -5504, 20795, 24632, -21645, -6561, -13259, -21911, -9781, 13527, -3921, 27240, -9848, 20011, 28549, 29817, 1168, 24929, -16527, 19934, -15906, 26093, 27773, 21725, 15150, 16035, 21042, -20309, -2445, 5104, 31343, 17261, -9225, -1819, -14082, 31212, 18247, 27932, 29466, -14118, -9809, -1999, -24447, -19335, 14559, -5316, 26832, 1885, 154, -20212, -26930, -30384, 7751, -19675, -26326, 23092, 6438, -21300, 6830, -32385, -3880, 21227, 29839]    1
    Should Contain X Times    ${output}    DataLength =     1
    Should Contain X Times    ${output}    === [ackCommand_ModbusTransmit] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
