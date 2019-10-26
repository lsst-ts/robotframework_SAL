*** Settings ***
Documentation    MTAOS_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTAOS
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
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger    alias=Logger     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"    "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    === ${subSystem} loggers ready
    Sleep    6s

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_wavefrontError test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_wavefrontError
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event wavefrontError iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_wavefrontError_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event wavefrontError generated =
    Comment    ======= Verify ${subSystem}_rejectedWavefrontError test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedWavefrontError
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedWavefrontError iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedWavefrontError_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedWavefrontError generated =
    Comment    ======= Verify ${subSystem}_degreeOfFreedom test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_degreeOfFreedom
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event degreeOfFreedom iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_degreeOfFreedom_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event degreeOfFreedom generated =
    Comment    ======= Verify ${subSystem}_rejectedDegreeOfFreedom test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedDegreeOfFreedom
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedDegreeOfFreedom iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedDegreeOfFreedom_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedDegreeOfFreedom generated =
    Comment    ======= Verify ${subSystem}_m2HexapodCorrection test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m2HexapodCorrection
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event m2HexapodCorrection iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m2HexapodCorrection_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m2HexapodCorrection generated =
    Comment    ======= Verify ${subSystem}_rejectedM2HexapodCorrection test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedM2HexapodCorrection
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedM2HexapodCorrection iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedM2HexapodCorrection_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedM2HexapodCorrection generated =
    Comment    ======= Verify ${subSystem}_cameraHexapodCorrection test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_cameraHexapodCorrection
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event cameraHexapodCorrection iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_cameraHexapodCorrection_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event cameraHexapodCorrection generated =
    Comment    ======= Verify ${subSystem}_rejectedCameraHexapodCorrection test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedCameraHexapodCorrection
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedCameraHexapodCorrection iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedCameraHexapodCorrection_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedCameraHexapodCorrection generated =
    Comment    ======= Verify ${subSystem}_m1m3Correction test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m1m3Correction
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event m1m3Correction iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m1m3Correction_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m1m3Correction generated =
    Comment    ======= Verify ${subSystem}_rejectedM1M3Correction test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedM1M3Correction
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedM1M3Correction iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedM1M3Correction_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedM1M3Correction generated =
    Comment    ======= Verify ${subSystem}_m2Correction test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m2Correction
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event m2Correction iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m2Correction_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m2Correction generated =
    Comment    ======= Verify ${subSystem}_rejectedM2Correction test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedM2Correction
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedM2Correction iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedM2Correction_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedM2Correction generated =
    Comment    ======= Verify ${subSystem}_wepWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_wepWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event wepWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_wepWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event wepWarning generated =
    Comment    ======= Verify ${subSystem}_ofcWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_ofcWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event ofcWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_ofcWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event ofcWarning generated =
    Comment    ======= Verify ${subSystem}_settingVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingVersions generated =
    Comment    ======= Verify ${subSystem}_errorCode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_errorCode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event errorCode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_errorCode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event errorCode generated =
    Comment    ======= Verify ${subSystem}_summaryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_summaryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event summaryState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_summaryState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event summaryState generated =
    Comment    ======= Verify ${subSystem}_appliedSettingsMatchStart test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedSettingsMatchStart
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedSettingsMatchStart iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedSettingsMatchStart_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedSettingsMatchStart generated =
    Comment    ======= Verify ${subSystem}_logLevel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logLevel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event logLevel iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logLevel_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logLevel generated =
    Comment    ======= Verify ${subSystem}_logMessage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logMessage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event logMessage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logMessage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logMessage generated =
    Comment    ======= Verify ${subSystem}_simulationMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_simulationMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event simulationMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_simulationMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event simulationMode generated =
    Comment    ======= Verify ${subSystem}_softwareVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_softwareVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event softwareVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_softwareVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event softwareVersions generated =
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_heartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event heartbeat iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_heartbeat_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event heartbeat generated =

Read Logger
    [Tags]    functional
    Switch Process    Logger
    ${output}=    Wait For Process    handle=Logger    timeout=${timeout}    on_timeout=terminate
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
    ${settingVersions_start}=    Get Index From List    ${full_list}    === Event settingVersions received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingVersions_start}
    ${settingVersions_end}=    Evaluate    ${end}+${1}
    ${settingVersions_list}=    Get Slice From List    ${full_list}    start=${settingVersions_start}    end=${settingVersions_end}
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsVersion : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsLabels : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settingsUrl : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${errorCode_start}=    Get Index From List    ${full_list}    === Event errorCode received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${errorCode_start}
    ${errorCode_end}=    Evaluate    ${end}+${1}
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end}
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorReport : LSST    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : LSST    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${summaryState_start}=    Get Index From List    ${full_list}    === Event summaryState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${summaryState_start}
    ${summaryState_end}=    Evaluate    ${end}+${1}
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end}
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}summaryState : 1    1
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedSettingsMatchStart_start}=    Get Index From List    ${full_list}    === Event appliedSettingsMatchStart received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${appliedSettingsMatchStart_start}
    ${appliedSettingsMatchStart_end}=    Evaluate    ${end}+${1}
    ${appliedSettingsMatchStart_list}=    Get Slice From List    ${full_list}    start=${appliedSettingsMatchStart_start}    end=${appliedSettingsMatchStart_end}
    Should Contain X Times    ${appliedSettingsMatchStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}appliedSettingsMatchStartIsTrue : 1    1
    Should Contain X Times    ${appliedSettingsMatchStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logLevel_start}=    Get Index From List    ${full_list}    === Event logLevel received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${logLevel_start}
    ${logLevel_end}=    Evaluate    ${end}+${1}
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end}
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logMessage_start}=    Get Index From List    ${full_list}    === Event logMessage received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${logMessage_start}
    ${logMessage_end}=    Evaluate    ${end}+${1}
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end}
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}message : LSST    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : LSST    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${simulationMode_start}=    Get Index From List    ${full_list}    === Event simulationMode received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${simulationMode_start}
    ${simulationMode_end}=    Evaluate    ${end}+${1}
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end}
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === Event softwareVersions received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${softwareVersions_start}
    ${softwareVersions_end}=    Evaluate    ${end}+${1}
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end}
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xmlVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openSpliceVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cscVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystemVersions : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${heartbeat_start}=    Get Index From List    ${full_list}    === Event heartbeat received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${heartbeat_start}
    ${heartbeat_end}=    Evaluate    ${end}+${1}
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end}
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeat : 1    1
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
