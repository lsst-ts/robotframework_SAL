*** Settings ***
Documentation    PromptProcessing_promptprocessingEntityStartup sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    promptProcessing
${component}    promptprocessingEntityStartup
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send kmNIVhtWzFevQxVlIqcBfUzDLuEisEHTOJSoShFouHUArswZFSuRbpJdobVvSLoSrcOGIDSjXlcwqzwirxUWQXfbUaECaPYMkjGDaUjTyLORrTsGSiZfBCPqCaoPGXkeCHknGsEaUQNLZwMZRbvCuHZPEeAGtWXDHWFBoUzJouMzRYlAwYaUkwgfnvOKFaEdHujiPVribGfOubtgloxAcAFgHcBvmoSsDtlytrwAjCCeYwlVlUgsJNzGZuOAMIAM 19.3689 SjHNMmKsNnUgExHDChlGfdiyfCwBDItoVvrpVHyWaDaVunuOEyzveugcRBlSryaBSrcRFpgyxUFvIlNTWjflDbHfgPVTkccjHIQGdOYEtgFdFXsJJnAIUgtTDVEdLbhqKuViJjrogFzHSdXvZVkBJDwarFmrJFQVNFlIimCLpSLuttDuPBdmWpZOVgTdPmrGhodVEmiGmXFsTxMJqiYmRQwVvNWvghccHCVUnCQkgxxMBypGzyxTWVNgCICvvPwT 508541052 669472843 -43933544
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] promptProcessing::logevent_promptprocessingEntityStartup writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event promptprocessingEntityStartup generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -43933544
    Log    ${output}
    Should Contain X Times    ${output}    === Event promptprocessingEntityStartup received =     1
    Should Contain    ${output}    Name : kmNIVhtWzFevQxVlIqcBfUzDLuEisEHTOJSoShFouHUArswZFSuRbpJdobVvSLoSrcOGIDSjXlcwqzwirxUWQXfbUaECaPYMkjGDaUjTyLORrTsGSiZfBCPqCaoPGXkeCHknGsEaUQNLZwMZRbvCuHZPEeAGtWXDHWFBoUzJouMzRYlAwYaUkwgfnvOKFaEdHujiPVribGfOubtgloxAcAFgHcBvmoSsDtlytrwAjCCeYwlVlUgsJNzGZuOAMIAM
    Should Contain    ${output}    Identifier : 19.3689
    Should Contain    ${output}    Timestamp : SjHNMmKsNnUgExHDChlGfdiyfCwBDItoVvrpVHyWaDaVunuOEyzveugcRBlSryaBSrcRFpgyxUFvIlNTWjflDbHfgPVTkccjHIQGdOYEtgFdFXsJJnAIUgtTDVEdLbhqKuViJjrogFzHSdXvZVkBJDwarFmrJFQVNFlIimCLpSLuttDuPBdmWpZOVgTdPmrGhodVEmiGmXFsTxMJqiYmRQwVvNWvghccHCVUnCQkgxxMBypGzyxTWVNgCICvvPwT
    Should Contain    ${output}    Address : 508541052
    Should Contain    ${output}    priority : 669472843
    Should Contain    ${output}    priority : -43933544
