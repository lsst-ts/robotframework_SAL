*** Settings ***
Documentation    DMHeaderService_LargeFileObjectAvailable sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    dmHeaderService
${component}    LargeFileObjectAvailable
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send -409458653 419 LPJioZqeBuCjWgpsPwHeKwAaKySsFbhnTOksIYDreRpwLYCuaECGloOBHgEayEtnLerlPyktPOCzgeaMEUZVILxaIXzgUfeJqecnfrrPzrvYJjqfohHkDacEsZtzfAFFcIHFzWDCQZtJXekqEwGiraktzxaToTByRSwaXOnmHTPHzcLezTBDnuZcdZbdFgFhcoCcFwnaMKjERmmQZgJPcxsNHMSJKGrXGwFNcUnzgcMueGcUuaAIpzARnSeSbUhvPugTpRevpqFSsYMzXSshtasiWskYzFCWeBaPLBDITQuvdLgQdkCTBUtaLkFfnsQYIktuiYKDqJjuoIVQBSSeneRlWKrihNwzFLnqJtALuYVsBKcxVepXrpQYkURtAUWLjZQUSEkxvcBJdqNivalNbjKqAUKuswDjDXJ 434 unjuYnNGeEmkmrUlDYTGdeblgxUJVNGmVQwSScLOrTDQJiHDyuuwZjYBVCclYvDjtwpxfsYBxaRQvzLpauIULBvWSNNZCYtPmEdcoZuuVSyGVIAVHpzHqSCZWPRAIXxwywJnyGLxfURXHAQtjmQtsFAeTryeITpcodIYVpEUghIhIIMFZjBacTvwENBFWtLFfbRTYyTSUnpvpVWJjxNNfvWGjNyNzjhCAReDbBlQckcKPepIZzKzjksoyMesQFVBsMTAmWsZvbUrjxVCuijtKkhdvIGLNGmgPKBlCWbyRvQGttKPJZIESfuvaxjjLFcztGpEiMYOsBxQMcWBpDKIdEtBeFdmUMoMxzzGHEmGXVGrnVgIkYeTjCkZUicsripMuZjuQykRQUlciOThtGUualDzMItexzMxFowctIprmlSmFulvjv 682 diSeAeXcqIHOirVYTyfZIHLOWHPPdJFvjddByAcUjlOoeODYTonQYleueqcFoEXfGJgqEKnEmofrKOkpoKbIgrJUMXDuYXdeFSypSKjfPXoNnLwAzhyioEubwZLDKiWElElIqQfnXJTxUFWcraxqJgahHTTivQBbYBApyHUTXhYlvSPsAIhSglDGYTavqkNAJnZnZXsMXQgFdxZmHJdgNgtiIKELrCPzSaPLhMqMBwpbQSrhuWjOCyTbEXJpoLrwSOZHabaviiUEgPlvehcctAhtJnTeOIDERnYjKBthtPfLmAEBJeFdrmsNRfoxNvqEtSGkrOBpAWLtAkjZcuHKLNxRgSipESymyvhcjrLWzgZsjqjtHDRjECybQCAildoGxYmTcoHIPLcsGeCbowKACTyQwsArZgJlYZNpUgJGnUefbpXPOmHXIUDEhgvpjvtjfIBhtAFDMojsowtwdgZZNkqolSQkqabkpqQnHGOVXsebXLrHwLQZrLHiWAFNjGvxarWEhabubHBMenLDBFIUYQRoMzDJHzJkaHFxgWRSdJFHSLAiEYSsWBKjHmqRUMVeqXPRdOoAcfyqsPMeyuTNUTCUNeUNbWEpYkXUSGtFDUTmxxPYTiZlDSluXyKQKVHysAUdgXKsivAdsfZnSdFOTKWjsgKIBSqZVGJGOGYZYw 930 qGvsBkXOqfqDmHyMQzcAzGDNjOHeeijAinsSvsEqAnPEsuSKWcMlXlhrSrGiaQvVFDHPCkiYZpxHOBTLnhvFlTFaMYuBfpFEKiyiyOkIgageDLZGJDDpxMqPwfeamvIcYZvKHxBjFhDBskUkqdvmcAeFPdqEuOwkrKgRMFBgstmwWnfetAKphQMhNPhGPcaDdhjOUkawOfyxtgDzypvsMTrFOrDybhkbtHxYIUwyVDTahIpNdXpqVUNBCZvCBIaeoRZKsNeIpNrHJpoUJmOtavUiPVFXwZLxwnXBRoLExQOHgrMdUGAQSkymggRSREpXwLBesuWUiZAwiMqzHiqFhQgtrqKsqzctFSFxmPfGdXKxpxaLBdcmswYSNMKwMQwLaYybmoscyZwWWBkoWBIBcnKOCKiYZABJpxhnmzapwZcRLqXHVgDOSuYazgPNvRqDkBREOyzOeqMLGbhIKGkawQTAScDhwyFwCRiqRnujBqahhcKChbHbaIznTrGCLDSsPVdAjCewzzSBlxlsuNhtGWGavJDllJwIJIcgphEboyEbWcBjPcwWcKitmaWkGvSEggXtaCsbRhLQhSrpxkQDCaHydrmVclgAzPgOqymiFAFceWIqvWhEOkxHcsyVhNRFZtcIkGyZfPFUnHUMVbBUBKfMbVfoObEXeYJMdCOXozeKSLMNzIhMymKmQQORyksuVZEPWXGGIvaRdGfulCnNkjMLCmabqDDRXpfBOWTLjZNeVshmkMGzGLUDkrtLLmNCubnNrTXtQMoTCKsblzLTYNNDUbDUQHmQrHFszNfehbeZdfFhnbmbMCktGlcggCNmSPZYacyBooBKqhewLrzSlAAaRavcJGlbdcfcKZUycaTszWhAbVFxZbLQLXxqJpTFfydUpeZEMXunFRFWiFIDMaqeFXepSmbzSA 0.846981797303 test 1949457818
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] dmHeaderService::logevent_LargeFileObjectAvailable writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event LargeFileObjectAvailable generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1949457818
    Log    ${output}
    Should Contain X Times    ${output}    === Event LargeFileObjectAvailable received =     1
    Should Contain    ${output}    Byte_Size : -409458653
    Should Contain    ${output}    Checksum : 419
    Should Contain    ${output}    Generator : LPJioZqeBuCjWgpsPwHeKwAaKySsFbhnTOksIYDreRpwLYCuaECGloOBHgEayEtnLerlPyktPOCzgeaMEUZVILxaIXzgUfeJqecnfrrPzrvYJjqfohHkDacEsZtzfAFFcIHFzWDCQZtJXekqEwGiraktzxaToTByRSwaXOnmHTPHzcLezTBDnuZcdZbdFgFhcoCcFwnaMKjERmmQZgJPcxsNHMSJKGrXGwFNcUnzgcMueGcUuaAIpzARnSeSbUhvPugTpRevpqFSsYMzXSshtasiWskYzFCWeBaPLBDITQuvdLgQdkCTBUtaLkFfnsQYIktuiYKDqJjuoIVQBSSeneRlWKrihNwzFLnqJtALuYVsBKcxVepXrpQYkURtAUWLjZQUSEkxvcBJdqNivalNbjKqAUKuswDjDXJ
    Should Contain    ${output}    Mime : 434
    Should Contain    ${output}    Type : unjuYnNGeEmkmrUlDYTGdeblgxUJVNGmVQwSScLOrTDQJiHDyuuwZjYBVCclYvDjtwpxfsYBxaRQvzLpauIULBvWSNNZCYtPmEdcoZuuVSyGVIAVHpzHqSCZWPRAIXxwywJnyGLxfURXHAQtjmQtsFAeTryeITpcodIYVpEUghIhIIMFZjBacTvwENBFWtLFfbRTYyTSUnpvpVWJjxNNfvWGjNyNzjhCAReDbBlQckcKPepIZzKzjksoyMesQFVBsMTAmWsZvbUrjxVCuijtKkhdvIGLNGmgPKBlCWbyRvQGttKPJZIESfuvaxjjLFcztGpEiMYOsBxQMcWBpDKIdEtBeFdmUMoMxzzGHEmGXVGrnVgIkYeTjCkZUicsripMuZjuQykRQUlciOThtGUualDzMItexzMxFowctIprmlSmFulvjv
    Should Contain    ${output}    URL : 682
    Should Contain    ${output}    Version : diSeAeXcqIHOirVYTyfZIHLOWHPPdJFvjddByAcUjlOoeODYTonQYleueqcFoEXfGJgqEKnEmofrKOkpoKbIgrJUMXDuYXdeFSypSKjfPXoNnLwAzhyioEubwZLDKiWElElIqQfnXJTxUFWcraxqJgahHTTivQBbYBApyHUTXhYlvSPsAIhSglDGYTavqkNAJnZnZXsMXQgFdxZmHJdgNgtiIKELrCPzSaPLhMqMBwpbQSrhuWjOCyTbEXJpoLrwSOZHabaviiUEgPlvehcctAhtJnTeOIDERnYjKBthtPfLmAEBJeFdrmsNRfoxNvqEtSGkrOBpAWLtAkjZcuHKLNxRgSipESymyvhcjrLWzgZsjqjtHDRjECybQCAildoGxYmTcoHIPLcsGeCbowKACTyQwsArZgJlYZNpUgJGnUefbpXPOmHXIUDEhgvpjvtjfIBhtAFDMojsowtwdgZZNkqolSQkqabkpqQnHGOVXsebXLrHwLQZrLHiWAFNjGvxarWEhabubHBMenLDBFIUYQRoMzDJHzJkaHFxgWRSdJFHSLAiEYSsWBKjHmqRUMVeqXPRdOoAcfyqsPMeyuTNUTCUNeUNbWEpYkXUSGtFDUTmxxPYTiZlDSluXyKQKVHysAUdgXKsivAdsfZnSdFOTKWjsgKIBSqZVGJGOGYZYw
    Should Contain    ${output}    priority : 930
