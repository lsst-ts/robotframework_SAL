*** Settings ***
Documentation    M1M3_HardpointActuatorInfo communications tests.
Force Tags    python    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    HardpointActuatorInfo
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp ReferenceId ReferencePosition ModbusSubnet ModbusAddress XPosition YPosition ZPosition ILCUniqueId ILCApplicationType NetworkNodeType ILCSelectedOptions NetworkNodeOptions MajorRevision MinorRevision ADCScanRate MainLoadCellCoefficient MainLoadCellOffset MainLoadCellSensitivity BackupLoadCellCoefficient BackupLoadCellOffset BackupLoadCellSensitivity priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 39.2592 15425 3329 -21421 -9732 28175 32704 1984244433 -1630323 1670306611 -374938068 334799094 -490140007 8706 -1382 -2686 -15646 -21227 -1098 16562 -24264 -28268 -22824 -28177 1978 0.806369 0.058626 0.160323 0.626083 0.578155 0.883272 0.152288 0.521674 0.947001 0.493686 0.02453 0.54929 0.671682 0.020762 0.478425 0.548988 0.993923 0.710016 test test test test test test -26317 9400 21905 -12274 -14829 20978 7635 -32751 31878 7838 -19096 -12965 4422 3348 30362 20021 -30784 -2860 8611 -32704 -16090 7981 -13398 -15873 4711 32660 28313 22756 32061 25974 -26044 30211 224 -29444 17459 17055 -6056 -2272 -12647 30802 19512 -2907 0.80041 0.752133 0.910839 0.562419 0.874607 0.092868 0.888844 0.108701 0.997999 0.982191 0.141737 0.326684 0.493949 0.459705 0.603708 0.522835 0.408101 0.914955 0.373702 0.343829 0.873658 0.303404 0.151572 0.793666 0.159064 0.803546 0.110302 0.983459 0.010349 0.337502 0.271116 0.011207 0.679677 0.261083 0.355654 0.138171 2060021249
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointActuatorInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
