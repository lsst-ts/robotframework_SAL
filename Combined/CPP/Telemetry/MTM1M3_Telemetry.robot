*** Settings ***
Documentation    MTM1M3 Telemetry communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTM1M3
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
    Should Contain    ${output}   Popen
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdout.txt
    Comment    Sleep for 6s to allow DDS time to register all the topics.
    Sleep    6s
    ${output}=    Get File    ${EXECDIR}${/}${subSystem}_stdout.txt
    Should Contain    ${output}    ===== MTM1M3 subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_forceActuatorData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_forceActuatorData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTM1M3_forceActuatorData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::forceActuatorData_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_forceActuatorData end of topic ===
    Comment    ======= Verify ${subSystem}_inclinometerData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_inclinometerData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTM1M3_inclinometerData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::inclinometerData_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_inclinometerData end of topic ===
    Comment    ======= Verify ${subSystem}_outerLoopData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_outerLoopData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTM1M3_outerLoopData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::outerLoopData_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_outerLoopData end of topic ===
    Comment    ======= Verify ${subSystem}_accelerometerData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_accelerometerData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTM1M3_accelerometerData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::accelerometerData_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_accelerometerData end of topic ===
    Comment    ======= Verify ${subSystem}_hardpointActuatorData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_hardpointActuatorData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTM1M3_hardpointActuatorData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::hardpointActuatorData_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_hardpointActuatorData end of topic ===
    Comment    ======= Verify ${subSystem}_imsData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_imsData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTM1M3_imsData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::imsData_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_imsData end of topic ===
    Comment    ======= Verify ${subSystem}_forceActuatorPressure test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_forceActuatorPressure
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTM1M3_forceActuatorPressure start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::forceActuatorPressure_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_forceActuatorPressure end of topic ===
    Comment    ======= Verify ${subSystem}_gyroData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_gyroData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTM1M3_gyroData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::gyroData_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_gyroData end of topic ===
    Comment    ======= Verify ${subSystem}_powerSupplyData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_powerSupplyData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTM1M3_powerSupplyData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::powerSupplyData_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_powerSupplyData end of topic ===
    Comment    ======= Verify ${subSystem}_pidData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_pidData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTM1M3_pidData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::pidData_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_pidData end of topic ===
    Comment    ======= Verify ${subSystem}_hardpointMonitorData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_hardpointMonitorData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTM1M3_hardpointMonitorData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::hardpointMonitorData_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3_hardpointMonitorData end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
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
    Should Contain X Times    ${outerLoopData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}slewFlag : 1    10
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
