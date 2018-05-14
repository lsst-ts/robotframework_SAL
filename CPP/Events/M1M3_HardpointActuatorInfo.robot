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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 87.9891 -2897 -31784 32146 443 8811 -6683 -35305581 785400404 -547352036 2039835245 -1690045929 -1433010624 31210 4629 -9429 -8957 -28807 20353 30464 9530 25714 -24062 15186 12319 0.206057519656 0.329180874354 0.702883026898 0.0583090940594 0.238699317824 0.23666168239 0.00397358564615 0.726806664617 0.127216642165 0.812583419897 0.545972593892 0.440578370809 0.795359789204 0.2976106044 0.710019505798 0.293657780246 0.746507397254 0.425194837234 test test test test test test -10064 -2178 24088 10879 -17747 1409 -29689 17356 -9516 -8973 10460 -22069 19194 -23051 6257 15151 -30919 -28552 9965 4097 26945 -9818 26851 12215 -24258 28405 2194 13219 -24704 -1459 -16158 -14731 -3457 -1466 15831 -28176 -28680 -25143 2667 16850 -24582 -5950 0.676978162683 0.755646101947 0.646971119543 0.102819188495 0.916874097573 0.559010581488 0.918247143221 0.715497554665 0.635442470165 0.498022636134 0.759692770225 0.557414549321 0.334564061981 0.770468447949 0.348264864405 0.00163643632863 0.582158127355 0.0629409037057 0.873390503625 0.589859580839 0.190693880812 0.631820023271 0.992722772986 0.927413587293 0.699149725453 0.376894409272 0.213859636909 0.330081899967 0.95700606289 0.651508868076 0.128153921547 0.997407610535 0.976203274464 0.755237460577 0.968623263122 0.0282166538452 1207351335
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointActuatorInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event HardpointActuatorInfo generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1207351335
    Log    ${output}
    Should Contain X Times    ${output}    === Event HardpointActuatorInfo received =     1
    Should Contain    ${output}    Timestamp : 87.9891
    Should Contain    ${output}    ReferenceId : -2897
    Should Contain    ${output}    ReferencePosition : -31784
    Should Contain    ${output}    ModbusSubnet : 32146
    Should Contain    ${output}    ModbusAddress : 443
    Should Contain    ${output}    XPosition : 8811
    Should Contain    ${output}    YPosition : -6683
    Should Contain    ${output}    ZPosition : -35305581
    Should Contain    ${output}    ILCUniqueId : 785400404
    Should Contain    ${output}    ILCApplicationType : -547352036
    Should Contain    ${output}    NetworkNodeType : 2039835245
    Should Contain    ${output}    ILCSelectedOptions : -1690045929
    Should Contain    ${output}    NetworkNodeOptions : -1433010624
    Should Contain    ${output}    MajorRevision : 31210
    Should Contain    ${output}    MinorRevision : 4629
    Should Contain    ${output}    ADCScanRate : -9429
    Should Contain    ${output}    MainLoadCellCoefficient : -8957
    Should Contain    ${output}    MainLoadCellOffset : -28807
    Should Contain    ${output}    MainLoadCellSensitivity : 20353
    Should Contain    ${output}    BackupLoadCellCoefficient : 30464
    Should Contain    ${output}    BackupLoadCellOffset : 9530
    Should Contain    ${output}    BackupLoadCellSensitivity : 25714
    Should Contain    ${output}    priority : -24062
