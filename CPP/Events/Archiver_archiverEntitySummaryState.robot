*** Settings ***
Documentation    Archiver_archiverEntitySummaryState sender/logger tests.
Force Tags    cpp
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    archiver
${component}    archiverEntitySummaryState
${timeout}    30s

*** Test Cases ***
Create Sender Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Sender    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

Create Logger Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Logger    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send PILMFyREqLLuEYATdYmnQepwlbAnOoHAYaGFPOCTAXPguxsrYMEZqdItZzSitKIaayTOcFOwMWynLfbBjQsFdXueZfZjrNGiBhQkwmRVkvqNsxiClXQeIUZHcidWwdQl 89.268 RMmwDNhsyKXwTlpXrxbHSjIEkHpgTyVjUlWQRPKliPHYTISEIYwOIKbdUXywKBmRdwSvPSxxsJzolXcwOdjNHEtBOFpqwRzKETRHYCwYfMOuJTdzhbeDCOKogzJQUbVEILtKMllnCEXmZTqePrVarSZApNhaBbGASHjkeYiKdiHHyveLgERyJvzSHlPbzSVYRdQghjDqIRqwxaNHbubRTliSbcKCJqyqwRlxSiFdxVsaQRpyPUvXwCYAJfCLKpAi 2139465217 QHxIUMQHSVmULKMEvxUETWIWzulIPjKZEDoVIgAaHGVexVdjDUeNpMUsfDGwjHhLFMhaHYivxBtyuKzAgLGkjpDDEDMYuTSoqSSPuFIXRtZpHWACUjtVxYHyXwiqzhkZ pgoOSaQwSzulPnKClPOYhCEKvlKCEDMZsmvPVmNosRaZYEgLANiBGNPbvweFfmWiKruRBqDqFNpwKJPZONzmdNxUJZALZWDHWCcywytwZPcOPSkMviNQivAINfszZHlQ gTxXpaUgpumiIgBvJJYTipBjEOYRenPCnFMjpnVTKcCpyzXXPYqtvuwWxvSkAbVbkCXuUdCqMBlXmHPTbvyIFzQtgyeHAMZqgmWApqOKEogixMOFJpnOBXoyscQXaOBj xBaTxRySMiywaCiQKiIAotNGoCEPlgEQRFbzUdTBvzLuxjgmzqcfGDCLXgBXjXnryxXQqyAOpzQJvLlWpUulLDvnAJmAwuMBVZCFUwSBLzJKoGJxljNloOmtxIvFHFFQ LKBjizrsXnLfMPcWzEIvGtMfMalODkJTnSOuSsEKMgMIXGNEFjTwerMMbyXZvpLEpKkYQkOxFJPvMbSeaRzyOVeYMsioZKBMUFqXkvDyVHIkckjLTzrYkPaoNeUquEce 208579126
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] archiver::logevent_archiverEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event archiverEntitySummaryState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 208579126
    Log    ${output}
    Should Contain X Times    ${output}    === Event archiverEntitySummaryState received =     1
    Should Contain    ${output}    Name : PILMFyREqLLuEYATdYmnQepwlbAnOoHAYaGFPOCTAXPguxsrYMEZqdItZzSitKIaayTOcFOwMWynLfbBjQsFdXueZfZjrNGiBhQkwmRVkvqNsxiClXQeIUZHcidWwdQl
    Should Contain    ${output}    Identifier : 89.268
    Should Contain    ${output}    Timestamp : RMmwDNhsyKXwTlpXrxbHSjIEkHpgTyVjUlWQRPKliPHYTISEIYwOIKbdUXywKBmRdwSvPSxxsJzolXcwOdjNHEtBOFpqwRzKETRHYCwYfMOuJTdzhbeDCOKogzJQUbVEILtKMllnCEXmZTqePrVarSZApNhaBbGASHjkeYiKdiHHyveLgERyJvzSHlPbzSVYRdQghjDqIRqwxaNHbubRTliSbcKCJqyqwRlxSiFdxVsaQRpyPUvXwCYAJfCLKpAi
    Should Contain    ${output}    Address : 2139465217
    Should Contain    ${output}    CurrentState : QHxIUMQHSVmULKMEvxUETWIWzulIPjKZEDoVIgAaHGVexVdjDUeNpMUsfDGwjHhLFMhaHYivxBtyuKzAgLGkjpDDEDMYuTSoqSSPuFIXRtZpHWACUjtVxYHyXwiqzhkZ
    Should Contain    ${output}    PreviousState : pgoOSaQwSzulPnKClPOYhCEKvlKCEDMZsmvPVmNosRaZYEgLANiBGNPbvweFfmWiKruRBqDqFNpwKJPZONzmdNxUJZALZWDHWCcywytwZPcOPSkMviNQivAINfszZHlQ
    Should Contain    ${output}    Executing : gTxXpaUgpumiIgBvJJYTipBjEOYRenPCnFMjpnVTKcCpyzXXPYqtvuwWxvSkAbVbkCXuUdCqMBlXmHPTbvyIFzQtgyeHAMZqgmWApqOKEogixMOFJpnOBXoyscQXaOBj
    Should Contain    ${output}    CommandsAvailable : xBaTxRySMiywaCiQKiIAotNGoCEPlgEQRFbzUdTBvzLuxjgmzqcfGDCLXgBXjXnryxXQqyAOpzQJvLlWpUulLDvnAJmAwuMBVZCFUwSBLzJKoGJxljNloOmtxIvFHFFQ
    Should Contain    ${output}    ConfigurationsAvailable : LKBjizrsXnLfMPcWzEIvGtMfMalODkJTnSOuSsEKMgMIXGNEFjTwerMMbyXZvpLEpKkYQkOxFJPvMbSeaRzyOVeYMsioZKBMUFqXkvDyVHIkckjLTzrYkPaoNeUquEce
    Should Contain    ${output}    priority : 208579126
