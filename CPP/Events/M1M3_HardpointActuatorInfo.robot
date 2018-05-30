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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 3.5173 24875 4761 -22936 -2305 -8787 1191 359785347 -1202264623 752488101 1031009063 515853241 -773119864 -2957 -25978 -18728 -25684 1281 -28389 10728 -11996 -6978 11085 18115 -28605 0.621322 0.154255 0.330788 0.609052 0.956569 0.238081 0.536864 0.539823 0.85326 0.626571 0.345823 0.230837 0.746486 0.987575 0.431651 0.517402 0.953966 0.272708 test test test test test test -11527 -23637 5578 -6950 26130 -5735 2850 -11036 28237 27077 -19524 28226 17506 -8468 27569 28465 -11861 25607 12701 -26546 19153 -13717 -31513 12638 25244 26439 22026 31017 3335 9403 17761 18093 -11899 8033 -26581 -2049 -4094 -1636 164 11503 -14901 32318 0.383695 0.2265 0.468868 0.950694 0.57431 0.623693 0.959432 0.152173 0.785993 0.55104 0.22976 0.296808 0.133932 0.154386 0.934199 0.222832 0.937 0.169619 0.24823 0.297109 0.490689 0.910037 0.296069 0.377589 0.018879 0.150339 0.450664 0.081628 0.492013 0.513153 0.597434 0.767496 0.555726 0.392963 0.054442 0.373402 1035064803
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointActuatorInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event HardpointActuatorInfo generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1035064803
    Log    ${output}
    Should Contain X Times    ${output}    === Event HardpointActuatorInfo received =     1
    Should Contain    ${output}    Timestamp : 3.5173
    Should Contain    ${output}    ReferenceId : 24875
    Should Contain    ${output}    ReferencePosition : 4761
    Should Contain    ${output}    ModbusSubnet : -22936
    Should Contain    ${output}    ModbusAddress : -2305
    Should Contain    ${output}    XPosition : -8787
    Should Contain    ${output}    YPosition : 1191
    Should Contain    ${output}    ZPosition : 359785347
    Should Contain    ${output}    ILCUniqueId : -1202264623
    Should Contain    ${output}    ILCApplicationType : 752488101
    Should Contain    ${output}    NetworkNodeType : 1031009063
    Should Contain    ${output}    ILCSelectedOptions : 515853241
    Should Contain    ${output}    NetworkNodeOptions : -773119864
    Should Contain    ${output}    MajorRevision : -2957
    Should Contain    ${output}    MinorRevision : -25978
    Should Contain    ${output}    ADCScanRate : -18728
    Should Contain    ${output}    MainLoadCellCoefficient : -25684
    Should Contain    ${output}    MainLoadCellOffset : 1281
    Should Contain    ${output}    MainLoadCellSensitivity : -28389
    Should Contain    ${output}    BackupLoadCellCoefficient : 10728
    Should Contain    ${output}    BackupLoadCellOffset : -11996
    Should Contain    ${output}    BackupLoadCellSensitivity : -6978
    Should Contain    ${output}    priority : 11085
