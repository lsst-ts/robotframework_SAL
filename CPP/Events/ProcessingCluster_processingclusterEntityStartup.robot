*** Settings ***
Documentation    ProcessingCluster_processingclusterEntityStartup sender/logger tests.
Force Tags    cpp
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    processingcluster
${component}    processingclusterEntityStartup
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send ahImyyMTBhBTCKdmGGsrgmbExlyDAcjbgFoegJNqXliOBYMrdnevOEmEtUctyXgBcujtKznxsWaMTWigkDABwAIcamwsTRWHsGfDPjIKEodfkFYThKIUYNTWQAVnKWvg 45.9693 XYWjcugdVuyAxJBWMKErHdjQbZWxpkbUURsagwfGeOIsNiaHwSrfGmGgxBZYQSdaatSAsRZoSeagbpcPVDxOsvEVFPyzLQxHhbWBcSvYYHZQHlprVYpEBCGbnpKsKeCSSanJIxDyTgjsQsNRhIddhqAvCaYfDAhFtwjJscZZrrditHYGQmDeXGknLNvkdSmNxjFUiTQWSZtcCefFjVNjaVMJumQEBoRfeTQHyEXeMHBrTnZSsRAdcbrJtdBoknsb 2136422836 2128493125
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] processingcluster::logevent_processingclusterEntityStartup writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event processingclusterEntityStartup generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 2128493125
    Log    ${output}
    Should Contain X Times    ${output}    === Event processingclusterEntityStartup received =     1
    Should Contain    ${output}    Name : ahImyyMTBhBTCKdmGGsrgmbExlyDAcjbgFoegJNqXliOBYMrdnevOEmEtUctyXgBcujtKznxsWaMTWigkDABwAIcamwsTRWHsGfDPjIKEodfkFYThKIUYNTWQAVnKWvg
    Should Contain    ${output}    Identifier : 45.9693
    Should Contain    ${output}    Timestamp : XYWjcugdVuyAxJBWMKErHdjQbZWxpkbUURsagwfGeOIsNiaHwSrfGmGgxBZYQSdaatSAsRZoSeagbpcPVDxOsvEVFPyzLQxHhbWBcSvYYHZQHlprVYpEBCGbnpKsKeCSSanJIxDyTgjsQsNRhIddhqAvCaYfDAhFtwjJscZZrrditHYGQmDeXGknLNvkdSmNxjFUiTQWSZtcCefFjVNjaVMJumQEBoRfeTQHyEXeMHBrTnZSsRAdcbrJtdBoknsb
    Should Contain    ${output}    Address : 2136422836
    Should Contain    ${output}    priority : 2128493125
