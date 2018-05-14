*** Settings ***
Documentation    Sequencer_sequencerEntityShutdown sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    sequencer
${component}    sequencerEntityShutdown
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send JSmtgWVSRaMIcXeWYOYwyqnuHefGHqDbrOkPkRFdIyMvheLWfyeKiaCTQXeGbaRWwEiMxIZDpOlpOVxkjIcyaQfxSyARJaRRCvGlZbQVKCgSODQHuzFqInuJNzsgkyJO 84.8746 hoDHsuLhivzxjbFMrHqjzlXlQaQfSIpJVSZJqGhHBPnMOIniyTsKXMjMvgjkZnIaVWMjajwUfRNyXKrVQSMkYoTYdnhpAUZHgaDtdMAjkvkUdXyQnSwAwDAcOzhldKguFpBoenLVUVpiiAdNOXEbBkEcqnjupfexbJlUrQpYiBliAvbmGuthftgmZlNhKHuBtCttLnbHQFygVxBsYVNNIrjrkQHzLhbZiIgWaTuRsRaaeohsuvqNjulCvqBDVdYb -1511875848 -867711763
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] sequencer::logevent_sequencerEntityShutdown writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event sequencerEntityShutdown generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -867711763
    Log    ${output}
    Should Contain X Times    ${output}    === Event sequencerEntityShutdown received =     1
    Should Contain    ${output}    Name : JSmtgWVSRaMIcXeWYOYwyqnuHefGHqDbrOkPkRFdIyMvheLWfyeKiaCTQXeGbaRWwEiMxIZDpOlpOVxkjIcyaQfxSyARJaRRCvGlZbQVKCgSODQHuzFqInuJNzsgkyJO
    Should Contain    ${output}    Identifier : 84.8746
    Should Contain    ${output}    Timestamp : hoDHsuLhivzxjbFMrHqjzlXlQaQfSIpJVSZJqGhHBPnMOIniyTsKXMjMvgjkZnIaVWMjajwUfRNyXKrVQSMkYoTYdnhpAUZHgaDtdMAjkvkUdXyQnSwAwDAcOzhldKguFpBoenLVUVpiiAdNOXEbBkEcqnjupfexbJlUrQpYiBliAvbmGuthftgmZlNhKHuBtCttLnbHQFygVxBsYVNNIrjrkQHzLhbZiIgWaTuRsRaaeohsuvqNjulCvqBDVdYb
    Should Contain    ${output}    Address : -1511875848
    Should Contain    ${output}    priority : -867711763
