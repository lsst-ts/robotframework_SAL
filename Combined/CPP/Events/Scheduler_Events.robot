*** Settings ***
Documentation    Scheduler_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Scheduler
${component}    all
${timeout}    45s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger

Start Logger
    [Tags]    functional
    Comment    Start Logger.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger    alias=${subSystem}_Logger     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"    "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    Comment    Wait 3s to allow full output to be written to file.
    Sleep    3s
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    === ${subSystem} loggers ready
    Sleep    6s

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_dependenciesVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_dependenciesVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event dependenciesVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_dependenciesVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event dependenciesVersions generated =
    Comment    ======= Verify ${subSystem}_target test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_target
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event target iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_target_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event target generated =
    Comment    ======= Verify ${subSystem}_invalidateTarget test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_invalidateTarget
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event invalidateTarget iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_invalidateTarget_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event invalidateTarget generated =
    Comment    ======= Verify ${subSystem}_needFilterSwap test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_needFilterSwap
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event needFilterSwap iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_needFilterSwap_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event needFilterSwap generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${dependenciesVersions_start}=    Get Index From List    ${full_list}    === Event dependenciesVersions received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${dependenciesVersions_start}
    ${dependenciesVersions_end}=    Evaluate    ${end}+${1}
    ${dependenciesVersions_list}=    Get Slice From List    ${full_list}    start=${dependenciesVersions_start}    end=${dependenciesVersions_end}
    Should Contain X Times    ${dependenciesVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : RO    1
    Should Contain X Times    ${dependenciesVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scheduler : RO    1
    Should Contain X Times    ${dependenciesVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cloudModel : RO    1
    Should Contain X Times    ${dependenciesVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}downtimeModel : RO    1
    Should Contain X Times    ${dependenciesVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}seeingModel : RO    1
    Should Contain X Times    ${dependenciesVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}skybrightnessModel : RO    1
    Should Contain X Times    ${dependenciesVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}observatoryModel : RO    1
    Should Contain X Times    ${dependenciesVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}observatoryLocation : RO    1
    Should Contain X Times    ${dependenciesVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${target_start}=    Get Index From List    ${full_list}    === Event target received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${target_start}
    ${target_end}=    Evaluate    ${end}+${1}
    ${target_list}=    Get Slice From List    ${full_list}    start=${target_start}    end=${target_end}
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetId : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}requestTime : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}requestMjd : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decl : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyAngle : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filter : RO    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numExposures : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposureTimes : 0    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}slewTime : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}offsetX : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}offsetY : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numProposals : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}proposalId : 0    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}isSequence : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequenceNVisits : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequenceVisits : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequenceDuration : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airmass : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyBrightness : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cloud : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}seeing : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonRa : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonDec : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonAlt : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonAz : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonDistance : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonPhase : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunRa : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunDec : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunAlt : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunAz : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}solarElong : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}note : RO    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${invalidateTarget_start}=    Get Index From List    ${full_list}    === Event invalidateTarget received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${invalidateTarget_start}
    ${invalidateTarget_end}=    Evaluate    ${end}+${1}
    ${invalidateTarget_list}=    Get Slice From List    ${full_list}    start=${invalidateTarget_start}    end=${invalidateTarget_end}
    Should Contain X Times    ${invalidateTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetId : 1    1
    Should Contain X Times    ${invalidateTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${needFilterSwap_start}=    Get Index From List    ${full_list}    === Event needFilterSwap received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${needFilterSwap_start}
    ${needFilterSwap_end}=    Evaluate    ${end}+${1}
    ${needFilterSwap_list}=    Get Slice From List    ${full_list}    start=${needFilterSwap_start}    end=${needFilterSwap_end}
    Should Contain X Times    ${needFilterSwap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}needSwap : 1    1
    Should Contain X Times    ${needFilterSwap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterToMount : RO    1
    Should Contain X Times    ${needFilterSwap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterToUnmount : RO    1
    Should Contain X Times    ${needFilterSwap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
