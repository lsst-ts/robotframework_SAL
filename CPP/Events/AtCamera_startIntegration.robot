*** Settings ***
Documentation    AtCamera_startIntegration sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atcamera
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send cSaWuHUzJNOBPbZeaCvCbzMVjwrPcGRHLPprCVSjvKtomSSpNRaSvwQXzjDIkoAMWzyjmVPoDpfWcyofelxGjltIvoyDSwWFJDzaYEzAKfGfZgzhiwJLWZNFfXoXxPmbSucFiApDkJJQbuDumlVchFTUUHtNLImyVlPmkNLJneRpaGiYYaeftRYoGYXytmHLyfBQJjQbJqKCIxsfSSvDGzipUpLuxwAfpLzgpInTpwHbywcFJImFmeBiAlQroxwk 30658360 HuNFuBLkETXiHeDVWSPefFuvYstXJjqTHnYsfBnGvqTxsWHJOvZEBzEyRivpSsZkXjJvjsvEGPFroHhxUiaLlzAqtpYhOYlBCAgwZWgRgOQkXEttmKhfnGvVlOzGgojNUTfbmgcawOcRKjJIXvXLWaSvNZsZRIpCiyEMHIEEewkUVNVudroRfDAhXLHFuhAgNSTaBKrVTSrEUKnADvdIIyuvSTodofNoVtfeANbnuUfdWdNLufLTzpTgYerFGZsM 979765342 37.5091 9.2417 -1949122334
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atcamera::logevent_startIntegration writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event startIntegration generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1949122334
    Log    ${output}
    Should Contain X Times    ${output}    === Event startIntegration received =     1
    Should Contain    ${output}    imageSequenceName : cSaWuHUzJNOBPbZeaCvCbzMVjwrPcGRHLPprCVSjvKtomSSpNRaSvwQXzjDIkoAMWzyjmVPoDpfWcyofelxGjltIvoyDSwWFJDzaYEzAKfGfZgzhiwJLWZNFfXoXxPmbSucFiApDkJJQbuDumlVchFTUUHtNLImyVlPmkNLJneRpaGiYYaeftRYoGYXytmHLyfBQJjQbJqKCIxsfSSvDGzipUpLuxwAfpLzgpInTpwHbywcFJImFmeBiAlQroxwk
    Should Contain    ${output}    imagesInSequence : 30658360
    Should Contain    ${output}    imageName : HuNFuBLkETXiHeDVWSPefFuvYstXJjqTHnYsfBnGvqTxsWHJOvZEBzEyRivpSsZkXjJvjsvEGPFroHhxUiaLlzAqtpYhOYlBCAgwZWgRgOQkXEttmKhfnGvVlOzGgojNUTfbmgcawOcRKjJIXvXLWaSvNZsZRIpCiyEMHIEEewkUVNVudroRfDAhXLHFuhAgNSTaBKrVTSrEUKnADvdIIyuvSTodofNoVtfeANbnuUfdWdNLufLTzpTgYerFGZsM
    Should Contain    ${output}    imageIndex : 979765342
    Should Contain    ${output}    timeStamp : 37.5091
    Should Contain    ${output}    exposureTime : 9.2417
    Should Contain    ${output}    priority : -1949122334
