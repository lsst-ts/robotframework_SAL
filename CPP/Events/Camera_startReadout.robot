*** Settings ***
Documentation    Camera_startReadout communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    camera
${component}    startReadout
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send AuhfcvoncEJnyURdlJBuSHPEfIQOmpqNbaOqAhKaCFhqTlvkMnACjRgQYqiuONODNCxHzQiEPKfuBhFurCkCSUNLFLbmOuebNrRBssMfhaqOkJahRSdvkTSvVbHuxFtzKyWpVrKyIxfQNbUSWWQeWMOjizwrLBwHElTvJeMpsTtjnBKXkZhyJVfrxxMISzHEnymYJUvIjmWCCnriXHHjyCuadSgpwoJqLMjVlHVxzNLuJgkiGaiTEZntEOUhwizU NzMViqkpQKugjAfxCgTztGluKPZaVzgAOYGKeBPXibRpoNdaNcMwkVHLNTJrtjVXflmAMotuACCRjRbkSrNPxHaDVxqWQJogBXFwUaHLPZiMXAlZNVdLeQdshnMPtPqPyScFtFvJIqzQXhTWrGRInjcpfktbUyxEIywPdHnZeNdCvjWJzlLoQjlnmFCcVGZKAIlNAOxDGcwmHIEbYAldGZtluSgDVEOYphUxbuTNSuQSIwssiUGshHkjsnuyOvWL 1558444824 47.6288 36.5079 -584613989
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] camera::logevent_startReadout writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event startReadout generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -584613989
    Log    ${output}
    Should Contain X Times    ${output}    === Event startReadout received =     1
    Should Contain    ${output}    imageSequenceName : AuhfcvoncEJnyURdlJBuSHPEfIQOmpqNbaOqAhKaCFhqTlvkMnACjRgQYqiuONODNCxHzQiEPKfuBhFurCkCSUNLFLbmOuebNrRBssMfhaqOkJahRSdvkTSvVbHuxFtzKyWpVrKyIxfQNbUSWWQeWMOjizwrLBwHElTvJeMpsTtjnBKXkZhyJVfrxxMISzHEnymYJUvIjmWCCnriXHHjyCuadSgpwoJqLMjVlHVxzNLuJgkiGaiTEZntEOUhwizU
    Should Contain    ${output}    imageName : NzMViqkpQKugjAfxCgTztGluKPZaVzgAOYGKeBPXibRpoNdaNcMwkVHLNTJrtjVXflmAMotuACCRjRbkSrNPxHaDVxqWQJogBXFwUaHLPZiMXAlZNVdLeQdshnMPtPqPyScFtFvJIqzQXhTWrGRInjcpfktbUyxEIywPdHnZeNdCvjWJzlLoQjlnmFCcVGZKAIlNAOxDGcwmHIEbYAldGZtluSgDVEOYphUxbuTNSuQSIwssiUGshHkjsnuyOvWL
    Should Contain    ${output}    imageIndex : 1558444824
    Should Contain    ${output}    timeStamp : 47.6288
    Should Contain    ${output}    exposureTime : 36.5079
    Should Contain    ${output}    priority : -584613989
