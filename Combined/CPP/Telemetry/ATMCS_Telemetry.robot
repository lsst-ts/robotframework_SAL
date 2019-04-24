*** Settings ***
Documentation    ATMCS Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATMCS
${component}    all
${timeout}    30s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber

Start Subscriber
    [Tags]    functional
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=Subscriber
    Log    ${output}
    Should Contain    "${output}"   "1"
    ${object}=    Get Process Object    Subscriber
    Log    ${object.stdout.peek()}
    ${string}=    Convert To String    ${object.stdout.peek()}
    Should Contain    ${string}    ===== ATMCS subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_mountEncoders test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_mountEncoders
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATMCS_mountEncoders start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::mountEncoders_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATMCS_mountEncoders end of topic ===
    Comment    ======= Verify ${subSystem}_torqueDemand test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_torqueDemand
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATMCS_torqueDemand start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::torqueDemand_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATMCS_torqueDemand end of topic ===
    Comment    ======= Verify ${subSystem}_measuredTorque test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_measuredTorque
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATMCS_measuredTorque start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::measuredTorque_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATMCS_measuredTorque end of topic ===
    Comment    ======= Verify ${subSystem}_measuredMotorVelocity test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_measuredMotorVelocity
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATMCS_measuredMotorVelocity start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::measuredMotorVelocity_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATMCS_measuredMotorVelocity end of topic ===
    Comment    ======= Verify ${subSystem}_mountMotorEncoders test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_mountMotorEncoders
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATMCS_mountMotorEncoders start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::mountMotorEncoders_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATMCS_mountMotorEncoders end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ATMCS subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${mountEncoders_start}=    Get Index From List    ${full_list}    === ATMCS_mountEncoders start of topic ===
    ${mountEncoders_end}=    Get Index From List    ${full_list}    === ATMCS_mountEncoders end of topic ===
    ${mountEncoders_list}=    Get Slice From List    ${full_list}    start=${mountEncoders_start}    end=${mountEncoders_end}
    Should Contain X Times    ${mountEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 1    10
    Should Contain X Times    ${mountEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 1    10
    Should Contain X Times    ${mountEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1CalculatedAngle : 1    10
    Should Contain X Times    ${mountEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2CalculatedAngle : 1    10
    Should Contain X Times    ${mountEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder1Raw : 1    10
    Should Contain X Times    ${mountEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder2Raw : 1    10
    Should Contain X Times    ${mountEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder3Raw : 1    10
    Should Contain X Times    ${mountEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder1Raw : 1    10
    Should Contain X Times    ${mountEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder2Raw : 1    10
    Should Contain X Times    ${mountEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder3Raw : 1    10
    Should Contain X Times    ${mountEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder1Raw : 1    10
    Should Contain X Times    ${mountEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder2Raw : 1    10
    Should Contain X Times    ${mountEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder3Raw : 1    10
    Should Contain X Times    ${mountEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder1Raw : 1    10
    Should Contain X Times    ${mountEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder2Raw : 1    10
    Should Contain X Times    ${mountEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder3Raw : 1    10
    Should Contain X Times    ${mountEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    10
    ${torqueDemand_start}=    Get Index From List    ${full_list}    === ATMCS_torqueDemand start of topic ===
    ${torqueDemand_end}=    Get Index From List    ${full_list}    === ATMCS_torqueDemand end of topic ===
    ${torqueDemand_list}=    Get Slice From List    ${full_list}    start=${torqueDemand_start}    end=${torqueDemand_end}
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 1    10
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 1    10
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 1    10
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 1    10
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 1    10
    ${measuredTorque_start}=    Get Index From List    ${full_list}    === ATMCS_measuredTorque start of topic ===
    ${measuredTorque_end}=    Get Index From List    ${full_list}    === ATMCS_measuredTorque end of topic ===
    ${measuredTorque_list}=    Get Slice From List    ${full_list}    start=${measuredTorque_start}    end=${measuredTorque_end}
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 1    10
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 1    10
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 1    10
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 1    10
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 1    10
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Torque : 1    10
    ${measuredMotorVelocity_start}=    Get Index From List    ${full_list}    === ATMCS_measuredMotorVelocity start of topic ===
    ${measuredMotorVelocity_end}=    Get Index From List    ${full_list}    === ATMCS_measuredMotorVelocity end of topic ===
    ${measuredMotorVelocity_list}=    Get Slice From List    ${full_list}    start=${measuredMotorVelocity_start}    end=${measuredMotorVelocity_end}
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorVelocity : 1    10
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Velocity : 1    10
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Velocity : 1    10
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorVelocity : 1    10
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorVelocity : 1    10
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Velocity : 1    10
    ${mountMotorEncoders_start}=    Get Index From List    ${full_list}    === ATMCS_mountMotorEncoders start of topic ===
    ${mountMotorEncoders_end}=    Get Index From List    ${full_list}    === ATMCS_mountMotorEncoders end of topic ===
    ${mountMotorEncoders_list}=    Get Slice From List    ${full_list}    start=${mountMotorEncoders_start}    end=${mountMotorEncoders_end}
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1Encoder : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2Encoder : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Encoder : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRaw : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1EncoderRaw : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2EncoderRaw : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1EncoderRaw : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2EncoderRaw : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3EncoderRaw : 1    10
