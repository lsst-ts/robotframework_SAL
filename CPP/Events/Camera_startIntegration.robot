*** Settings ***
Documentation    Camera_startIntegration communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    camera
${component}    startIntegration
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send ALIczWJPnnHPIMYkBfGSRUQjkiqjKKzdBRpZPcUEpCLJPTkkcphtxYSUiCEZZSSJWyeFwTWNVEHhFGqVkoIxZADwzrKfDLPRxyNfrebHYGQRSeHTyfUoArLicGTiAMthxtZfhBhqHxiHJrkWmlZcgRCapGhEVbPpRDUlzfRSDRMUbnthyOahfcKwbcjbJNAzxzMtqStyXEXtjiMoGpkdmYuSwgUaSxdAqXALJXRTFipeaqnSDYPCvWbNTtvsQUcS dqzrcGabJsBjMfCzOQdUnAKufHiQUklyfIXncIiUqVCsAaBGHgxcwwMjLsDvHPgWOuSpQgaclRXpixRgYsbVfKhZkoFhVwEHQYsJdaHWFAuIrfFjjdmyuGgnLTfFUuhoFsAJcJvBlXeGIVgHOEYIsRiRItFySXNUfRElLdWXwnBjLTRKLPzJAIJLDAwQzGjFDzWqomWyCbUOcYYmJVsKQcmfRKOUmGofmOqbMqgaUbzIHNwtADQTrCnVsnImRMwj -1163888444 83.7856 94.5452 -930839850
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] camera::logevent_startIntegration writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event startIntegration generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -930839850
    Log    ${output}
    Should Contain X Times    ${output}    === Event startIntegration received =     1
    Should Contain    ${output}    imageSequenceName : ALIczWJPnnHPIMYkBfGSRUQjkiqjKKzdBRpZPcUEpCLJPTkkcphtxYSUiCEZZSSJWyeFwTWNVEHhFGqVkoIxZADwzrKfDLPRxyNfrebHYGQRSeHTyfUoArLicGTiAMthxtZfhBhqHxiHJrkWmlZcgRCapGhEVbPpRDUlzfRSDRMUbnthyOahfcKwbcjbJNAzxzMtqStyXEXtjiMoGpkdmYuSwgUaSxdAqXALJXRTFipeaqnSDYPCvWbNTtvsQUcS
    Should Contain    ${output}    imageName : dqzrcGabJsBjMfCzOQdUnAKufHiQUklyfIXncIiUqVCsAaBGHgxcwwMjLsDvHPgWOuSpQgaclRXpixRgYsbVfKhZkoFhVwEHQYsJdaHWFAuIrfFjjdmyuGgnLTfFUuhoFsAJcJvBlXeGIVgHOEYIsRiRItFySXNUfRElLdWXwnBjLTRKLPzJAIJLDAwQzGjFDzWqomWyCbUOcYYmJVsKQcmfRKOUmGofmOqbMqgaUbzIHNwtADQTrCnVsnImRMwj
    Should Contain    ${output}    imageIndex : -1163888444
    Should Contain    ${output}    timeStamp : 83.7856
    Should Contain    ${output}    exposureTime : 94.5452
    Should Contain    ${output}    priority : -930839850
