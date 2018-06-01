*** Settings ***
Documentation    M1M3_ApplyAberrationForces communications tests.
Force Tags    cpp    TSS-2617
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 0.822372 0.440991 0.416827 0.033829 0.790306 0.986264 0.236522 0.709721 0.632166 0.243018 0.874081 0.58 0.72772 0.619902 0.040897 0.520383 0.244551 0.913749 0.099789 0.984866 0.188163 0.754925 0.606759 0.493019 0.680807 0.225083 0.274281 0.046112 0.849308 0.40804 0.883911 0.840265 0.639953 0.383332 0.585783 0.277988 0.006472 0.831126 0.162316 0.671297 0.440813 0.365911 0.465648 0.575865 0.67248 0.51621 0.601042 0.828164 0.65083 0.915923 0.6094 0.488488 0.79489 0.443698 0.135327 0.587989 0.109799 0.849577 0.320587 0.381262 0.210315 0.404588 0.194115 0.362421 0.942162 0.277483 0.884388 0.494771 0.717271 0.206337 0.444318 0.900221 0.263332 0.455097 0.334417 0.948157 0.071648 0.321079 0.783139 0.433502 0.735725 0.575303 0.909277 0.480669 0.220209 0.753686 0.870061 0.49914 0.094882 0.229362 0.571599 0.472163 0.324015 0.645178 0.872851 0.352824 0.050461 0.806131 0.322966 0.56629 0.396048 0.576245 0.223048 0.825364 0.444034 0.721034 0.911926 0.332283 0.711784 0.770206 0.996533 0.731066 0.921992 0.972305 0.606221 0.24102 0.830953 0.474397 0.586311 0.528578 0.763553 0.941617 0.428517 0.419263 0.621074 0.193976 0.121713 0.705137 0.902738 0.791778 0.139147 0.273645 0.517313 0.483971 0.380503 0.467978 0.151201 0.198261 0.573322 0.587528 0.541083 0.788036 0.402956 0.834931 0.727763 0.85894 0.013497 0.061088 0.765637 0.21994 0.303401 0.255651 0.214633 0.335036 0.905369 0.884504
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 0.822372 0.440991 0.416827 0.033829 0.790306 0.986264 0.236522 0.709721 0.632166 0.243018 0.874081 0.58 0.72772 0.619902 0.040897 0.520383 0.244551 0.913749 0.099789 0.984866 0.188163 0.754925 0.606759 0.493019 0.680807 0.225083 0.274281 0.046112 0.849308 0.40804 0.883911 0.840265 0.639953 0.383332 0.585783 0.277988 0.006472 0.831126 0.162316 0.671297 0.440813 0.365911 0.465648 0.575865 0.67248 0.51621 0.601042 0.828164 0.65083 0.915923 0.6094 0.488488 0.79489 0.443698 0.135327 0.587989 0.109799 0.849577 0.320587 0.381262 0.210315 0.404588 0.194115 0.362421 0.942162 0.277483 0.884388 0.494771 0.717271 0.206337 0.444318 0.900221 0.263332 0.455097 0.334417 0.948157 0.071648 0.321079 0.783139 0.433502 0.735725 0.575303 0.909277 0.480669 0.220209 0.753686 0.870061 0.49914 0.094882 0.229362 0.571599 0.472163 0.324015 0.645178 0.872851 0.352824 0.050461 0.806131 0.322966 0.56629 0.396048 0.576245 0.223048 0.825364 0.444034 0.721034 0.911926 0.332283 0.711784 0.770206 0.996533 0.731066 0.921992 0.972305 0.606221 0.24102 0.830953 0.474397 0.586311 0.528578 0.763553 0.941617 0.428517 0.419263 0.621074 0.193976 0.121713 0.705137 0.902738 0.791778 0.139147 0.273645 0.517313 0.483971 0.380503 0.467978 0.151201 0.198261 0.573322 0.587528 0.541083 0.788036 0.402956 0.834931 0.727763 0.85894 0.013497 0.061088 0.765637 0.21994 0.303401 0.255651 0.214633 0.335036 0.905369 0.884504
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    ZForces : 0.822372    1
    Should Contain    ${output}    === command ApplyAberrationForces issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command ApplyAberrationForces received =
    Should Contain    ${output}    device : 
    Should Contain    ${output}    property : 
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    ZForces : 0.822372    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyAberrationForces] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
