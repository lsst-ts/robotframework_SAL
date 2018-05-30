*** Settings ***
Documentation    Sequencer_sequencerCommandStatus communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    sequencer
${component}    sequencerCommandStatus
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send xBMlBwgxmNpjVAVLXTHpOJvLyMEnFDVNwihziFjhtIhzTePpjFZysvHzrJgZHBCZeohIgNWkViPlPoOsmjNcegsFHOBrTrjdJgabNVeGdZbqbmAkdrpwgjyPxrcEThxbzSVfzWVUZCZxeZkEGBXtOJSAwPqHOgfUIxCTWTQPCdVJHJkrujAAyYSfcfyVbBDiyDQaHsljMbfrKXTkSdVPnngQdGgTPihSLDflTTnmQaJBiCUmGgFfwCRFctZgRptE 930669514 21.2736 qwkcNOYeaQrgUImeMGzuUmtWxAPanmcMLWLmfVaKIFsIIpYOzrhvXlrMcZUgMPTzBaLHOqgZHCoAtsrlUZoUciMsoyyHqeytDnMylhZVgpIEDDSJZbfcjEcEFXjFnDwSgvUldYpCIxUAdOKvzsgJKrpfteADeMSoYKRmUitNKWtylyFLCbTdQLoBQKJMagTyhRBJnoSnDPVHomImRlgqIHnEuYiAGTKXAVmyVPvNTssLFtpYOSUnxZPfUenhTtSi SqWbYqDWDfBQwSEofNTGzZHiIwMJJbIFPpOJSIEqJxCyNCWdRqMGKlAClCPvRZHkvQsKgxYLqSrDucAMfLgSTmkmKQatanlqIhCcgCjRxyppzspNgJKKItwywgYXOFRILLlbuWIBtznfxZFtWmjbKHyaetyIjJIhudnFXVnIAmFnEzyglzOzdmvcwMNWqoFdtbEthJWiiiCztqZVPEmAUtDxkccVxbCdCDIrlqzBvHaIbilYjHpZKMtliYsOGMfJ 707479410 oTHQwAABLGxIywzmqBAoWBLXeDNDZMRqgWYtfVLcTLKITDOJZDyloEqKYJwfvowcuQSTcbkiYztTYODmdPRFwPySabRvhZJAGcVlYRrSCBdUgkgmJrbwYlLmIZTVKCIdtVtCVKASZLFqbbbKuegeTPVoWCQZHHggJFEFsjQkFMydRGOmuvFGqDmruFZmMEnxZeVFnaRQqbbemuLBKsuHIuvRmamDvwqQVhEZltHQwRrnrGsjxjEBQEghwbMVagiy 1911501457
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] sequencer::logevent_sequencerCommandStatus writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event sequencerCommandStatus generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1911501457
    Log    ${output}
    Should Contain X Times    ${output}    === Event sequencerCommandStatus received =     1
    Should Contain    ${output}    CommandSource : xBMlBwgxmNpjVAVLXTHpOJvLyMEnFDVNwihziFjhtIhzTePpjFZysvHzrJgZHBCZeohIgNWkViPlPoOsmjNcegsFHOBrTrjdJgabNVeGdZbqbmAkdrpwgjyPxrcEThxbzSVfzWVUZCZxeZkEGBXtOJSAwPqHOgfUIxCTWTQPCdVJHJkrujAAyYSfcfyVbBDiyDQaHsljMbfrKXTkSdVPnngQdGgTPihSLDflTTnmQaJBiCUmGgFfwCRFctZgRptE
    Should Contain    ${output}    SequenceNumber : 930669514
    Should Contain    ${output}    Identifier : 21.2736
    Should Contain    ${output}    Timestamp : qwkcNOYeaQrgUImeMGzuUmtWxAPanmcMLWLmfVaKIFsIIpYOzrhvXlrMcZUgMPTzBaLHOqgZHCoAtsrlUZoUciMsoyyHqeytDnMylhZVgpIEDDSJZbfcjEcEFXjFnDwSgvUldYpCIxUAdOKvzsgJKrpfteADeMSoYKRmUitNKWtylyFLCbTdQLoBQKJMagTyhRBJnoSnDPVHomImRlgqIHnEuYiAGTKXAVmyVPvNTssLFtpYOSUnxZPfUenhTtSi
    Should Contain    ${output}    CommandSent : SqWbYqDWDfBQwSEofNTGzZHiIwMJJbIFPpOJSIEqJxCyNCWdRqMGKlAClCPvRZHkvQsKgxYLqSrDucAMfLgSTmkmKQatanlqIhCcgCjRxyppzspNgJKKItwywgYXOFRILLlbuWIBtznfxZFtWmjbKHyaetyIjJIhudnFXVnIAmFnEzyglzOzdmvcwMNWqoFdtbEthJWiiiCztqZVPEmAUtDxkccVxbCdCDIrlqzBvHaIbilYjHpZKMtliYsOGMfJ
    Should Contain    ${output}    StatusValue : 707479410
    Should Contain    ${output}    Status : oTHQwAABLGxIywzmqBAoWBLXeDNDZMRqgWYtfVLcTLKITDOJZDyloEqKYJwfvowcuQSTcbkiYztTYODmdPRFwPySabRvhZJAGcVlYRrSCBdUgkgmJrbwYlLmIZTVKCIdtVtCVKASZLFqbbbKuegeTPVoWCQZHHggJFEFsjQkFMydRGOmuvFGqDmruFZmMEnxZeVFnaRQqbbemuLBKsuHIuvRmamDvwqQVhEZltHQwRrnrGsjxjEBQEghwbMVagiy
    Should Contain    ${output}    priority : 1911501457
