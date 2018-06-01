*** Settings ***
Documentation    AtCamera_endReadout communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atcamera
${component}    endReadout
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send SURKEAltkJOivNdCnsYexBynVlyaLqqHTCVMxQEOePlqBLdtyUcXnaZCXZQNvpBnADmMUJWKPNfzqnExACVrRYphyUtNvojmWmBexReVNefmyJJZedsnLiwBqfnccklHmFIctTXxHFKsLcdiSRviLVzMBqApmBBYLoLgtQSiBKWvlboHOhwMKrmNmJYxSDNCsASEDbtddAtWmPVvFhaFnzdQNcpGXgUpKfqeqcPxUlhSriiOxPhYsJDOypxaKdVn 1483925660 lfimBLUAinfbYqyaPoJgraeZSrhQdAHipXHHjBpvFjvlMibSAAfyGjHlfDrzcSzgAehODMhAjdacawcZuSqCsiaPBVKMgmTUbSVwNJXztSXAJGhjbcXpCODBSgSSDgGsbdstXCJcFgIUNulvOwLnZFcZuJVRBORUQfAuaRscUuRjsbGvSTZSSjwiDXTdeQBduZZoybmzkwCgKbbPFQgRfjtkKxfNuNTwpALLqqmifdXeIkaAagWnjBjhRozePcaq -1773810178 54.7342 75.4802 976992563
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atcamera::logevent_endReadout writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event endReadout generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 976992563
    Log    ${output}
    Should Contain X Times    ${output}    === Event endReadout received =     1
    Should Contain    ${output}    imageSequenceName : SURKEAltkJOivNdCnsYexBynVlyaLqqHTCVMxQEOePlqBLdtyUcXnaZCXZQNvpBnADmMUJWKPNfzqnExACVrRYphyUtNvojmWmBexReVNefmyJJZedsnLiwBqfnccklHmFIctTXxHFKsLcdiSRviLVzMBqApmBBYLoLgtQSiBKWvlboHOhwMKrmNmJYxSDNCsASEDbtddAtWmPVvFhaFnzdQNcpGXgUpKfqeqcPxUlhSriiOxPhYsJDOypxaKdVn
    Should Contain    ${output}    imagesInSequence : 1483925660
    Should Contain    ${output}    imageName : lfimBLUAinfbYqyaPoJgraeZSrhQdAHipXHHjBpvFjvlMibSAAfyGjHlfDrzcSzgAehODMhAjdacawcZuSqCsiaPBVKMgmTUbSVwNJXztSXAJGhjbcXpCODBSgSSDgGsbdstXCJcFgIUNulvOwLnZFcZuJVRBORUQfAuaRscUuRjsbGvSTZSSjwiDXTdeQBduZZoybmzkwCgKbbPFQgRfjtkKxfNuNTwpALLqqmifdXeIkaAagWnjBjhRozePcaq
    Should Contain    ${output}    imageIndex : -1773810178
    Should Contain    ${output}    timeStamp : 54.7342
    Should Contain    ${output}    exposureTime : 75.4802
    Should Contain    ${output}    priority : 976992563