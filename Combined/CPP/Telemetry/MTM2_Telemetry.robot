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
    Comment    ======= Verify ${subSystem}_axialForcesMeasured test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_axialForcesMeasured
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_axialForcesMeasured start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::axialForcesMeasured_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_axialForcesMeasured end of topic ===
    Comment    ======= Verify ${subSystem}_tangentForcesMeasured test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_tangentForcesMeasured
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_tangentForcesMeasured start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::tangentForcesMeasured_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_tangentForcesMeasured end of topic ===
    Comment    ======= Verify ${subSystem}_zenithAngleMeasured test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_zenithAngleMeasured
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_zenithAngleMeasured start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::zenithAngleMeasured_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_zenithAngleMeasured end of topic ===
    Comment    ======= Verify ${subSystem}_axialActuatorAbsolutePositionSteps test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_axialActuatorAbsolutePositionSteps
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_axialActuatorAbsolutePositionSteps start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::axialActuatorAbsolutePositionSteps_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_axialActuatorAbsolutePositionSteps end of topic ===
    Comment    ======= Verify ${subSystem}_tangentActuatorAbsolutePositionSteps test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_tangentActuatorAbsolutePositionSteps
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_tangentActuatorAbsolutePositionSteps start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::tangentActuatorAbsolutePositionSteps_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_tangentActuatorAbsolutePositionSteps end of topic ===
    Comment    ======= Verify ${subSystem}_axialActuatorPositionAbsoluteEncoderPositionMeasured test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_axialActuatorPositionAbsoluteEncoderPositionMeasured
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_axialActuatorPositionAbsoluteEncoderPositionMeasured start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::axialActuatorPositionAbsoluteEncoderPositionMeasured_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_axialActuatorPositionAbsoluteEncoderPositionMeasured end of topic ===
    Comment    ======= Verify ${subSystem}_tangentActuatorPositionAbsoluteEncoderPositionMeasured test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_tangentActuatorPositionAbsoluteEncoderPositionMeasured
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_tangentActuatorPositionAbsoluteEncoderPositionMeasured start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::tangentActuatorPositionAbsoluteEncoderPositionMeasured_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_tangentActuatorPositionAbsoluteEncoderPositionMeasured end of topic ===
    Comment    ======= Verify ${subSystem}_powerStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_powerStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_powerStatus start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::powerStatus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_powerStatus end of topic ===
    Comment    ======= Verify ${subSystem}_temperaturesMeasured test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_temperaturesMeasured
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_temperaturesMeasured start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::temperaturesMeasured_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_temperaturesMeasured end of topic ===
    Comment    ======= Verify ${subSystem}_rawDisplacement test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_rawDisplacement
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_rawDisplacement start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::rawDisplacement_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_rawDisplacement end of topic ===
    Comment    ======= Verify ${subSystem}_stepVectorUpdate test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_stepVectorUpdate
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_stepVectorUpdate start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::stepVectorUpdate_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_stepVectorUpdate end of topic ===
    Comment    ======= Verify ${subSystem}_targetForces test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_targetForces
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_targetForces start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::targetForces_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_targetForces end of topic ===
    Comment    ======= Verify ${subSystem}_systemStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_systemStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_systemStatus start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::systemStatus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_systemStatus end of topic ===
    Comment    ======= Verify ${subSystem}_rawTelemetry test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_rawTelemetry
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_rawTelemetry start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::rawTelemetry_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_rawTelemetry end of topic ===
    Comment    ======= Verify ${subSystem}_actuatorLimitSwitches test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_actuatorLimitSwitches
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM2_actuatorLimitSwitches start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::actuatorLimitSwitches_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM2_actuatorLimitSwitches end of topic ===

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
    Should Contain X Times    ${mirrorPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xTilt : 1    10
    Should Contain X Times    ${mirrorPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yTilt : 1    10
    Should Contain X Times    ${mirrorPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}piston : 1    10
    Should Contain X Times    ${mirrorPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xPosition : 1    10
    Should Contain X Times    ${mirrorPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yPosition : 1    10
    Should Contain X Times    ${mirrorPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thetaZPosition : 1    10
    ${axialForcesMeasured_start}=    Get Index From List    ${full_list}    === MTM2_axialForcesMeasured start of topic ===
    ${axialForcesMeasured_end}=    Get Index From List    ${full_list}    === MTM2_axialForcesMeasured end of topic ===
    ${axialForcesMeasured_list}=    Get Slice From List    ${full_list}    start=${axialForcesMeasured_start}    end=${axialForcesMeasured_end}
    Should Contain X Times    ${axialForcesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForceMeasured : 0    1
    Should Contain X Times    ${axialForcesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForceMeasured : 1    1
    Should Contain X Times    ${axialForcesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForceMeasured : 2    1
    Should Contain X Times    ${axialForcesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForceMeasured : 3    1
    Should Contain X Times    ${axialForcesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForceMeasured : 4    1
    Should Contain X Times    ${axialForcesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForceMeasured : 5    1
    Should Contain X Times    ${axialForcesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForceMeasured : 6    1
    Should Contain X Times    ${axialForcesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForceMeasured : 7    1
    Should Contain X Times    ${axialForcesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForceMeasured : 8    1
    Should Contain X Times    ${axialForcesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialForceMeasured : 9    1
    ${tangentForcesMeasured_start}=    Get Index From List    ${full_list}    === MTM2_tangentForcesMeasured start of topic ===
    ${tangentForcesMeasured_end}=    Get Index From List    ${full_list}    === MTM2_tangentForcesMeasured end of topic ===
    ${tangentForcesMeasured_list}=    Get Slice From List    ${full_list}    start=${tangentForcesMeasured_start}    end=${tangentForcesMeasured_end}
    Should Contain X Times    ${tangentForcesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink0DegForceMeasured : 1    10
    Should Contain X Times    ${tangentForcesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink60DegForceMeasured : 1    10
    Should Contain X Times    ${tangentForcesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink120DegForceMeasured : 1    10
    Should Contain X Times    ${tangentForcesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink180DegForceMeasured : 1    10
    Should Contain X Times    ${tangentForcesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink240DegForceMeasured : 1    10
    Should Contain X Times    ${tangentForcesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink300DegForceMeasured : 1    10
    ${zenithAngleMeasured_start}=    Get Index From List    ${full_list}    === MTM2_zenithAngleMeasured start of topic ===
    ${zenithAngleMeasured_end}=    Get Index From List    ${full_list}    === MTM2_zenithAngleMeasured end of topic ===
    ${zenithAngleMeasured_list}=    Get Slice From List    ${full_list}    start=${zenithAngleMeasured_start}    end=${zenithAngleMeasured_end}
    Should Contain X Times    ${zenithAngleMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zenithAngleMeasured : 1    10
    ${axialActuatorAbsolutePositionSteps_start}=    Get Index From List    ${full_list}    === MTM2_axialActuatorAbsolutePositionSteps start of topic ===
    ${axialActuatorAbsolutePositionSteps_end}=    Get Index From List    ${full_list}    === MTM2_axialActuatorAbsolutePositionSteps end of topic ===
    ${axialActuatorAbsolutePositionSteps_list}=    Get Slice From List    ${full_list}    start=${axialActuatorAbsolutePositionSteps_start}    end=${axialActuatorAbsolutePositionSteps_end}
    Should Contain X Times    ${axialActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialAbsolutePositionSteps : 0    1
    Should Contain X Times    ${axialActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialAbsolutePositionSteps : 1    1
    Should Contain X Times    ${axialActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialAbsolutePositionSteps : 2    1
    Should Contain X Times    ${axialActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialAbsolutePositionSteps : 3    1
    Should Contain X Times    ${axialActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialAbsolutePositionSteps : 4    1
    Should Contain X Times    ${axialActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialAbsolutePositionSteps : 5    1
    Should Contain X Times    ${axialActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialAbsolutePositionSteps : 6    1
    Should Contain X Times    ${axialActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialAbsolutePositionSteps : 7    1
    Should Contain X Times    ${axialActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialAbsolutePositionSteps : 8    1
    Should Contain X Times    ${axialActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialAbsolutePositionSteps : 9    1
    ${tangentActuatorAbsolutePositionSteps_start}=    Get Index From List    ${full_list}    === MTM2_tangentActuatorAbsolutePositionSteps start of topic ===
    ${tangentActuatorAbsolutePositionSteps_end}=    Get Index From List    ${full_list}    === MTM2_tangentActuatorAbsolutePositionSteps end of topic ===
    ${tangentActuatorAbsolutePositionSteps_list}=    Get Slice From List    ${full_list}    start=${tangentActuatorAbsolutePositionSteps_start}    end=${tangentActuatorAbsolutePositionSteps_end}
    Should Contain X Times    ${tangentActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink0DegAbsolutePositionSteps : 1    10
    Should Contain X Times    ${tangentActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink60DegAbsolutePositionSteps : 1    10
    Should Contain X Times    ${tangentActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink120DegAbsolutePositionSteps : 1    10
    Should Contain X Times    ${tangentActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink180DegAbsolutePositionSteps : 1    10
    Should Contain X Times    ${tangentActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink240DegAbsolutePositionSteps : 1    10
    Should Contain X Times    ${tangentActuatorAbsolutePositionSteps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink300DegAbsolutePositionSteps : 1    10
    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_start}=    Get Index From List    ${full_list}    === MTM2_axialActuatorPositionAbsoluteEncoderPositionMeasured start of topic ===
    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_end}=    Get Index From List    ${full_list}    === MTM2_axialActuatorPositionAbsoluteEncoderPositionMeasured end of topic ===
    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}=    Get Slice From List    ${full_list}    start=${axialActuatorPositionAbsoluteEncoderPositionMeasured_start}    end=${axialActuatorPositionAbsoluteEncoderPositionMeasured_end}
    Should Contain X Times    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositionMeasured : 0    1
    Should Contain X Times    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositionMeasured : 1    1
    Should Contain X Times    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositionMeasured : 2    1
    Should Contain X Times    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositionMeasured : 3    1
    Should Contain X Times    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositionMeasured : 4    1
    Should Contain X Times    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositionMeasured : 5    1
    Should Contain X Times    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositionMeasured : 6    1
    Should Contain X Times    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositionMeasured : 7    1
    Should Contain X Times    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositionMeasured : 8    1
    Should Contain X Times    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}axialEncoderPositionMeasured : 9    1
    ${tangentActuatorPositionAbsoluteEncoderPositionMeasured_start}=    Get Index From List    ${full_list}    === MTM2_tangentActuatorPositionAbsoluteEncoderPositionMeasured start of topic ===
    ${tangentActuatorPositionAbsoluteEncoderPositionMeasured_end}=    Get Index From List    ${full_list}    === MTM2_tangentActuatorPositionAbsoluteEncoderPositionMeasured end of topic ===
    ${tangentActuatorPositionAbsoluteEncoderPositionMeasured_list}=    Get Slice From List    ${full_list}    start=${tangentActuatorPositionAbsoluteEncoderPositionMeasured_start}    end=${tangentActuatorPositionAbsoluteEncoderPositionMeasured_end}
    Should Contain X Times    ${tangentActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink0DegAbsoluteEncoderPositionMeasured : 1    10
    Should Contain X Times    ${tangentActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink60DegAbsoluteEncoderPositionMeasured : 1    10
    Should Contain X Times    ${tangentActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink120DegAbsoluteEncoderPositionMeasured : 1    10
    Should Contain X Times    ${tangentActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink180DegAbsoluteEncoderPositionMeasured : 1    10
    Should Contain X Times    ${tangentActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink240DegAbsoluteEncoderPositionMeasured : 1    10
    Should Contain X Times    ${tangentActuatorPositionAbsoluteEncoderPositionMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tangentLink300DegAbsoluteEncoderPositionMeasured : 1    10
    ${powerStatus_start}=    Get Index From List    ${full_list}    === MTM2_powerStatus start of topic ===
    ${powerStatus_end}=    Get Index From List    ${full_list}    === MTM2_powerStatus end of topic ===
    ${powerStatus_list}=    Get Slice From List    ${full_list}    start=${powerStatus_start}    end=${powerStatus_end}
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}voltages : 0    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}voltages : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}voltages : 2    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}voltages : 3    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}voltages : 4    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}voltages : 5    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}voltages : 6    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}voltages : 7    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}voltages : 8    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}voltages : 9    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currents : 0    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currents : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currents : 2    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currents : 3    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currents : 4    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currents : 5    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currents : 6    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currents : 7    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currents : 8    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currents : 9    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}onOff : 0    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}onOff : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}onOff : 2    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}onOff : 3    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}onOff : 4    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}onOff : 5    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}onOff : 6    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}onOff : 7    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}onOff : 8    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}onOff : 9    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}states : 0    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}states : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}states : 2    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}states : 3    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}states : 4    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}states : 5    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}states : 6    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}states : 7    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}states : 8    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}states : 9    1
    ${temperaturesMeasured_start}=    Get Index From List    ${full_list}    === MTM2_temperaturesMeasured start of topic ===
    ${temperaturesMeasured_end}=    Get Index From List    ${full_list}    === MTM2_temperaturesMeasured end of topic ===
    ${temperaturesMeasured_list}=    Get Slice From List    ${full_list}    start=${temperaturesMeasured_start}    end=${temperaturesMeasured_end}
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temps : 0    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temps : 1    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temps : 2    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temps : 3    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temps : 4    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temps : 5    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temps : 6    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temps : 7    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temps : 8    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temps : 9    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperatures : 0    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperatures : 1    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperatures : 2    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperatures : 3    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperatures : 4    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperatures : 5    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperatures : 6    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperatures : 7    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperatures : 8    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemperatures : 9    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatures : 0    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatures : 1    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatures : 2    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatures : 3    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatures : 4    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatures : 5    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatures : 6    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatures : 7    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatures : 8    1
    Should Contain X Times    ${temperaturesMeasured_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaustTemperatures : 9    1
    ${rawDisplacement_start}=    Get Index From List    ${full_list}    === MTM2_rawDisplacement start of topic ===
    ${rawDisplacement_end}=    Get Index From List    ${full_list}    === MTM2_rawDisplacement end of topic ===
    ${rawDisplacement_list}=    Get Slice From List    ${full_list}    start=${rawDisplacement_start}    end=${rawDisplacement_end}
    Should Contain X Times    ${rawDisplacement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawPosition : 0    1
    Should Contain X Times    ${rawDisplacement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawPosition : 1    1
    Should Contain X Times    ${rawDisplacement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawPosition : 2    1
    Should Contain X Times    ${rawDisplacement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawPosition : 3    1
    Should Contain X Times    ${rawDisplacement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawPosition : 4    1
    Should Contain X Times    ${rawDisplacement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawPosition : 5    1
    Should Contain X Times    ${rawDisplacement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawPosition : 6    1
    Should Contain X Times    ${rawDisplacement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawPosition : 7    1
    Should Contain X Times    ${rawDisplacement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawPosition : 8    1
    Should Contain X Times    ${rawDisplacement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawPosition : 9    1
    ${stepVectorUpdate_start}=    Get Index From List    ${full_list}    === MTM2_stepVectorUpdate start of topic ===
    ${stepVectorUpdate_end}=    Get Index From List    ${full_list}    === MTM2_stepVectorUpdate end of topic ===
    ${stepVectorUpdate_list}=    Get Slice From List    ${full_list}    start=${stepVectorUpdate_start}    end=${stepVectorUpdate_end}
    Should Contain X Times    ${stepVectorUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}steps : 0    1
    Should Contain X Times    ${stepVectorUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}steps : 1    1
    Should Contain X Times    ${stepVectorUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}steps : 2    1
    Should Contain X Times    ${stepVectorUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}steps : 3    1
    Should Contain X Times    ${stepVectorUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}steps : 4    1
    Should Contain X Times    ${stepVectorUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}steps : 5    1
    Should Contain X Times    ${stepVectorUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}steps : 6    1
    Should Contain X Times    ${stepVectorUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}steps : 7    1
    Should Contain X Times    ${stepVectorUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}steps : 8    1
    Should Contain X Times    ${stepVectorUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}steps : 9    1
    ${targetForces_start}=    Get Index From List    ${full_list}    === MTM2_targetForces start of topic ===
    ${targetForces_end}=    Get Index From List    ${full_list}    === MTM2_targetForces end of topic ===
    ${targetForces_list}=    Get Slice From List    ${full_list}    start=${targetForces_start}    end=${targetForces_end}
    Should Contain X Times    ${targetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setPoint : 0    1
    Should Contain X Times    ${targetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setPoint : 1    1
    Should Contain X Times    ${targetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setPoint : 2    1
    Should Contain X Times    ${targetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setPoint : 3    1
    Should Contain X Times    ${targetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setPoint : 4    1
    Should Contain X Times    ${targetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setPoint : 5    1
    Should Contain X Times    ${targetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setPoint : 6    1
    Should Contain X Times    ${targetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setPoint : 7    1
    Should Contain X Times    ${targetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setPoint : 8    1
    Should Contain X Times    ${targetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setPoint : 9    1
    Should Contain X Times    ${targetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceComponent : 0    1
    Should Contain X Times    ${targetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceComponent : 1    1
    Should Contain X Times    ${targetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceComponent : 2    1
    Should Contain X Times    ${targetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceComponent : 3    1
    Should Contain X Times    ${targetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceComponent : 4    1
    Should Contain X Times    ${targetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceComponent : 5    1
    Should Contain X Times    ${targetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceComponent : 6    1
    Should Contain X Times    ${targetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceComponent : 7    1
    Should Contain X Times    ${targetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceComponent : 8    1
    Should Contain X Times    ${targetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceComponent : 9    1
    ${systemStatus_start}=    Get Index From List    ${full_list}    === MTM2_systemStatus start of topic ===
    ${systemStatus_end}=    Get Index From List    ${full_list}    === MTM2_systemStatus end of topic ===
    ${systemStatus_list}=    Get Slice From List    ${full_list}    start=${systemStatus_start}    end=${systemStatus_end}
    Should Contain X Times    ${systemStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}statusBits : 0    1
    Should Contain X Times    ${systemStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}statusBits : 1    1
    Should Contain X Times    ${systemStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}statusBits : 2    1
    Should Contain X Times    ${systemStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}statusBits : 3    1
    Should Contain X Times    ${systemStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}statusBits : 4    1
    Should Contain X Times    ${systemStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}statusBits : 5    1
    Should Contain X Times    ${systemStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}statusBits : 6    1
    Should Contain X Times    ${systemStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}statusBits : 7    1
    Should Contain X Times    ${systemStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}statusBits : 8    1
    Should Contain X Times    ${systemStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}statusBits : 9    1
    ${rawTelemetry_start}=    Get Index From List    ${full_list}    === MTM2_rawTelemetry start of topic ===
    ${rawTelemetry_end}=    Get Index From List    ${full_list}    === MTM2_rawTelemetry end of topic ===
    ${rawTelemetry_list}=    Get Slice From List    ${full_list}    start=${rawTelemetry_start}    end=${rawTelemetry_end}
    Should Contain X Times    ${rawTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dataPacket : 0    1
    Should Contain X Times    ${rawTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dataPacket : 1    1
    Should Contain X Times    ${rawTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dataPacket : 2    1
    Should Contain X Times    ${rawTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dataPacket : 3    1
    Should Contain X Times    ${rawTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dataPacket : 4    1
    Should Contain X Times    ${rawTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dataPacket : 5    1
    Should Contain X Times    ${rawTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dataPacket : 6    1
    Should Contain X Times    ${rawTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dataPacket : 7    1
    Should Contain X Times    ${rawTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dataPacket : 8    1
    Should Contain X Times    ${rawTelemetry_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dataPacket : 9    1
    ${actuatorLimitSwitches_start}=    Get Index From List    ${full_list}    === MTM2_actuatorLimitSwitches start of topic ===
    ${actuatorLimitSwitches_end}=    Get Index From List    ${full_list}    === MTM2_actuatorLimitSwitches end of topic ===
    ${actuatorLimitSwitches_list}=    Get Slice From List    ${full_list}    start=${actuatorLimitSwitches_start}    end=${actuatorLimitSwitches_end}
    Should Contain X Times    ${actuatorLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forward : 0    1
    Should Contain X Times    ${actuatorLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forward : 1    1
    Should Contain X Times    ${actuatorLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forward : 2    1
    Should Contain X Times    ${actuatorLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forward : 3    1
    Should Contain X Times    ${actuatorLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forward : 4    1
    Should Contain X Times    ${actuatorLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forward : 5    1
    Should Contain X Times    ${actuatorLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forward : 6    1
    Should Contain X Times    ${actuatorLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forward : 7    1
    Should Contain X Times    ${actuatorLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forward : 8    1
    Should Contain X Times    ${actuatorLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forward : 9    1
    Should Contain X Times    ${actuatorLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reverse : 0    1
    Should Contain X Times    ${actuatorLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reverse : 1    1
    Should Contain X Times    ${actuatorLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reverse : 2    1
    Should Contain X Times    ${actuatorLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reverse : 3    1
    Should Contain X Times    ${actuatorLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reverse : 4    1
    Should Contain X Times    ${actuatorLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reverse : 5    1
    Should Contain X Times    ${actuatorLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reverse : 6    1
    Should Contain X Times    ${actuatorLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reverse : 7    1
    Should Contain X Times    ${actuatorLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reverse : 8    1
    Should Contain X Times    ${actuatorLimitSwitches_list}    ${SPACE}${SPACE}${SPACE}${SPACE}reverse : 9    1
