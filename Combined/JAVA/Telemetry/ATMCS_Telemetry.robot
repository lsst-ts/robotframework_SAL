*** Settings ***
Documentation    ATMCS_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATMCS
${component}    all
${timeout}    600s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${XMLVersion}-${SALVersion}.${MavenVersion}/src/test/java/${subSystem}Publisher_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${XMLVersion}-${SALVersion}.${MavenVersion}/src/test/java/${subSystem}Subscriber_all.java

Start Subscriber
    [Tags]    functional
    Comment    Executing Combined Java Subscriber Program.
    ${output}=    Start Process    mvn    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${XMLVersion}-${SALVersion}.${MavenVersion}/    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt    stderr=${EXECDIR}${/}${subSystem}_stderrSubscriber.txt
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    30    1s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt
    Comment    Wait for Subscriber program to be ready.
    ${subscriberOutput}=    Get File    ${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt
    :FOR    ${i}    IN RANGE    30
    \    Exit For Loop If     '${subSystem} all subscribers ready' in $subscriberOutput
    \    ${subscriberOutput}=    Get File    ${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt
    \    Sleep    3s
    Log    ${subscriberOutput}
    Should Contain    ${subscriberOutput}    ===== ${subSystem} all subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Executing Combined Java Publisher Program.
    ${output}=    Run Process    mvn    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${XMLVersion}-${SALVersion}.${MavenVersion}/    alias=${subSystem}_Publisher    stdout=${EXECDIR}${/}${subSystem}_stdoutPublisher.txt    stderr=${EXECDIR}${/}${subSystem}_stderrPublisher.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all publishers ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ATMCS all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${trajectory_start}=    Get Index From List    ${full_list}    === ATMCS_trajectory start of topic ===
    ${trajectory_end}=    Get Index From List    ${full_list}    === ATMCS_trajectory end of topic ===
    ${trajectory_list}=    Get Slice From List    ${full_list}    start=${trajectory_start}    end=${trajectory_end + 1}
    Log Many    ${trajectory_list}
    Should Contain    ${trajectory_list}    === ATMCS_trajectory start of topic ===
    Should Contain    ${trajectory_list}    === ATMCS_trajectory end of topic ===
    ${mount_AzEl_Encoders_start}=    Get Index From List    ${full_list}    === ATMCS_mount_AzEl_Encoders start of topic ===
    ${mount_AzEl_Encoders_end}=    Get Index From List    ${full_list}    === ATMCS_mount_AzEl_Encoders end of topic ===
    ${mount_AzEl_Encoders_list}=    Get Slice From List    ${full_list}    start=${mount_AzEl_Encoders_start}    end=${mount_AzEl_Encoders_end + 1}
    Log Many    ${mount_AzEl_Encoders_list}
    Should Contain    ${mount_AzEl_Encoders_list}    === ATMCS_mount_AzEl_Encoders start of topic ===
    Should Contain    ${mount_AzEl_Encoders_list}    === ATMCS_mount_AzEl_Encoders end of topic ===
    ${mount_Nasmyth_Encoders_start}=    Get Index From List    ${full_list}    === ATMCS_mount_Nasmyth_Encoders start of topic ===
    ${mount_Nasmyth_Encoders_end}=    Get Index From List    ${full_list}    === ATMCS_mount_Nasmyth_Encoders end of topic ===
    ${mount_Nasmyth_Encoders_list}=    Get Slice From List    ${full_list}    start=${mount_Nasmyth_Encoders_start}    end=${mount_Nasmyth_Encoders_end + 1}
    Log Many    ${mount_Nasmyth_Encoders_list}
    Should Contain    ${mount_Nasmyth_Encoders_list}    === ATMCS_mount_Nasmyth_Encoders start of topic ===
    Should Contain    ${mount_Nasmyth_Encoders_list}    === ATMCS_mount_Nasmyth_Encoders end of topic ===
    ${torqueDemand_start}=    Get Index From List    ${full_list}    === ATMCS_torqueDemand start of topic ===
    ${torqueDemand_end}=    Get Index From List    ${full_list}    === ATMCS_torqueDemand end of topic ===
    ${torqueDemand_list}=    Get Slice From List    ${full_list}    start=${torqueDemand_start}    end=${torqueDemand_end + 1}
    Log Many    ${torqueDemand_list}
    Should Contain    ${torqueDemand_list}    === ATMCS_torqueDemand start of topic ===
    Should Contain    ${torqueDemand_list}    === ATMCS_torqueDemand end of topic ===
    ${measuredTorque_start}=    Get Index From List    ${full_list}    === ATMCS_measuredTorque start of topic ===
    ${measuredTorque_end}=    Get Index From List    ${full_list}    === ATMCS_measuredTorque end of topic ===
    ${measuredTorque_list}=    Get Slice From List    ${full_list}    start=${measuredTorque_start}    end=${measuredTorque_end + 1}
    Log Many    ${measuredTorque_list}
    Should Contain    ${measuredTorque_list}    === ATMCS_measuredTorque start of topic ===
    Should Contain    ${measuredTorque_list}    === ATMCS_measuredTorque end of topic ===
    ${measuredMotorVelocity_start}=    Get Index From List    ${full_list}    === ATMCS_measuredMotorVelocity start of topic ===
    ${measuredMotorVelocity_end}=    Get Index From List    ${full_list}    === ATMCS_measuredMotorVelocity end of topic ===
    ${measuredMotorVelocity_list}=    Get Slice From List    ${full_list}    start=${measuredMotorVelocity_start}    end=${measuredMotorVelocity_end + 1}
    Log Many    ${measuredMotorVelocity_list}
    Should Contain    ${measuredMotorVelocity_list}    === ATMCS_measuredMotorVelocity start of topic ===
    Should Contain    ${measuredMotorVelocity_list}    === ATMCS_measuredMotorVelocity end of topic ===
    ${nasymth_m3_mountMotorEncoders_start}=    Get Index From List    ${full_list}    === ATMCS_nasymth_m3_mountMotorEncoders start of topic ===
    ${nasymth_m3_mountMotorEncoders_end}=    Get Index From List    ${full_list}    === ATMCS_nasymth_m3_mountMotorEncoders end of topic ===
    ${nasymth_m3_mountMotorEncoders_list}=    Get Slice From List    ${full_list}    start=${nasymth_m3_mountMotorEncoders_start}    end=${nasymth_m3_mountMotorEncoders_end + 1}
    Log Many    ${nasymth_m3_mountMotorEncoders_list}
    Should Contain    ${nasymth_m3_mountMotorEncoders_list}    === ATMCS_nasymth_m3_mountMotorEncoders start of topic ===
    Should Contain    ${nasymth_m3_mountMotorEncoders_list}    === ATMCS_nasymth_m3_mountMotorEncoders end of topic ===
    ${azEl_mountMotorEncoders_start}=    Get Index From List    ${full_list}    === ATMCS_azEl_mountMotorEncoders start of topic ===
    ${azEl_mountMotorEncoders_end}=    Get Index From List    ${full_list}    === ATMCS_azEl_mountMotorEncoders end of topic ===
    ${azEl_mountMotorEncoders_list}=    Get Slice From List    ${full_list}    start=${azEl_mountMotorEncoders_start}    end=${azEl_mountMotorEncoders_end + 1}
    Log Many    ${azEl_mountMotorEncoders_list}
    Should Contain    ${azEl_mountMotorEncoders_list}    === ATMCS_azEl_mountMotorEncoders start of topic ===
    Should Contain    ${azEl_mountMotorEncoders_list}    === ATMCS_azEl_mountMotorEncoders end of topic ===
