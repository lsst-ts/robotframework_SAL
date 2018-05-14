*** Settings ***
Documentation    AtCamera_WREB communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Publisher    AND    Create Session    Subscriber
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atcamera
${component}    WREB
${timeout}    30s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_sub

Start Subscriber
    [Tags]    functional
    Switch Connection    Subscriber
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}_${component}/cpp/standalone
    Comment    Start Subscriber.
    ${input}=    Write    ./sacpp_${subSystem}_sub
    ${output}=    Read Until    [Subscriber] Ready
    Log    ${output}
    Should Contain    ${output}    [Subscriber] Ready

Start Publisher
    [Tags]    functional
    Switch Connection    Publisher
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}_${component}/cpp/standalone
    Comment    Start Publisher.
    ${input}=    Write    ./sacpp_${subSystem}_pub
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    [putSample] ${subSystem}::${component} writing a message containing :    9
    Should Contain X Times    ${output}    revCode \ : LSST TEST REVCODE    9

Read Subscriber
    [Tags]    functional
    Switch Connection    Subscriber
    ${output}=    Read    delay=1s
    Log    ${output}
    @{list}=    Split To Lines    ${output}    start=1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}CKPSH_V : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}CKPOV : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}OGOV : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Temp1 : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Temp2 : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Temp3 : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Temp4 : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Temp5 : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Temp6 : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Atemp0U : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Atemp0L : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}CCDtemp0 : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}RTDtemp : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}DigPS_V : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}DigPS_I : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}AnaPS_V : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}AnaPS_I : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}ClkHPS_V : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}ClkHPS_I : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}ODPS_V : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}ODPS_I : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}HtrPS_V : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}HtrPS_I : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}Power : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}SCKU_V : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}SCKL_V : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}RGU_V : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}RGL_V : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}CKS0V : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}RG0V : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}OD0V : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}RD0V : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}GD0V : 1    9
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}OD0I : 1    9
