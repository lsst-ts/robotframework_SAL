*** Settings ***
Documentation    Camera_endOfImageTelemetry sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    camera
${component}    endOfImageTelemetry
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send IchhzLGUDOybImpTTNdMRVPfUwhftknJnDvDwwvMivbFNDeQymCpkCBnxQWMghwHmLXQldvCNUHWhPDSogriWrHqooSFjPshEgVXClNhkDQBEsNQappvMthJqCnQVToWbAMPzjwyhpTejTNZYyxPlrCjJkUoeUWEAjwHXbbOIOYBHkjyIfoqLiJFvjezudlBAzWIxVELFdVilsQMUownzpMJREXhSBCFJITOgGcDYndKXXgAHemyuHGRaGmCAMsA BizMrKQqkptNYllggnymucyLFIIHQTSbKwOVhAEiqQbyJrWOqAvExtixtZbNsxEUpKAGkdvBkowdhMRvXlvFhidmZFJKAkRtvzOXFvLVYjAGQjBQCREQDoDnZrWvFunrynJRoiTHsXrtueVsUuvZOMEAxBpCmaJCbkzrCGapyWStBYaTEBWcigdLxMohPNCWiQWoJalQrpcZkZxULFJYOqHYTkTaKfasMrEYChbXJUNRuLdYDgTFZkEHxhgojJRv -857065005 77.5009 49.1645 1810596261
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] camera::logevent_endOfImageTelemetry writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event endOfImageTelemetry generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1810596261
    Log    ${output}
    Should Contain X Times    ${output}    === Event endOfImageTelemetry received =     1
    Should Contain    ${output}    imageSequenceName : IchhzLGUDOybImpTTNdMRVPfUwhftknJnDvDwwvMivbFNDeQymCpkCBnxQWMghwHmLXQldvCNUHWhPDSogriWrHqooSFjPshEgVXClNhkDQBEsNQappvMthJqCnQVToWbAMPzjwyhpTejTNZYyxPlrCjJkUoeUWEAjwHXbbOIOYBHkjyIfoqLiJFvjezudlBAzWIxVELFdVilsQMUownzpMJREXhSBCFJITOgGcDYndKXXgAHemyuHGRaGmCAMsA
    Should Contain    ${output}    imageName : BizMrKQqkptNYllggnymucyLFIIHQTSbKwOVhAEiqQbyJrWOqAvExtixtZbNsxEUpKAGkdvBkowdhMRvXlvFhidmZFJKAkRtvzOXFvLVYjAGQjBQCREQDoDnZrWvFunrynJRoiTHsXrtueVsUuvZOMEAxBpCmaJCbkzrCGapyWStBYaTEBWcigdLxMohPNCWiQWoJalQrpcZkZxULFJYOqHYTkTaKfasMrEYChbXJUNRuLdYDgTFZkEHxhgojJRv
    Should Contain    ${output}    imageIndex : -857065005
    Should Contain    ${output}    timeStamp : 77.5009
    Should Contain    ${output}    exposureTime : 49.1645
    Should Contain    ${output}    priority : 1810596261
