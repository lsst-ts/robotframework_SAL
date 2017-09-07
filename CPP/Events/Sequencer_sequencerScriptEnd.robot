*** Settings ***
Documentation    Sequencer_sequencerScriptEnd sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    sequencer
${component}    sequencerScriptEnd
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send ptyaVInYxoqaFwRJrjXSTxBKWchemYBuaGrAHUmeHFuxTHLAKeCmyCpNqckUOBgeWVFNuTWmHcmnFZNlZnugTsKDVnNRjqfCDgWGZYKKepLngBDgDyGAwxZUMxTpXQjcymQwbJSknSTzcGBMrPEePAaQoGMHrQHDbmtTytHbvEhhjdxSdDIgwIYZPtusMoEAcvDESAASADdZkyHWBLukWJRagcnoKJbMvfyhOToEKfHWfFjzmTNQcPoUtSyFdoaH 66.6324 CrCrlXPHHwqsBRaNHHTxnhjwCnIRQfqhMkYQHyHxgcFZXIQbCBRgPhIBtiMFyxaWgKqqoJjFUMALWorezvxtMITsMGwRECGguavWNwGLkDjVfJijLmINXrZHtJyxiRgHyIqPqFvRbDJmueecRoANxCpeDvClfcWxEUsuoDrLSYTxcUTvGjpNDaGMEmladXBAudaVfnYpOlAihdNYEmgqaEmQOElUaKCHPUxrsbuUgdxqRJRFiykvNVDzGwEKJwCM -170915305 XInnqrVUyWbBNSuRnicVbTXKEuPbNQUjJzhjCtdAbyMMykzxKjhCYEqZZmqCyMMvsJjDoHkeJtckRuDIZazeWoBzqiXIjFicEIkGOVbYtCcPHlajtpCXohsLnCcatofUKbgEaiarSBEHblfzhzevJwMWQJCMledoZIZRqhJdaNoBpwBdUxTcPkOjTLyNeRwRyoaILSHZZvpCUFUDKUbNKfVEmNcYZMhvGKdUpkcZRlifdiWRYgrPKNFfXtexACRd -1208110087
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] sequencer::logevent_sequencerScriptEnd writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event sequencerScriptEnd generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1208110087
    Log    ${output}
    Should Contain X Times    ${output}    === Event sequencerScriptEnd received =     1
    Should Contain    ${output}    sequencerScriptName : ptyaVInYxoqaFwRJrjXSTxBKWchemYBuaGrAHUmeHFuxTHLAKeCmyCpNqckUOBgeWVFNuTWmHcmnFZNlZnugTsKDVnNRjqfCDgWGZYKKepLngBDgDyGAwxZUMxTpXQjcymQwbJSknSTzcGBMrPEePAaQoGMHrQHDbmtTytHbvEhhjdxSdDIgwIYZPtusMoEAcvDESAASADdZkyHWBLukWJRagcnoKJbMvfyhOToEKfHWfFjzmTNQcPoUtSyFdoaH
    Should Contain    ${output}    sequencerScriptIdentifier : 66.6324
    Should Contain    ${output}    sequencerScriptTimestamp : CrCrlXPHHwqsBRaNHHTxnhjwCnIRQfqhMkYQHyHxgcFZXIQbCBRgPhIBtiMFyxaWgKqqoJjFUMALWorezvxtMITsMGwRECGguavWNwGLkDjVfJijLmINXrZHtJyxiRgHyIqPqFvRbDJmueecRoANxCpeDvClfcWxEUsuoDrLSYTxcUTvGjpNDaGMEmladXBAudaVfnYpOlAihdNYEmgqaEmQOElUaKCHPUxrsbuUgdxqRJRFiykvNVDzGwEKJwCM
    Should Contain    ${output}    sequencerScriptStatusCode : -170915305
    Should Contain    ${output}    sequencerScriptStatusText : XInnqrVUyWbBNSuRnicVbTXKEuPbNQUjJzhjCtdAbyMMykzxKjhCYEqZZmqCyMMvsJjDoHkeJtckRuDIZazeWoBzqiXIjFicEIkGOVbYtCcPHlajtpCXohsLnCcatofUKbgEaiarSBEHblfzhzevJwMWQJCMledoZIZRqhJdaNoBpwBdUxTcPkOjTLyNeRwRyoaILSHZZvpCUFUDKUbNKfVEmNcYZMhvGKdUpkcZRlifdiWRYgrPKNFfXtexACRd
    Should Contain    ${output}    priority : -1208110087
