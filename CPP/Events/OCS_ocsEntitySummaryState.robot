*** Settings ***
Documentation    OCS_ocsEntitySummaryState sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    ocs
${component}    ocsEntitySummaryState
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send uFnnOznqxgeNEAreyLNoJPqEBmHlblkJaUrAPCkCezpBHfwbghBFIBErzHaKvhpUEQZXmYaOIyuxuydSIgSQGDKRsZsIHoXBQRotkMFVpJzyecxNAWlFuSVXOPUgnqUD 53.9698 GqWhLVeJSZzZeRPgQAuWrPnaoqbwEhRqBollMHYJmHGAgOKJnAicQEYZPdhEqSbdZHbziqeyQNYEPdTOqtNNaJtTMEoGWiRAELIFEeVThnaWjRVuXiIxbHWbHpNWCeXzXSTwyeXgHhhAehiHCqBuTBiGmiaJuwgMnVmahNiBjedgTkvQvoLlttfoYZRjrkTyYVCQXwkDdziLpHLuIuytpbIVYeihjHUjFtGWqdMOnMINkGZKsGVzVOQuSbgggGUw -1751997985 ZPbiNpbVfZZeKmCZzVipRjlygYDEMwtPTsWrMDbxWdppprhDgrAQLYPLJHixriYibFJFBUdKwcFsboaaJcIPCGnwmSaEsdDlvGFhqcMYEtvKqIqvewQfLCNdJfAHCsGf FLPMmCCFwghTrWuqeUroDabEhncZGIHJUOutVWoSToIzIFNVjJIvkKLcDetmVIEKwUkLloPkdJOhBhgnAGYKwDaDRfIRvEwFElkLtGVTSLtOoLhJGbUnhfFGlzUkVzcy QFwoeYfLtiwsTpzgMdFbiioNzJqKFPrMNxHXjkvUwZmFYZHeDpvPexXDsbPseTwdLLzHUozOFicfFNWULwwTUKwbWjGIeInMDLFKVRrlQgnRYPExIctdtwseDmsmElql AJFpNrVlhNdyJvQREdtSxoWuxycaRFSQafvpinWjOnNpUiVHMVoMPqSnvfSWHBXpopgxZYVidmvRyqnIGTKpdJHNpylfWpgVBQtiLDjPxqrCahUcbKCVJjpXZktWoenN rqTlJgfKSMoGMlVODIGwkpFEyEtwgmXcCCXxhdXawbgBFLMMCzWKbxggALXNCtsqhHzreggvlvnKeZwqEwzdIjEbItVNtWecHnzARSDCydLLNgkIGVLyGmBdIUoNzpzU -189229228
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] ocs::logevent_ocsEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ocsEntitySummaryState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -189229228
    Log    ${output}
    Should Contain X Times    ${output}    === Event ocsEntitySummaryState received =     1
    Should Contain    ${output}    Name : uFnnOznqxgeNEAreyLNoJPqEBmHlblkJaUrAPCkCezpBHfwbghBFIBErzHaKvhpUEQZXmYaOIyuxuydSIgSQGDKRsZsIHoXBQRotkMFVpJzyecxNAWlFuSVXOPUgnqUD
    Should Contain    ${output}    Identifier : 53.9698
    Should Contain    ${output}    Timestamp : GqWhLVeJSZzZeRPgQAuWrPnaoqbwEhRqBollMHYJmHGAgOKJnAicQEYZPdhEqSbdZHbziqeyQNYEPdTOqtNNaJtTMEoGWiRAELIFEeVThnaWjRVuXiIxbHWbHpNWCeXzXSTwyeXgHhhAehiHCqBuTBiGmiaJuwgMnVmahNiBjedgTkvQvoLlttfoYZRjrkTyYVCQXwkDdziLpHLuIuytpbIVYeihjHUjFtGWqdMOnMINkGZKsGVzVOQuSbgggGUw
    Should Contain    ${output}    Address : -1751997985
    Should Contain    ${output}    CurrentState : ZPbiNpbVfZZeKmCZzVipRjlygYDEMwtPTsWrMDbxWdppprhDgrAQLYPLJHixriYibFJFBUdKwcFsboaaJcIPCGnwmSaEsdDlvGFhqcMYEtvKqIqvewQfLCNdJfAHCsGf
    Should Contain    ${output}    PreviousState : FLPMmCCFwghTrWuqeUroDabEhncZGIHJUOutVWoSToIzIFNVjJIvkKLcDetmVIEKwUkLloPkdJOhBhgnAGYKwDaDRfIRvEwFElkLtGVTSLtOoLhJGbUnhfFGlzUkVzcy
    Should Contain    ${output}    Executing : QFwoeYfLtiwsTpzgMdFbiioNzJqKFPrMNxHXjkvUwZmFYZHeDpvPexXDsbPseTwdLLzHUozOFicfFNWULwwTUKwbWjGIeInMDLFKVRrlQgnRYPExIctdtwseDmsmElql
    Should Contain    ${output}    CommandsAvailable : AJFpNrVlhNdyJvQREdtSxoWuxycaRFSQafvpinWjOnNpUiVHMVoMPqSnvfSWHBXpopgxZYVidmvRyqnIGTKpdJHNpylfWpgVBQtiLDjPxqrCahUcbKCVJjpXZktWoenN
    Should Contain    ${output}    ConfigurationsAvailable : rqTlJgfKSMoGMlVODIGwkpFEyEtwgmXcCCXxhdXawbgBFLMMCzWKbxggALXNCtsqhHzreggvlvnKeZwqEwzdIjEbItVNtWecHnzARSDCydLLNgkIGVLyGmBdIUoNzpzU
    Should Contain    ${output}    priority : -189229228
