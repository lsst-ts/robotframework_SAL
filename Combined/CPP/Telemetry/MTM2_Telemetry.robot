*** Settings ***
Documentation    MTM2 Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTM2
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
    Should Contain    ${output}    ===== MTM2 subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_position test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_position
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_position start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::position_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_position end of topic ===
    Comment    ======= Verify ${subSystem}_positionIMS test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_positionIMS
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_positionIMS start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::positionIMS_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_positionIMS end of topic ===
    Comment    ======= Verify ${subSystem}_axialForce test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_axialForce
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_axialForce start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::axialForce_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_axialForce end of topic ===
    Comment    ======= Verify ${subSystem}_tangentForce test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_tangentForce
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_tangentForce start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::tangentForce_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_tangentForce end of topic ===
    Comment    ======= Verify ${subSystem}_temperature test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_temperature
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_temperature start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::temperature_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_temperature end of topic ===
    Comment    ======= Verify ${subSystem}_zenithAngle test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_zenithAngle
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_zenithAngle start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::zenithAngle_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_zenithAngle end of topic ===
    Comment    ======= Verify ${subSystem}_axialActuatorSteps test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_axialActuatorSteps
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_axialActuatorSteps start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::axialActuatorSteps_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_axialActuatorSteps end of topic ===
    Comment    ======= Verify ${subSystem}_tangentActuatorSteps test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_tangentActuatorSteps
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_tangentActuatorSteps start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::tangentActuatorSteps_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_tangentActuatorSteps end of topic ===
    Comment    ======= Verify ${subSystem}_axialEncoderPositions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_axialEncoderPositions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_axialEncoderPositions start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::axialEncoderPositions_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_axialEncoderPositions end of topic ===
    Comment    ======= Verify ${subSystem}_tangentEncoderPositions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_tangentEncoderPositions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_tangentEncoderPositions start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::tangentEncoderPositions_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_tangentEncoderPositions end of topic ===
    Comment    ======= Verify ${subSystem}_ilcData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_ilcData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_ilcData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::ilcData_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_ilcData end of topic ===
    Comment    ======= Verify ${subSystem}_displacementSensors test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_displacementSensors
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_displacementSensors start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::displacementSensors_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_displacementSensors end of topic ===
    Comment    ======= Verify ${subSystem}_forceBalance test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_forceBalance
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_forceBalance start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::forceBalance_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_forceBalance end of topic ===
    Comment    ======= Verify ${subSystem}_netForcesTotal test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_netForcesTotal
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_netForcesTotal start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::netForcesTotal_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_netForcesTotal end of topic ===
    Comment    ======= Verify ${subSystem}_netMomentsTotal test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_netMomentsTotal
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_netMomentsTotal start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::netMomentsTotal_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_netMomentsTotal end of topic ===
    Comment    ======= Verify ${subSystem}_powerStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_powerStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_powerStatus start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::powerStatus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_powerStatus end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTM2 subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${position_start}=    Get Index From List    ${full_list}    === MTM2_position start of topic ===
    ${position_end}=    Get Index From List    ${full_list}    === MTM2_position end of topic ===
    ${position_list}=    Get Slice From List    ${full_list}    start=${position_start}    end=${position_end}
    Should Contain X Times    ${position_list}    ${SPACE}${SPACE}${SPACE}${SPACE}x : 1    10
    Should Contain X Times    ${position_list}    ${SPACE}${SPACE}${SPACE}${SPACE}y : 1    10
    Should Contain X Times    ${position_list}    ${SPACE}${SPACE}${SPACE}${SPACE}z : 1    10
    Should Contain X Times    ${position_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xRot : 1    10
    Should Contain X Times    ${position_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yRot : 1    10
    Should Contain X Times    ${position_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zRot : 1    10
    ${positionIMS_start}=    Get Index From List    ${full_list}    === MTM2_positionIMS start of topic ===
    ${positionIMS_end}=    Get Index From List    ${full_list}    === MTM2_positionIMS end of topic ===
    ${positionIMS_list}=    Get Slice From List    ${full_list}    start=${positionIMS_start}    end=${positionIMS_end}
    Should Contain X Times    ${positionIMS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}x : 1    10
    Should Contain X Times    ${positionIMS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}y : 1    10
    Should Contain X Times    ${positionIMS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}z : 1    10
    Should Contain X Times    ${positionIMS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xRot : 1    10
    Should Contain X Times    ${positionIMS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yRot : 1    10
    Should Contain X Times    ${positionIMS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zRot : 1    10
    ${axialForce_start}=    Get Index From List    ${full_list}    === MTM2_axialForce start of topic ===
    ${axialForce_end}=    Get Index From List    ${full_list}    === MTM2_axialForce end of topic ===
    ${axialForce_list}=    Get Slice From List    ${full_list}    start=${axialForce_start}    end=${axialForce_end}
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutGravity : 0    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutGravity : 1    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutGravity : 2    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutGravity : 3    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutGravity : 4    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutGravity : 5    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutGravity : 6    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutGravity : 7    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutGravity : 8    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutGravity : 9    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutTemperature : 0    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutTemperature : 1    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutTemperature : 2    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutTemperature : 3    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutTemperature : 4    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutTemperature : 5    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutTemperature : 6    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutTemperature : 7    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutTemperature : 8    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutTemperature : 9    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applied : 0    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applied : 1    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applied : 2    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applied : 3    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applied : 4    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applied : 5    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applied : 6    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applied : 7    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applied : 8    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applied : 9    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measured : 0    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measured : 1    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measured : 2    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measured : 3    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measured : 4    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measured : 5    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measured : 6    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measured : 7    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measured : 8    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measured : 9    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointCorrection : 0    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointCorrection : 1    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointCorrection : 2    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointCorrection : 3    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointCorrection : 4    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointCorrection : 5    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointCorrection : 6    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointCorrection : 7    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointCorrection : 8    1
    Should Contain X Times    ${axialForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointCorrection : 9    1
    ${tangentForce_start}=    Get Index From List    ${full_list}    === MTM2_tangentForce start of topic ===
    ${tangentForce_end}=    Get Index From List    ${full_list}    === MTM2_tangentForce end of topic ===
    ${tangentForce_list}=    Get Slice From List    ${full_list}    start=${tangentForce_start}    end=${tangentForce_end}
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutGravity : 0    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutGravity : 1    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutGravity : 2    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutGravity : 3    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutGravity : 4    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutGravity : 5    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutGravity : 6    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutGravity : 7    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutGravity : 8    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutGravity : 9    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutTemperature : 0    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutTemperature : 1    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutTemperature : 2    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutTemperature : 3    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutTemperature : 4    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutTemperature : 5    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutTemperature : 6    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutTemperature : 7    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutTemperature : 8    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lutTemperature : 9    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forcesApplied : 0    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forcesApplied : 1    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forcesApplied : 2    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forcesApplied : 3    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forcesApplied : 4    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forcesApplied : 5    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forcesApplied : 6    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forcesApplied : 7    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forcesApplied : 8    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forcesApplied : 9    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forcesMeasured : 0    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forcesMeasured : 1    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forcesMeasured : 2    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forcesMeasured : 3    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forcesMeasured : 4    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forcesMeasured : 5    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forcesMeasured : 6    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forcesMeasured : 7    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forcesMeasured : 8    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forcesMeasured : 9    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointCorrection : 0    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointCorrection : 1    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointCorrection : 2    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointCorrection : 3    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointCorrection : 4    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointCorrection : 5    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointCorrection : 6    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointCorrection : 7    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointCorrection : 8    1
    Should Contain X Times    ${tangentForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointCorrection : 9    1
    ${temperature_start}=    Get Index From List    ${full_list}    === MTM2_temperature start of topic ===
    ${temperature_end}=    Get Index From List    ${full_list}    === MTM2_temperature end of topic ===
    ${temperature_list}=    Get Slice From List    ${full_list}    start=${temperature_start}    end=${temperature_end}
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ring : 0    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ring : 1    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ring : 2    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ring : 3    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ring : 4    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ring : 5    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ring : 6    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ring : 7    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ring : 8    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ring : 9    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intake : 0    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intake : 1    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intake : 2    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intake : 3    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intake : 4    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intake : 5    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intake : 6    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intake : 7    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intake : 8    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intake : 9    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaust : 0    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaust : 1    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaust : 2    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaust : 3    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaust : 4    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaust : 5    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaust : 6    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaust : 7    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaust : 8    1
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaust : 9    1
    ${zenithAngle_start}=    Get Index From List    ${full_list}    === MTM2_zenithAngle start of topic ===
    ${zenithAngle_end}=    Get Index From List    ${full_list}    === MTM2_zenithAngle end of topic ===
    ${zenithAngle_list}=    Get Slice From List    ${full_list}    start=${zenithAngle_start}    end=${zenithAngle_end}
    Should Contain X Times    ${zenithAngle_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measured : 1    10
    Should Contain X Times    ${zenithAngle_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inclinometerRaw : 1    10
    Should Contain X Times    ${zenithAngle_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inclinometerProcessed : 1    10
    ${axialActuatorSteps_start}=    Get Index From List    ${full_list}    === MTM2_axialActuatorSteps start of topic ===
    ${axialActuatorSteps_end}=    Get Index From List    ${full_list}    === MTM2_axialActuatorSteps end of topic ===
    ${axialActuatorSteps_list}=    Get Slice From List    ${full_list}    start=${axialActuatorSteps_start}    end=${axialActuatorSteps_end}
    Should Contain X Times    ${axialActuatorSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialActuatorSteps : 0    1
    Should Contain X Times    ${axialActuatorSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialActuatorSteps : 1    1
    Should Contain X Times    ${axialActuatorSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialActuatorSteps : 2    1
    Should Contain X Times    ${axialActuatorSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialActuatorSteps : 3    1
    Should Contain X Times    ${axialActuatorSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialActuatorSteps : 4    1
    Should Contain X Times    ${axialActuatorSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialActuatorSteps : 5    1
    Should Contain X Times    ${axialActuatorSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialActuatorSteps : 6    1
    Should Contain X Times    ${axialActuatorSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialActuatorSteps : 7    1
    Should Contain X Times    ${axialActuatorSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialActuatorSteps : 8    1
    Should Contain X Times    ${axialActuatorSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialActuatorSteps : 9    1
    ${tangentActuatorSteps_start}=    Get Index From List    ${full_list}    === MTM2_tangentActuatorSteps start of topic ===
    ${tangentActuatorSteps_end}=    Get Index From List    ${full_list}    === MTM2_tangentActuatorSteps end of topic ===
    ${tangentActuatorSteps_list}=    Get Slice From List    ${full_list}    start=${tangentActuatorSteps_start}    end=${tangentActuatorSteps_end}
    Should Contain X Times    ${tangentActuatorSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentActuatorSteps : 0    1
    Should Contain X Times    ${tangentActuatorSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentActuatorSteps : 1    1
    Should Contain X Times    ${tangentActuatorSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentActuatorSteps : 2    1
    Should Contain X Times    ${tangentActuatorSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentActuatorSteps : 3    1
    Should Contain X Times    ${tangentActuatorSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentActuatorSteps : 4    1
    Should Contain X Times    ${tangentActuatorSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentActuatorSteps : 5    1
    Should Contain X Times    ${tangentActuatorSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentActuatorSteps : 6    1
    Should Contain X Times    ${tangentActuatorSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentActuatorSteps : 7    1
    Should Contain X Times    ${tangentActuatorSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentActuatorSteps : 8    1
    Should Contain X Times    ${tangentActuatorSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentActuatorSteps : 9    1
    ${axialEncoderPositions_start}=    Get Index From List    ${full_list}    === MTM2_axialEncoderPositions start of topic ===
    ${axialEncoderPositions_end}=    Get Index From List    ${full_list}    === MTM2_axialEncoderPositions end of topic ===
    ${axialEncoderPositions_list}=    Get Slice From List    ${full_list}    start=${axialEncoderPositions_start}    end=${axialEncoderPositions_end}
    Should Contain X Times    ${axialEncoderPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositions : 0    1
    Should Contain X Times    ${axialEncoderPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositions : 1    1
    Should Contain X Times    ${axialEncoderPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositions : 2    1
    Should Contain X Times    ${axialEncoderPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositions : 3    1
    Should Contain X Times    ${axialEncoderPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositions : 4    1
    Should Contain X Times    ${axialEncoderPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositions : 5    1
    Should Contain X Times    ${axialEncoderPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositions : 6    1
    Should Contain X Times    ${axialEncoderPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositions : 7    1
    Should Contain X Times    ${axialEncoderPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositions : 8    1
    Should Contain X Times    ${axialEncoderPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositions : 9    1
    ${tangentEncoderPositions_start}=    Get Index From List    ${full_list}    === MTM2_tangentEncoderPositions start of topic ===
    ${tangentEncoderPositions_end}=    Get Index From List    ${full_list}    === MTM2_tangentEncoderPositions end of topic ===
    ${tangentEncoderPositions_list}=    Get Slice From List    ${full_list}    start=${tangentEncoderPositions_start}    end=${tangentEncoderPositions_end}
    Should Contain X Times    ${tangentEncoderPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentEncoderPositions : 0    1
    Should Contain X Times    ${tangentEncoderPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentEncoderPositions : 1    1
    Should Contain X Times    ${tangentEncoderPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentEncoderPositions : 2    1
    Should Contain X Times    ${tangentEncoderPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentEncoderPositions : 3    1
    Should Contain X Times    ${tangentEncoderPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentEncoderPositions : 4    1
    Should Contain X Times    ${tangentEncoderPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentEncoderPositions : 5    1
    Should Contain X Times    ${tangentEncoderPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentEncoderPositions : 6    1
    Should Contain X Times    ${tangentEncoderPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentEncoderPositions : 7    1
    Should Contain X Times    ${tangentEncoderPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentEncoderPositions : 8    1
    Should Contain X Times    ${tangentEncoderPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentEncoderPositions : 9    1
    ${ilcData_start}=    Get Index From List    ${full_list}    === MTM2_ilcData start of topic ===
    ${ilcData_end}=    Get Index From List    ${full_list}    === MTM2_ilcData end of topic ===
    ${ilcData_list}=    Get Slice From List    ${full_list}    start=${ilcData_start}    end=${ilcData_end}
    Should Contain X Times    ${ilcData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 0    1
    Should Contain X Times    ${ilcData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 1    1
    Should Contain X Times    ${ilcData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 2    1
    Should Contain X Times    ${ilcData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 3    1
    Should Contain X Times    ${ilcData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 4    1
    Should Contain X Times    ${ilcData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 5    1
    Should Contain X Times    ${ilcData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 6    1
    Should Contain X Times    ${ilcData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 7    1
    Should Contain X Times    ${ilcData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 8    1
    Should Contain X Times    ${ilcData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 9    1
    ${displacementSensors_start}=    Get Index From List    ${full_list}    === MTM2_displacementSensors start of topic ===
    ${displacementSensors_end}=    Get Index From List    ${full_list}    === MTM2_displacementSensors end of topic ===
    ${displacementSensors_list}=    Get Slice From List    ${full_list}    start=${displacementSensors_start}    end=${displacementSensors_end}
    Should Contain X Times    ${displacementSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thetaZ : 0    1
    Should Contain X Times    ${displacementSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thetaZ : 1    1
    Should Contain X Times    ${displacementSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thetaZ : 2    1
    Should Contain X Times    ${displacementSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thetaZ : 3    1
    Should Contain X Times    ${displacementSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thetaZ : 4    1
    Should Contain X Times    ${displacementSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thetaZ : 5    1
    Should Contain X Times    ${displacementSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thetaZ : 6    1
    Should Contain X Times    ${displacementSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thetaZ : 7    1
    Should Contain X Times    ${displacementSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thetaZ : 8    1
    Should Contain X Times    ${displacementSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thetaZ : 9    1
    Should Contain X Times    ${displacementSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}deltaZ : 0    1
    Should Contain X Times    ${displacementSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}deltaZ : 1    1
    Should Contain X Times    ${displacementSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}deltaZ : 2    1
    Should Contain X Times    ${displacementSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}deltaZ : 3    1
    Should Contain X Times    ${displacementSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}deltaZ : 4    1
    Should Contain X Times    ${displacementSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}deltaZ : 5    1
    Should Contain X Times    ${displacementSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}deltaZ : 6    1
    Should Contain X Times    ${displacementSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}deltaZ : 7    1
    Should Contain X Times    ${displacementSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}deltaZ : 8    1
    Should Contain X Times    ${displacementSensors_list}    ${SPACE}${SPACE}${SPACE}${SPACE}deltaZ : 9    1
    ${forceBalance_start}=    Get Index From List    ${full_list}    === MTM2_forceBalance start of topic ===
    ${forceBalance_end}=    Get Index From List    ${full_list}    === MTM2_forceBalance end of topic ===
    ${forceBalance_list}=    Get Slice From List    ${full_list}    start=${forceBalance_start}    end=${forceBalance_end}
    Should Contain X Times    ${forceBalance_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    10
    Should Contain X Times    ${forceBalance_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    10
    Should Contain X Times    ${forceBalance_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    10
    Should Contain X Times    ${forceBalance_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    10
    Should Contain X Times    ${forceBalance_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    10
    Should Contain X Times    ${forceBalance_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    10
    ${netForcesTotal_start}=    Get Index From List    ${full_list}    === MTM2_netForcesTotal start of topic ===
    ${netForcesTotal_end}=    Get Index From List    ${full_list}    === MTM2_netForcesTotal end of topic ===
    ${netForcesTotal_list}=    Get Slice From List    ${full_list}    start=${netForcesTotal_start}    end=${netForcesTotal_end}
    Should Contain X Times    ${netForcesTotal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    10
    Should Contain X Times    ${netForcesTotal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    10
    Should Contain X Times    ${netForcesTotal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    10
    ${netMomentsTotal_start}=    Get Index From List    ${full_list}    === MTM2_netMomentsTotal start of topic ===
    ${netMomentsTotal_end}=    Get Index From List    ${full_list}    === MTM2_netMomentsTotal end of topic ===
    ${netMomentsTotal_list}=    Get Slice From List    ${full_list}    start=${netMomentsTotal_start}    end=${netMomentsTotal_end}
    Should Contain X Times    ${netMomentsTotal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    10
    Should Contain X Times    ${netMomentsTotal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    10
    Should Contain X Times    ${netMomentsTotal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    10
    ${powerStatus_start}=    Get Index From List    ${full_list}    === MTM2_powerStatus start of topic ===
    ${powerStatus_end}=    Get Index From List    ${full_list}    === MTM2_powerStatus end of topic ===
    ${powerStatus_list}=    Get Slice From List    ${full_list}    start=${powerStatus_start}    end=${powerStatus_end}
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorVoltage : 1    10
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 1    10
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commVoltage : 1    10
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commCurrent : 1    10
