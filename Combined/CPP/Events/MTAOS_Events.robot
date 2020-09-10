*** Settings ***
Documentation    MTAOS_Events communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}common.robot
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTAOS
${component}    all
${timeout}    90s

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
    Wait Until Keyword Succeeds    90s    5s    File Should Contain    ${EXECDIR}${/}stdout.txt    === ${subSystem} loggers ready
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Log    ${output}

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_wavefrontError test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_wavefrontError
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event wavefrontError iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_wavefrontError_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event wavefrontError generated =
    Comment    ======= Verify ${subSystem}_rejectedWavefrontError test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedWavefrontError
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedWavefrontError iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedWavefrontError_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedWavefrontError generated =
    Comment    ======= Verify ${subSystem}_degreeOfFreedom test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_degreeOfFreedom
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event degreeOfFreedom iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_degreeOfFreedom_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event degreeOfFreedom generated =
    Comment    ======= Verify ${subSystem}_rejectedDegreeOfFreedom test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedDegreeOfFreedom
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedDegreeOfFreedom iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedDegreeOfFreedom_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedDegreeOfFreedom generated =
    Comment    ======= Verify ${subSystem}_m2HexapodCorrection test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m2HexapodCorrection
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event m2HexapodCorrection iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m2HexapodCorrection_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m2HexapodCorrection generated =
    Comment    ======= Verify ${subSystem}_rejectedM2HexapodCorrection test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedM2HexapodCorrection
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedM2HexapodCorrection iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedM2HexapodCorrection_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedM2HexapodCorrection generated =
    Comment    ======= Verify ${subSystem}_cameraHexapodCorrection test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_cameraHexapodCorrection
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event cameraHexapodCorrection iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_cameraHexapodCorrection_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event cameraHexapodCorrection generated =
    Comment    ======= Verify ${subSystem}_rejectedCameraHexapodCorrection test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedCameraHexapodCorrection
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedCameraHexapodCorrection iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedCameraHexapodCorrection_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedCameraHexapodCorrection generated =
    Comment    ======= Verify ${subSystem}_m1m3Correction test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m1m3Correction
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event m1m3Correction iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m1m3Correction_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m1m3Correction generated =
    Comment    ======= Verify ${subSystem}_rejectedM1M3Correction test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedM1M3Correction
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedM1M3Correction iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedM1M3Correction_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedM1M3Correction generated =
    Comment    ======= Verify ${subSystem}_m2Correction test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m2Correction
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event m2Correction iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m2Correction_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m2Correction generated =
    Comment    ======= Verify ${subSystem}_rejectedM2Correction test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedM2Correction
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedM2Correction iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedM2Correction_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedM2Correction generated =
    Comment    ======= Verify ${subSystem}_wepWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_wepWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event wepWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_wepWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event wepWarning generated =
    Comment    ======= Verify ${subSystem}_ofcWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_ofcWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event ofcWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_ofcWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event ofcWarning generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${wavefrontError_start}=    Get Index From List    ${full_list}    === Event wavefrontError received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${wavefrontError_start}
    ${wavefrontError_end}=    Evaluate    ${end}+${1}
    ${wavefrontError_list}=    Get Slice From List    ${full_list}    start=${wavefrontError_start}    end=${wavefrontError_end}
    Should Contain X Times    ${wavefrontError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${wavefrontError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorId : 1    1
    Should Contain X Times    ${wavefrontError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}annularZernikePoly : 0    1
    Should Contain X Times    ${wavefrontError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedWavefrontError_start}=    Get Index From List    ${full_list}    === Event rejectedWavefrontError received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${rejectedWavefrontError_start}
    ${rejectedWavefrontError_end}=    Evaluate    ${end}+${1}
    ${rejectedWavefrontError_list}=    Get Slice From List    ${full_list}    start=${rejectedWavefrontError_start}    end=${rejectedWavefrontError_end}
    Should Contain X Times    ${rejectedWavefrontError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${rejectedWavefrontError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensorId : 1    1
    Should Contain X Times    ${rejectedWavefrontError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}annularZernikePoly : 0    1
    Should Contain X Times    ${rejectedWavefrontError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${degreeOfFreedom_start}=    Get Index From List    ${full_list}    === Event degreeOfFreedom received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${degreeOfFreedom_start}
    ${degreeOfFreedom_end}=    Evaluate    ${end}+${1}
    ${degreeOfFreedom_list}=    Get Slice From List    ${full_list}    start=${degreeOfFreedom_start}    end=${degreeOfFreedom_end}
    Should Contain X Times    ${degreeOfFreedom_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${degreeOfFreedom_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aggregatedDoF : 0    1
    Should Contain X Times    ${degreeOfFreedom_list}    ${SPACE}${SPACE}${SPACE}${SPACE}visitDoF : 0    1
    Should Contain X Times    ${degreeOfFreedom_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedDegreeOfFreedom_start}=    Get Index From List    ${full_list}    === Event rejectedDegreeOfFreedom received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${rejectedDegreeOfFreedom_start}
    ${rejectedDegreeOfFreedom_end}=    Evaluate    ${end}+${1}
    ${rejectedDegreeOfFreedom_list}=    Get Slice From List    ${full_list}    start=${rejectedDegreeOfFreedom_start}    end=${rejectedDegreeOfFreedom_end}
    Should Contain X Times    ${rejectedDegreeOfFreedom_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${rejectedDegreeOfFreedom_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aggregatedDoF : 0    1
    Should Contain X Times    ${rejectedDegreeOfFreedom_list}    ${SPACE}${SPACE}${SPACE}${SPACE}visitDoF : 0    1
    Should Contain X Times    ${rejectedDegreeOfFreedom_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m2HexapodCorrection_start}=    Get Index From List    ${full_list}    === Event m2HexapodCorrection received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m2HexapodCorrection_start}
    ${m2HexapodCorrection_end}=    Evaluate    ${end}+${1}
    ${m2HexapodCorrection_list}=    Get Slice From List    ${full_list}    start=${m2HexapodCorrection_start}    end=${m2HexapodCorrection_end}
    Should Contain X Times    ${m2HexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${m2HexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}x : 1    1
    Should Contain X Times    ${m2HexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}y : 1    1
    Should Contain X Times    ${m2HexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}z : 1    1
    Should Contain X Times    ${m2HexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}u : 1    1
    Should Contain X Times    ${m2HexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}v : 1    1
    Should Contain X Times    ${m2HexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}w : 1    1
    Should Contain X Times    ${m2HexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedM2HexapodCorrection_start}=    Get Index From List    ${full_list}    === Event rejectedM2HexapodCorrection received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${rejectedM2HexapodCorrection_start}
    ${rejectedM2HexapodCorrection_end}=    Evaluate    ${end}+${1}
    ${rejectedM2HexapodCorrection_list}=    Get Slice From List    ${full_list}    start=${rejectedM2HexapodCorrection_start}    end=${rejectedM2HexapodCorrection_end}
    Should Contain X Times    ${rejectedM2HexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${rejectedM2HexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}x : 1    1
    Should Contain X Times    ${rejectedM2HexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}y : 1    1
    Should Contain X Times    ${rejectedM2HexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}z : 1    1
    Should Contain X Times    ${rejectedM2HexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}u : 1    1
    Should Contain X Times    ${rejectedM2HexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}v : 1    1
    Should Contain X Times    ${rejectedM2HexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}w : 1    1
    Should Contain X Times    ${rejectedM2HexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${cameraHexapodCorrection_start}=    Get Index From List    ${full_list}    === Event cameraHexapodCorrection received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${cameraHexapodCorrection_start}
    ${cameraHexapodCorrection_end}=    Evaluate    ${end}+${1}
    ${cameraHexapodCorrection_list}=    Get Slice From List    ${full_list}    start=${cameraHexapodCorrection_start}    end=${cameraHexapodCorrection_end}
    Should Contain X Times    ${cameraHexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${cameraHexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}x : 1    1
    Should Contain X Times    ${cameraHexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}y : 1    1
    Should Contain X Times    ${cameraHexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}z : 1    1
    Should Contain X Times    ${cameraHexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}u : 1    1
    Should Contain X Times    ${cameraHexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}v : 1    1
    Should Contain X Times    ${cameraHexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}w : 1    1
    Should Contain X Times    ${cameraHexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedCameraHexapodCorrection_start}=    Get Index From List    ${full_list}    === Event rejectedCameraHexapodCorrection received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${rejectedCameraHexapodCorrection_start}
    ${rejectedCameraHexapodCorrection_end}=    Evaluate    ${end}+${1}
    ${rejectedCameraHexapodCorrection_list}=    Get Slice From List    ${full_list}    start=${rejectedCameraHexapodCorrection_start}    end=${rejectedCameraHexapodCorrection_end}
    Should Contain X Times    ${rejectedCameraHexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${rejectedCameraHexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}x : 1    1
    Should Contain X Times    ${rejectedCameraHexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}y : 1    1
    Should Contain X Times    ${rejectedCameraHexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}z : 1    1
    Should Contain X Times    ${rejectedCameraHexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}u : 1    1
    Should Contain X Times    ${rejectedCameraHexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}v : 1    1
    Should Contain X Times    ${rejectedCameraHexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}w : 1    1
    Should Contain X Times    ${rejectedCameraHexapodCorrection_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m1m3Correction_start}=    Get Index From List    ${full_list}    === Event m1m3Correction received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m1m3Correction_start}
    ${m1m3Correction_end}=    Evaluate    ${end}+${1}
    ${m1m3Correction_list}=    Get Slice From List    ${full_list}    start=${m1m3Correction_start}    end=${m1m3Correction_end}
    Should Contain X Times    ${m1m3Correction_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${m1m3Correction_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${m1m3Correction_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedM1M3Correction_start}=    Get Index From List    ${full_list}    === Event rejectedM1M3Correction received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${rejectedM1M3Correction_start}
    ${rejectedM1M3Correction_end}=    Evaluate    ${end}+${1}
    ${rejectedM1M3Correction_list}=    Get Slice From List    ${full_list}    start=${rejectedM1M3Correction_start}    end=${rejectedM1M3Correction_end}
    Should Contain X Times    ${rejectedM1M3Correction_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${rejectedM1M3Correction_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${rejectedM1M3Correction_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m2Correction_start}=    Get Index From List    ${full_list}    === Event m2Correction received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m2Correction_start}
    ${m2Correction_end}=    Evaluate    ${end}+${1}
    ${m2Correction_list}=    Get Slice From List    ${full_list}    start=${m2Correction_start}    end=${m2Correction_end}
    Should Contain X Times    ${m2Correction_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${m2Correction_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${m2Correction_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedM2Correction_start}=    Get Index From List    ${full_list}    === Event rejectedM2Correction received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${rejectedM2Correction_start}
    ${rejectedM2Correction_end}=    Evaluate    ${end}+${1}
    ${rejectedM2Correction_list}=    Get Slice From List    ${full_list}    start=${rejectedM2Correction_start}    end=${rejectedM2Correction_end}
    Should Contain X Times    ${rejectedM2Correction_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${rejectedM2Correction_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${rejectedM2Correction_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${wepWarning_start}=    Get Index From List    ${full_list}    === Event wepWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${wepWarning_start}
    ${wepWarning_end}=    Evaluate    ${end}+${1}
    ${wepWarning_list}=    Get Slice From List    ${full_list}    start=${wepWarning_start}    end=${wepWarning_end}
    Should Contain X Times    ${wepWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${wepWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}warning : 1    1
    Should Contain X Times    ${wepWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${ofcWarning_start}=    Get Index From List    ${full_list}    === Event ofcWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${ofcWarning_start}
    ${ofcWarning_end}=    Evaluate    ${end}+${1}
    ${ofcWarning_list}=    Get Slice From List    ${full_list}    start=${ofcWarning_start}    end=${ofcWarning_end}
    Should Contain X Times    ${ofcWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${ofcWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}warning : 1    1
    Should Contain X Times    ${ofcWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
