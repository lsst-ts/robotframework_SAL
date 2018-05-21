*** Settings ***
Documentation    M1M3_HardpointActuatorInfo sender/logger tests.
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 11.6668 26848 -28090 462 13617 -5656 22904 988578637 -1928326612 -1127899899 -1988132697 -1975669661 -1192523822 31081 5356 -23375 -2055 -17636 8369 -5270 -17753 5457 -6584 1455 9190 0.509462737295 0.374960466941 0.478407406981 0.268917174126 0.686638226923 0.212682275984 0.931997844951 0.404217590508 0.304393846943 0.621062254419 0.945692822324 0.511897241165 0.891802329119 0.54814290554 0.991797822527 0.118343308368 0.0834397036966 0.834650153944 test test test test test test -20202 4073 24308 -28534 -7265 -24158 31933 -25674 25300 24265 -31108 26238 1377 27593 12704 -18094 19557 11169 779 17916 -31751 20521 -3651 -22817 -12496 32000 -11889 -18134 -26451 -8834 -31043 27774 -1729 7319 -29989 -24740 -1828 16903 4591 28141 2233 3683 0.0109263235519 0.605788960857 0.695211385185 0.210942561785 0.501655699564 0.0311738372232 0.46462685301 0.769408991306 0.895525849739 0.600362025573 0.730326732119 0.684161005618 0.852190322331 0.856192083455 0.526951478802 0.723374768042 0.107067990465 0.278249239288 0.582532843265 0.537936202618 0.381652684541 0.119057191806 0.712862591075 0.248564705397 0.220030685695 0.576027730456 0.0172879600795 0.652673031343 0.469534475932 0.553301946551 0.641417260476 0.983975596381 0.456893456165 0.841994885504 0.371918753206 0.582046006733 328339773
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointActuatorInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event HardpointActuatorInfo generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 328339773
    Log    ${output}
    Should Contain X Times    ${output}    === Event HardpointActuatorInfo received =     1
    Should Contain    ${output}    Timestamp : 11.6668
    Should Contain    ${output}    ReferenceId : 26848
    Should Contain    ${output}    ReferencePosition : -28090
    Should Contain    ${output}    ModbusSubnet : 462
    Should Contain    ${output}    ModbusAddress : 13617
    Should Contain    ${output}    XPosition : -5656
    Should Contain    ${output}    YPosition : 22904
    Should Contain    ${output}    ZPosition : 988578637
    Should Contain    ${output}    ILCUniqueId : -1928326612
    Should Contain    ${output}    ILCApplicationType : -1127899899
    Should Contain    ${output}    NetworkNodeType : -1988132697
    Should Contain    ${output}    ILCSelectedOptions : -1975669661
    Should Contain    ${output}    NetworkNodeOptions : -1192523822
    Should Contain    ${output}    MajorRevision : 31081
    Should Contain    ${output}    MinorRevision : 5356
    Should Contain    ${output}    ADCScanRate : -23375
    Should Contain    ${output}    MainLoadCellCoefficient : -2055
    Should Contain    ${output}    MainLoadCellOffset : -17636
    Should Contain    ${output}    MainLoadCellSensitivity : 8369
    Should Contain    ${output}    BackupLoadCellCoefficient : -5270
    Should Contain    ${output}    BackupLoadCellOffset : -17753
    Should Contain    ${output}    BackupLoadCellSensitivity : 5457
    Should Contain    ${output}    priority : -6584
