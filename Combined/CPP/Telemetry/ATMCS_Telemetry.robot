*** Settings ***
Documentation    ATMCS Telemetry communications tests.
Force Tags    messaging    cpp    atmcs    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}common.robot
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATMCS
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
    Wait Until Keyword Succeeds    60s    10    File Should Contain    ${EXECDIR}${/}${subSystem}_stdout.txt    ===== ATMCS subscribers ready =====

Start Publisher
    [Tags]    functional    publisher    robot:continue-on-failure
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "trajectory"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_trajectory test messages =======
    Should Contain    ${output.stdout}    === ATMCS_trajectory start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.trajectory writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATMCS_trajectory end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "mount_AzEl_Encoders"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_mount_AzEl_Encoders test messages =======
    Should Contain    ${output.stdout}    === ATMCS_mount_AzEl_Encoders start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.mount_AzEl_Encoders writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATMCS_mount_AzEl_Encoders end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "mount_Nasmyth_Encoders"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_mount_Nasmyth_Encoders test messages =======
    Should Contain    ${output.stdout}    === ATMCS_mount_Nasmyth_Encoders start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.mount_Nasmyth_Encoders writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATMCS_mount_Nasmyth_Encoders end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "torqueDemand"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_torqueDemand test messages =======
    Should Contain    ${output.stdout}    === ATMCS_torqueDemand start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.torqueDemand writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATMCS_torqueDemand end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "measuredTorque"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_measuredTorque test messages =======
    Should Contain    ${output.stdout}    === ATMCS_measuredTorque start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.measuredTorque writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATMCS_measuredTorque end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "measuredMotorVelocity"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_measuredMotorVelocity test messages =======
    Should Contain    ${output.stdout}    === ATMCS_measuredMotorVelocity start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.measuredMotorVelocity writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATMCS_measuredMotorVelocity end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "nasmyth_m3_mountMotorEncoders"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_nasmyth_m3_mountMotorEncoders test messages =======
    Should Contain    ${output.stdout}    === ATMCS_nasmyth_m3_mountMotorEncoders start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.nasmyth_m3_mountMotorEncoders writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATMCS_nasmyth_m3_mountMotorEncoders end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "azEl_mountMotorEncoders"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_azEl_mountMotorEncoders test messages =======
    Should Contain    ${output.stdout}    === ATMCS_azEl_mountMotorEncoders start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.azEl_mountMotorEncoders writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATMCS_azEl_mountMotorEncoders end of topic ===

Read Subscriber
    [Tags]    functional    subscriber    robot:continue-on-failure
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    1/1 brokers are down
    Should Not Contain    ${output.stderr}    Consume failed
    Should Not Contain    ${output.stderr}    Broker: Unknown topic or partition
    Should Contain    ${output.stdout}    ===== ATMCS subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${trajectory_start}=    Get Index From List    ${full_list}    === ATMCS_trajectory start of topic ===
    ${trajectory_end}=    Get Index From List    ${full_list}    === ATMCS_trajectory end of topic ===
    ${trajectory_list}=    Get Slice From List    ${full_list}    start=${trajectory_start}    end=${trajectory_end}
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cRIO_timestamp : 1    10
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 0    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 2    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 3    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 4    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 5    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 6    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 7    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 8    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 9    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationVelocity : 0    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationVelocity : 1    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationVelocity : 2    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationVelocity : 3    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationVelocity : 4    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationVelocity : 5    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationVelocity : 6    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationVelocity : 7    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationVelocity : 8    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationVelocity : 9    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 0    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 2    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 3    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 4    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 5    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 6    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 7    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 8    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 9    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthVelocity : 0    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthVelocity : 1    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthVelocity : 2    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthVelocity : 3    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthVelocity : 4    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthVelocity : 5    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthVelocity : 6    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthVelocity : 7    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthVelocity : 8    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthVelocity : 9    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngle : 0    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngle : 1    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngle : 2    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngle : 3    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngle : 4    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngle : 5    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngle : 6    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngle : 7    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngle : 8    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngle : 9    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngleVelocity : 0    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngleVelocity : 1    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngleVelocity : 2    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngleVelocity : 3    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngleVelocity : 4    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngleVelocity : 5    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngleVelocity : 6    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngleVelocity : 7    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngleVelocity : 8    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1RotatorAngleVelocity : 9    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngle : 0    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngle : 1    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngle : 2    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngle : 3    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngle : 4    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngle : 5    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngle : 6    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngle : 7    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngle : 8    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngle : 9    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngleVelocity : 0    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngleVelocity : 1    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngleVelocity : 2    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngleVelocity : 3    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngleVelocity : 4    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngleVelocity : 5    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngleVelocity : 6    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngleVelocity : 7    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngleVelocity : 8    1
    Should Contain X Times    ${trajectory_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2RotatorAngleVelocity : 9    1
    ${mount_AzEl_Encoders_start}=    Get Index From List    ${full_list}    === ATMCS_mount_AzEl_Encoders start of topic ===
    ${mount_AzEl_Encoders_end}=    Get Index From List    ${full_list}    === ATMCS_mount_AzEl_Encoders end of topic ===
    ${mount_AzEl_Encoders_list}=    Get Slice From List    ${full_list}    start=${mount_AzEl_Encoders_start}    end=${mount_AzEl_Encoders_end}
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cRIO_timestamp : 1    10
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 0    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 1    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 2    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 3    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 4    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 5    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 6    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 7    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 8    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 9    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 0    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 1    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 2    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 3    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 4    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 5    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 6    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 7    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 8    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 9    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder1Raw : 0    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder1Raw : 1    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder1Raw : 2    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder1Raw : 3    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder1Raw : 4    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder1Raw : 5    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder1Raw : 6    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder1Raw : 7    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder1Raw : 8    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder1Raw : 9    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder2Raw : 0    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder2Raw : 1    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder2Raw : 2    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder2Raw : 3    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder2Raw : 4    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder2Raw : 5    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder2Raw : 6    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder2Raw : 7    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder2Raw : 8    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder2Raw : 9    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder3Raw : 0    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder3Raw : 1    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder3Raw : 2    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder3Raw : 3    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder3Raw : 4    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder3Raw : 5    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder3Raw : 6    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder3Raw : 7    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder3Raw : 8    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder3Raw : 9    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder1Raw : 0    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder1Raw : 1    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder1Raw : 2    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder1Raw : 3    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder1Raw : 4    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder1Raw : 5    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder1Raw : 6    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder1Raw : 7    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder1Raw : 8    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder1Raw : 9    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder2Raw : 0    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder2Raw : 1    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder2Raw : 2    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder2Raw : 3    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder2Raw : 4    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder2Raw : 5    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder2Raw : 6    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder2Raw : 7    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder2Raw : 8    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder2Raw : 9    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder3Raw : 0    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder3Raw : 1    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder3Raw : 2    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder3Raw : 3    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder3Raw : 4    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder3Raw : 5    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder3Raw : 6    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder3Raw : 7    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder3Raw : 8    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthEncoder3Raw : 9    1
    Should Contain X Times    ${mount_AzEl_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    10
    ${mount_Nasmyth_Encoders_start}=    Get Index From List    ${full_list}    === ATMCS_mount_Nasmyth_Encoders start of topic ===
    ${mount_Nasmyth_Encoders_end}=    Get Index From List    ${full_list}    === ATMCS_mount_Nasmyth_Encoders end of topic ===
    ${mount_Nasmyth_Encoders_list}=    Get Slice From List    ${full_list}    start=${mount_Nasmyth_Encoders_start}    end=${mount_Nasmyth_Encoders_end}
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cRIO_timestamp : 1    10
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1CalculatedAngle : 0    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1CalculatedAngle : 1    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1CalculatedAngle : 2    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1CalculatedAngle : 3    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1CalculatedAngle : 4    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1CalculatedAngle : 5    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1CalculatedAngle : 6    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1CalculatedAngle : 7    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1CalculatedAngle : 8    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1CalculatedAngle : 9    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2CalculatedAngle : 0    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2CalculatedAngle : 1    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2CalculatedAngle : 2    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2CalculatedAngle : 3    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2CalculatedAngle : 4    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2CalculatedAngle : 5    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2CalculatedAngle : 6    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2CalculatedAngle : 7    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2CalculatedAngle : 8    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2CalculatedAngle : 9    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder1Raw : 0    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder1Raw : 1    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder1Raw : 2    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder1Raw : 3    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder1Raw : 4    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder1Raw : 5    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder1Raw : 6    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder1Raw : 7    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder1Raw : 8    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder1Raw : 9    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder2Raw : 0    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder2Raw : 1    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder2Raw : 2    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder2Raw : 3    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder2Raw : 4    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder2Raw : 5    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder2Raw : 6    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder2Raw : 7    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder2Raw : 8    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder2Raw : 9    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder3Raw : 0    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder3Raw : 1    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder3Raw : 2    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder3Raw : 3    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder3Raw : 4    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder3Raw : 5    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder3Raw : 6    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder3Raw : 7    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder3Raw : 8    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder3Raw : 9    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder1Raw : 0    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder1Raw : 1    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder1Raw : 2    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder1Raw : 3    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder1Raw : 4    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder1Raw : 5    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder1Raw : 6    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder1Raw : 7    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder1Raw : 8    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder1Raw : 9    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder2Raw : 0    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder2Raw : 1    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder2Raw : 2    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder2Raw : 3    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder2Raw : 4    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder2Raw : 5    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder2Raw : 6    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder2Raw : 7    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder2Raw : 8    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder2Raw : 9    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder3Raw : 0    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder3Raw : 1    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder3Raw : 2    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder3Raw : 3    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder3Raw : 4    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder3Raw : 5    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder3Raw : 6    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder3Raw : 7    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder3Raw : 8    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder3Raw : 9    1
    Should Contain X Times    ${mount_Nasmyth_Encoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    10
    ${torqueDemand_start}=    Get Index From List    ${full_list}    === ATMCS_torqueDemand start of topic ===
    ${torqueDemand_end}=    Get Index From List    ${full_list}    === ATMCS_torqueDemand end of topic ===
    ${torqueDemand_list}=    Get Slice From List    ${full_list}    start=${torqueDemand_start}    end=${torqueDemand_end}
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cRIO_timestamp : 1    10
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 0    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 1    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 2    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 3    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 4    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 5    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 6    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 7    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 8    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 9    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 0    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 1    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 2    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 3    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 4    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 5    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 6    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 7    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 8    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 9    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 0    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 1    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 2    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 3    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 4    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 5    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 6    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 7    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 8    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 9    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 0    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 1    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 2    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 3    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 4    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 5    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 6    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 7    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 8    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 9    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 0    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 1    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 2    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 3    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 4    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 5    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 6    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 7    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 8    1
    Should Contain X Times    ${torqueDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 9    1
    ${measuredTorque_start}=    Get Index From List    ${full_list}    === ATMCS_measuredTorque start of topic ===
    ${measuredTorque_end}=    Get Index From List    ${full_list}    === ATMCS_measuredTorque end of topic ===
    ${measuredTorque_list}=    Get Slice From List    ${full_list}    start=${measuredTorque_start}    end=${measuredTorque_end}
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cRIO_timestamp : 1    10
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 0    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 1    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 2    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 3    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 4    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 5    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 6    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 7    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 8    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorTorque : 9    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 0    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 1    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 2    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 3    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 4    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 5    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 6    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 7    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 8    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Torque : 9    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 0    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 1    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 2    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 3    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 4    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 5    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 6    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 7    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 8    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Torque : 9    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 0    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 1    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 2    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 3    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 4    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 5    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 6    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 7    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 8    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorTorque : 9    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 0    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 1    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 2    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 3    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 4    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 5    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 6    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 7    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 8    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorTorque : 9    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Torque : 0    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Torque : 1    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Torque : 2    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Torque : 3    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Torque : 4    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Torque : 5    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Torque : 6    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Torque : 7    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Torque : 8    1
    Should Contain X Times    ${measuredTorque_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Torque : 9    1
    ${measuredMotorVelocity_start}=    Get Index From List    ${full_list}    === ATMCS_measuredMotorVelocity start of topic ===
    ${measuredMotorVelocity_end}=    Get Index From List    ${full_list}    === ATMCS_measuredMotorVelocity end of topic ===
    ${measuredMotorVelocity_list}=    Get Slice From List    ${full_list}    start=${measuredMotorVelocity_start}    end=${measuredMotorVelocity_end}
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cRIO_timestamp : 1    10
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorVelocity : 0    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorVelocity : 1    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorVelocity : 2    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorVelocity : 3    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorVelocity : 4    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorVelocity : 5    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorVelocity : 6    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorVelocity : 7    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorVelocity : 8    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationMotorVelocity : 9    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Velocity : 0    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Velocity : 1    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Velocity : 2    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Velocity : 3    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Velocity : 4    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Velocity : 5    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Velocity : 6    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Velocity : 7    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Velocity : 8    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor1Velocity : 9    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Velocity : 0    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Velocity : 1    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Velocity : 2    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Velocity : 3    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Velocity : 4    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Velocity : 5    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Velocity : 6    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Velocity : 7    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Velocity : 8    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthMotor2Velocity : 9    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorVelocity : 0    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorVelocity : 1    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorVelocity : 2    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorVelocity : 3    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorVelocity : 4    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorVelocity : 5    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorVelocity : 6    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorVelocity : 7    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorVelocity : 8    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1MotorVelocity : 9    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorVelocity : 0    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorVelocity : 1    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorVelocity : 2    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorVelocity : 3    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorVelocity : 4    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorVelocity : 5    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorVelocity : 6    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorVelocity : 7    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorVelocity : 8    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2MotorVelocity : 9    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Velocity : 0    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Velocity : 1    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Velocity : 2    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Velocity : 3    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Velocity : 4    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Velocity : 5    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Velocity : 6    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Velocity : 7    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Velocity : 8    1
    Should Contain X Times    ${measuredMotorVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Velocity : 9    1
    ${nasmyth_m3_mountMotorEncoders_start}=    Get Index From List    ${full_list}    === ATMCS_nasmyth_m3_mountMotorEncoders start of topic ===
    ${nasmyth_m3_mountMotorEncoders_end}=    Get Index From List    ${full_list}    === ATMCS_nasmyth_m3_mountMotorEncoders end of topic ===
    ${nasmyth_m3_mountMotorEncoders_list}=    Get Slice From List    ${full_list}    start=${nasmyth_m3_mountMotorEncoders_start}    end=${nasmyth_m3_mountMotorEncoders_end}
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cRIO_timestamp : 1    10
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder : 0    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder : 1    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder : 2    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder : 3    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder : 4    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder : 5    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder : 6    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder : 7    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder : 8    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder : 9    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder : 0    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder : 1    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder : 2    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder : 3    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder : 4    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder : 5    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder : 6    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder : 7    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder : 8    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder : 9    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Encoder : 0    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Encoder : 1    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Encoder : 2    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Encoder : 3    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Encoder : 4    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Encoder : 5    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Encoder : 6    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Encoder : 7    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Encoder : 8    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Encoder : 9    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1EncoderRaw : 0    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1EncoderRaw : 1    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1EncoderRaw : 2    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1EncoderRaw : 3    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1EncoderRaw : 4    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1EncoderRaw : 5    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1EncoderRaw : 6    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1EncoderRaw : 7    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1EncoderRaw : 8    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1EncoderRaw : 9    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2EncoderRaw : 0    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2EncoderRaw : 1    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2EncoderRaw : 2    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2EncoderRaw : 3    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2EncoderRaw : 4    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2EncoderRaw : 5    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2EncoderRaw : 6    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2EncoderRaw : 7    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2EncoderRaw : 8    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2EncoderRaw : 9    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3EncoderRaw : 0    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3EncoderRaw : 1    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3EncoderRaw : 2    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3EncoderRaw : 3    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3EncoderRaw : 4    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3EncoderRaw : 5    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3EncoderRaw : 6    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3EncoderRaw : 7    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3EncoderRaw : 8    1
    Should Contain X Times    ${nasmyth_m3_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3EncoderRaw : 9    1
    ${azEl_mountMotorEncoders_start}=    Get Index From List    ${full_list}    === ATMCS_azEl_mountMotorEncoders start of topic ===
    ${azEl_mountMotorEncoders_end}=    Get Index From List    ${full_list}    === ATMCS_azEl_mountMotorEncoders end of topic ===
    ${azEl_mountMotorEncoders_list}=    Get Slice From List    ${full_list}    start=${azEl_mountMotorEncoders_start}    end=${azEl_mountMotorEncoders_end}
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cRIO_timestamp : 1    10
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder : 0    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder : 1    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder : 2    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder : 3    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder : 4    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder : 5    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder : 6    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder : 7    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder : 8    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder : 9    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1Encoder : 0    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1Encoder : 1    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1Encoder : 2    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1Encoder : 3    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1Encoder : 4    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1Encoder : 5    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1Encoder : 6    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1Encoder : 7    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1Encoder : 8    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1Encoder : 9    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2Encoder : 0    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2Encoder : 1    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2Encoder : 2    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2Encoder : 3    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2Encoder : 4    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2Encoder : 5    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2Encoder : 6    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2Encoder : 7    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2Encoder : 8    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2Encoder : 9    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRaw : 0    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRaw : 1    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRaw : 2    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRaw : 3    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRaw : 4    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRaw : 5    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRaw : 6    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRaw : 7    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRaw : 8    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRaw : 9    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1EncoderRaw : 0    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1EncoderRaw : 1    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1EncoderRaw : 2    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1EncoderRaw : 3    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1EncoderRaw : 4    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1EncoderRaw : 5    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1EncoderRaw : 6    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1EncoderRaw : 7    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1EncoderRaw : 8    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1EncoderRaw : 9    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2EncoderRaw : 0    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2EncoderRaw : 1    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2EncoderRaw : 2    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2EncoderRaw : 3    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2EncoderRaw : 4    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2EncoderRaw : 5    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2EncoderRaw : 6    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2EncoderRaw : 7    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2EncoderRaw : 8    1
    Should Contain X Times    ${azEl_mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2EncoderRaw : 9    1
