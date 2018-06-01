*** Settings ***
Documentation    AtCamera_imageReadoutParameters communications tests.
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send VSyesYXCCcXeezJEfZJABtYbNbWklJgfKiVWQgLGAzrdHVpHwzFXwPoNbGwRSyQudtwUUoZmBeooybvaVdLFJNwQJdnRArFbEKuALcFInvSgpCGNdivNyncIqUeIoMRJqcxfrkYSpdGdqdbZvliXunfQImzLLAEUMKIVkxYjGVupUKKTlKfHgDhrLfhEaLQgfpAYCnahRxzVWuAiGhjrFDFLlhjGRvzsyNBYqIpqElgkuUlAkmiWEwotyaMuavKs WiwPSEAThjvewPXKfFByoTGStZODBTMcQvNLNaJvwdyOSQBWZhodjAlhlYQYYnwFXhBsCKTlFKUrEirIikVKtetMgsCcwHbDFQKcpcSQXPoCgwLIUJZfEUDJQGDlegdZvSuSCsTvFkTcGSdASJHmEeydsGWshuCFimQqTLXxxXrDWQSEWwUllSVnocpeEfCcEytJqbuvSxDkqdoEtqwjFTgKeJLXCIuBdMEVtgVHxJNkrTGEaoERQEdkkKokAQFt -1669678587 -367086083 -515881726 -1580826518 1633131571 56694818 318304861 -1235212735 -2056595189 -20504466
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atcamera::logevent_imageReadoutParameters writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event imageReadoutParameters generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -20504466
    Log    ${output}
    Should Contain X Times    ${output}    === Event imageReadoutParameters received =     1
    Should Contain    ${output}    imageName : VSyesYXCCcXeezJEfZJABtYbNbWklJgfKiVWQgLGAzrdHVpHwzFXwPoNbGwRSyQudtwUUoZmBeooybvaVdLFJNwQJdnRArFbEKuALcFInvSgpCGNdivNyncIqUeIoMRJqcxfrkYSpdGdqdbZvliXunfQImzLLAEUMKIVkxYjGVupUKKTlKfHgDhrLfhEaLQgfpAYCnahRxzVWuAiGhjrFDFLlhjGRvzsyNBYqIpqElgkuUlAkmiWEwotyaMuavKs
    Should Contain    ${output}    ccdNames : WiwPSEAThjvewPXKfFByoTGStZODBTMcQvNLNaJvwdyOSQBWZhodjAlhlYQYYnwFXhBsCKTlFKUrEirIikVKtetMgsCcwHbDFQKcpcSQXPoCgwLIUJZfEUDJQGDlegdZvSuSCsTvFkTcGSdASJHmEeydsGWshuCFimQqTLXxxXrDWQSEWwUllSVnocpeEfCcEytJqbuvSxDkqdoEtqwjFTgKeJLXCIuBdMEVtgVHxJNkrTGEaoERQEdkkKokAQFt
    Should Contain    ${output}    ccdType : -1669678587
    Should Contain    ${output}    overRows : -367086083
    Should Contain    ${output}    overCols : -515881726
    Should Contain    ${output}    readRows : -1580826518
    Should Contain    ${output}    readCols : 1633131571
    Should Contain    ${output}    readCols2 : 56694818
    Should Contain    ${output}    preCols : 318304861
    Should Contain    ${output}    preRows : -1235212735
    Should Contain    ${output}    postCols : -2056595189
    Should Contain    ${output}    priority : -20504466
