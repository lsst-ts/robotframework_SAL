*** Settings ***
Documentation    M1M3_FPGAData communications tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Publisher    AND    Create Session    Subscriber
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    FPGAData
${timeout}    30s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_${component}_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_${component}_Publisher.py

Start Subscriber
    [Tags]    functional
    Switch Connection    Subscriber
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Subscriber.
    ${input}=    Write    python ${subSystem}_${component}_Subscriber.py
    ${output}=    Read Until    subscriber ready
    Log    ${output}
    Should Be Equal    ${output}    ${subSystem}_${component} subscriber ready

Start Publisher
    [Tags]    functional
    Switch Connection    Publisher
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Publisher.
    ${input}=    Write    python ${subSystem}_${component}_Publisher.py
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    [putSample] ${subSystem}::${component} writing a message containing :   10
    Should Contain X Times    ${output}    revCode \ : LSST TEST REVCODE    10

Read Subscriber
    [Tags]    functional
    Switch Connection    Subscriber
    ${output}=    Read    delay=1s
    Log    ${output}
    @{list}=    Split To Lines    ${output}    start=1
    Should Contain X Times    ${list}    Timestamp = 1.0    10
    Should Contain X Times    ${list}    ModbusSubnetATxInternalFIFOOverflow = 1    10
    Should Contain X Times    ${list}    ModbusSubnetAInvalidInstruction = 1    10
    Should Contain X Times    ${list}    ModbusSubnetAWaitForRxFrameTimeout = 1    10
    Should Contain X Times    ${list}    ModbusSubnetAStartBitError = 1    10
    Should Contain X Times    ${list}    ModbusSubnetAStopBitError = 1    10
    Should Contain X Times    ${list}    ModbusSubnetARxDataFIFOOverflow = 1    10
    Should Contain X Times    ${list}    ModbusSubnetATxByteCount = 1    10
    Should Contain X Times    ${list}    ModbusSubnetATxFrameCount = 1    10
    Should Contain X Times    ${list}    ModbusSubnetARxByteCount = 1    10
    Should Contain X Times    ${list}    ModbusSubnetARxFrameCount = 1    10
    Should Contain X Times    ${list}    ModbusSubnetBTxInternalFIFOOverflow = 1    10
    Should Contain X Times    ${list}    ModbusSubnetBInvalidInstruction = 1    10
    Should Contain X Times    ${list}    ModbusSubnetBWaitForRxFrameTimeout = 1    10
    Should Contain X Times    ${list}    ModbusSubnetBStartBitError = 1    10
    Should Contain X Times    ${list}    ModbusSubnetBStopBitError = 1    10
    Should Contain X Times    ${list}    ModbusSubnetBRxDataFIFOOverflow = 1    10
    Should Contain X Times    ${list}    ModbusSubnetBTxByteCount = 1    10
    Should Contain X Times    ${list}    ModbusSubnetBTxFrameCount = 1    10
    Should Contain X Times    ${list}    ModbusSubnetBRxByteCount = 1    10
    Should Contain X Times    ${list}    ModbusSubnetBRxFrameCount = 1    10
    Should Contain X Times    ${list}    ModbusSubnetCTxInternalFIFOOverflow = 1    10
    Should Contain X Times    ${list}    ModbusSubnetCInvalidInstruction = 1    10
    Should Contain X Times    ${list}    ModbusSubnetCWaitForRxFrameTimeout = 1    10
    Should Contain X Times    ${list}    ModbusSubnetCStartBitError = 1    10
    Should Contain X Times    ${list}    ModbusSubnetCStopBitError = 1    10
    Should Contain X Times    ${list}    ModbusSubnetCRxDataFIFOOverflow = 1    10
    Should Contain X Times    ${list}    ModbusSubnetCTxByteCount = 1    10
    Should Contain X Times    ${list}    ModbusSubnetCTxFrameCount = 1    10
    Should Contain X Times    ${list}    ModbusSubnetCRxByteCount = 1    10
    Should Contain X Times    ${list}    ModbusSubnetCRxFrameCount = 1    10
    Should Contain X Times    ${list}    ModbusSubnetDTxInternalFIFOOverflow = 1    10
    Should Contain X Times    ${list}    ModbusSubnetDInvalidInstruction = 1    10
    Should Contain X Times    ${list}    ModbusSubnetDWaitForRxFrameTimeout = 1    10
    Should Contain X Times    ${list}    ModbusSubnetDStartBitError = 1    10
    Should Contain X Times    ${list}    ModbusSubnetDStopBitError = 1    10
    Should Contain X Times    ${list}    ModbusSubnetDRxDataFIFOOverflow = 1    10
    Should Contain X Times    ${list}    ModbusSubnetDTxByteCount = 1    10
    Should Contain X Times    ${list}    ModbusSubnetDTxFrameCount = 1    10
    Should Contain X Times    ${list}    ModbusSubnetDRxByteCount = 1    10
    Should Contain X Times    ${list}    ModbusSubnetDRxFrameCount = 1    10
    Should Contain X Times    ${list}    ModbusSubnetETxInternalFIFOOverflow = 1    10
    Should Contain X Times    ${list}    ModbusSubnetEInvalidInstruction = 1    10
    Should Contain X Times    ${list}    ModbusSubnetEWaitForRxFrameTimeout = 1    10
    Should Contain X Times    ${list}    ModbusSubnetEStartBitError = 1    10
    Should Contain X Times    ${list}    ModbusSubnetEStopBitError = 1    10
    Should Contain X Times    ${list}    ModbusSubnetERxDataFIFOOverflow = 1    10
    Should Contain X Times    ${list}    ModbusSubnetETxByteCount = 1    10
    Should Contain X Times    ${list}    ModbusSubnetETxFrameCount = 1    10
    Should Contain X Times    ${list}    ModbusSubnetERxByteCount = 1    10
    Should Contain X Times    ${list}    ModbusSubnetERxFrameCount = 1    10
    Should Contain X Times    ${list}    FPGATime = 1.0    10
