*** Settings ***
Documentation    Sequencer_sequencerCommandIssued sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    sequencer
${component}    sequencerCommandIssued
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send TTbDKDRDSEwoXEmVCNPHLHsIuoILwjpXkJWtShYzlhcmqgeOaPbkvYgKGZdsUiWZJrYgJfKWKtnyZaMvGJatlcpNHFxCXUNToWfAcmGnhKuDtVkLENEVIBmeLxMvEJzSWwtMXqCHUJoQuMXkIXHFFzOZmAnfpsWejNzElKhlyizdwaSFjdCtcxclrykmZwuXkbJNKOKkBlalCGkpPeAqfNQMVfbgRPmWEuuieGTVKSiphAfmmeMyZRouLBbYjDXf 826525035 41.4476 dAXYOiOSZLRPswWLQXfqyinBqWVmDWZIGaSHMZKRgMeeJLJUwpxLBqxFNOtSaStkueUXSXLxLfqEsvbCgHjUVUTgUkznCKWTCoYJIhBXoevfbnHhGwfNrkfGPbIMYkJdzoAPLUvWpJBGZUxODRTomDELJlDsbSPyXtUyDkJPiGIaPMmBaBFsmocJQvEUKcIjTCtITydhperdPxQGSxEYeUQFVJnutEwHcNlAkxAzggWbexjsAisExMKmXgWxVxcS kSnhPaQvMMLJSjPwZkdcZKZBkUuzHqIrelqxRYwaJiGKQUeuBOZgXViktrcaieSiDRebVvyNpKKuczCmakRgLaNNZpLdYSLgYwbFogRIRHwmfgJqxAsWEibNIOxvIfvFeGqOYWQCrZNVymWhLVcvMzWzzzLXlhrzKLsQNqfGySfluxpHWXligAJElFgcXAvPRuaYckMPTRAOFujFzKqTGwAUrUIXgPUAzZjGmZnbsOurCXcYwFVFWMrrQVgZuBZT 428068841 228912001
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] sequencer::logevent_sequencerCommandIssued writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event sequencerCommandIssued generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 228912001
    Log    ${output}
    Should Contain X Times    ${output}    === Event sequencerCommandIssued received =     1
    Should Contain    ${output}    CommandSource : TTbDKDRDSEwoXEmVCNPHLHsIuoILwjpXkJWtShYzlhcmqgeOaPbkvYgKGZdsUiWZJrYgJfKWKtnyZaMvGJatlcpNHFxCXUNToWfAcmGnhKuDtVkLENEVIBmeLxMvEJzSWwtMXqCHUJoQuMXkIXHFFzOZmAnfpsWejNzElKhlyizdwaSFjdCtcxclrykmZwuXkbJNKOKkBlalCGkpPeAqfNQMVfbgRPmWEuuieGTVKSiphAfmmeMyZRouLBbYjDXf
    Should Contain    ${output}    SequenceNumber : 826525035
    Should Contain    ${output}    Identifier : 41.4476
    Should Contain    ${output}    Timestamp : dAXYOiOSZLRPswWLQXfqyinBqWVmDWZIGaSHMZKRgMeeJLJUwpxLBqxFNOtSaStkueUXSXLxLfqEsvbCgHjUVUTgUkznCKWTCoYJIhBXoevfbnHhGwfNrkfGPbIMYkJdzoAPLUvWpJBGZUxODRTomDELJlDsbSPyXtUyDkJPiGIaPMmBaBFsmocJQvEUKcIjTCtITydhperdPxQGSxEYeUQFVJnutEwHcNlAkxAzggWbexjsAisExMKmXgWxVxcS
    Should Contain    ${output}    CommandSent : kSnhPaQvMMLJSjPwZkdcZKZBkUuzHqIrelqxRYwaJiGKQUeuBOZgXViktrcaieSiDRebVvyNpKKuczCmakRgLaNNZpLdYSLgYwbFogRIRHwmfgJqxAsWEibNIOxvIfvFeGqOYWQCrZNVymWhLVcvMzWzzzLXlhrzKLsQNqfGySfluxpHWXligAJElFgcXAvPRuaYckMPTRAOFujFzKqTGwAUrUIXgPUAzZjGmZnbsOurCXcYwFVFWMrrQVgZuBZT
    Should Contain    ${output}    ReturnValue : 428068841
    Should Contain    ${output}    priority : 228912001
