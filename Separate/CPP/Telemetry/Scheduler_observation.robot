*** Settings ***
Documentation    Scheduler Observation communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Scheduler
${component}    
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
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : LSST TEST REVCODE    10

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=10    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ${subSystem} subscriber Ready
    @{list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}observationId : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}observationStartTime : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}observationStartMjd : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}observationStartLst : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}night : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetId : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}fieldId : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}groupId : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}filter : LSST    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}numProposals : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalIds : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}decl : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}angle : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}altitude : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}numExposures : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 1    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 2    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 3    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 4    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 5    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 6    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 7    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 8    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 9    1
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}visitTime : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyBrightness : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}airmass : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}cloud : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}seeingFwhm500 : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}seeingFwhmGeom : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}seeingFwhmEff : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}fiveSigmaDepth : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonRa : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonDec : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonAlt : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonAz : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonPhase : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonDistance : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunAlt : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunAz : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunRa : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunDec : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}solarElong : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}slewTime : 1    10
    Should Contain X Times    ${list}    ${SPACE}${SPACE}${SPACE}${SPACE}note : LSST    10