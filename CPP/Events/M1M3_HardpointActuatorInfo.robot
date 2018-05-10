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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 39.1171 28946 -24656 -16796 17098 -22992 28832 -1237835879 -910965036 -515787788 480894993 -1059645647 -16926950 -25979 -12947 32393 -24092 -16843 12145 -16937 -29493 7977 10077 -26631 17808 0.307399913011 0.248829848919 0.374401649043 0.0720286628066 0.338010170809 0.473483326692 0.242101501005 0.245604515616 0.989159139467 0.721956764611 0.085171170351 0.523374283218 0.193789117931 0.190038107452 0.0132480113843 0.809088801089 0.96623803512 0.130893864387 test test test test test test 26276 -14838 15790 26943 12909 -4905 -7508 -714 19909 -13075 28859 -30196 -8558 -10503 -19720 -28308 14254 27564 30861 19890 30127 22940 -31005 12907 -9266 8229 23591 7788 -3200 -3588 -30604 28968 9110 -27215 -1783 -20881 27464 1333 32159 21820 18355 32089 0.591682372476 0.392949050031 0.250103480334 0.637023074925 0.460278103152 0.325120405685 0.387633616286 0.80125477712 0.897815279794 0.417576165421 0.531920891211 0.595066315961 0.69110082151 0.918687176201 0.363846949803 0.0890810846487 0.748521642744 0.567381150155 0.0199475321797 0.281774595245 0.867351278599 0.367913488212 0.156784597102 0.730012934502 0.536962277546 0.485679442481 0.0438078732086 0.553541809023 0.36351461729 0.0824020669863 0.457364830499 0.684273907989 0.708113420985 0.575248215529 0.722963695087 0.459051700435 609962064
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointActuatorInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event HardpointActuatorInfo generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 609962064
    Log    ${output}
    Should Contain X Times    ${output}    === Event HardpointActuatorInfo received =     1
    Should Contain    ${output}    Timestamp : 39.1171
    Should Contain    ${output}    ReferenceId : 28946
    Should Contain    ${output}    ReferencePosition : -24656
    Should Contain    ${output}    ModbusSubnet : -16796
    Should Contain    ${output}    ModbusAddress : 17098
    Should Contain    ${output}    XPosition : -22992
    Should Contain    ${output}    YPosition : 28832
    Should Contain    ${output}    ZPosition : -1237835879
    Should Contain    ${output}    ILCUniqueId : -910965036
    Should Contain    ${output}    ILCApplicationType : -515787788
    Should Contain    ${output}    NetworkNodeType : 480894993
    Should Contain    ${output}    ILCSelectedOptions : -1059645647
    Should Contain    ${output}    NetworkNodeOptions : -16926950
    Should Contain    ${output}    MajorRevision : -25979
    Should Contain    ${output}    MinorRevision : -12947
    Should Contain    ${output}    ADCScanRate : 32393
    Should Contain    ${output}    MainLoadCellCoefficient : -24092
    Should Contain    ${output}    MainLoadCellOffset : -16843
    Should Contain    ${output}    MainLoadCellSensitivity : 12145
    Should Contain    ${output}    BackupLoadCellCoefficient : -16937
    Should Contain    ${output}    BackupLoadCellOffset : -29493
    Should Contain    ${output}    BackupLoadCellSensitivity : 7977
    Should Contain    ${output}    priority : 10077
