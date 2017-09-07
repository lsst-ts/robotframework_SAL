*** Settings ***
Documentation    Sequencer_sequencerScriptEntititesInUse sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    sequencer
${component}    sequencerScriptEntititesInUse
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send uWoaehiXhwnCTPUWqfrpOnIXujUkZbNIzFvvGVKzcdysNejjcLyUPNhWJtVurKmOLGZypHUxqQiKVlTfdnRxHEAxNtPpsmoXqjWZgEuOrnSOCBosnJiAxyUEoWcmkruyJuuSDovWqPHygTMPwFxKPZYsDiSSPQDfLCDtQsIESaSpEkEzPcSAwKWmkMAypTtSXMJTGiSTGaFNBWyAsszpmqJcfnDTNukEoSebQJMdYdWhPdIhnPfHzULxdDcyMXCT 59.3889 WPgzSrhiZUHLFFEZjuPZCigkIeVCFeMKJfatFHgUruTWJUVrZLSdWlTvIzkJUpRdlfoFpeblivbXvhUDIGvfMqIkYyBPlyOKiJGBRtwqISSFWlvUrfOuoiwuQZuBKxIwiAZTqBToWoPrDxdkwJLsikWAwZhlKcylddyjMcewhuxqxYeiwgsfSJzLqFxbWqcFsMqnKZzQUTosctDJrEYFyeYAZacJVugesKPgILQuBHzdJXKRkaVwXgpkCiFugoFv VyiHIXYcoYWQhmgNauAdUnUkjIYlNJxZCVxUvKyiyXJAVZimVTghjabuaGtxRUAQsGWLrmHYukVXzkrtZvPFOgwjzviHOrzdWObHFtTQxfRHdQWzLecurgCQyIBZLvtcEDajKxuKLogdUDyfuZQQpKhsMhJRUevKYCnOkgozQoepNnnCStFpHIMpKUasEThntdMHQtzdDzcAfFlDMnZoSoKkKSkeXdmuKrCedZiVWbKHrZLofWNQYTBkZxSgWdoi -1190414201
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] sequencer::logevent_sequencerScriptEntititesInUse writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event sequencerScriptEntititesInUse generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1190414201
    Log    ${output}
    Should Contain X Times    ${output}    === Event sequencerScriptEntititesInUse received =     1
    Should Contain    ${output}    sequencerScriptName : uWoaehiXhwnCTPUWqfrpOnIXujUkZbNIzFvvGVKzcdysNejjcLyUPNhWJtVurKmOLGZypHUxqQiKVlTfdnRxHEAxNtPpsmoXqjWZgEuOrnSOCBosnJiAxyUEoWcmkruyJuuSDovWqPHygTMPwFxKPZYsDiSSPQDfLCDtQsIESaSpEkEzPcSAwKWmkMAypTtSXMJTGiSTGaFNBWyAsszpmqJcfnDTNukEoSebQJMdYdWhPdIhnPfHzULxdDcyMXCT
    Should Contain    ${output}    sequencerScriptIdentifier : 59.3889
    Should Contain    ${output}    sequencerScriptTimestamp : WPgzSrhiZUHLFFEZjuPZCigkIeVCFeMKJfatFHgUruTWJUVrZLSdWlTvIzkJUpRdlfoFpeblivbXvhUDIGvfMqIkYyBPlyOKiJGBRtwqISSFWlvUrfOuoiwuQZuBKxIwiAZTqBToWoPrDxdkwJLsikWAwZhlKcylddyjMcewhuxqxYeiwgsfSJzLqFxbWqcFsMqnKZzQUTosctDJrEYFyeYAZacJVugesKPgILQuBHzdJXKRkaVwXgpkCiFugoFv
    Should Contain    ${output}    sequencerEntititesList : VyiHIXYcoYWQhmgNauAdUnUkjIYlNJxZCVxUvKyiyXJAVZimVTghjabuaGtxRUAQsGWLrmHYukVXzkrtZvPFOgwjzviHOrzdWObHFtTQxfRHdQWzLecurgCQyIBZLvtcEDajKxuKLogdUDyfuZQQpKhsMhJRUevKYCnOkgozQoepNnnCStFpHIMpKUasEThntdMHQtzdDzcAfFlDMnZoSoKkKSkeXdmuKrCedZiVWbKHrZLofWNQYTBkZxSgWdoi
    Should Contain    ${output}    priority : -1190414201
