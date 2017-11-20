*** Settings ***
Documentation    M1M3_HardpointActuatorInfo sender/logger tests.
Force Tags    cpp    
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 48.951 -761049406 1633805514 -1613178788 1067221306 -1292806400 1979677352 -69598984 1469781529 -737778627 -1354427906 -536105187 900069113 0.456086990368 0.564663990402 0.557627358967 0.535886871866 0.435757994397 0.405846881362 0.924684835079 0.602427476727 0.558886926296 0.536624333642 0.429711289619 0.703453544097 0.238199068914 0.020981691637 0.501683317968 0.976306971701 0.156537454254 0.596225608798 test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test 0.306120114453 0.956030144658 0.580914093027 0.286396180828 0.945773537477 0.672877075259 0.370170713763 0.701069488503 0.607367439252 0.590311938955 0.768124421888 0.155599072911 0.905461451284 0.755751776966 0.616135725694 0.809186564312 0.14344283101 0.0224770477476 0.208811377432 0.157415886041 0.0300839578499 0.604868703559 0.136926436043 0.885605362611 0.873434220947 0.00760084008476 0.870859509158 0.833131295 0.969370740167 0.323922495865 0.848969166767 0.181719030048 0.436743829982 0.899103715282 0.859212460738 0.843143007707 0.819847940053 0.263359134149 0.902704896754 0.265893295145 0.900366136021 0.119689291143 0.313930570522 0.532299546378 0.610585165445 0.141410854392 0.702194397795 0.991199738176 0.969053033077 0.679830830034 0.997684442605 0.976431798298 0.770847445876 0.372248773904 0.815096866303 0.592645312912 0.560819287553 0.501552390017 0.910513493027 0.477596707939 0.524040270968 0.361523652777 0.137657890579 0.952708716025 0.219630321742 0.0794175261889 0.777076259701 0.229568014407 0.0362731778369 0.118815679477 0.142419469444 0.156817054957 1 0 1 1 0 0 1 0 0 1 1 1 1 1 1 0 1 1 1 0 1 1 0 0 1 0 1 1 1 1 0 1 1 1 1 1 1 1 0 0 1 1 0 0 1 1 0 0 1 0 0 0 0 1 65960931
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointActuatorInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event HardpointActuatorInfo generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 65960931
    Log    ${output}
    Should Contain X Times    ${output}    === Event HardpointActuatorInfo received =     1
    Should Contain    ${output}    Timestamp : 48.951
    Should Contain    ${output}    ReferenceId : -761049406
    Should Contain    ${output}    ReferencePosition : 1633805514
    Should Contain    ${output}    XPosition : -1613178788
    Should Contain    ${output}    YPosition : 1067221306
    Should Contain    ${output}    ZPosition : -1292806400
    Should Contain    ${output}    ILCUniqueId : 1979677352
    Should Contain    ${output}    ILCApplicationType : -69598984
    Should Contain    ${output}    NetworkNodeType : 1469781529
    Should Contain    ${output}    ILCSelectedOptions : -737778627
    Should Contain    ${output}    NetworkNodeOptions : -1354427906
    Should Contain    ${output}    MajorRevision : -536105187
    Should Contain    ${output}    MinorRevision : 900069113
    Should Contain    ${output}    ADCScanRate : 0.456086990368
    Should Contain    ${output}    MainADCCalibrationK1 : 0.564663990402
    Should Contain    ${output}    MainADCCalibrationK2 : 0.557627358967
    Should Contain    ${output}    MainADCCalibrationK3 : 0.535886871866
    Should Contain    ${output}    MainADCCalibrationK4 : 0.435757994397
    Should Contain    ${output}    MainLoadCellOffset : 0.405846881362
    Should Contain    ${output}    MainLoadCellSensitivity : 0.924684835079
    Should Contain    ${output}    BackupADCCalibrationK1 : 0.602427476727
    Should Contain    ${output}    BackupADCCalibrationK2 : 0.558886926296
    Should Contain    ${output}    BackupADCCalibrationK3 : 0.536624333642
    Should Contain    ${output}    BackupADCCalibrationK4 : 0.429711289619
    Should Contain    ${output}    BackupLoadCellOffset : 0.703453544097
    Should Contain    ${output}    BackupLoadCellSensitivity : 0.238199068914
    Should Contain    ${output}    MainCalibrationError : 0.020981691637
    Should Contain    ${output}    BackupCalibrationError : 0.501683317968
    Should Contain    ${output}    UniqueIdCRCError : 0.976306971701
    Should Contain    ${output}    ApplicationTypeMismatch : 0.156537454254
    Should Contain    ${output}    ApplicationMissing : 0.596225608798
    Should Contain    ${output}    ApplicationCRCMismatch : test
    Should Contain    ${output}    OneWireMissing : test
    Should Contain    ${output}    OneWire1Mismatch : test
    Should Contain    ${output}    OneWire2Mismatch : test
    Should Contain    ${output}    priority : test
