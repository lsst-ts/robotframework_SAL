*** Settings ***
Documentation    Sequencer_sequencerCommandStatus sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    sequencer
${component}    sequencerCommandStatus
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send hvarDyYZvhTthIfZlMwANhbbQwaXbxawreffEQkiprTgVlwmpfHuenOdVUgGoBYOVWSrMWSqsGtZEbolfyLOLxOWilXtbbKYnGaSAnLunFWDnkemueWhCRbbiBxWRnBIwgZAcwzCpuBupEMFMDAqwtkQrHkFCvBmHPPdGyzqqiIqOgloEOoMBnLWivhuyWTZemgiGIeHqgZbeCXXMBHOXXZDqSsfQYfgMHdDaTbKJMuzjbuonsTNZJDRIoRzhIFU -831296727 51.4063 uVaZqqDXgqtaPkSKhnfcnDhtAkUVVwQiIfRyCTnNXgTIhlrBqFWlGZhPziqLDJvcJmPRSaxGnuAzzNLurZRBxQNzDUyvvZiuugRLaKOKXSmtNmHuFmWrvlQrJgYpTputDKbPAMxeNmZrRvvuUBWzTurnpxVWzxlQNAtOVSmAMcOKdOuZSjewOauFUoiSOolMJZxZXBmaYOTNdKPBESUptafFjWZRMrmdwVQhvABDfeqXCuVIdpjEEHrbGwQqXiAC MIUGRJCydStkyyIOfWlmYCnAabtQkghJyVjgCVVHbrQbiKbRtfJfxLjYarKWjNdroyDblvYufcDmDoQgqOAKjHuXJZNwsHdifWCcIisEdUHAUKhdRZmgFrigWXQqyWZRDsHXlWrZfgeWFWbVFpRlpziXXRjvYKjCQiwNSklENHOvqXjkvevikIhUOQFpYZsAUbfFWxtxEHvQHpFiOAqcnVchUudvDRiBkeWQrAPQTdgjthIRYCmfCELCZJGNQoKV 1199430828 zXVEWbMwmrbHUGaGkhAnKOhGgmpMfXDLAquQVhKFckfdPlVFZfgSYKQISOKlDcaaDpEOdtawoDOAZAXRwuiPIFOVehLSayuLXBpjzddPPMgGUiEuzHuvfsZgPJVlBSfnUtjANNXpmFHhJaxFwWwgYYDcpfSCQxwacJOCymjZIrYVHIVVHCfPzjKMiFWzUfhqZHqWTypMYdKvLBJAIpDsbhrbbDNoNXBllxpkMjQaNOaBFChygsFgkFwZboFHzOzZ 1931415893
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] sequencer::logevent_sequencerCommandStatus writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event sequencerCommandStatus generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1931415893
    Log    ${output}
    Should Contain X Times    ${output}    === Event sequencerCommandStatus received =     1
    Should Contain    ${output}    CommandSource : hvarDyYZvhTthIfZlMwANhbbQwaXbxawreffEQkiprTgVlwmpfHuenOdVUgGoBYOVWSrMWSqsGtZEbolfyLOLxOWilXtbbKYnGaSAnLunFWDnkemueWhCRbbiBxWRnBIwgZAcwzCpuBupEMFMDAqwtkQrHkFCvBmHPPdGyzqqiIqOgloEOoMBnLWivhuyWTZemgiGIeHqgZbeCXXMBHOXXZDqSsfQYfgMHdDaTbKJMuzjbuonsTNZJDRIoRzhIFU
    Should Contain    ${output}    SequenceNumber : -831296727
    Should Contain    ${output}    Identifier : 51.4063
    Should Contain    ${output}    Timestamp : uVaZqqDXgqtaPkSKhnfcnDhtAkUVVwQiIfRyCTnNXgTIhlrBqFWlGZhPziqLDJvcJmPRSaxGnuAzzNLurZRBxQNzDUyvvZiuugRLaKOKXSmtNmHuFmWrvlQrJgYpTputDKbPAMxeNmZrRvvuUBWzTurnpxVWzxlQNAtOVSmAMcOKdOuZSjewOauFUoiSOolMJZxZXBmaYOTNdKPBESUptafFjWZRMrmdwVQhvABDfeqXCuVIdpjEEHrbGwQqXiAC
    Should Contain    ${output}    CommandSent : MIUGRJCydStkyyIOfWlmYCnAabtQkghJyVjgCVVHbrQbiKbRtfJfxLjYarKWjNdroyDblvYufcDmDoQgqOAKjHuXJZNwsHdifWCcIisEdUHAUKhdRZmgFrigWXQqyWZRDsHXlWrZfgeWFWbVFpRlpziXXRjvYKjCQiwNSklENHOvqXjkvevikIhUOQFpYZsAUbfFWxtxEHvQHpFiOAqcnVchUudvDRiBkeWQrAPQTdgjthIRYCmfCELCZJGNQoKV
    Should Contain    ${output}    StatusValue : 1199430828
    Should Contain    ${output}    Status : zXVEWbMwmrbHUGaGkhAnKOhGgmpMfXDLAquQVhKFckfdPlVFZfgSYKQISOKlDcaaDpEOdtawoDOAZAXRwuiPIFOVehLSayuLXBpjzddPPMgGUiEuzHuvfsZgPJVlBSfnUtjANNXpmFHhJaxFwWwgYYDcpfSCQxwacJOCymjZIrYVHIVVHCfPzjKMiFWzUfhqZHqWTypMYdKvLBJAIpDsbhrbbDNoNXBllxpkMjQaNOaBFChygsFgkFwZboFHzOzZ
    Should Contain    ${output}    priority : 1931415893
