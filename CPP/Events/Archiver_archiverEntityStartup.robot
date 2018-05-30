*** Settings ***
Documentation    Archiver_archiverEntityStartup communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    archiver
${component}    archiverEntityStartup
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send NrYdZaBqhBznpNgeOIKuBwoloMOtsQQVcvFWvByjkIVgbUtsxbdxWeoUVLeiJJouhFYIBSptGjlEYuJMRTLJmbOFBNmpeLZXwROTfAXUlABGLDxFcpMlRwBxcKyWKzIV 81.0536 osPvaxLoqqRtLlSJXhwjzLmGmIGhgybAqHmSvFcDbTGwmUqzSdyRKVvnftIjcKxlKhYymKuRaQyWDiGWVBGWNYCdUhrNLFqMeslRXbGSfiGgVgiSPRutehaWhctLcpuzBDvVNafaNjfygOKNJDKheIREJQeNwbmvAAwpePOEetxDZvWVqsJrQmMaLMJpDvxqWtnLrMvEmqgudGWdkMLsVFURkUdQjlcFrPBCKDcbSxkkJzOmNgYSSzFpbAJmNVJU -566932974 982816377
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] archiver::logevent_archiverEntityStartup writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event archiverEntityStartup generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 982816377
    Log    ${output}
    Should Contain X Times    ${output}    === Event archiverEntityStartup received =     1
    Should Contain    ${output}    Name : NrYdZaBqhBznpNgeOIKuBwoloMOtsQQVcvFWvByjkIVgbUtsxbdxWeoUVLeiJJouhFYIBSptGjlEYuJMRTLJmbOFBNmpeLZXwROTfAXUlABGLDxFcpMlRwBxcKyWKzIV
    Should Contain    ${output}    Identifier : 81.0536
    Should Contain    ${output}    Timestamp : osPvaxLoqqRtLlSJXhwjzLmGmIGhgybAqHmSvFcDbTGwmUqzSdyRKVvnftIjcKxlKhYymKuRaQyWDiGWVBGWNYCdUhrNLFqMeslRXbGSfiGgVgiSPRutehaWhctLcpuzBDvVNafaNjfygOKNJDKheIREJQeNwbmvAAwpePOEetxDZvWVqsJrQmMaLMJpDvxqWtnLrMvEmqgudGWdkMLsVFURkUdQjlcFrPBCKDcbSxkkJzOmNgYSSzFpbAJmNVJU
    Should Contain    ${output}    Address : -566932974
    Should Contain    ${output}    priority : 982816377
