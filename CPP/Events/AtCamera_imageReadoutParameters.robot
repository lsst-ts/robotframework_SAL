*** Settings ***
Documentation    AtCamera_imageReadoutParameters sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atcamera
${component}    imageReadoutParameters
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send yCgQkIzgxzOKtMqRctqIWALTqfOFQRDxvMUScZUpGmJgErIpORpUyrZJvgfyLNXPnZoOLpXZJKkkwsOeSVJWhzOWqJsWnpZyZKjlbhogliZyGfiDnlqrqxojpytyfuRPFALixpIlsUswSqXpdNABbIbqweKhHTmLHrAFYHcFJVSroeAYjQQhpqflGmubkViZartboXtBkUTWrPWxVDSolxTApouYEnajXPiGlRhtcvxuYwUJehTMfgOHbZfWtoMc ZDptXFLvbiSSdXmNoUpbuqhJZgxTkHZHnQgxySFkQYHrzRZWNBEwfwEKSnuXXqiyedqfpkqmNuXPPKQOVhDhHGccgKjJoBndGoesLEcEgWcUgePZIAjmNwPIWgYQEewbSDgNsfOUPVugMGkgADTLaPNACYZhgvCOmsitzOxTmmheRzDFrQEfBeBgqiWrWCQQTWfBXwjBEXrSXJOBqWXIEECPYhuquVZREBGFuWsboZaXyocaNBlPoMItNnCpnQbv -2129815922 -908319332 1913027075 845192393 201580622 1233277356 1294467141 -1791599361 338345840 -1428333364
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atcamera::logevent_imageReadoutParameters writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event imageReadoutParameters generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1428333364
    Log    ${output}
    Should Contain X Times    ${output}    === Event imageReadoutParameters received =     1
    Should Contain    ${output}    imageName : yCgQkIzgxzOKtMqRctqIWALTqfOFQRDxvMUScZUpGmJgErIpORpUyrZJvgfyLNXPnZoOLpXZJKkkwsOeSVJWhzOWqJsWnpZyZKjlbhogliZyGfiDnlqrqxojpytyfuRPFALixpIlsUswSqXpdNABbIbqweKhHTmLHrAFYHcFJVSroeAYjQQhpqflGmubkViZartboXtBkUTWrPWxVDSolxTApouYEnajXPiGlRhtcvxuYwUJehTMfgOHbZfWtoMc
    Should Contain    ${output}    ccdNames : ZDptXFLvbiSSdXmNoUpbuqhJZgxTkHZHnQgxySFkQYHrzRZWNBEwfwEKSnuXXqiyedqfpkqmNuXPPKQOVhDhHGccgKjJoBndGoesLEcEgWcUgePZIAjmNwPIWgYQEewbSDgNsfOUPVugMGkgADTLaPNACYZhgvCOmsitzOxTmmheRzDFrQEfBeBgqiWrWCQQTWfBXwjBEXrSXJOBqWXIEECPYhuquVZREBGFuWsboZaXyocaNBlPoMItNnCpnQbv
    Should Contain    ${output}    ccdType : -2129815922
    Should Contain    ${output}    overRows : -908319332
    Should Contain    ${output}    overCols : 1913027075
    Should Contain    ${output}    readRows : 845192393
    Should Contain    ${output}    readCols : 201580622
    Should Contain    ${output}    readCols2 : 1233277356
    Should Contain    ${output}    preCols : 1294467141
    Should Contain    ${output}    preRows : -1791599361
    Should Contain    ${output}    postCols : 338345840
    Should Contain    ${output}    priority : -1428333364
