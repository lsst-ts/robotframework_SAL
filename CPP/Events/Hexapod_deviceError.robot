*** Settings ***
Documentation    Hexapod_deviceError communications tests.
Force Tags    cpp    TSS-2680
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    hexapod
${component}    deviceError
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send NPKXMReCOiyKHiwjXeuZzXHYxvhSiNeSfvhBgcXBDWibnUBOqibtKphLdrBUJJZNoRDcHploaDhSNzSoaZLabkpYKoIbxhZhokdUPxIDpXcgIWcWRkDrrZeCsKXRiLBqrZMRRzZuUhugcIbFspmuasAwAmzTCcyXMVKsMcyTqvhCoVOAuHQtNKCNhZvhFuiuGSudwiSLiVTThUkcslyIAeHJRCpIJlJfZLMcdjsRhPUNIyyqiGGYHmlVxzBjXIjH -1513938393 12.6457 eiLIUrpxyJnTGlkoBfKxxkTdXNZEkladOYlwuPVkwIvoWxZvcGkhTWovTdMjnOfyvECUCWdLKDTOPamXZOsbkURveluJDOMjgdXAyzJgGUFuTpBrizmvOGOBImMmjBFFeHqYsPwgdDydYLvBlBfpJnFQCsENRUMgMFCkrJwOBXBlRqCEDrYYNDzepArkZvszXcMSGBerWGDRKPxwuVUWoOWIgTaYPXJlbgWSrfcSbYBxvmLuRiUBulQuCFNJmYWq -703377478
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] hexapod::logevent_deviceError writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event deviceError generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -703377478
    Log    ${output}
    Should Contain X Times    ${output}    === Event deviceError received =     1
    Should Contain    ${output}    device : NPKXMReCOiyKHiwjXeuZzXHYxvhSiNeSfvhBgcXBDWibnUBOqibtKphLdrBUJJZNoRDcHploaDhSNzSoaZLabkpYKoIbxhZhokdUPxIDpXcgIWcWRkDrrZeCsKXRiLBqrZMRRzZuUhugcIbFspmuasAwAmzTCcyXMVKsMcyTqvhCoVOAuHQtNKCNhZvhFuiuGSudwiSLiVTThUkcslyIAeHJRCpIJlJfZLMcdjsRhPUNIyyqiGGYHmlVxzBjXIjH
    Should Contain    ${output}    severity : -1513938393
    Should Contain    ${output}    timestamp : 12.6457
    Should Contain    ${output}    code : eiLIUrpxyJnTGlkoBfKxxkTdXNZEkladOYlwuPVkwIvoWxZvcGkhTWovTdMjnOfyvECUCWdLKDTOPamXZOsbkURveluJDOMjgdXAyzJgGUFuTpBrizmvOGOBImMmjBFFeHqYsPwgdDydYLvBlBfpJnFQCsENRUMgMFCkrJwOBXBlRqCEDrYYNDzepArkZvszXcMSGBerWGDRKPxwuVUWoOWIgTaYPXJlbgWSrfcSbYBxvmLuRiUBulQuCFNJmYWq
    Should Contain    ${output}    priority : -703377478
