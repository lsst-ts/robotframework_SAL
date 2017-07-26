*** Settings ***
Documentation    OCS_ocsEntitySummaryState sender/logger tests.
Force Tags    cpp
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    ocs
${component}    ocsEntitySummaryState
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send nqYTXgIoecWpPmAnQjVeHoCoYRSiJeXXFVtdtuVSNJuFrMpfrPEtiKCCYomuFDHJWrrpVkDcAJAjwSLKjkfmhKAibiejjxWpbSdyVDfWyvihYOXBLaDrNioTNMWeGgfr 23.4595 McuSijplvHSUrxJgFmgygiEYCgXbyxvCTPSWKjiFcbZbfQNOHvsFGJqVRVOqSmhnjnzAlbwUjKaUktbDmFqQnPHBGGGrJKPmoeopoDufxilGKjxrVHCIssiGZoLedPnuyMEDAUhzKvWyLEgLLoZCMYDxijOrClwqWefZufvHWooRqwGKFsANCRwJltOSOvBTMwwNhfyVuPyBWdhWcumPrnmIfbZthumkzMeQSjhyIEdraCGSggofQqJbbChJJTBX -765597930 TjBAgBaXmWqOFWEMJiODyKeWlzKNrCqhPwMmdNeupOMiiMIKQYKuPGjCDeXohWrgsYMtHxAPdVHFoooTumkfmXueqKnGaNtdpcagtnIdKruqwTfiEXUSEUPyEShhiaoU oSzMpSBPaQAjaYJoKFUCnfoAliCNJIQvEhQmckjMNksrSHqmomczvSGCQkhjMSdeTLvZCJXDeknCIbIkyTfhyjWkIArHTIaZtgmsXFRzpMENLakuNhcMtQeMxmWWkWbf MyJtjQJDBwhIIQfQmoGugCGzloOdrjrVdUJMQtjfwINntizYeGEDHfGIyAYPSbaJsTeyzAZIbZIPCYpHsUbUGVcRkkVpyNHNYATVQkdsCWKyFBrwCBHZMlIwHEerwkqk xsClvyEBYXAvoZFernCXWkCIRfyHarEJQYfIkiVfQPSTkoCDTLjvJEkmvhtgHpYwIwRiFGwWEqmhfYSLxBlDmxEDQlIycUzToQQWcikQxYJtIBtIPBXgsvmFvxGdMzfH mXxvzOkWAeePXronLGFqHbWVuGMIhQExuYEUqvkdlAqCxrnpackvnQsGfoGPjdcMNwNRYxjjtTWYDdAKtyAybugPOwSMMKMjrSbIErjSDUBOzgfmHmLYViSZWSWdtGze -1784347999
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] ocs::logevent_ocsEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ocsEntitySummaryState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1784347999
    Log    ${output}
    Should Contain X Times    ${output}    === Event ocsEntitySummaryState received =     1
    Should Contain    ${output}    Name : nqYTXgIoecWpPmAnQjVeHoCoYRSiJeXXFVtdtuVSNJuFrMpfrPEtiKCCYomuFDHJWrrpVkDcAJAjwSLKjkfmhKAibiejjxWpbSdyVDfWyvihYOXBLaDrNioTNMWeGgfr
    Should Contain    ${output}    Identifier : 23.4595
    Should Contain    ${output}    Timestamp : McuSijplvHSUrxJgFmgygiEYCgXbyxvCTPSWKjiFcbZbfQNOHvsFGJqVRVOqSmhnjnzAlbwUjKaUktbDmFqQnPHBGGGrJKPmoeopoDufxilGKjxrVHCIssiGZoLedPnuyMEDAUhzKvWyLEgLLoZCMYDxijOrClwqWefZufvHWooRqwGKFsANCRwJltOSOvBTMwwNhfyVuPyBWdhWcumPrnmIfbZthumkzMeQSjhyIEdraCGSggofQqJbbChJJTBX
    Should Contain    ${output}    Address : -765597930
    Should Contain    ${output}    CurrentState : TjBAgBaXmWqOFWEMJiODyKeWlzKNrCqhPwMmdNeupOMiiMIKQYKuPGjCDeXohWrgsYMtHxAPdVHFoooTumkfmXueqKnGaNtdpcagtnIdKruqwTfiEXUSEUPyEShhiaoU
    Should Contain    ${output}    PreviousState : oSzMpSBPaQAjaYJoKFUCnfoAliCNJIQvEhQmckjMNksrSHqmomczvSGCQkhjMSdeTLvZCJXDeknCIbIkyTfhyjWkIArHTIaZtgmsXFRzpMENLakuNhcMtQeMxmWWkWbf
    Should Contain    ${output}    Executing : MyJtjQJDBwhIIQfQmoGugCGzloOdrjrVdUJMQtjfwINntizYeGEDHfGIyAYPSbaJsTeyzAZIbZIPCYpHsUbUGVcRkkVpyNHNYATVQkdsCWKyFBrwCBHZMlIwHEerwkqk
    Should Contain    ${output}    CommandsAvailable : xsClvyEBYXAvoZFernCXWkCIRfyHarEJQYfIkiVfQPSTkoCDTLjvJEkmvhtgHpYwIwRiFGwWEqmhfYSLxBlDmxEDQlIycUzToQQWcikQxYJtIBtIPBXgsvmFvxGdMzfH
    Should Contain    ${output}    ConfigurationsAvailable : mXxvzOkWAeePXronLGFqHbWVuGMIhQExuYEUqvkdlAqCxrnpackvnQsGfoGPjdcMNwNRYxjjtTWYDdAKtyAybugPOwSMMKMjrSbIErjSDUBOzgfmHmLYViSZWSWdtGze
    Should Contain    ${output}    priority : -1784347999
