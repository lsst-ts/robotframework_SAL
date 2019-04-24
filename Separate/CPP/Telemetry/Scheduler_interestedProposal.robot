*** Settings ***
Documentation    Scheduler InterestedProposal communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Scheduler
${component}    interestedProposal
${timeout}    30s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_sub

Start Subscriber
    [Tags]    functional
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_sub    alias=Subscriber
    Log    ${output}
    Should Contain    "${output}"   "1"

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_downtime test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_interestedProposal
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Scheduler subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}observationId : 1    10
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numProposals : 1    10
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 0    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 1    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 2    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 3    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 4    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 5    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 6    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 7    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 8    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 9    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalValues : 0    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalValues : 1    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalValues : 2    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalValues : 3    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalValues : 4    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalValues : 5    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalValues : 6    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalValues : 7    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalValues : 8    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalValues : 9    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalNeeds : 0    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalNeeds : 1    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalNeeds : 2    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalNeeds : 3    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalNeeds : 4    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalNeeds : 5    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalNeeds : 6    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalNeeds : 7    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalNeeds : 8    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalNeeds : 9    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBonuses : 0    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBonuses : 1    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBonuses : 2    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBonuses : 3    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBonuses : 4    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBonuses : 5    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBonuses : 6    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBonuses : 7    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBonuses : 8    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBonuses : 9    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBoosts : 0    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBoosts : 1    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBoosts : 2    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBoosts : 3    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBoosts : 4    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBoosts : 5    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBoosts : 6    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBoosts : 7    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBoosts : 8    1
    Should Contain X Times    ${interestedProposal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalBoosts : 9    1
