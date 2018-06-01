*** Settings ***
Documentation    M1M3_HardpointActuatorInfo communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    HardpointActuatorInfo
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_log

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage :  input parameters...

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Logger.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_log
    ${output}=    Read Until    logger ready =
    Log    ${output}
    Should Contain    ${output}    Event ${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 71.4231 -10220 -12063 -26853 -19582 -31105 -10742 -1719876737 1552144951 -36517224 2039674694 -1370794498 1655060817 29061 -5182 -12094 -8544 23622 19172 31332 8157 20925 -16901 -12301 -6312 0.465671 0.223025 0.202107 0.242631 0.163816 0.527989 0.985254 0.577674 0.011536 0.772353 0.411376 0.617216 0.929622 0.668349 0.679388 0.600389 0.657486 0.430078 test test test test test test 30638 6429 -5197 11035 -28697 -7997 20623 -4003 -14347 -4454 23948 28147 16842 -1201 -11095 -6104 -2096 -6957 -11980 4237 6391 15820 30341 30022 6445 29328 -18373 -3459 -961 -12446 -19989 -20335 14698 23509 -19407 13509 -27143 -27651 -21769 -30794 -24722 -21618 0.876536 0.576785 0.577449 0.710239 0.890836 0.380505 0.135401 0.38438 0.441365 0.316312 0.071728 0.135604 0.94057 0.328016 0.292758 0.613567 0.260654 0.401351 0.501056 0.316771 0.43285 0.010873 0.011187 0.303722 0.001797 0.375586 0.183323 0.347414 0.364397 0.049085 0.087937 0.144209 0.256969 0.13229 0.723574 0.800235 -1787045523
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointActuatorInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event HardpointActuatorInfo generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1787045523
    Log    ${output}
    Should Contain X Times    ${output}    === Event HardpointActuatorInfo received =     1
    Should Contain    ${output}    Timestamp : 71.4231
    Should Contain    ${output}    ReferenceId : -10220
    Should Contain    ${output}    ReferencePosition : -12063
    Should Contain    ${output}    ModbusSubnet : -26853
    Should Contain    ${output}    ModbusAddress : -19582
    Should Contain    ${output}    XPosition : -31105
    Should Contain    ${output}    YPosition : -10742
    Should Contain    ${output}    ZPosition : -1719876737
    Should Contain    ${output}    ILCUniqueId : 1552144951
    Should Contain    ${output}    ILCApplicationType : -36517224
    Should Contain    ${output}    NetworkNodeType : 2039674694
    Should Contain    ${output}    ILCSelectedOptions : -1370794498
    Should Contain    ${output}    NetworkNodeOptions : 1655060817
    Should Contain    ${output}    MajorRevision : 29061
    Should Contain    ${output}    MinorRevision : -5182
    Should Contain    ${output}    ADCScanRate : -12094
    Should Contain    ${output}    MainLoadCellCoefficient : -8544
    Should Contain    ${output}    MainLoadCellOffset : 23622
    Should Contain    ${output}    MainLoadCellSensitivity : 19172
    Should Contain    ${output}    BackupLoadCellCoefficient : 31332
    Should Contain    ${output}    BackupLoadCellOffset : 8157
    Should Contain    ${output}    BackupLoadCellSensitivity : 20925
    Should Contain    ${output}    priority : -16901
