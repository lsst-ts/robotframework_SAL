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
    Comment    ======= Verify ${subSystem}_mirrorPositionMeasured test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_mirrorPositionMeasured
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_mirrorPositionMeasured start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::mirrorPositionMeasured_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_mirrorPositionMeasured end of topic ===
    Comment    ======= Verify ${subSystem}_axialForceData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_axialForceData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_axialForceData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::axialForceData_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_axialForceData end of topic ===
    Comment    ======= Verify ${subSystem}_tangentForceData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_tangentForceData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_tangentForceData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::tangentForceData_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_tangentForceData end of topic ===
    Comment    ======= Verify ${subSystem}_temperaturesMeasured test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_temperaturesMeasured
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_temperaturesMeasured start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::temperaturesMeasured_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_temperaturesMeasured end of topic ===
    Comment    ======= Verify ${subSystem}_zenithAngleData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_zenithAngleData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_zenithAngleData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::zenithAngleData_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_zenithAngleData end of topic ===
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

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTM2 subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${mirrorPositionMeasured_start}=    Get Index From List    ${full_list}    === MTM2_mirrorPositionMeasured start of topic ===
    ${mirrorPositionMeasured_end}=    Get Index From List    ${full_list}    === MTM2_mirrorPositionMeasured end of topic ===
    ${mirrorPositionMeasured_list}=    Get Slice From List    ${full_list}    start=${mirrorPositionMeasured_start}    end=${mirrorPositionMeasured_end}
    Should Contain X Times    ${mirrorPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}x : 1    10
    Should Contain X Times    ${mirrorPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}y : 1    10
    Should Contain X Times    ${mirrorPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}z : 1    10
    Should Contain X Times    ${mirrorPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xRot : 1    10
    Should Contain X Times    ${mirrorPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yRot : 1    10
    Should Contain X Times    ${mirrorPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zRot : 1    10
    ${axialForceData_start}=    Get Index From List    ${full_list}    === MTM2_axialForceData start of topic ===
    ${axialForceData_end}=    Get Index From List    ${full_list}    === MTM2_axialForceData end of topic ===
    ${axialForceData_list}=    Get Slice From List    ${full_list}    start=${axialForceData_start}    end=${axialForceData_end}
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesLutGravity : 0    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesLutGravity : 1    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesLutGravity : 2    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesLutGravity : 3    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesLutGravity : 4    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesLutGravity : 5    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesLutGravity : 6    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesLutGravity : 7    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesLutGravity : 8    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesLutGravity : 9    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesLutTemperature : 0    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesLutTemperature : 1    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesLutTemperature : 2    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesLutTemperature : 3    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesLutTemperature : 4    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesLutTemperature : 5    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesLutTemperature : 6    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesLutTemperature : 7    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesLutTemperature : 8    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesLutTemperature : 9    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesApplied : 0    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesApplied : 1    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesApplied : 2    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesApplied : 3    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesApplied : 4    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesApplied : 5    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesApplied : 6    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesApplied : 7    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesApplied : 8    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesApplied : 9    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesMeasured : 0    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesMeasured : 1    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesMeasured : 2    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesMeasured : 3    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesMeasured : 4    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesMeasured : 5    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesMeasured : 6    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesMeasured : 7    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesMeasured : 8    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesMeasured : 9    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesHardpointCorrection : 0    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesHardpointCorrection : 1    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesHardpointCorrection : 2    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesHardpointCorrection : 3    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesHardpointCorrection : 4    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesHardpointCorrection : 5    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesHardpointCorrection : 6    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesHardpointCorrection : 7    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesHardpointCorrection : 8    1
    Should Contain X Times    ${axialForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForcesHardpointCorrection : 9    1
    ${tangentForceData_start}=    Get Index From List    ${full_list}    === MTM2_tangentForceData start of topic ===
    ${tangentForceData_end}=    Get Index From List    ${full_list}    === MTM2_tangentForceData end of topic ===
    ${tangentForceData_list}=    Get Slice From List    ${full_list}    start=${tangentForceData_start}    end=${tangentForceData_end}
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesLutGravity : 0    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesLutGravity : 1    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesLutGravity : 2    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesLutGravity : 3    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesLutGravity : 4    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesLutGravity : 5    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesLutGravity : 6    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesLutGravity : 7    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesLutGravity : 8    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesLutGravity : 9    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesLutTemperature : 0    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesLutTemperature : 1    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesLutTemperature : 2    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesLutTemperature : 3    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesLutTemperature : 4    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesLutTemperature : 5    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesLutTemperature : 6    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesLutTemperature : 7    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesLutTemperature : 8    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesLutTemperature : 9    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesApplied : 0    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesApplied : 1    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesApplied : 2    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesApplied : 3    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesApplied : 4    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesApplied : 5    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesApplied : 6    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesApplied : 7    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesApplied : 8    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesApplied : 9    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesMeasured : 0    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesMeasured : 1    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesMeasured : 2    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesMeasured : 3    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesMeasured : 4    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesMeasured : 5    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesMeasured : 6    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesMeasured : 7    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesMeasured : 8    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesMeasured : 9    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesHardpointCorrection : 0    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesHardpointCorrection : 1    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesHardpointCorrection : 2    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesHardpointCorrection : 3    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesHardpointCorrection : 4    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesHardpointCorrection : 5    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesHardpointCorrection : 6    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesHardpointCorrection : 7    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesHardpointCorrection : 8    1
    Should Contain X Times    ${tangentForceData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentForcesHardpointCorrection : 9    1
    ${temperaturesMeasured_start}=    Get Index From List    ${full_list}    === MTM2_temperaturesMeasured start of topic ===
    ${temperaturesMeasured_end}=    Get Index From List    ${full_list}    === MTM2_temperaturesMeasured end of topic ===
    ${temperaturesMeasured_list}=    Get Slice From List    ${full_list}    start=${temperaturesMeasured_start}    end=${temperaturesMeasured_end}
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ringTemperature : 0    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ringTemperature : 1    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ringTemperature : 2    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ringTemperature : 3    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ringTemperature : 4    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ringTemperature : 5    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ringTemperature : 6    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ringTemperature : 7    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ringTemperature : 8    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ringTemperature : 9    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperature : 0    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperature : 1    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperature : 2    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperature : 3    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperature : 4    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperature : 5    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperature : 6    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperature : 7    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperature : 8    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperature : 9    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperature : 0    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperature : 1    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperature : 2    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperature : 3    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperature : 4    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperature : 5    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperature : 6    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperature : 7    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperature : 8    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperature : 9    1
    ${zenithAngleData_start}=    Get Index From List    ${full_list}    === MTM2_zenithAngleData start of topic ===
    ${zenithAngleData_end}=    Get Index From List    ${full_list}    === MTM2_zenithAngleData end of topic ===
    ${zenithAngleData_list}=    Get Slice From List    ${full_list}    start=${zenithAngleData_start}    end=${zenithAngleData_end}
    Should Contain X Times    ${zenithAngleData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zenithAngleMeasured : 1    10
    Should Contain X Times    ${zenithAngleData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAngleInclinometer : 1    10
    Should Contain X Times    ${zenithAngleData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}procAngleInclinometer : 1    10
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
