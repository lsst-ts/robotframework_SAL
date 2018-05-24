*** Settings ***
Documentation    AtCamera_endOfImageTelemetry sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atcamera
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send QGVOguvHgGWaTsnMazPyRpwyrWLmZdBeeBgxpvCzPbYoJogjEbpiydhejtVRZGQLEldRYmXwfDGjUZRRrkDFtfGyipbJzZjYlvVDwWtZuODpVzPwjvifDtBybMLLpbSISTdtLEcPWJzoNspmGuNZNcmPKLnAXTwkFAjKZKMSojbkHNmAzxjzzkgulFAyUSVYjjJrWnqmEflUsojMAvqZktkwiZWnYrRGZgltLAzWpvLTNNjQYybKxbZGlhRrIHDV 424703374 hnxgvfNvvmdufzMLantXgpjbWxhSIpaZrdlZmojlJMvyjrUWawBfltZGafujQLKtFKZaqZFlMIMzroOKrtqJWTTzJEqvYLspnriQMqQAYkCzIEELUlySXOweWDxtUNyGCdRTjGPVjtuKcpIZGbAxFiDHKVvrWNmlsEGzTotivAUJNZjxXJliIMyYZikqVaAknjfTgKQHeGBErQHaRNfwQXXaUEDtlTFAZJFhZzWQyxapZhbNKmjreKNhrMEbhogm 114742791 12.8187 95.1061 1089092283
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atcamera::logevent_endOfImageTelemetry writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event endOfImageTelemetry generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1089092283
    Log    ${output}
    Should Contain X Times    ${output}    === Event endOfImageTelemetry received =     1
    Should Contain    ${output}    imageSequenceName : QGVOguvHgGWaTsnMazPyRpwyrWLmZdBeeBgxpvCzPbYoJogjEbpiydhejtVRZGQLEldRYmXwfDGjUZRRrkDFtfGyipbJzZjYlvVDwWtZuODpVzPwjvifDtBybMLLpbSISTdtLEcPWJzoNspmGuNZNcmPKLnAXTwkFAjKZKMSojbkHNmAzxjzzkgulFAyUSVYjjJrWnqmEflUsojMAvqZktkwiZWnYrRGZgltLAzWpvLTNNjQYybKxbZGlhRrIHDV
    Should Contain    ${output}    imagesInSequence : 424703374
    Should Contain    ${output}    imageName : hnxgvfNvvmdufzMLantXgpjbWxhSIpaZrdlZmojlJMvyjrUWawBfltZGafujQLKtFKZaqZFlMIMzroOKrtqJWTTzJEqvYLspnriQMqQAYkCzIEELUlySXOweWDxtUNyGCdRTjGPVjtuKcpIZGbAxFiDHKVvrWNmlsEGzTotivAUJNZjxXJliIMyYZikqVaAknjfTgKQHeGBErQHaRNfwQXXaUEDtlTFAZJFhZzWQyxapZhbNKmjreKNhrMEbhogm
    Should Contain    ${output}    imageIndex : 114742791
    Should Contain    ${output}    timeStamp : 12.8187
    Should Contain    ${output}    exposureTime : 95.1061
    Should Contain    ${output}    priority : 1089092283
