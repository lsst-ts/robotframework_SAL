*** Settings ***
Documentation    Sequencer_sequencerScriptError sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    sequencer
${component}    sequencerScriptError
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send QYHNABeDJARKyOTMNDsiUzTBhNIMvHBJleQGEgKnzxeNVqpryvIAPEDfegzGSPYySRaHviZKayhqvsKImSAwhunvDRVwKbGKpIpNSXuavHaoGShbqBOiFypHAaVaQxYJKFOgYbpJzwKUbYhppTjTnyMQFdkROfoLKfwfCztpPMttxxXyyNyJDEzNhTvRKZpmvbFlKEQOiWpzIiAWqmlSMvQjXgzrRVmEaPBuifhEbtANKpvOtwAziMxDeoSvUTNe 76.0025 EsbnuSbZxfeHwBseFactosRuDZpfKeTNTTCKqBtPUcUyeUcMhOsgjLswjOWRmhDhnYGdwxjLxuwDRxbFYjqYkuTvjwexZleQtAIhNNzZvVonjgRBsCglpuNgqcghFzDgSfdgZduXgFNZlpGicvlNcymoHTOLjaDJCowxVIJTjRiORFuvBLbaKbfRPeplXJGhkWFwNriEfVpbWOJEsazuwsLAYcrOjIMSWvmXkMXzbISbuUNXJwgfeQjtWUvrbOHu -1801222606 -1423614410 tSLwJfKXAgrVTRCECLqkMEibBOXDpoAdntWePfTrFljsdJhJScQWMJZbBYXNvRlziPZAWEnuNprTipONZWYLmaNFiVGViGWtTFUBGsOOXGsnXkhduizgNoXgdkJOaytqFcDsdMZWnjENdUXglRctHKHJkYlpVBGIYQJSvCNgKWUzTnQWASYtDFhcZBvMnzpEAdDmlHbCwZGjJKckFMaInwqnYOtDIlUKbuQrBotJkAtmLCPtJOPaMKdxskJevAzL -5611117
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] sequencer::logevent_sequencerScriptError writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event sequencerScriptError generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -5611117
    Log    ${output}
    Should Contain X Times    ${output}    === Event sequencerScriptError received =     1
    Should Contain    ${output}    sequencerScriptName : QYHNABeDJARKyOTMNDsiUzTBhNIMvHBJleQGEgKnzxeNVqpryvIAPEDfegzGSPYySRaHviZKayhqvsKImSAwhunvDRVwKbGKpIpNSXuavHaoGShbqBOiFypHAaVaQxYJKFOgYbpJzwKUbYhppTjTnyMQFdkROfoLKfwfCztpPMttxxXyyNyJDEzNhTvRKZpmvbFlKEQOiWpzIiAWqmlSMvQjXgzrRVmEaPBuifhEbtANKpvOtwAziMxDeoSvUTNe
    Should Contain    ${output}    sequencerScriptIdentifier : 76.0025
    Should Contain    ${output}    sequencerScriptTimestamp : EsbnuSbZxfeHwBseFactosRuDZpfKeTNTTCKqBtPUcUyeUcMhOsgjLswjOWRmhDhnYGdwxjLxuwDRxbFYjqYkuTvjwexZleQtAIhNNzZvVonjgRBsCglpuNgqcghFzDgSfdgZduXgFNZlpGicvlNcymoHTOLjaDJCowxVIJTjRiORFuvBLbaKbfRPeplXJGhkWFwNriEfVpbWOJEsazuwsLAYcrOjIMSWvmXkMXzbISbuUNXJwgfeQjtWUvrbOHu
    Should Contain    ${output}    sequencerScriptLineNumber : -1801222606
    Should Contain    ${output}    sequencerScriptErrorCode : -1423614410
    Should Contain    ${output}    sequencerScriptErrorText : tSLwJfKXAgrVTRCECLqkMEibBOXDpoAdntWePfTrFljsdJhJScQWMJZbBYXNvRlziPZAWEnuNprTipONZWYLmaNFiVGViGWtTFUBGsOOXGsnXkhduizgNoXgdkJOaytqFcDsdMZWnjENdUXglRctHKHJkYlpVBGIYQJSvCNgKWUzTnQWASYtDFhcZBvMnzpEAdDmlHbCwZGjJKckFMaInwqnYOtDIlUKbuQrBotJkAtmLCPtJOPaMKdxskJevAzL
    Should Contain    ${output}    priority : -5611117
