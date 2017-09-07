*** Settings ***
Documentation    Sequencer_sequencerEntityShutdown sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    sequencer
${component}    sequencerEntityShutdown
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send yZRiQiORSYXWHwDSEPvNrWDoENFQMzEDduOOfuhLBXIZMdtOmLIWfsdxTiruTenLIfcThUVLvSZyNbbgXWmHHRFygBrWSOPcQwHejdEoOsNyUkobQorLinauLobeRCTj 60.4038 nMAiYBehCcJMZmAlEllPvVNzIJIvRcjyuQSXOVyjxsygRGqsszAMrtxaLqucyZxdplmWwgfztHUTQsQzcqettpKsZjqRhwerWoqgaTAPsycFgjgrClKJqLGfKRaojQKyrLGIVlAwQfLuATEgAERzXwoUPaNqSSghLwaSBCevnKEUcUbzOvoHckSFAQkiWcTFkDKIxoJjEWGIZWzFJuLCvdhyUndhNhZZvPznGxSAPsgMaXroRgNLyicPuDuqkBcy -2102551096 -185436902
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] sequencer::logevent_sequencerEntityShutdown writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event sequencerEntityShutdown generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -185436902
    Log    ${output}
    Should Contain X Times    ${output}    === Event sequencerEntityShutdown received =     1
    Should Contain    ${output}    Name : yZRiQiORSYXWHwDSEPvNrWDoENFQMzEDduOOfuhLBXIZMdtOmLIWfsdxTiruTenLIfcThUVLvSZyNbbgXWmHHRFygBrWSOPcQwHejdEoOsNyUkobQorLinauLobeRCTj
    Should Contain    ${output}    Identifier : 60.4038
    Should Contain    ${output}    Timestamp : nMAiYBehCcJMZmAlEllPvVNzIJIvRcjyuQSXOVyjxsygRGqsszAMrtxaLqucyZxdplmWwgfztHUTQsQzcqettpKsZjqRhwerWoqgaTAPsycFgjgrClKJqLGfKRaojQKyrLGIVlAwQfLuATEgAERzXwoUPaNqSSghLwaSBCevnKEUcUbzOvoHckSFAQkiWcTFkDKIxoJjEWGIZWzFJuLCvdhyUndhNhZZvPznGxSAPsgMaXroRgNLyicPuDuqkBcy
    Should Contain    ${output}    Address : -2102551096
    Should Contain    ${output}    priority : -185436902
