*** Settings ***
Documentation    OCS_ocsCommandStatus sender/logger tests.
Force Tags    cpp
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    ocs
${component}    ocsCommandStatus
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send eaOLYVIcwmvdfZLnPvyTpBOVbPUWLyNKkSeXzlnVNwnAuoGsRACiQFDdEGSrXZXxKVfqqlwYFOCqxZTBjqNaEVVfYRkOPtmLbhjLSZexfSArKmhKkycoLRgkgDMTQarppAMsyGLsCRAlkOxHNLGyYDRhRtlaMlUDmolfxidBtNsvFFNlVtEHEMkqXmXvuTOatTRFcGMUCbRZRBMONppAVdCLTbOAhiUlvJvkkAUAtFYopjRLqROazxmZHDWOAhIR -587770653 71.0766 PlntBHfBDLdQJMnVbzROnqRiIqvhmSTKRhzTFdvoHfedZSTfNAXLzTDmpJVyzjHTKHZSHGyViHnowDORsQmHcTklzpHbzWVeoFqkOmichsvzqROgvlNQkhMfRpDUrZxCBHqdIkeoeeuOCKgigFIdOWwXCDFBxUrKGSgysBCAZCXtisgoYSOXWRMYtQYNNsujyCxhkpjxVhlqYfxJJiSKpvMEMAYzCtnRDCkQEHSWCKuYQWtxtKkNudBDohVDywlb BitjMpcUWoJybjpLIulZozVhGVXZUXlaxLQyDNETijCZGDCxczTjUemDAgbAQmIByRFofOkjWyVGHxAADAHUPfrxcyHkBEkZICBkNPccqyZsOAOJLKbDAkYmXHDdkSbUYCQZVbWJhxSYDSVWtNYjJRHcAboYBvdapPcFhCRIFAHWIbGxnnLHOoLeStbRxYuUyrWJkLYrObvPPVLAcMTYzvYlIsfKUiBknZDdeypywndMvAmnrNXblwruJHaMRPPh 2025818668 PzGMoOhPvnCzzkcSFyhxKKCdxlfsdSbXbfVBdLPleTqRNLWSXWXxbFNkUsmYUpjNnoXCEDJUwUTQIshbKebpeNvgndiwJKjqdXBEgJsjcoKbcpXhlguLHJIVvktBIfhYCDHHlOoqqBmrTmaRyKPvRZNOnKSIyXzuztKfUuPrMQSBCtBIoeipCNcqaJyPhIhYkWLHkbOzjYZuPrvzqaOrTnkUqUJqmxKxhKgDDkFHKDCzpvjagYTvaIzWBujSeDpa 503395070
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] ocs::logevent_ocsCommandStatus writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ocsCommandStatus generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 503395070
    Log    ${output}
    Should Contain X Times    ${output}    === Event ocsCommandStatus received =     1
    Should Contain    ${output}    CommandSource : eaOLYVIcwmvdfZLnPvyTpBOVbPUWLyNKkSeXzlnVNwnAuoGsRACiQFDdEGSrXZXxKVfqqlwYFOCqxZTBjqNaEVVfYRkOPtmLbhjLSZexfSArKmhKkycoLRgkgDMTQarppAMsyGLsCRAlkOxHNLGyYDRhRtlaMlUDmolfxidBtNsvFFNlVtEHEMkqXmXvuTOatTRFcGMUCbRZRBMONppAVdCLTbOAhiUlvJvkkAUAtFYopjRLqROazxmZHDWOAhIR
    Should Contain    ${output}    SequenceNumber : -587770653
    Should Contain    ${output}    Identifier : 71.0766
    Should Contain    ${output}    Timestamp : PlntBHfBDLdQJMnVbzROnqRiIqvhmSTKRhzTFdvoHfedZSTfNAXLzTDmpJVyzjHTKHZSHGyViHnowDORsQmHcTklzpHbzWVeoFqkOmichsvzqROgvlNQkhMfRpDUrZxCBHqdIkeoeeuOCKgigFIdOWwXCDFBxUrKGSgysBCAZCXtisgoYSOXWRMYtQYNNsujyCxhkpjxVhlqYfxJJiSKpvMEMAYzCtnRDCkQEHSWCKuYQWtxtKkNudBDohVDywlb
    Should Contain    ${output}    CommandSent : BitjMpcUWoJybjpLIulZozVhGVXZUXlaxLQyDNETijCZGDCxczTjUemDAgbAQmIByRFofOkjWyVGHxAADAHUPfrxcyHkBEkZICBkNPccqyZsOAOJLKbDAkYmXHDdkSbUYCQZVbWJhxSYDSVWtNYjJRHcAboYBvdapPcFhCRIFAHWIbGxnnLHOoLeStbRxYuUyrWJkLYrObvPPVLAcMTYzvYlIsfKUiBknZDdeypywndMvAmnrNXblwruJHaMRPPh
    Should Contain    ${output}    StatusValue : 2025818668
    Should Contain    ${output}    Status : PzGMoOhPvnCzzkcSFyhxKKCdxlfsdSbXbfVBdLPleTqRNLWSXWXxbFNkUsmYUpjNnoXCEDJUwUTQIshbKebpeNvgndiwJKjqdXBEgJsjcoKbcpXhlguLHJIVvktBIfhYCDHHlOoqqBmrTmaRyKPvRZNOnKSIyXzuztKfUuPrMQSBCtBIoeipCNcqaJyPhIhYkWLHkbOzjYZuPrvzqaOrTnkUqUJqmxKxhKgDDkFHKDCzpvjagYTvaIzWBujSeDpa
    Should Contain    ${output}    priority : 503395070
