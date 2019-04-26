*** Settings ***
Documentation    Scheduler ObservatoryState communications tests.
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
${component}    observatoryState
${timeout}    15s

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
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    ===== Scheduler subscribers ready =====
    Sleep    6s

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_downtime test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_observatoryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Scheduler subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingRa : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingDec : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingAngle : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingAltitude : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingAzimuth : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingPa : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingRot : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tracking : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telescopeAltitude : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telescopeAzimuth : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telescopeRotator : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}domeAltitude : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}domeAzimuth : 1    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterPosition : LSST    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterMounted : LSST    10
    Should Contain X Times    ${observatoryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterUnmounted : LSST    10
