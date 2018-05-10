*** Settings ***
Documentation    M1M3_HardpointActuatorInfo sender/logger tests.
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 29.9487 982 22473 23717 -7080 31961 -5627 -1762688903 -1586331554 -1559842804 1675641483 -111067269 -761016163 -3337 -12797 -16784 -3078 22760 -5882 29105 -8949 -32033 1090 -3627 -6316 0.811004578771 0.490858827674 0.681267532762 0.28038305424 0.050471322368 0.302582261124 0.313137788567 0.937634900751 0.303223443256 0.916391734076 0.561481922872 0.558758351827 0.56651810563 0.115823184052 0.538573489301 0.508573595267 0.565549367903 0.524068163822 test test test test test test -32375 -3342 -7600 8690 25198 -28733 23407 -13122 17515 18378 23558 6437 27661 -6787 23454 27489 479 -14593 14680 -1954 -18543 19073 -16736 12461 -24642 16077 26600 24320 -28174 19074 -14682 3104 3051 -23866 -28547 -11313 -27447 -407 2828 9458 -29000 21028 0.792588996153 0.384706414777 0.895331359146 0.306430046 0.282835586266 0.242741824115 0.363984360133 0.950463256524 0.937218670584 0.0539217624115 0.384680630732 0.78335422207 0.407943689829 0.718494611635 0.46079048547 0.000833919704733 0.609722376212 0.822589696976 0.992144433599 0.0163134782998 0.513690222226 0.491555322188 0.646371116369 0.836955009404 0.154605428034 0.999943629265 0.815286205898 0.41531260565 0.0428606614947 0.208677816815 0.812225083769 0.157589815644 0.424651540388 0.255731949073 0.390719102637 0.503559705218 182776892
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
