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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -1857922068 957 -11437 16097 -25388 -9714 -32615 -12518 -12392 -19318 10229 -17476 28483 2172 -7323 30279 6359 448 29643 17351 -15643 12104 14595 11328 -1594 26691 658 4208 -5714 -32764 2950 11153 7771 -4047 31011 -20624 318 1678 -9725 -17472 18850 -7209 20666 -19287 -10627 14143 -3470 1010 29492 2729 28184 15621 27911 10791 -23670 -13682 -3419 12169 3950 -6889 -4371 -23736 -11749 -11953 8384 -18611 25029 21663 14918 30353 -3050 -28564 -23282 7322 -6504 -17447 18863 -8688 -6362 20061 15991 -7101 -16913 -20209 29485 23238 21849 19250 -109 -3886 6740 -14069 -2883 18842 -14603 11429 -18487 -6280 -22930 7385 -8673 -29503 15053 -28422 -2633 22440 -27005 11380 -27704 -23101 -13993 -16518 15318 -2940 -11256 -28411 9714 -4153 17207 4295 -3253 -17488 -19746 -11561 -23046 -11482 28709 6704 -29474 28692 2448 4293 -14133 -9659 -2465 -22918 -15053 27899 -28423 8948 11134 26106 16611 603 -7010 11371 -20935 -29839 -32347 7359 13450 18502 28430 9482 26222 14143 9143 22012 4997 25695 -7799 -25780 -9091 -31423 -687 -32738 -26649 -3737 -22473 27351 12492 -24245 -11095 -9590 153 4666 -19436 -7041 -30314 -6688 14597 8797 -3088 -14683 -1810 -1814 2672 -30844 -12260 18521 26019 -16744 -20222 -6925 -1791 -5970 11370 15127 28479 29608 17720 8436 -29904 18087 -23986 1520 22889 -21264 5059 -29137 -4954 31726 32629 -15884 -21471 29202 -2663 27424 6690 6460 -17398 5844 -20015 -11778 -25790 -32139 28091 -2885 22096 -1510 23297 5045 -21213 -25048 24237 -16699 -15252 20226 -13945 -17250 -14647 28288 -20219 -21338 26592 25979 21408 -23056 256 -209 29327 -23411 15169 -5674 16997
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -1857922068 957 -11437 16097 -25388 -9714 -32615 -12518 -12392 -19318 10229 -17476 28483 2172 -7323 30279 6359 448 29643 17351 -15643 12104 14595 11328 -1594 26691 658 4208 -5714 -32764 2950 11153 7771 -4047 31011 -20624 318 1678 -9725 -17472 18850 -7209 20666 -19287 -10627 14143 -3470 1010 29492 2729 28184 15621 27911 10791 -23670 -13682 -3419 12169 3950 -6889 -4371 -23736 -11749 -11953 8384 -18611 25029 21663 14918 30353 -3050 -28564 -23282 7322 -6504 -17447 18863 -8688 -6362 20061 15991 -7101 -16913 -20209 29485 23238 21849 19250 -109 -3886 6740 -14069 -2883 18842 -14603 11429 -18487 -6280 -22930 7385 -8673 -29503 15053 -28422 -2633 22440 -27005 11380 -27704 -23101 -13993 -16518 15318 -2940 -11256 -28411 9714 -4153 17207 4295 -3253 -17488 -19746 -11561 -23046 -11482 28709 6704 -29474 28692 2448 4293 -14133 -9659 -2465 -22918 -15053 27899 -28423 8948 11134 26106 16611 603 -7010 11371 -20935 -29839 -32347 7359 13450 18502 28430 9482 26222 14143 9143 22012 4997 25695 -7799 -25780 -9091 -31423 -687 -32738 -26649 -3737 -22473 27351 12492 -24245 -11095 -9590 153 4666 -19436 -7041 -30314 -6688 14597 8797 -3088 -14683 -1810 -1814 2672 -30844 -12260 18521 26019 -16744 -20222 -6925 -1791 -5970 11370 15127 28479 29608 17720 8436 -29904 18087 -23986 1520 22889 -21264 5059 -29137 -4954 31726 32629 -15884 -21471 29202 -2663 27424 6690 6460 -17398 5844 -20015 -11778 -25790 -32139 28091 -2885 22096 -1510 23297 5045 -21213 -25048 24237 -16699 -15252 20226 -13945 -17250 -14647 28288 -20219 -21338 26592 25979 21408 -23056 256 -209 29327 -23411 15169 -5674 16997
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    ActuatorId : -1857922068    1
    Should Contain X Times    ${output}    FunctionCode : 957    1
    Should Contain X Times    ${output}    Data : -11437    1
    Should Contain X Times    ${output}    DataLength :     1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    ActuatorId = -1857922068    1
    Should Contain X Times    ${output}    FunctionCode = 957    1
    Should Contain X Times    ${output}    Data(252) = [-11437, 16097, -25388, -9714, -32615, -12518, -12392, -19318, 10229, -17476, 28483, 2172, -7323, 30279, 6359, 448, 29643, 17351, -15643, 12104, 14595, 11328, -1594, 26691, 658, 4208, -5714, -32764, 2950, 11153, 7771, -4047, 31011, -20624, 318, 1678, -9725, -17472, 18850, -7209, 20666, -19287, -10627, 14143, -3470, 1010, 29492, 2729, 28184, 15621, 27911, 10791, -23670, -13682, -3419, 12169, 3950, -6889, -4371, -23736, -11749, -11953, 8384, -18611, 25029, 21663, 14918, 30353, -3050, -28564, -23282, 7322, -6504, -17447, 18863, -8688, -6362, 20061, 15991, -7101, -16913, -20209, 29485, 23238, 21849, 19250, -109, -3886, 6740, -14069, -2883, 18842, -14603, 11429, -18487, -6280, -22930, 7385, -8673, -29503, 15053, -28422, -2633, 22440, -27005, 11380, -27704, -23101, -13993, -16518, 15318, -2940, -11256, -28411, 9714, -4153, 17207, 4295, -3253, -17488, -19746, -11561, -23046, -11482, 28709, 6704, -29474, 28692, 2448, 4293, -14133, -9659, -2465, -22918, -15053, 27899, -28423, 8948, 11134, 26106, 16611, 603, -7010, 11371, -20935, -29839, -32347, 7359, 13450, 18502, 28430, 9482, 26222, 14143, 9143, 22012, 4997, 25695, -7799, -25780, -9091, -31423, -687, -32738, -26649, -3737, -22473, 27351, 12492, -24245, -11095, -9590, 153, 4666, -19436, -7041, -30314, -6688, 14597, 8797, -3088, -14683, -1810, -1814, 2672, -30844, -12260, 18521, 26019, -16744, -20222, -6925, -1791, -5970, 11370, 15127, 28479, 29608, 17720, 8436, -29904, 18087, -23986, 1520, 22889, -21264, 5059, -29137, -4954, 31726, 32629, -15884, -21471, 29202, -2663, 27424, 6690, 6460, -17398, 5844, -20015, -11778, -25790, -32139, 28091, -2885, 22096, -1510, 23297, 5045, -21213, -25048, 24237, -16699, -15252, 20226, -13945, -17250, -14647, 28288, -20219, -21338, 26592, 25979, 21408, -23056, 256, -209, 29327, -23411, 15169, -5674]    1
    Should Contain X Times    ${output}    DataLength =     1
    Should Contain X Times    ${output}    === [ackCommand_ModbusTransmit] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
