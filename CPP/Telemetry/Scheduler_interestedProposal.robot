*** Settings ***
Documentation    Scheduler_interestedProposal communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    scheduler
${component}    interestedProposal
${timeout}    30s

*** Test Cases ***
Create Publisher Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Publisher    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_${component}

Create Subscriber Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Subscriber    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_${component}

Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_sub

Start Subscriber
    [Tags]    functional
    Switch Connection    Subscriber
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}_${component}/cpp/standalone
    Comment    Start Subscriber.
    ${input}=    Write    ./sacpp_${subSystem}_sub
    ${output}=    Read Until    [Subscriber] Ready
    Log    ${output}
    Should Contain    ${output}    [Subscriber] Ready

Start Publisher
    [Tags]    functional
    Switch Connection    Publisher
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}_${component}/cpp/standalone
    Comment    Start Publisher.
    ${input}=    Write    ./sacpp_${subSystem}_pub
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    [putSample] ${subSystem}::${component} writing a message containing :    9
    Should Contain X Times    ${output}    revCode \ : LSST TEST REVCODE    9

Read Subscriber
    [Tags]    functional
    Switch Connection    Subscriber
    ${output}=    Read    delay=1s
    Log    ${output}
    Should Contain X Times    ${output}    observationId : 1    9
    Should Contain X Times    ${output}    num_proposals : 1    9
    Should Contain X Times    ${output}    proposal_Ids : 1    1
    Should Contain X Times    ${output}    proposal_Ids : 2    1
    Should Contain X Times    ${output}    proposal_Ids : 3    1
    Should Contain X Times    ${output}    proposal_Ids : 4    1
    Should Contain X Times    ${output}    proposal_Ids : 5    1
    Should Contain X Times    ${output}    proposal_Ids : 6    1
    Should Contain X Times    ${output}    proposal_Ids : 7    1
    Should Contain X Times    ${output}    proposal_Ids : 8    1
    Should Contain X Times    ${output}    proposal_Ids : 9    1
    Should Contain X Times    ${output}    proposal_values : 1    1
    Should Contain X Times    ${output}    proposal_values : 2    1
    Should Contain X Times    ${output}    proposal_values : 3    1
    Should Contain X Times    ${output}    proposal_values : 4    1
    Should Contain X Times    ${output}    proposal_values : 5    1
    Should Contain X Times    ${output}    proposal_values : 6    1
    Should Contain X Times    ${output}    proposal_values : 7    1
    Should Contain X Times    ${output}    proposal_values : 8    1
    Should Contain X Times    ${output}    proposal_values : 9    1
    Should Contain X Times    ${output}    proposal_needs : 1    1
    Should Contain X Times    ${output}    proposal_needs : 2    1
    Should Contain X Times    ${output}    proposal_needs : 3    1
    Should Contain X Times    ${output}    proposal_needs : 4    1
    Should Contain X Times    ${output}    proposal_needs : 5    1
    Should Contain X Times    ${output}    proposal_needs : 6    1
    Should Contain X Times    ${output}    proposal_needs : 7    1
    Should Contain X Times    ${output}    proposal_needs : 8    1
    Should Contain X Times    ${output}    proposal_needs : 9    1
    Should Contain X Times    ${output}    proposal_bonuses : 1    1
    Should Contain X Times    ${output}    proposal_bonuses : 2    1
    Should Contain X Times    ${output}    proposal_bonuses : 3    1
    Should Contain X Times    ${output}    proposal_bonuses : 4    1
    Should Contain X Times    ${output}    proposal_bonuses : 5    1
    Should Contain X Times    ${output}    proposal_bonuses : 6    1
    Should Contain X Times    ${output}    proposal_bonuses : 7    1
    Should Contain X Times    ${output}    proposal_bonuses : 8    1
    Should Contain X Times    ${output}    proposal_bonuses : 9    1
    Should Contain X Times    ${output}    proposal_boosts : 1    1
    Should Contain X Times    ${output}    proposal_boosts : 2    1
    Should Contain X Times    ${output}    proposal_boosts : 3    1
    Should Contain X Times    ${output}    proposal_boosts : 4    1
    Should Contain X Times    ${output}    proposal_boosts : 5    1
    Should Contain X Times    ${output}    proposal_boosts : 6    1
    Should Contain X Times    ${output}    proposal_boosts : 7    1
    Should Contain X Times    ${output}    proposal_boosts : 8    1
    Should Contain X Times    ${output}    proposal_boosts : 9    1
