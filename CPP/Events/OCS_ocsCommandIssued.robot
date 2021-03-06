*** Settings ***
Documentation    OCS_ocsCommandIssued communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    ocs
${component}    ocsCommandIssued
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send yxaugPrqHHrxTQVDUbmfrlpnQUijjBptaGfkTNJLDQLBeoFqOnuNLbwvUrSAzJlIrnBGGmOyCzwxQpaUVVdAmQJPUHHyboxTlCQvDueKlolOoOXuMsqqUpjkzbibbARuMzYsDlZIqzqbcQiMISkPxqbHwDytxxsRoMgXoRPvvcVYlgjDSLMWChyoOeTzpcplyuBTnWwdoJafCozMDErmWddXggGSCiTgzEGWoalFdtAYWIrskbRMpmrVnetilYsq 1632132140 73.5394 jpLsTJrBYkziJXyEbidHkBkJbmTeplTIxumiUSebLIRTvXIrdPMFklTIFpkrBEyhOKpowDPyppcdWAZOWKHwGRvAuCnlPbvTliheyMimDgSsBwdxtEFJfWeWdlgixINEjAYRmJsMzMcfGfnoXzkKuauAPhTpECPLySJzMlBuzblDxoDtjhELQOOxFCAeDThaMNKdjKHpcfnFNHdIUCuVFFNoaIheeAhAKKpTyxEdXfZUCJfSyTrwYhTZApFAyVeF amXDloLhHcVUeALGhfPUZFEduuehifwjwOJprbbMRfZJJcGokZZSymDzgzbzGpmPZhmukjtzzypZiplylhUqpgNjFtpEeocvoRJdQLEpvcVrvmCwHCAEeiaFgINgdRDimTexZryHyiyfellAeJHNqGaqvzJMNLBnDDPhJtxDTrlwHpFWAHNfekxfbYXmnVOtZRqwiymiMeFukjDIJojzLDcCthNSXiDgVUnWwhPBKuYscjFCJHmLwfKgolyUKvpJ -1473504764 520793872
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] ocs::logevent_ocsCommandIssued writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ocsCommandIssued generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 520793872
    Log    ${output}
    Should Contain X Times    ${output}    === Event ocsCommandIssued received =     1
    Should Contain    ${output}    CommandSource : yxaugPrqHHrxTQVDUbmfrlpnQUijjBptaGfkTNJLDQLBeoFqOnuNLbwvUrSAzJlIrnBGGmOyCzwxQpaUVVdAmQJPUHHyboxTlCQvDueKlolOoOXuMsqqUpjkzbibbARuMzYsDlZIqzqbcQiMISkPxqbHwDytxxsRoMgXoRPvvcVYlgjDSLMWChyoOeTzpcplyuBTnWwdoJafCozMDErmWddXggGSCiTgzEGWoalFdtAYWIrskbRMpmrVnetilYsq
    Should Contain    ${output}    SequenceNumber : 1632132140
    Should Contain    ${output}    Identifier : 73.5394
    Should Contain    ${output}    Timestamp : jpLsTJrBYkziJXyEbidHkBkJbmTeplTIxumiUSebLIRTvXIrdPMFklTIFpkrBEyhOKpowDPyppcdWAZOWKHwGRvAuCnlPbvTliheyMimDgSsBwdxtEFJfWeWdlgixINEjAYRmJsMzMcfGfnoXzkKuauAPhTpECPLySJzMlBuzblDxoDtjhELQOOxFCAeDThaMNKdjKHpcfnFNHdIUCuVFFNoaIheeAhAKKpTyxEdXfZUCJfSyTrwYhTZApFAyVeF
    Should Contain    ${output}    CommandSent : amXDloLhHcVUeALGhfPUZFEduuehifwjwOJprbbMRfZJJcGokZZSymDzgzbzGpmPZhmukjtzzypZiplylhUqpgNjFtpEeocvoRJdQLEpvcVrvmCwHCAEeiaFgINgdRDimTexZryHyiyfellAeJHNqGaqvzJMNLBnDDPhJtxDTrlwHpFWAHNfekxfbYXmnVOtZRqwiymiMeFukjDIJojzLDcCthNSXiDgVUnWwhPBKuYscjFCJHmLwfKgolyUKvpJ
    Should Contain    ${output}    ReturnValue : -1473504764
    Should Contain    ${output}    priority : 520793872
