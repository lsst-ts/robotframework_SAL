*** Settings ***
Documentation    PromptProcessing_promptprocessingEntitySummaryState sender/logger tests.
Force Tags    cpp    TSS-2633
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    promptprocessing
${component}    promptprocessingEntitySummaryState
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send nNzClOGwejXIXTIwhYPQtYEuciGgIirTtprSbreIalPVYLVlscnYLsNrzgsUIUwwUlxfGWtTdZWbTnUqNNHhHXSLEMjeowTdSOSJPrsxEBqfyeLhwFsVvFpGzEnBPcNMFanuWfxbKNxRebmcsMmiSFNnkFmxaflzbioAljzIFBODwrTebRPEZOHbPjRnKcSxnXZWmFjSILnmJjoWFGYhJWnxAjAwZfkPnwmdBYAYKeIcSkWoNZhvBEtcNZmpRFdY 59.3513 tMKgOluQNUKYBvActgoVdwGMqRuTawrPfnIZWBzmGntgztkqBktHwcPjxMiFYpVCuOZGCNSjYuEgLdLIlyXUkexnmQMxKkVzPHUmvzInUIrgMZUbxLWtluYInmzHnkyxhzUAUaeAfZEwqOyQEHpBiueTOAqRuQyAsogVSqmNDdEnsnJeFLXfxGWKMLBOxsrEVorfLYCsCyOJGTtHFZoQxCfnmvmBTFtmYkiRwizOaLkbTRkziLuNVnGmAqTNUsjo 2078045365 LrsFMOlDPpxWwXZQEQjreTFWfKXXWZlRCjyDxgjdXmJTxABVhVjHKIaKUpTsuiWlrqiYIqOKhMovepCdJfljUIqZrXiDpSsSOhTbrwEAXNcGZGYGndUGjadKRxxmIAcefVhiufButxhknUICfEHzUDZiVXSqbjFDAYMdfZtavYuYseRDbmKgYoDVTBiPbsEOgnXgqhuwvSNuRYKCideqJyZYhNPAqRCOazpgKHgIaqabplYJgIwNgIXMyzVWOGdm sIEpyuROjBXBLqBDrlKQnazbcWwZeeSQCehWQWmQUxEeEhnrznVoiqfCPQIUcQbVmZBcFWgSZrXCFIqdJuGapWyPdDGiDkVDObKaLhmMDmisYGkNEroPDoQdtTgnVniZbMtOQvgiVjlfeRhTLmLAAARrnyjxcqPYOvIPqtKRaplkCnwRpKhCPQykdMRXKqDGLBCbPVaMnxgivfoQjNxudHTRXfqRUuKMJnQFBuOBofHMIujLjKxHtqBUvFDHtGDf HkAPIMqmKDcQrSsMGlerCVpIKYoXdnGfHMGqGGQMAWimXLIaFpNbsOZpAmuLCvUFVJQBQZTJBblqHJEjVEozllKOOKiXTewyXunIpqARCiknSakdJvKdPSmxwMaOkCKAHNraNLLgyIsdKZJuffDLGeOHkjgKhHFTgBsLnfPUScmsSNTDzfliTYvvijoLaZVTDetoibeNDbqnehAcmdKTDwfohvJKYpMfhnImwyYTFPYwYVZugkawJlwnAyrwsYox vXrXBrzBzXEhnsTQICIEVTodgJldjbCmCZZLRyCpjIEQTRXuuhotukBUwNNmkwJsAWPzaaXCpyMfwbireNcCwEnnEOHzZJCoCHsoNMcGuZIawhGyyniMOAXCKueOAuRrOYFtisNIOiBCXmSJAjeGrSosXsGJdHqHKBTUTRzMveTHBYyJFYRebdebxUEgkochOGcNDJNavwpSsYPHVxijbhvcRGspRHsrZcnGVaHVdZqYNHgJvNPOSSRAILQbqmRJ xECBHNtJIrYnEFhfJsSNztkQvmTPZNPNhOhDozkjjnQcLobsEfiBPuVmwKqStPhqXdSYMisCVGwZfIEEivhqnTFfGOxLBtZFKuuoQyutftpjMFuHnwphllPXlVgJNZpiETfcNltGpgcSnPQinKKEGmvvzAnKbFKUdBuTXiVPRlElTNhpQWOqKXEshOUPLuYpYSGHNvdguZrIoirGERgRicXHnxwsRaaTZnjSTwMAWGnFokNcayauOGWyqGjGJRwq 830385050 -1954525748
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] promptprocessing::logevent_promptprocessingEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event promptprocessingEntitySummaryState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1954525748
    Log    ${output}
    Should Contain X Times    ${output}    === Event promptprocessingEntitySummaryState received =     1
    Should Contain    ${output}    Name : nNzClOGwejXIXTIwhYPQtYEuciGgIirTtprSbreIalPVYLVlscnYLsNrzgsUIUwwUlxfGWtTdZWbTnUqNNHhHXSLEMjeowTdSOSJPrsxEBqfyeLhwFsVvFpGzEnBPcNMFanuWfxbKNxRebmcsMmiSFNnkFmxaflzbioAljzIFBODwrTebRPEZOHbPjRnKcSxnXZWmFjSILnmJjoWFGYhJWnxAjAwZfkPnwmdBYAYKeIcSkWoNZhvBEtcNZmpRFdY
    Should Contain    ${output}    Identifier : 59.3513
    Should Contain    ${output}    Timestamp : tMKgOluQNUKYBvActgoVdwGMqRuTawrPfnIZWBzmGntgztkqBktHwcPjxMiFYpVCuOZGCNSjYuEgLdLIlyXUkexnmQMxKkVzPHUmvzInUIrgMZUbxLWtluYInmzHnkyxhzUAUaeAfZEwqOyQEHpBiueTOAqRuQyAsogVSqmNDdEnsnJeFLXfxGWKMLBOxsrEVorfLYCsCyOJGTtHFZoQxCfnmvmBTFtmYkiRwizOaLkbTRkziLuNVnGmAqTNUsjo
    Should Contain    ${output}    Address : 2078045365
    Should Contain    ${output}    CurrentState : LrsFMOlDPpxWwXZQEQjreTFWfKXXWZlRCjyDxgjdXmJTxABVhVjHKIaKUpTsuiWlrqiYIqOKhMovepCdJfljUIqZrXiDpSsSOhTbrwEAXNcGZGYGndUGjadKRxxmIAcefVhiufButxhknUICfEHzUDZiVXSqbjFDAYMdfZtavYuYseRDbmKgYoDVTBiPbsEOgnXgqhuwvSNuRYKCideqJyZYhNPAqRCOazpgKHgIaqabplYJgIwNgIXMyzVWOGdm
    Should Contain    ${output}    PreviousState : sIEpyuROjBXBLqBDrlKQnazbcWwZeeSQCehWQWmQUxEeEhnrznVoiqfCPQIUcQbVmZBcFWgSZrXCFIqdJuGapWyPdDGiDkVDObKaLhmMDmisYGkNEroPDoQdtTgnVniZbMtOQvgiVjlfeRhTLmLAAARrnyjxcqPYOvIPqtKRaplkCnwRpKhCPQykdMRXKqDGLBCbPVaMnxgivfoQjNxudHTRXfqRUuKMJnQFBuOBofHMIujLjKxHtqBUvFDHtGDf
    Should Contain    ${output}    Executing : HkAPIMqmKDcQrSsMGlerCVpIKYoXdnGfHMGqGGQMAWimXLIaFpNbsOZpAmuLCvUFVJQBQZTJBblqHJEjVEozllKOOKiXTewyXunIpqARCiknSakdJvKdPSmxwMaOkCKAHNraNLLgyIsdKZJuffDLGeOHkjgKhHFTgBsLnfPUScmsSNTDzfliTYvvijoLaZVTDetoibeNDbqnehAcmdKTDwfohvJKYpMfhnImwyYTFPYwYVZugkawJlwnAyrwsYox
    Should Contain    ${output}    CommandsAvailable : vXrXBrzBzXEhnsTQICIEVTodgJldjbCmCZZLRyCpjIEQTRXuuhotukBUwNNmkwJsAWPzaaXCpyMfwbireNcCwEnnEOHzZJCoCHsoNMcGuZIawhGyyniMOAXCKueOAuRrOYFtisNIOiBCXmSJAjeGrSosXsGJdHqHKBTUTRzMveTHBYyJFYRebdebxUEgkochOGcNDJNavwpSsYPHVxijbhvcRGspRHsrZcnGVaHVdZqYNHgJvNPOSSRAILQbqmRJ
    Should Contain    ${output}    ConfigurationsAvailable : xECBHNtJIrYnEFhfJsSNztkQvmTPZNPNhOhDozkjjnQcLobsEfiBPuVmwKqStPhqXdSYMisCVGwZfIEEivhqnTFfGOxLBtZFKuuoQyutftpjMFuHnwphllPXlVgJNZpiETfcNltGpgcSnPQinKKEGmvvzAnKbFKUdBuTXiVPRlElTNhpQWOqKXEshOUPLuYpYSGHNvdguZrIoirGERgRicXHnxwsRaaTZnjSTwMAWGnFokNcayauOGWyqGjGJRwq
    Should Contain    ${output}    priority : 830385050
    Should Contain    ${output}    priority : -1954525748
