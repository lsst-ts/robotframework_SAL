*** Settings ***
Documentation    Dome Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Dome
${component}    all
${timeout}    15s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber

Start Subscriber
    [Tags]    functional
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdout.txt
    Comment    Sleep for 6s to allow DDS time to register all the topics.
    Sleep    6s
    ${output}=    Get File    ${EXECDIR}${/}${subSystem}_stdout.txt
    Should Contain    ${output}    ===== Dome subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_summary test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_summary
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Dome_summary start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::summary_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Dome_summary end of topic ===
    Comment    ======= Verify ${subSystem}_domeADB_status test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_domeADB_status
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Dome_domeADB_status start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::domeADB_status_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Dome_domeADB_status end of topic ===
    Comment    ======= Verify ${subSystem}_domeAPS_status test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_domeAPS_status
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Dome_domeAPS_status start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::domeAPS_status_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Dome_domeAPS_status end of topic ===
    Comment    ======= Verify ${subSystem}_domeLouvers_status test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_domeLouvers_status
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Dome_domeLouvers_status start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::domeLouvers_status_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Dome_domeLouvers_status end of topic ===
    Comment    ======= Verify ${subSystem}_domeLWS_status test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_domeLWS_status
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Dome_domeLWS_status start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::domeLWS_status_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Dome_domeLWS_status end of topic ===
    Comment    ======= Verify ${subSystem}_domeMONCS_status test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_domeMONCS_status
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Dome_domeMONCS_status start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::domeMONCS_status_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Dome_domeMONCS_status end of topic ===
    Comment    ======= Verify ${subSystem}_domeTHCS_status test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_domeTHCS_status
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Dome_domeTHCS_status start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::domeTHCS_status_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Dome_domeTHCS_status end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Dome subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${summary_start}=    Get Index From List    ${full_list}    === Dome_summary start of topic ===
    ${summary_end}=    Get Index From List    ${full_list}    === Dome_summary end of topic ===
    ${summary_list}=    Get Slice From List    ${full_list}    start=${summary_start}    end=${summary_end}
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 0    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 1    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 2    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 3    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 4    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 5    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 6    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 7    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 8    1
    Should Contain X Times    ${summary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 9    1
    ${domeADB_status_start}=    Get Index From List    ${full_list}    === Dome_domeADB_status start of topic ===
    ${domeADB_status_end}=    Get Index From List    ${full_list}    === Dome_domeADB_status end of topic ===
    ${domeADB_status_list}=    Get Slice From List    ${full_list}    start=${domeADB_status_start}    end=${domeADB_status_end}
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 1    10
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 1    10
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 1    10
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 0    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 1    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 2    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 3    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 4    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 5    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 6    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 7    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 8    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 9    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 0    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 1    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 2    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 3    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 4    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 5    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 6    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 7    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 8    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 9    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 0    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 1    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 2    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 3    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 4    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 5    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 6    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 7    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 8    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 9    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 0    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 1    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 2    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 3    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 4    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 5    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 6    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 7    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 8    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 9    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 0    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 1    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 2    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 3    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 4    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 5    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 6    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 7    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 8    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 9    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 0    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 1    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 2    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 3    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 4    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 5    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 6    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 7    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 8    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 9    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 0    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 1    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 2    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 3    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 4    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 5    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 6    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 7    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 8    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 9    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 0    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 1    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 2    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 3    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 4    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 5    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 6    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 7    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 8    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 9    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 0    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 1    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 2    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 3    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 4    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 5    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 6    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 7    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 8    1
    Should Contain X Times    ${domeADB_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 9    1
    ${domeAPS_status_start}=    Get Index From List    ${full_list}    === Dome_domeAPS_status start of topic ===
    ${domeAPS_status_end}=    Get Index From List    ${full_list}    === Dome_domeAPS_status end of topic ===
    ${domeAPS_status_list}=    Get Slice From List    ${full_list}    start=${domeAPS_status_start}    end=${domeAPS_status_end}
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 1    10
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 1    10
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 1    10
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 0    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 1    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 2    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 3    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 4    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 5    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 6    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 7    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 8    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 9    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 0    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 1    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 2    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 3    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 4    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 5    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 6    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 7    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 8    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 9    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 0    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 1    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 2    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 3    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 4    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 5    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 6    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 7    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 8    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 9    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 0    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 1    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 2    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 3    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 4    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 5    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 6    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 7    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 8    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 9    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 0    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 1    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 2    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 3    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 4    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 5    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 6    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 7    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 8    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 9    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadRaw : 0    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadRaw : 1    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadRaw : 2    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadRaw : 3    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadRaw : 4    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadRaw : 5    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadRaw : 6    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadRaw : 7    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadRaw : 8    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadRaw : 9    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadCalibrated : 0    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadCalibrated : 1    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadCalibrated : 2    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadCalibrated : 3    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadCalibrated : 4    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadCalibrated : 5    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadCalibrated : 6    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadCalibrated : 7    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadCalibrated : 8    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadCalibrated : 9    1
    Should Contain X Times    ${domeAPS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerAbsortion : 1    10
    ${domeLouvers_status_start}=    Get Index From List    ${full_list}    === Dome_domeLouvers_status start of topic ===
    ${domeLouvers_status_end}=    Get Index From List    ${full_list}    === Dome_domeLouvers_status end of topic ===
    ${domeLouvers_status_list}=    Get Slice From List    ${full_list}    start=${domeLouvers_status_start}    end=${domeLouvers_status_end}
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 0    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 1    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 2    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 3    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 4    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 5    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 6    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 7    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 8    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 9    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 0    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 1    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 2    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 3    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 4    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 5    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 6    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 7    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 8    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 9    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 0    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 1    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 2    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 3    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 4    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 5    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 6    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 7    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 8    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 9    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 0    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 1    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 2    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 3    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 4    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 5    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 6    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 7    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 8    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 9    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 0    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 1    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 2    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 3    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 4    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 5    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 6    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 7    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 8    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 9    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 0    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 1    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 2    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 3    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 4    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 5    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 6    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 7    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 8    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 9    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 0    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 1    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 2    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 3    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 4    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 5    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 6    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 7    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 8    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 9    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 0    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 1    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 2    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 3    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 4    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 5    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 6    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 7    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 8    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 9    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 0    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 1    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 2    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 3    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 4    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 5    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 6    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 7    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 8    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 9    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 0    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 1    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 2    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 3    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 4    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 5    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 6    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 7    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 8    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 9    1
    Should Contain X Times    ${domeLouvers_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerAbsortion : 1    10
    ${domeLWS_status_start}=    Get Index From List    ${full_list}    === Dome_domeLWS_status start of topic ===
    ${domeLWS_status_end}=    Get Index From List    ${full_list}    === Dome_domeLWS_status end of topic ===
    ${domeLWS_status_list}=    Get Slice From List    ${full_list}    start=${domeLWS_status_start}    end=${domeLWS_status_end}
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 1    10
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 1    10
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 1    10
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 0    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 1    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 2    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 3    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 4    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 5    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 6    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 7    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 8    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 9    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 0    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 1    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 2    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 3    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 4    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 5    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 6    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 7    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 8    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 9    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 0    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 1    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 2    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 3    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 4    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 5    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 6    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 7    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 8    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 9    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 0    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 1    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 2    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 3    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 4    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 5    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 6    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 7    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 8    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 9    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 0    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 1    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 2    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 3    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 4    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 5    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 6    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 7    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 8    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 9    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 0    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 1    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 2    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 3    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 4    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 5    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 6    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 7    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 8    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 9    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 0    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 1    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 2    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 3    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 4    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 5    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 6    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 7    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 8    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 9    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 0    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 1    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 2    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 3    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 4    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 5    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 6    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 7    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 8    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 9    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 0    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 1    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 2    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 3    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 4    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 5    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 6    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 7    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 8    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 9    1
    Should Contain X Times    ${domeLWS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerAbsortion : 1    10
    ${domeMONCS_status_start}=    Get Index From List    ${full_list}    === Dome_domeMONCS_status start of topic ===
    ${domeMONCS_status_end}=    Get Index From List    ${full_list}    === Dome_domeMONCS_status end of topic ===
    ${domeMONCS_status_list}=    Get Slice From List    ${full_list}    start=${domeMONCS_status_start}    end=${domeMONCS_status_end}
    Should Contain X Times    ${domeMONCS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 0    1
    Should Contain X Times    ${domeMONCS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 1    1
    Should Contain X Times    ${domeMONCS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 2    1
    Should Contain X Times    ${domeMONCS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 3    1
    Should Contain X Times    ${domeMONCS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 4    1
    Should Contain X Times    ${domeMONCS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 5    1
    Should Contain X Times    ${domeMONCS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 6    1
    Should Contain X Times    ${domeMONCS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 7    1
    Should Contain X Times    ${domeMONCS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 8    1
    Should Contain X Times    ${domeMONCS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 9    1
    ${domeTHCS_status_start}=    Get Index From List    ${full_list}    === Dome_domeTHCS_status start of topic ===
    ${domeTHCS_status_end}=    Get Index From List    ${full_list}    === Dome_domeTHCS_status end of topic ===
    ${domeTHCS_status_list}=    Get Slice From List    ${full_list}    start=${domeTHCS_status_start}    end=${domeTHCS_status_end}
    Should Contain X Times    ${domeTHCS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 0    1
    Should Contain X Times    ${domeTHCS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 1    1
    Should Contain X Times    ${domeTHCS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 2    1
    Should Contain X Times    ${domeTHCS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 3    1
    Should Contain X Times    ${domeTHCS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 4    1
    Should Contain X Times    ${domeTHCS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 5    1
    Should Contain X Times    ${domeTHCS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 6    1
    Should Contain X Times    ${domeTHCS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 7    1
    Should Contain X Times    ${domeTHCS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 8    1
    Should Contain X Times    ${domeTHCS_status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 9    1
