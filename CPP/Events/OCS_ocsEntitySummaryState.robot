*** Settings ***
Documentation    OCS_ocsEntitySummaryState communications tests.
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send GbUAaYhnEJiJNMwVqTFMeJKDHCpfOyODgcAeMfRFCdNtTWqDmYiKSAZVQPiohpyTLMxDrvecwEviqcsyqiqdTjlrgmJAJUbRnynTOwyuJmlUbmpHAjcqcuThpPEbRMnm 60.2952 ScLxXMrTpVYznWfIYwpkWZtAMohCOLzteDASlTtLjilRSkXpoSyRjoZhDQwCiqjQQPQpmTOeMBAMmVvQAmcgrTsMtDExbFTORILBiPNHAuDDhXSOhhEjsfVkzowrXsSAeiqaKdBnpQauEFQzaJOSELjowhJMgQNaSJpOJBlCIoLSQrIpFTiOrnuNDKMlXElZRjjBQBcNEzXVLIFSgVoUINRhOBPVTwYDqTgsCjlqVlYxrOdMPuMCwgBQsNxLnLRM 257838763 dgmMoYwYgeKCQqVedXfHhvbfhmhEyDEAeMTDtwNloMpFGBiCpkUraQrgQyayyuSwGeLQEbYKqJcZFPygusdHFLyRHJgFleNZotVFRwlBOFOAfNmtDRHHVwrTUcckzvPd PWFztkwAMIKetcdlRwiYkAdHbiMylpcYAcDdbFbclLOhQGJGInTMpVPxSHuJvZbEJVjWwMCrVcaLfrzoGGytyeQLywsUNYKgzrKhOmcCDheqsGnIvmAUlXesYuAYCOlm zjnrrBnHyVJiHfoPWcJgTmeeOlcXHSuKIrhShalMZodNEFTONdPGXRTIKUtJAbxCcDhNAxTpJEOTgaqZspBFqpFyEQdwcTYwxgtygavMNsFursOthGySUMWgTXMKCXhv ngvZghQxolwGBxgpkjNeSdKpnxeizQpbMynbKNlbOsGWzUEdNKQUZUsTUYiBZCLBgHBtWRwwVsrqvpnBjZxOAwFCZdYLZBDZxWJExntxTfPweOmzQiYDjOlIzzWuUqcd NjdnayRRoXDUiawuyPMFdtkOMBTWYWrjuAHSbSJXmvmzMjEIOzwAhBffAlwGSYZGLzOmQppFvQZDVFuwLTXBQLCktlQZbRXEpHGLHZHiYNApGZTKOJLAoQyEkYYoWkgv 1280812399
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] ocs::logevent_ocsEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ocsEntitySummaryState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1280812399
    Log    ${output}
    Should Contain X Times    ${output}    === Event ocsEntitySummaryState received =     1
    Should Contain    ${output}    Name : GbUAaYhnEJiJNMwVqTFMeJKDHCpfOyODgcAeMfRFCdNtTWqDmYiKSAZVQPiohpyTLMxDrvecwEviqcsyqiqdTjlrgmJAJUbRnynTOwyuJmlUbmpHAjcqcuThpPEbRMnm
    Should Contain    ${output}    Identifier : 60.2952
    Should Contain    ${output}    Timestamp : ScLxXMrTpVYznWfIYwpkWZtAMohCOLzteDASlTtLjilRSkXpoSyRjoZhDQwCiqjQQPQpmTOeMBAMmVvQAmcgrTsMtDExbFTORILBiPNHAuDDhXSOhhEjsfVkzowrXsSAeiqaKdBnpQauEFQzaJOSELjowhJMgQNaSJpOJBlCIoLSQrIpFTiOrnuNDKMlXElZRjjBQBcNEzXVLIFSgVoUINRhOBPVTwYDqTgsCjlqVlYxrOdMPuMCwgBQsNxLnLRM
    Should Contain    ${output}    Address : 257838763
    Should Contain    ${output}    CurrentState : dgmMoYwYgeKCQqVedXfHhvbfhmhEyDEAeMTDtwNloMpFGBiCpkUraQrgQyayyuSwGeLQEbYKqJcZFPygusdHFLyRHJgFleNZotVFRwlBOFOAfNmtDRHHVwrTUcckzvPd
    Should Contain    ${output}    PreviousState : PWFztkwAMIKetcdlRwiYkAdHbiMylpcYAcDdbFbclLOhQGJGInTMpVPxSHuJvZbEJVjWwMCrVcaLfrzoGGytyeQLywsUNYKgzrKhOmcCDheqsGnIvmAUlXesYuAYCOlm
    Should Contain    ${output}    Executing : zjnrrBnHyVJiHfoPWcJgTmeeOlcXHSuKIrhShalMZodNEFTONdPGXRTIKUtJAbxCcDhNAxTpJEOTgaqZspBFqpFyEQdwcTYwxgtygavMNsFursOthGySUMWgTXMKCXhv
    Should Contain    ${output}    CommandsAvailable : ngvZghQxolwGBxgpkjNeSdKpnxeizQpbMynbKNlbOsGWzUEdNKQUZUsTUYiBZCLBgHBtWRwwVsrqvpnBjZxOAwFCZdYLZBDZxWJExntxTfPweOmzQiYDjOlIzzWuUqcd
    Should Contain    ${output}    ConfigurationsAvailable : NjdnayRRoXDUiawuyPMFdtkOMBTWYWrjuAHSbSJXmvmzMjEIOzwAhBffAlwGSYZGLzOmQppFvQZDVFuwLTXBQLCktlQZbRXEpHGLHZHiYNApGZTKOJLAoQyEkYYoWkgv
    Should Contain    ${output}    priority : 1280812399
