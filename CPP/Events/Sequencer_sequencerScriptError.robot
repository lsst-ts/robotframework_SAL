*** Settings ***
Documentation    Sequencer_sequencerScriptError sender/logger tests.
Force Tags    cpp
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    sequencer
${component}    sequencerScriptError
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send CtFHPCDygEhFOdIhKCqWXyxYYRyGLAkhhaetfvLtiwgkPMkpAjQOVmsuOCQRFpTtyVabILzzUyrAPBJwJFuIPIQvAxFHxmviCRxnjLhHtisofQcgFuwXNaSWOJJiveKeAKbQeTbLEbhztoyWdHYEDnDwUosacdAjhQbgIbkDJTJaAsfNLmVjbnSUVkAPKpqTcFrGOwODakJFJrgedjcEzXuXKToqgMYKldqCHjFuyLuhxplgoWYbikcmEKumiIQx 11.7336 gJgzBXhPEZvRgejdhstJxIPjXPUtgLwOoyhXqaWnYveJHBSfcuRNCSUtNwCFpGTBJnFneAsUBruMIffrOLVJYOCUkCGjUOgUhcJbgGDdcbsgjHtVGcfVrphhoGYZuGZgrUSfBklpCEkglZnHhylMjvoFfIfLVlVAAkraVNaaTPlCeERfKtcDIlEGeorSrpXLzAndsKUMzuUunJxleeIePUheUvcZFidjuNDWSFXTIhGGjAKvKpKLiMqSmOCAXDur -1463878471 -2074234764 RkqaedwdviFybLpLHWIyLkSAkBKpaEboPpyVvUkJNUrvfGimSgbtsIhRTLSnRpHgxDSjbDgCTGQhDdjOlcFgdGxtCFVAtGVbYvLuGHfccPLwrYsLVQSBBSQJPVvDNsyAFEubxjUYCUJhBqPpgxMLLGbbssfHtggxOrRyyuEHTULAwfuNuczmBJtpfVSEcDgCXVuJsdZdAgrYoZXHimcXEOpRfEFPQFxrimDkKISiaweEQIAoetoxpmyRIhnJhscG 521578668
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] sequencer::logevent_sequencerScriptError writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event sequencerScriptError generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 521578668
    Log    ${output}
    Should Contain X Times    ${output}    === Event sequencerScriptError received =     1
    Should Contain    ${output}    sequencerScriptName : CtFHPCDygEhFOdIhKCqWXyxYYRyGLAkhhaetfvLtiwgkPMkpAjQOVmsuOCQRFpTtyVabILzzUyrAPBJwJFuIPIQvAxFHxmviCRxnjLhHtisofQcgFuwXNaSWOJJiveKeAKbQeTbLEbhztoyWdHYEDnDwUosacdAjhQbgIbkDJTJaAsfNLmVjbnSUVkAPKpqTcFrGOwODakJFJrgedjcEzXuXKToqgMYKldqCHjFuyLuhxplgoWYbikcmEKumiIQx
    Should Contain    ${output}    sequencerScriptIdentifier : 11.7336
    Should Contain    ${output}    sequencerScriptTimestamp : gJgzBXhPEZvRgejdhstJxIPjXPUtgLwOoyhXqaWnYveJHBSfcuRNCSUtNwCFpGTBJnFneAsUBruMIffrOLVJYOCUkCGjUOgUhcJbgGDdcbsgjHtVGcfVrphhoGYZuGZgrUSfBklpCEkglZnHhylMjvoFfIfLVlVAAkraVNaaTPlCeERfKtcDIlEGeorSrpXLzAndsKUMzuUunJxleeIePUheUvcZFidjuNDWSFXTIhGGjAKvKpKLiMqSmOCAXDur
    Should Contain    ${output}    sequencerScriptLineNumber : -1463878471
    Should Contain    ${output}    sequencerScriptErrorCode : -2074234764
    Should Contain    ${output}    sequencerScriptErrorText : RkqaedwdviFybLpLHWIyLkSAkBKpaEboPpyVvUkJNUrvfGimSgbtsIhRTLSnRpHgxDSjbDgCTGQhDdjOlcFgdGxtCFVAtGVbYvLuGHfccPLwrYsLVQSBBSQJPVvDNsyAFEubxjUYCUJhBqPpgxMLLGbbssfHtggxOrRyyuEHTULAwfuNuczmBJtpfVSEcDgCXVuJsdZdAgrYoZXHimcXEOpRfEFPQFxrimDkKISiaweEQIAoetoxpmyRIhnJhscG
    Should Contain    ${output}    priority : 521578668
