*** Settings ***
Documentation    MTCalCS_ communications tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    MTCalCS
${timeout}    30s

*** Test Cases ***
Verify settingVersions Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_settingVersions.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_settingVersions.py

Start settingVersions Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_settingVersions.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_settingVersions logger ready

Start settingVersions Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_settingVersions.py PZicRPaXrAUPzqagXNVPlZaMrShubkPQkoTqSWnEGYYgVXgUgnXcVDCuHyyuVfKDuGcslWsjRUrLmRbeLnpoJJsKNVFQkuhUBznNYlsLEEZqhepMvBTBYaYtmUyjoddvCSaEIzQYVuZAqgVzaKGZCnQGiVfRQBDYQPhgdwDqOWKGzhYcgKPJKHPcXnEsgjlytdwIzRtYJGTAjZMfkJqsfmJBEgLUTwkBoGhblFIPWBcTZlMIPWlVZAfNIgFGgAEo rTfUHobWmJZyWCeHTNCmiiVstgrVKNXMdQdqROxyDTWnkBmYAFVlfDzklTsqrbAyZeuzUrbRemVglAGQVxKuGxvWLAuURStKuiKsOeZMEOJHYwzTpLhKCbZRKUqQtjjeNZEBEdqrgncmCUNOQZIMDbNBRVBtdAGHVlTMSTsWHkijvjGgjwurirfjGPbLVrNXCsXpdcTDMlrRWhdQiPAGFwQzBZarUuCxZFYEytjFqjlfjpFOMlLRDmPZcCabKniC -1175153222
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] MTCalCS::logevent_settingVersions_    1
    Should Contain    ${output}    revCode \ :

Read settingVersions Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    settingVersions received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} settingVersions received     1

Terminate settingVersions Controller
    [Tags]    functional
    Switch Connection    Logger
    ${crtl_c}    Evaluate    chr(int(3))
    Write Bare    ${crtl_c}
    ${output}=    Read Until Prompt
    Should Contain    ${output}    ^C

Verify errorCode Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_errorCode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_errorCode.py

Start errorCode Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_errorCode.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_errorCode logger ready

Start errorCode Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_errorCode.py 1010165331 BVjDePAFuRJxoiNbllrYbqdXPsESKCJHsUPJLEyZbRMjmdFZhZhrosRnCCyCbYsXaqTOnSExtphHJtdzuQNxyMUdEhFjuWwinfCLLrLxAMEYAHxnnEqVjyYROIrVbKiKFKydOMatuCGXYFrpXPCusIjysWrCqMNKbYGImrnDJKWSnlphzlPDrJHoTzBUEGScJTCDJOaLmZlEgzEgfkVvcdBbSfoIdxRNjqJlCXUIPXZuoHTLYVDiGnbclujLUGRtkErpVatpFOHIjZNheXGtrXphlQujTzTjDmLQ zjCtRfchLFSDfHeqRMAKCjZlNtWfRDMKoONjnucEDdVjxTPROQzyGRvKtwSyGiPicVBxnpxcuaSCWHvMdDvcwZSUKqMJYTjAhMdTJVyAjpSfslvAeSeLFyYbhEUUULZfehIcZOpqYSXVfzhqApLHXkozQkoqRHgIlzInGlcKLdEaOZYtYKGKXYAijVfYMNUphjDsalmsYQgkwfHisQzfOpvImBMbIxSWBRUoMkOQrvUJXUFJwnSSkxjiiUGYgeLrbfWFaQUUQpMFTAXmkgsxLfhOsvmMZoiSOCbqfgcMSrPrHsKtFyRZ 1536668255
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] MTCalCS::logevent_errorCode_    1
    Should Contain    ${output}    revCode \ :

Read errorCode Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    errorCode received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} errorCode received     1

Terminate errorCode Controller
    [Tags]    functional
    Switch Connection    Logger
    ${crtl_c}    Evaluate    chr(int(3))
    Write Bare    ${crtl_c}
    ${output}=    Read Until Prompt
    Should Contain    ${output}    ^C

Verify summaryState Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_summaryState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_summaryState.py

Start summaryState Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_summaryState.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_summaryState logger ready

Start summaryState Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_summaryState.py -1731282503 638449924
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] MTCalCS::logevent_summaryState_    1
    Should Contain    ${output}    revCode \ :

Read summaryState Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    summaryState received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} summaryState received     1

Terminate summaryState Controller
    [Tags]    functional
    Switch Connection    Logger
    ${crtl_c}    Evaluate    chr(int(3))
    Write Bare    ${crtl_c}
    ${output}=    Read Until Prompt
    Should Contain    ${output}    ^C

Verify appliedSettingsMatchStart Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_appliedSettingsMatchStart.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_appliedSettingsMatchStart.py

Start appliedSettingsMatchStart Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_appliedSettingsMatchStart.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_appliedSettingsMatchStart logger ready

Start appliedSettingsMatchStart Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_appliedSettingsMatchStart.py 0 -1707350049
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] MTCalCS::logevent_appliedSettingsMatchStart_    1
    Should Contain    ${output}    revCode \ :

Read appliedSettingsMatchStart Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    appliedSettingsMatchStart received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} appliedSettingsMatchStart received     1

Terminate appliedSettingsMatchStart Controller
    [Tags]    functional
    Switch Connection    Logger
    ${crtl_c}    Evaluate    chr(int(3))
    Write Bare    ${crtl_c}
    ${output}=    Read Until Prompt
    Should Contain    ${output}    ^C

