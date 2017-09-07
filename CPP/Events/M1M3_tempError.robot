*** Settings ***
Documentation    M1M3_tempError sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    tempError
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send yanaoBDWShespwegEJNvLieiAJhLqfwwjYGMdVQWNSQEzvSzkZhNMHWgzQcIPdeTbxaJqwKeLLwtbspPyEqhCzqaNVcQCdwgSBBwZUEQSsTZAGwhyXCHQwKMwEGhrhpZNXechSNzqzROpBwtAtxNMBakoIWxhHjlgGulfrVhAmduhVuCrCArRQxlRgYVGPAnofYIOzdBcMcxuvSDytaWLhnUDnFsmTSyGUTLjsYJPWLgrTrlHHdmGFjgXcPvddxIWtecVctJHtqVfiCPviBuboDJPkGGBceDpltlgrMAxEPgZPHtKtFeKsJtOaPUwLhnirfpodIJpZpyCfDyxOTSUkWmTdswYwNexQBUxaTVubpoPPnMRgXrtNhLjrYoTnafCRKBeNVshktLXiVWbAdzedjkhMSMSBWzbFDDQOLencQCdMxXiHZUwmxgNmvItlSEUSDBkscLqdolGHYNlhsBITebTyFbbyLVcCmesvdlLGAmxLXSVDdUDzflQyTFUdpuZENrxpyTVFgcBVUbFqTpbdwehLEgSecRiACvKREFZvhmxVNKkcNIIKPFkBmYFDdESkvgyjXuRPFzNRCNadPiMhOleENzkrwSvmhvYfiXLHXmVArvqbOUhzsgAdLyoHldxsSlpyXWeaFgjrpEGKTFtcgWQNerFOnbRYUJfUQHWISDvbhdjBzjNKJiFVgQvEkzCJkiwhrUYqaMidoTtDSdbIIUCFRgbAelgyXQCwwEtuYoEgCNNGvxrOHVodTgxqoUPUaAlcQsSXGcsEQRxUaxlVyOpStEYQKaHvTDjmeAcLopXSBjQQaDvWWrsvZatQQgbSlmIKIDXaYWdtNBkgnbh 1645224796 42.4732 -545006460
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_tempError writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event tempError generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -545006460
    Log    ${output}
    Should Contain X Times    ${output}    === Event tempError received =     1
    Should Contain    ${output}    device : yanaoBDWShespwegEJNvLieiAJhLqfwwjYGMdVQWNSQEzvSzkZhNMHWgzQcIPdeTbxaJqwKeLLwtbspPyEqhCzqaNVcQCdwgSBBwZUEQSsTZAGwhyXCHQwKMwEGhrhpZNXechSNzqzROpBwtAtxNMBakoIWxhHjlgGulfrVhAmduhVuCrCArRQxlRgYVGPAnofYIOzdBcMcxuvSDytaWLhnUDnFsmTSyGUTLjsYJPWLgrTrlHHdmGFjgXcPvddxIWtecVctJHtqVfiCPviBuboDJPkGGBceDpltlgrMAxEPgZPHtKtFeKsJtOaPUwLhnirfpodIJpZpyCfDyxOTSUkWmTdswYwNexQBUxaTVubpoPPnMRgXrtNhLjrYoTnafCRKBeNVshktLXiVWbAdzedjkhMSMSBWzbFDDQOLencQCdMxXiHZUwmxgNmvItlSEUSDBkscLqdolGHYNlhsBITebTyFbbyLVcCmesvdlLGAmxLXSVDdUDzflQyTFUdpuZENrxpyTVFgcBVUbFqTpbdwehLEgSecRiACvKREFZvhmxVNKkcNIIKPFkBmYFDdESkvgyjXuRPFzNRCNadPiMhOleENzkrwSvmhvYfiXLHXmVArvqbOUhzsgAdLyoHldxsSlpyXWeaFgjrpEGKTFtcgWQNerFOnbRYUJfUQHWISDvbhdjBzjNKJiFVgQvEkzCJkiwhrUYqaMidoTtDSdbIIUCFRgbAelgyXQCwwEtuYoEgCNNGvxrOHVodTgxqoUPUaAlcQsSXGcsEQRxUaxlVyOpStEYQKaHvTDjmeAcLopXSBjQQaDvWWrsvZatQQgbSlmIKIDXaYWdtNBkgnbh
    Should Contain    ${output}    severity : 1645224796
    Should Contain    ${output}    temp : 42.4732
    Should Contain    ${output}    priority : -545006460
