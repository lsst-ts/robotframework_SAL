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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send bWPALyoniPTiJjkkvyQakFJQfupvunXKbqYBlyqalZwpobnkvsxFYRMEFaWZnaikCxPiVeDQkdoMnvfuwBkBRgkxhJEizEZnLKPVTMSeZrGZujHKpyIxQEFWOUUXsUbqFYNjwupcQljxaplKjPTNFUNJCxgYVtvggUvdWSfsbCCVEOMlTODsuDloKcOKHKEDqXYGWsCYDbXhdnTApsMTxCNiChErtZdRfwUicQanccaUqcoAYroifrvyaYSupoOG -1004678460 86.169 ChbMguFRmqMsXvrRRoNDuvlknVoJJqxsyeUhcpmjjymJxJsYuktLmDOjRSdwkzyYXiuGaCtIdvvYkbKJCLMQAGoAYEuGlZgCpyvgSzJnmEAsAFDilVUMgxClgWODHMPFFuaElVjFteZMzvanEAFHLHwSOXdEkIrNrLRENoFseWJjwDZrwAOvAFHszyOjngtSHHuVOHfLqOfclwiHTqeyMixiLwBbdVEVNRwibmLxbxZcWomxCHssqExcvUtmxnmM uJvfRkEoIOeAFBwIWCKdwaLYofthLvwHbjGPGoZampEnxMsFxHyQDRmOaTfBSwEvHXIsIGYIUEUgEdZmSUfuFnGKIJuVQVZUpMiZSboAJwzvkCagWDUfPzEGUJhdTIQctyhSSLopYzpItbIcaXoAlCrXTXOuqnEHLvFQBDDKaBMvBvqGVZKMKFbgGEVJwTinqPXvltjyGjnTAIlQbDZAPQtwtAUvFeuzvGtpxHSZdjZuusSDypiHysyiDZSqECtX -1143990397 yTmvnQQnOgeVPDzlEJffyHUCTEanPFLPEgGhaerSYOPWUJayCikNsLJsyjrxqddStEEZmfNkaiQOViyQEjzzyONWAyPsSXqeaRTSDHQPAqmDMnLmCCvQFsyiFQXQaGNfzxrpeCldXkScQnTPAIjzObzphFBSZMzYjUPPNmXlKEQoANgSAAHCkNsgzCuJGSNCARgzQQkpNYaslcJQPbIbrMMICtWgiUBkxJrLuSuRXjvHfzXVwNIgAGqrqmbiROkM 1225784527
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] sequencer::logevent_sequencerCommandStatus writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event sequencerCommandStatus generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1225784527
    Log    ${output}
    Should Contain X Times    ${output}    === Event sequencerCommandStatus received =     1
    Should Contain    ${output}    CommandSource : bWPALyoniPTiJjkkvyQakFJQfupvunXKbqYBlyqalZwpobnkvsxFYRMEFaWZnaikCxPiVeDQkdoMnvfuwBkBRgkxhJEizEZnLKPVTMSeZrGZujHKpyIxQEFWOUUXsUbqFYNjwupcQljxaplKjPTNFUNJCxgYVtvggUvdWSfsbCCVEOMlTODsuDloKcOKHKEDqXYGWsCYDbXhdnTApsMTxCNiChErtZdRfwUicQanccaUqcoAYroifrvyaYSupoOG
    Should Contain    ${output}    SequenceNumber : -1004678460
    Should Contain    ${output}    Identifier : 86.169
    Should Contain    ${output}    Timestamp : ChbMguFRmqMsXvrRRoNDuvlknVoJJqxsyeUhcpmjjymJxJsYuktLmDOjRSdwkzyYXiuGaCtIdvvYkbKJCLMQAGoAYEuGlZgCpyvgSzJnmEAsAFDilVUMgxClgWODHMPFFuaElVjFteZMzvanEAFHLHwSOXdEkIrNrLRENoFseWJjwDZrwAOvAFHszyOjngtSHHuVOHfLqOfclwiHTqeyMixiLwBbdVEVNRwibmLxbxZcWomxCHssqExcvUtmxnmM
    Should Contain    ${output}    CommandSent : uJvfRkEoIOeAFBwIWCKdwaLYofthLvwHbjGPGoZampEnxMsFxHyQDRmOaTfBSwEvHXIsIGYIUEUgEdZmSUfuFnGKIJuVQVZUpMiZSboAJwzvkCagWDUfPzEGUJhdTIQctyhSSLopYzpItbIcaXoAlCrXTXOuqnEHLvFQBDDKaBMvBvqGVZKMKFbgGEVJwTinqPXvltjyGjnTAIlQbDZAPQtwtAUvFeuzvGtpxHSZdjZuusSDypiHysyiDZSqECtX
    Should Contain    ${output}    StatusValue : -1143990397
    Should Contain    ${output}    Status : yTmvnQQnOgeVPDzlEJffyHUCTEanPFLPEgGhaerSYOPWUJayCikNsLJsyjrxqddStEEZmfNkaiQOViyQEjzzyONWAyPsSXqeaRTSDHQPAqmDMnLmCCvQFsyiFQXQaGNfzxrpeCldXkScQnTPAIjzObzphFBSZMzYjUPPNmXlKEQoANgSAAHCkNsgzCuJGSNCARgzQQkpNYaslcJQPbIbrMMICtWgiUBkxJrLuSuRXjvHfzXVwNIgAGqrqmbiROkM
    Should Contain    ${output}    priority : 1225784527
