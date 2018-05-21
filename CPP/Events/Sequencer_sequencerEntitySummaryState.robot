*** Settings ***
Documentation    Sequencer_sequencerEntitySummaryState sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    sequencer
${component}    sequencerEntitySummaryState
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send mWbOGXZvvjrWWmIjTfbGIcCRuUSPTWYzbPEYwxDvWbhBHXedJpJthmZnowNiRRwoDifvOyuSjIMNwyVpRgmUIRJaZoPIbUITZSflcZdvEgBEmIMYYaRWxbfbCDBFSsSD 17.7125 kylnZgFxuepBUmeIyEbYwMRClkuuAKWAlodKNaSegXONcsBLJsLQShpFqpVgBrfzbkkDoNyEVachizNvsFWlBHONqyzXwXwrThIqorYAvmdBtNccZpdUNmRwjaMfqblPlmfwudkVaJFhRuXqRlpfZIrgdOcYpxIZuOZYCRVZvYNZPAQyUafelzUaSdEzFxYDDkTFqcHoVorEUgZOYkAoueuWAjGZxBUvriIQgTrrqaKAIBZlnztOKFJEpykgwHHj -1970367573 pLEmAVSUDoHjGubpElqMMePjEGRgOECZDxYqhPACCbNXxLpxGrNjQildepKiVgtMRgQMUSIUysgyOyzwHocjIrhweEceTPVctEvotRmipxmwilvjosZufhXYZWRWnRPp LPIXveCHWWkbsldxbEPJZVGiHkrWXarDCciGdOGkFuAHZYbfnEEKCLBMQpGZdBxmhdgEvcPSfBTGGEztMSoNeJxpcxaGckUFspwLtqudGICOZtZFnssTAfrREUGmLCJj uCkulPwWWPSGLHrLvhOhOoXTHyEaTwERhvehqjSjupZyMZdVQvoUOUAmZXRMnAWFowBrPKToLBCcnMdKFNrrncJySZXpTJSiVjctJAjUSxRGJTZMjOYMCIBkLNDKlTog jOUYWpEfkuCyXCnyiQNiJyXMfoyCnJncrrORZNzhuhsFjzcXcJoORnYfeSQufKBolFAFTllGuODAxGMQOzpaTTxhkYvNBnZrvJmPTVnCNguQJhcOCTAxOkLffkrDaNle iZEDctwmxGFwAJzEnIVgptprCRSzUPvTDHCItIPiXWAMCWCfaAJnrUQogXhLgJcqRPicgEqqjuuQHnUWLShTDyHiACRCjXbYiNMAJotkDPbIOprSQjyQIgVQqJDRNJqc 251018704
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] sequencer::logevent_sequencerEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event sequencerEntitySummaryState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 251018704
    Log    ${output}
    Should Contain X Times    ${output}    === Event sequencerEntitySummaryState received =     1
    Should Contain    ${output}    Name : mWbOGXZvvjrWWmIjTfbGIcCRuUSPTWYzbPEYwxDvWbhBHXedJpJthmZnowNiRRwoDifvOyuSjIMNwyVpRgmUIRJaZoPIbUITZSflcZdvEgBEmIMYYaRWxbfbCDBFSsSD
    Should Contain    ${output}    Identifier : 17.7125
    Should Contain    ${output}    Timestamp : kylnZgFxuepBUmeIyEbYwMRClkuuAKWAlodKNaSegXONcsBLJsLQShpFqpVgBrfzbkkDoNyEVachizNvsFWlBHONqyzXwXwrThIqorYAvmdBtNccZpdUNmRwjaMfqblPlmfwudkVaJFhRuXqRlpfZIrgdOcYpxIZuOZYCRVZvYNZPAQyUafelzUaSdEzFxYDDkTFqcHoVorEUgZOYkAoueuWAjGZxBUvriIQgTrrqaKAIBZlnztOKFJEpykgwHHj
    Should Contain    ${output}    Address : -1970367573
    Should Contain    ${output}    CurrentState : pLEmAVSUDoHjGubpElqMMePjEGRgOECZDxYqhPACCbNXxLpxGrNjQildepKiVgtMRgQMUSIUysgyOyzwHocjIrhweEceTPVctEvotRmipxmwilvjosZufhXYZWRWnRPp
    Should Contain    ${output}    PreviousState : LPIXveCHWWkbsldxbEPJZVGiHkrWXarDCciGdOGkFuAHZYbfnEEKCLBMQpGZdBxmhdgEvcPSfBTGGEztMSoNeJxpcxaGckUFspwLtqudGICOZtZFnssTAfrREUGmLCJj
    Should Contain    ${output}    Executing : uCkulPwWWPSGLHrLvhOhOoXTHyEaTwERhvehqjSjupZyMZdVQvoUOUAmZXRMnAWFowBrPKToLBCcnMdKFNrrncJySZXpTJSiVjctJAjUSxRGJTZMjOYMCIBkLNDKlTog
    Should Contain    ${output}    CommandsAvailable : jOUYWpEfkuCyXCnyiQNiJyXMfoyCnJncrrORZNzhuhsFjzcXcJoORnYfeSQufKBolFAFTllGuODAxGMQOzpaTTxhkYvNBnZrvJmPTVnCNguQJhcOCTAxOkLffkrDaNle
    Should Contain    ${output}    ConfigurationsAvailable : iZEDctwmxGFwAJzEnIVgptprCRSzUPvTDHCItIPiXWAMCWCfaAJnrUQogXhLgJcqRPicgEqqjuuQHnUWLShTDyHiACRCjXbYiNMAJotkDPbIOprSQjyQIgVQqJDRNJqc
    Should Contain    ${output}    priority : 251018704
