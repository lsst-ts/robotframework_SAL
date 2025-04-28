*** Settings ***
Documentation    MTM1M3 Telemetry communications tests.
Force Tags    messaging    cpp    mtm1m3    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}common.robot
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTM1M3
${component}    all
${timeout}    300s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber

Start Subscriber
    [Tags]    functional    subscriber
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Should Be Equal    ${output.returncode}   ${NONE}
    Wait Until Keyword Succeeds    60s    10    File Should Contain    ${EXECDIR}${/}${subSystem}_stdout.txt    ===== MTM1M3 subscribers ready =====

Start Publisher
    [Tags]    functional    publisher    robot:continue-on-failure
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "forceActuatorData"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_forceActuatorData test messages =======
    Should Contain    ${output.stdout}    === MTM1M3_forceActuatorData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.forceActuatorData writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_forceActuatorData end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "inclinometerData"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_inclinometerData test messages =======
    Should Contain    ${output.stdout}    === MTM1M3_inclinometerData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.inclinometerData writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_inclinometerData end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "outerLoopData"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_outerLoopData test messages =======
    Should Contain    ${output.stdout}    === MTM1M3_outerLoopData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.outerLoopData writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_outerLoopData end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "accelerometerData"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_accelerometerData test messages =======
    Should Contain    ${output.stdout}    === MTM1M3_accelerometerData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.accelerometerData writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_accelerometerData end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "hardpointActuatorData"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_hardpointActuatorData test messages =======
    Should Contain    ${output.stdout}    === MTM1M3_hardpointActuatorData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.hardpointActuatorData writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_hardpointActuatorData end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "imsData"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_imsData test messages =======
    Should Contain    ${output.stdout}    === MTM1M3_imsData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.imsData writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_imsData end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "forceActuatorPressure"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_forceActuatorPressure test messages =======
    Should Contain    ${output.stdout}    === MTM1M3_forceActuatorPressure start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.forceActuatorPressure writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_forceActuatorPressure end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "gyroData"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_gyroData test messages =======
    Should Contain    ${output.stdout}    === MTM1M3_gyroData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.gyroData writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_gyroData end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "powerSupplyData"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_powerSupplyData test messages =======
    Should Contain    ${output.stdout}    === MTM1M3_powerSupplyData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.powerSupplyData writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_powerSupplyData end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "pidData"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_pidData test messages =======
    Should Contain    ${output.stdout}    === MTM1M3_pidData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.pidData writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_pidData end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "hardpointMonitorData"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_hardpointMonitorData test messages =======
    Should Contain    ${output.stdout}    === MTM1M3_hardpointMonitorData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.hardpointMonitorData writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_hardpointMonitorData end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "appliedAzimuthForces"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_appliedAzimuthForces test messages =======
    Should Contain    ${output.stdout}    === MTM1M3_appliedAzimuthForces start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.appliedAzimuthForces writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_appliedAzimuthForces end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "appliedAccelerationForces"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_appliedAccelerationForces test messages =======
    Should Contain    ${output.stdout}    === MTM1M3_appliedAccelerationForces start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.appliedAccelerationForces writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_appliedAccelerationForces end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "appliedBalanceForces"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_appliedBalanceForces test messages =======
    Should Contain    ${output.stdout}    === MTM1M3_appliedBalanceForces start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.appliedBalanceForces writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_appliedBalanceForces end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "appliedCylinderForces"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_appliedCylinderForces test messages =======
    Should Contain    ${output.stdout}    === MTM1M3_appliedCylinderForces start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.appliedCylinderForces writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_appliedCylinderForces end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "appliedElevationForces"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_appliedElevationForces test messages =======
    Should Contain    ${output.stdout}    === MTM1M3_appliedElevationForces start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.appliedElevationForces writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_appliedElevationForces end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "appliedForces"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_appliedForces test messages =======
    Should Contain    ${output.stdout}    === MTM1M3_appliedForces start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.appliedForces writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_appliedForces end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "appliedThermalForces"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_appliedThermalForces test messages =======
    Should Contain    ${output.stdout}    === MTM1M3_appliedThermalForces start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.appliedThermalForces writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_appliedThermalForces end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "appliedVelocityForces"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_appliedVelocityForces test messages =======
    Should Contain    ${output.stdout}    === MTM1M3_appliedVelocityForces start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.appliedVelocityForces writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_appliedVelocityForces end of topic ===

Read Subscriber
    [Tags]    functional    subscriber    robot:continue-on-failure
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    1/1 brokers are down
    Should Not Contain    ${output.stderr}    Consume failed
    Should Not Contain    ${output.stderr}    Broker: Unknown topic or partition
    Should Contain    ${output.stdout}    ===== MTM1M3 subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${forceActuatorData_start}=    Get Index From List    ${full_list}    === MTM1M3_forceActuatorData start of topic ===
    ${forceActuatorData_end}=    Get Index From List    ${full_list}    === MTM1M3_forceActuatorData end of topic ===
    ${forceActuatorData_list}=    Get Slice From List    ${full_list}    start=${forceActuatorData_start}    end=${forceActuatorData_end}
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForce : 0    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForce : 1    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForce : 2    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForce : 3    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForce : 4    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForce : 5    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForce : 6    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForce : 7    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForce : 8    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForce : 9    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForce : 0    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForce : 1    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForce : 2    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForce : 3    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForce : 4    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForce : 5    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForce : 6    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForce : 7    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForce : 8    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForce : 9    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderFollowingError : 0    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderFollowingError : 1    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderFollowingError : 2    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderFollowingError : 3    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderFollowingError : 4    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderFollowingError : 5    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderFollowingError : 6    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderFollowingError : 7    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderFollowingError : 8    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderFollowingError : 9    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderFollowingError : 0    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderFollowingError : 1    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderFollowingError : 2    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderFollowingError : 3    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderFollowingError : 4    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderFollowingError : 5    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderFollowingError : 6    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderFollowingError : 7    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderFollowingError : 8    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderFollowingError : 9    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForce : 0    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForce : 1    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForce : 2    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForce : 3    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForce : 4    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForce : 5    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForce : 6    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForce : 7    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForce : 8    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForce : 9    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForce : 0    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForce : 1    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForce : 2    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForce : 3    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForce : 4    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForce : 5    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForce : 6    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForce : 7    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForce : 8    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForce : 9    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForce : 0    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForce : 1    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForce : 2    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForce : 3    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForce : 4    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForce : 5    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForce : 6    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForce : 7    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForce : 8    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForce : 9    1
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    10
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    10
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    10
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    10
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    10
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    10
    Should Contain X Times    ${forceActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    10
    ${inclinometerData_start}=    Get Index From List    ${full_list}    === MTM1M3_inclinometerData start of topic ===
    ${inclinometerData_end}=    Get Index From List    ${full_list}    === MTM1M3_inclinometerData end of topic ===
    ${inclinometerData_list}=    Get Slice From List    ${full_list}    start=${inclinometerData_start}    end=${inclinometerData_end}
    Should Contain X Times    ${inclinometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${inclinometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inclinometerAngle : 1    10
    ${outerLoopData_start}=    Get Index From List    ${full_list}    === MTM1M3_outerLoopData start of topic ===
    ${outerLoopData_end}=    Get Index From List    ${full_list}    === MTM1M3_outerLoopData end of topic ===
    ${outerLoopData_list}=    Get Slice From List    ${full_list}    start=${outerLoopData_start}    end=${outerLoopData_end}
    Should Contain X Times    ${outerLoopData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${outerLoopData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}broadcastCounter : 1    10
    Should Contain X Times    ${outerLoopData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}executionTime : 1    10
    ${accelerometerData_start}=    Get Index From List    ${full_list}    === MTM1M3_accelerometerData start of topic ===
    ${accelerometerData_end}=    Get Index From List    ${full_list}    === MTM1M3_accelerometerData end of topic ===
    ${accelerometerData_list}=    Get Slice From List    ${full_list}    start=${accelerometerData_start}    end=${accelerometerData_end}
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAccelerometer : 0    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAccelerometer : 1    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAccelerometer : 2    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAccelerometer : 3    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAccelerometer : 4    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAccelerometer : 5    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAccelerometer : 6    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAccelerometer : 7    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAccelerometer : 8    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAccelerometer : 9    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 0    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 1    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 2    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 3    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 4    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 5    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 6    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 7    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 8    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 9    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}angularAccelerationX : 1    10
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}angularAccelerationY : 1    10
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}angularAccelerationZ : 1    10
    ${hardpointActuatorData_start}=    Get Index From List    ${full_list}    === MTM1M3_hardpointActuatorData start of topic ===
    ${hardpointActuatorData_end}=    Get Index From List    ${full_list}    === MTM1M3_hardpointActuatorData end of topic ===
    ${hardpointActuatorData_list}=    Get Slice From List    ${full_list}    start=${hardpointActuatorData_start}    end=${hardpointActuatorData_end}
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stepsQueued : 0    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stepsQueued : 1    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stepsQueued : 2    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stepsQueued : 3    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stepsQueued : 4    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stepsQueued : 5    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stepsQueued : 6    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stepsQueued : 7    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stepsQueued : 8    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stepsQueued : 9    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stepsCommanded : 0    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stepsCommanded : 1    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stepsCommanded : 2    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stepsCommanded : 3    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stepsCommanded : 4    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stepsCommanded : 5    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stepsCommanded : 6    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stepsCommanded : 7    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stepsCommanded : 8    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stepsCommanded : 9    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredForce : 0    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredForce : 1    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredForce : 2    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredForce : 3    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredForce : 4    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredForce : 5    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredForce : 6    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredForce : 7    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredForce : 8    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredForce : 9    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoder : 0    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoder : 1    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoder : 2    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoder : 3    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoder : 4    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoder : 5    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoder : 6    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoder : 7    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoder : 8    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoder : 9    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacement : 0    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacement : 1    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacement : 2    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacement : 3    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacement : 4    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacement : 5    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacement : 6    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacement : 7    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacement : 8    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacement : 9    1
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xPosition : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yPosition : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zPosition : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xRotation : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yRotation : 1    10
    Should Contain X Times    ${hardpointActuatorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zRotation : 1    10
    ${imsData_start}=    Get Index From List    ${full_list}    === MTM1M3_imsData start of topic ===
    ${imsData_end}=    Get Index From List    ${full_list}    === MTM1M3_imsData end of topic ===
    ${imsData_list}=    Get Slice From List    ${full_list}    start=${imsData_start}    end=${imsData_end}
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawSensorData : 0    1
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawSensorData : 1    1
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawSensorData : 2    1
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawSensorData : 3    1
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawSensorData : 4    1
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawSensorData : 5    1
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawSensorData : 6    1
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawSensorData : 7    1
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawSensorData : 8    1
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawSensorData : 9    1
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xPosition : 1    10
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yPosition : 1    10
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zPosition : 1    10
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xRotation : 1    10
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yRotation : 1    10
    Should Contain X Times    ${imsData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zRotation : 1    10
    ${forceActuatorPressure_start}=    Get Index From List    ${full_list}    === MTM1M3_forceActuatorPressure start of topic ===
    ${forceActuatorPressure_end}=    Get Index From List    ${full_list}    === MTM1M3_forceActuatorPressure end of topic ===
    ${forceActuatorPressure_list}=    Get Slice From List    ${full_list}    start=${forceActuatorPressure_start}    end=${forceActuatorPressure_end}
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamps : 0    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamps : 1    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamps : 2    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamps : 3    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamps : 4    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamps : 5    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamps : 6    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamps : 7    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamps : 8    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamps : 9    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPushPressures : 0    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPushPressures : 1    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPushPressures : 2    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPushPressures : 3    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPushPressures : 4    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPushPressures : 5    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPushPressures : 6    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPushPressures : 7    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPushPressures : 8    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPushPressures : 9    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPullPressures : 0    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPullPressures : 1    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPullPressures : 2    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPullPressures : 3    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPullPressures : 4    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPullPressures : 5    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPullPressures : 6    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPullPressures : 7    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPullPressures : 8    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderPullPressures : 9    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPushPressures : 0    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPushPressures : 1    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPushPressures : 2    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPushPressures : 3    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPushPressures : 4    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPushPressures : 5    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPushPressures : 6    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPushPressures : 7    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPushPressures : 8    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPushPressures : 9    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPullPressures : 0    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPullPressures : 1    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPullPressures : 2    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPullPressures : 3    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPullPressures : 4    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPullPressures : 5    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPullPressures : 6    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPullPressures : 7    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPullPressures : 8    1
    Should Contain X Times    ${forceActuatorPressure_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderPullPressures : 9    1
    ${gyroData_start}=    Get Index From List    ${full_list}    === MTM1M3_gyroData start of topic ===
    ${gyroData_end}=    Get Index From List    ${full_list}    === MTM1M3_gyroData end of topic ===
    ${gyroData_list}=    Get Slice From List    ${full_list}    start=${gyroData_start}    end=${gyroData_end}
    Should Contain X Times    ${gyroData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${gyroData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}angularVelocityX : 1    10
    Should Contain X Times    ${gyroData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}angularVelocityY : 1    10
    Should Contain X Times    ${gyroData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}angularVelocityZ : 1    10
    Should Contain X Times    ${gyroData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sequenceNumber : 1    10
    Should Contain X Times    ${gyroData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 1    10
    ${powerSupplyData_start}=    Get Index From List    ${full_list}    === MTM1M3_powerSupplyData start of topic ===
    ${powerSupplyData_end}=    Get Index From List    ${full_list}    === MTM1M3_powerSupplyData end of topic ===
    ${powerSupplyData_list}=    Get Slice From List    ${full_list}    start=${powerSupplyData_start}    end=${powerSupplyData_end}
    Should Contain X Times    ${powerSupplyData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${powerSupplyData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkACurrent : 1    10
    Should Contain X Times    ${powerSupplyData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkBCurrent : 1    10
    Should Contain X Times    ${powerSupplyData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkCCurrent : 1    10
    Should Contain X Times    ${powerSupplyData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerNetworkDCurrent : 1    10
    Should Contain X Times    ${powerSupplyData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lightPowerNetworkCurrent : 1    10
    Should Contain X Times    ${powerSupplyData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlsPowerNetworkCurrent : 1    10
    ${pidData_start}=    Get Index From List    ${full_list}    === MTM1M3_pidData start of topic ===
    ${pidData_end}=    Get Index From List    ${full_list}    === MTM1M3_pidData end of topic ===
    ${pidData_list}=    Get Slice From List    ${full_list}    start=${pidData_start}    end=${pidData_end}
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 0    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 1    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 2    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 3    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 4    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 5    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 6    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 7    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 8    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpoint : 9    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredPID : 0    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredPID : 1    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredPID : 2    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredPID : 3    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredPID : 4    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredPID : 5    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredPID : 6    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredPID : 7    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredPID : 8    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredPID : 9    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 0    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 1    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 2    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 3    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 4    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 5    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 6    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 7    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 8    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 9    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT1 : 0    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT1 : 1    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT1 : 2    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT1 : 3    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT1 : 4    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT1 : 5    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT1 : 6    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT1 : 7    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT1 : 8    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT1 : 9    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT2 : 0    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT2 : 1    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT2 : 2    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT2 : 3    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT2 : 4    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT2 : 5    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT2 : 6    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT2 : 7    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT2 : 8    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorT2 : 9    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}control : 0    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}control : 1    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}control : 2    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}control : 3    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}control : 4    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}control : 5    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}control : 6    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}control : 7    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}control : 8    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}control : 9    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT1 : 0    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT1 : 1    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT1 : 2    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT1 : 3    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT1 : 4    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT1 : 5    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT1 : 6    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT1 : 7    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT1 : 8    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT1 : 9    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT2 : 0    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT2 : 1    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT2 : 2    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT2 : 3    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT2 : 4    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT2 : 5    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT2 : 6    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT2 : 7    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT2 : 8    1
    Should Contain X Times    ${pidData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controlT2 : 9    1
    ${hardpointMonitorData_start}=    Get Index From List    ${full_list}    === MTM1M3_hardpointMonitorData start of topic ===
    ${hardpointMonitorData_end}=    Get Index From List    ${full_list}    === MTM1M3_hardpointMonitorData end of topic ===
    ${hardpointMonitorData_list}=    Get Slice From List    ${full_list}    start=${hardpointMonitorData_start}    end=${hardpointMonitorData_end}
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayLVDT : 0    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayLVDT : 1    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayLVDT : 2    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayLVDT : 3    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayLVDT : 4    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayLVDT : 5    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayLVDT : 6    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayLVDT : 7    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayLVDT : 8    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayLVDT : 9    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementLVDT : 0    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementLVDT : 1    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementLVDT : 2    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementLVDT : 3    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementLVDT : 4    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementLVDT : 5    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementLVDT : 6    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementLVDT : 7    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementLVDT : 8    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}displacementLVDT : 9    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayPressure : 0    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayPressure : 1    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayPressure : 2    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayPressure : 3    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayPressure : 4    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayPressure : 5    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayPressure : 6    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayPressure : 7    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayPressure : 8    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakawayPressure : 9    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor1 : 0    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor1 : 1    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor1 : 2    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor1 : 3    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor1 : 4    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor1 : 5    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor1 : 6    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor1 : 7    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor1 : 8    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor1 : 9    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor2 : 0    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor2 : 1    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor2 : 2    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor2 : 3    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor2 : 4    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor2 : 5    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor2 : 6    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor2 : 7    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor2 : 8    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor2 : 9    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor3 : 0    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor3 : 1    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor3 : 2    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor3 : 3    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor3 : 4    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor3 : 5    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor3 : 6    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor3 : 7    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor3 : 8    1
    Should Contain X Times    ${hardpointMonitorData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressureSensor3 : 9    1
    ${appliedAzimuthForces_start}=    Get Index From List    ${full_list}    === MTM1M3_appliedAzimuthForces start of topic ===
    ${appliedAzimuthForces_end}=    Get Index From List    ${full_list}    === MTM1M3_appliedAzimuthForces end of topic ===
    ${appliedAzimuthForces_list}=    Get Slice From List    ${full_list}    start=${appliedAzimuthForces_start}    end=${appliedAzimuthForces_end}
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 1    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 2    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 3    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 4    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 5    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 6    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 7    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 8    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 9    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 1    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 2    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 3    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 4    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 5    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 6    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 7    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 8    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 9    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 1    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 2    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 3    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 4    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 5    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 6    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 7    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 8    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 9    1
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    10
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    10
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    10
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    10
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    10
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    10
    Should Contain X Times    ${appliedAzimuthForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    10
    ${appliedAccelerationForces_start}=    Get Index From List    ${full_list}    === MTM1M3_appliedAccelerationForces start of topic ===
    ${appliedAccelerationForces_end}=    Get Index From List    ${full_list}    === MTM1M3_appliedAccelerationForces end of topic ===
    ${appliedAccelerationForces_list}=    Get Slice From List    ${full_list}    start=${appliedAccelerationForces_start}    end=${appliedAccelerationForces_end}
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 1    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 2    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 3    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 4    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 5    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 6    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 7    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 8    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 9    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 1    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 2    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 3    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 4    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 5    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 6    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 7    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 8    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 9    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 1    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 2    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 3    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 4    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 5    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 6    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 7    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 8    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 9    1
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    10
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    10
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    10
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    10
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    10
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    10
    Should Contain X Times    ${appliedAccelerationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    10
    ${appliedBalanceForces_start}=    Get Index From List    ${full_list}    === MTM1M3_appliedBalanceForces start of topic ===
    ${appliedBalanceForces_end}=    Get Index From List    ${full_list}    === MTM1M3_appliedBalanceForces end of topic ===
    ${appliedBalanceForces_list}=    Get Slice From List    ${full_list}    start=${appliedBalanceForces_start}    end=${appliedBalanceForces_end}
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 1    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 2    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 3    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 4    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 5    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 6    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 7    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 8    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 9    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 1    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 2    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 3    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 4    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 5    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 6    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 7    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 8    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 9    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 1    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 2    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 3    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 4    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 5    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 6    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 7    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 8    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 9    1
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    10
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    10
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    10
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    10
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    10
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    10
    Should Contain X Times    ${appliedBalanceForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    10
    ${appliedCylinderForces_start}=    Get Index From List    ${full_list}    === MTM1M3_appliedCylinderForces start of topic ===
    ${appliedCylinderForces_end}=    Get Index From List    ${full_list}    === MTM1M3_appliedCylinderForces end of topic ===
    ${appliedCylinderForces_list}=    Get Slice From List    ${full_list}    start=${appliedCylinderForces_start}    end=${appliedCylinderForces_end}
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 0    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 1    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 2    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 3    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 4    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 5    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 6    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 7    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 8    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secondaryCylinderForces : 9    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 0    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 1    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 2    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 3    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 4    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 5    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 6    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 7    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 8    1
    Should Contain X Times    ${appliedCylinderForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}primaryCylinderForces : 9    1
    ${appliedElevationForces_start}=    Get Index From List    ${full_list}    === MTM1M3_appliedElevationForces start of topic ===
    ${appliedElevationForces_end}=    Get Index From List    ${full_list}    === MTM1M3_appliedElevationForces end of topic ===
    ${appliedElevationForces_list}=    Get Slice From List    ${full_list}    start=${appliedElevationForces_start}    end=${appliedElevationForces_end}
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 1    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 2    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 3    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 4    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 5    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 6    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 7    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 8    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 9    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 1    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 2    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 3    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 4    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 5    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 6    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 7    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 8    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 9    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 1    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 2    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 3    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 4    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 5    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 6    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 7    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 8    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 9    1
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    10
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    10
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    10
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    10
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    10
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    10
    Should Contain X Times    ${appliedElevationForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    10
    ${appliedForces_start}=    Get Index From List    ${full_list}    === MTM1M3_appliedForces start of topic ===
    ${appliedForces_end}=    Get Index From List    ${full_list}    === MTM1M3_appliedForces end of topic ===
    ${appliedForces_list}=    Get Slice From List    ${full_list}    start=${appliedForces_start}    end=${appliedForces_end}
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 1    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 2    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 3    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 4    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 5    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 6    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 7    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 8    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 9    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 1    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 2    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 3    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 4    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 5    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 6    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 7    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 8    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 9    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 1    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 2    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 3    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 4    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 5    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 6    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 7    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 8    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 9    1
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    10
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    10
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    10
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    10
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    10
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    10
    Should Contain X Times    ${appliedForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    10
    ${appliedThermalForces_start}=    Get Index From List    ${full_list}    === MTM1M3_appliedThermalForces start of topic ===
    ${appliedThermalForces_end}=    Get Index From List    ${full_list}    === MTM1M3_appliedThermalForces end of topic ===
    ${appliedThermalForces_list}=    Get Slice From List    ${full_list}    start=${appliedThermalForces_start}    end=${appliedThermalForces_end}
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 1    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 2    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 3    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 4    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 5    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 6    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 7    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 8    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 9    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 1    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 2    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 3    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 4    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 5    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 6    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 7    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 8    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 9    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 1    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 2    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 3    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 4    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 5    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 6    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 7    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 8    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 9    1
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    10
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    10
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    10
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    10
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    10
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    10
    Should Contain X Times    ${appliedThermalForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    10
    ${appliedVelocityForces_start}=    Get Index From List    ${full_list}    === MTM1M3_appliedVelocityForces start of topic ===
    ${appliedVelocityForces_end}=    Get Index From List    ${full_list}    === MTM1M3_appliedVelocityForces end of topic ===
    ${appliedVelocityForces_list}=    Get Slice From List    ${full_list}    start=${appliedVelocityForces_start}    end=${appliedVelocityForces_end}
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 1    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 2    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 3    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 4    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 5    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 6    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 7    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 8    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 9    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 1    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 2    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 3    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 4    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 5    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 6    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 7    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 8    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 9    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 1    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 2    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 3    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 4    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 5    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 6    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 7    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 8    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 9    1
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fx : 1    10
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fy : 1    10
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fz : 1    10
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mx : 1    10
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}my : 1    10
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mz : 1    10
    Should Contain X Times    ${appliedVelocityForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceMagnitude : 1    10
