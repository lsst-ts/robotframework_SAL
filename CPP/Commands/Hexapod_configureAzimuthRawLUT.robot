*** Settings ***
Documentation    Hexapod_configureAzimuthRawLUT communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    hexapod
${component}    configureAzimuthRawLUT
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -29550 -16692 20786 26361 4501 -16597 1406 30755 1447 21793 20677 15430 -3036 8950 -12876 -30310 15434 17975 -23917 -32381 -17769 12843 -9901 -6754 -2616 -19848 21383 -8798 31009 -1795 -18601 -25053 -30050 -22911 7127 32451 -28565 0.029663 0.252393 0.047601 0.631625 0.641789 0.874374 0.2488 0.434465 0.546294 0.305274 0.273879 0.147306 0.6907 0.094934 0.30948 0.792462 0.310738 0.669618 0.040288 0.152852 0.317143 0.023906 0.78983 0.833068 0.807215 0.499919 0.762779 0.940983 0.306149 0.966835 0.851685 0.355456 0.317817 0.836385 0.933611 0.505773 0.174296 0.839323 0.948365 0.632748 0.278356 0.12022 0.432872 0.45293 0.950158 0.646798 0.518801 0.345116 0.207404 0.862915 0.973584 0.593825 0.255316 0.600479 0.501674 0.657995 0.364415 0.991264 0.900033 0.559148 0.014263 0.005447 0.945967 0.876232 0.845123 0.47901 0.393865 0.743108 0.814144 0.164626 0.267389 0.905933 0.072301 0.086735 0.967227 0.436812 0.292679 0.817827 0.00876 0.626069 0.025419 0.635804 0.599152 0.296671 0.91089 0.542224 0.865389 0.115681 0.015428 0.594703 0.276884 0.406399 0.209554 0.674351 0.109616 0.260344 0.486552 0.569436 0.052923 0.315905 0.49136 0.16504 0.096951 0.652869 0.900824 0.685036 0.549621 0.383328 0.211523 0.324825 0.70748 0.489505 0.534129 0.258682 0.576714 0.706701 0.995884 0.811624 0.083486 0.565813 0.695433 0.096548 0.414626 0.068452 0.956907 0.457427 0.093638 0.964152 0.488862 0.84938 0.598913 0.331734 0.639179 0.183096 0.511669 0.28496 0.504707 0.908972 0.206229 0.11114 0.881879 0.410314 0.615685 0.929354 0.226654 0.295462 0.502206 0.137162 0.89099 0.317576 0.370442 0.660168 0.391723 0.107401 0.553298 0.149465 0.910313 0.082309 0.376377 0.671481 0.866179 0.962806 0.581733 0.173616 0.218691 0.298962 0.606605 0.652094 0.359685 0.58003 0.708486 0.382521 0.712259 0.437693 0.127731 0.111474 0.194855 0.775723 0.97923 0.735281 0.069791 0.958442 0.33963 0.62739 0.291111 0.736548 0.333973 0.742529 0.283753 0.614509 0.932564 0.65772 0.013043 0.458402 0.788138 0.51819 0.117945 0.884663 0.942039 0.985179 0.802799 0.854047 0.109492 0.155628 0.343217 0.133618 0.29453 0.237182 0.988678 0.184521 0.722008 0.722149 0.726043 0.497085 0.684928 0.583422 0.602955 0.473412 0.282495 0.136988 0.936157 0.926726
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -29550 -16692 20786 26361 4501 -16597 1406 30755 1447 21793 20677 15430 -3036 8950 -12876 -30310 15434 17975 -23917 -32381 -17769 12843 -9901 -6754 -2616 -19848 21383 -8798 31009 -1795 -18601 -25053 -30050 -22911 7127 32451 -28565 0.029663 0.252393 0.047601 0.631625 0.641789 0.874374 0.2488 0.434465 0.546294 0.305274 0.273879 0.147306 0.6907 0.094934 0.30948 0.792462 0.310738 0.669618 0.040288 0.152852 0.317143 0.023906 0.78983 0.833068 0.807215 0.499919 0.762779 0.940983 0.306149 0.966835 0.851685 0.355456 0.317817 0.836385 0.933611 0.505773 0.174296 0.839323 0.948365 0.632748 0.278356 0.12022 0.432872 0.45293 0.950158 0.646798 0.518801 0.345116 0.207404 0.862915 0.973584 0.593825 0.255316 0.600479 0.501674 0.657995 0.364415 0.991264 0.900033 0.559148 0.014263 0.005447 0.945967 0.876232 0.845123 0.47901 0.393865 0.743108 0.814144 0.164626 0.267389 0.905933 0.072301 0.086735 0.967227 0.436812 0.292679 0.817827 0.00876 0.626069 0.025419 0.635804 0.599152 0.296671 0.91089 0.542224 0.865389 0.115681 0.015428 0.594703 0.276884 0.406399 0.209554 0.674351 0.109616 0.260344 0.486552 0.569436 0.052923 0.315905 0.49136 0.16504 0.096951 0.652869 0.900824 0.685036 0.549621 0.383328 0.211523 0.324825 0.70748 0.489505 0.534129 0.258682 0.576714 0.706701 0.995884 0.811624 0.083486 0.565813 0.695433 0.096548 0.414626 0.068452 0.956907 0.457427 0.093638 0.964152 0.488862 0.84938 0.598913 0.331734 0.639179 0.183096 0.511669 0.28496 0.504707 0.908972 0.206229 0.11114 0.881879 0.410314 0.615685 0.929354 0.226654 0.295462 0.502206 0.137162 0.89099 0.317576 0.370442 0.660168 0.391723 0.107401 0.553298 0.149465 0.910313 0.082309 0.376377 0.671481 0.866179 0.962806 0.581733 0.173616 0.218691 0.298962 0.606605 0.652094 0.359685 0.58003 0.708486 0.382521 0.712259 0.437693 0.127731 0.111474 0.194855 0.775723 0.97923 0.735281 0.069791 0.958442 0.33963 0.62739 0.291111 0.736548 0.333973 0.742529 0.283753 0.614509 0.932564 0.65772 0.013043 0.458402 0.788138 0.51819 0.117945 0.884663 0.942039 0.985179 0.802799 0.854047 0.109492 0.155628 0.343217 0.133618 0.29453 0.237182 0.988678 0.184521 0.722008 0.722149 0.726043 0.497085 0.684928 0.583422 0.602955 0.473412 0.282495 0.136988 0.936157 0.926726
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    azIndex : -29550    1
    Should Contain X Times    ${output}    fz1 : 0.029663    1
    Should Contain X Times    ${output}    fz2 : 0.839323    1
    Should Contain X Times    ${output}    fz3 : 0.967227    1
    Should Contain X Times    ${output}    fz4 : 0.489505    1
    Should Contain X Times    ${output}    fz5 : 0.89099    1
    Should Contain X Times    ${output}    fz6 : 0.736548    1
    Should Contain    ${output}    === command configureAzimuthRawLUT issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command configureAzimuthRawLUT received =
    Should Contain    ${output}    device : 
    Should Contain    ${output}    property : 
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    azIndex : -29550    1
    Should Contain X Times    ${output}    fz1 : 0.029663    1
    Should Contain X Times    ${output}    fz2 : 0.839323    1
    Should Contain X Times    ${output}    fz3 : 0.967227    1
    Should Contain X Times    ${output}    fz4 : 0.489505    1
    Should Contain X Times    ${output}    fz5 : 0.89099    1
    Should Contain X Times    ${output}    fz6 : 0.736548    1
    Should Contain X Times    ${output}    === [ackCommand_configureAzimuthRawLUT] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
