*** Settings ***
Documentation    MTM2_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTM2
${component}    all
${timeout}    600s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${MavenVersion}/src/test/java/${subSystem}Publisher_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${MavenVersion}/src/test/java/${subSystem}Subscriber_all.java

Start Subscriber
    [Tags]    functional
    Comment    Executing Combined Java Subscriber Program.
    ${output}=    Start Process    mvn    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${MavenVersion}/    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt    stderr=${EXECDIR}${/}${subSystem}_stderrSubscriber.txt
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
    ${output}=    Run Process    mvn    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${MavenVersion}/    alias=${subSystem}_Publisher    stdout=${EXECDIR}${/}${subSystem}_stdoutPublisher.txt    stderr=${EXECDIR}${/}${subSystem}_stderrPublisher.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all publishers ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTM2 all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${position_start}=    Get Index From List    ${full_list}    === MTM2_position start of topic ===
    ${position_end}=    Get Index From List    ${full_list}    === MTM2_position end of topic ===
    ${position_list}=    Get Slice From List    ${full_list}    start=${position_start}    end=${position_end + 1}
    Log Many    ${position_list}
    Should Contain    ${position_list}    === MTM2_position start of topic ===
    Should Contain    ${position_list}    === MTM2_position end of topic ===
    ${positionIMS_start}=    Get Index From List    ${full_list}    === MTM2_positionIMS start of topic ===
    ${positionIMS_end}=    Get Index From List    ${full_list}    === MTM2_positionIMS end of topic ===
    ${positionIMS_list}=    Get Slice From List    ${full_list}    start=${positionIMS_start}    end=${positionIMS_end + 1}
    Log Many    ${positionIMS_list}
    Should Contain    ${positionIMS_list}    === MTM2_positionIMS start of topic ===
    Should Contain    ${positionIMS_list}    === MTM2_positionIMS end of topic ===
    ${axialForce_start}=    Get Index From List    ${full_list}    === MTM2_axialForce start of topic ===
    ${axialForce_end}=    Get Index From List    ${full_list}    === MTM2_axialForce end of topic ===
    ${axialForce_list}=    Get Slice From List    ${full_list}    start=${axialForce_start}    end=${axialForce_end + 1}
    Log Many    ${axialForce_list}
    Should Contain    ${axialForce_list}    === MTM2_axialForce start of topic ===
    Should Contain    ${axialForce_list}    === MTM2_axialForce end of topic ===
    ${tangentForce_start}=    Get Index From List    ${full_list}    === MTM2_tangentForce start of topic ===
    ${tangentForce_end}=    Get Index From List    ${full_list}    === MTM2_tangentForce end of topic ===
    ${tangentForce_list}=    Get Slice From List    ${full_list}    start=${tangentForce_start}    end=${tangentForce_end + 1}
    Log Many    ${tangentForce_list}
    Should Contain    ${tangentForce_list}    === MTM2_tangentForce start of topic ===
    Should Contain    ${tangentForce_list}    === MTM2_tangentForce end of topic ===
    ${temperature_start}=    Get Index From List    ${full_list}    === MTM2_temperature start of topic ===
    ${temperature_end}=    Get Index From List    ${full_list}    === MTM2_temperature end of topic ===
    ${temperature_list}=    Get Slice From List    ${full_list}    start=${temperature_start}    end=${temperature_end + 1}
    Log Many    ${temperature_list}
    Should Contain    ${temperature_list}    === MTM2_temperature start of topic ===
    Should Contain    ${temperature_list}    === MTM2_temperature end of topic ===
    ${zenithAngle_start}=    Get Index From List    ${full_list}    === MTM2_zenithAngle start of topic ===
    ${zenithAngle_end}=    Get Index From List    ${full_list}    === MTM2_zenithAngle end of topic ===
    ${zenithAngle_list}=    Get Slice From List    ${full_list}    start=${zenithAngle_start}    end=${zenithAngle_end + 1}
    Log Many    ${zenithAngle_list}
    Should Contain    ${zenithAngle_list}    === MTM2_zenithAngle start of topic ===
    Should Contain    ${zenithAngle_list}    === MTM2_zenithAngle end of topic ===
    ${axialActuatorSteps_start}=    Get Index From List    ${full_list}    === MTM2_axialActuatorSteps start of topic ===
    ${axialActuatorSteps_end}=    Get Index From List    ${full_list}    === MTM2_axialActuatorSteps end of topic ===
    ${axialActuatorSteps_list}=    Get Slice From List    ${full_list}    start=${axialActuatorSteps_start}    end=${axialActuatorSteps_end + 1}
    Log Many    ${axialActuatorSteps_list}
    Should Contain    ${axialActuatorSteps_list}    === MTM2_axialActuatorSteps start of topic ===
    Should Contain    ${axialActuatorSteps_list}    === MTM2_axialActuatorSteps end of topic ===
    ${tangentActuatorSteps_start}=    Get Index From List    ${full_list}    === MTM2_tangentActuatorSteps start of topic ===
    ${tangentActuatorSteps_end}=    Get Index From List    ${full_list}    === MTM2_tangentActuatorSteps end of topic ===
    ${tangentActuatorSteps_list}=    Get Slice From List    ${full_list}    start=${tangentActuatorSteps_start}    end=${tangentActuatorSteps_end + 1}
    Log Many    ${tangentActuatorSteps_list}
    Should Contain    ${tangentActuatorSteps_list}    === MTM2_tangentActuatorSteps start of topic ===
    Should Contain    ${tangentActuatorSteps_list}    === MTM2_tangentActuatorSteps end of topic ===
    ${axialEncoderPositions_start}=    Get Index From List    ${full_list}    === MTM2_axialEncoderPositions start of topic ===
    ${axialEncoderPositions_end}=    Get Index From List    ${full_list}    === MTM2_axialEncoderPositions end of topic ===
    ${axialEncoderPositions_list}=    Get Slice From List    ${full_list}    start=${axialEncoderPositions_start}    end=${axialEncoderPositions_end + 1}
    Log Many    ${axialEncoderPositions_list}
    Should Contain    ${axialEncoderPositions_list}    === MTM2_axialEncoderPositions start of topic ===
    Should Contain    ${axialEncoderPositions_list}    === MTM2_axialEncoderPositions end of topic ===
    ${tangentEncoderPositions_start}=    Get Index From List    ${full_list}    === MTM2_tangentEncoderPositions start of topic ===
    ${tangentEncoderPositions_end}=    Get Index From List    ${full_list}    === MTM2_tangentEncoderPositions end of topic ===
    ${tangentEncoderPositions_list}=    Get Slice From List    ${full_list}    start=${tangentEncoderPositions_start}    end=${tangentEncoderPositions_end + 1}
    Log Many    ${tangentEncoderPositions_list}
    Should Contain    ${tangentEncoderPositions_list}    === MTM2_tangentEncoderPositions start of topic ===
    Should Contain    ${tangentEncoderPositions_list}    === MTM2_tangentEncoderPositions end of topic ===
    ${ilcData_start}=    Get Index From List    ${full_list}    === MTM2_ilcData start of topic ===
    ${ilcData_end}=    Get Index From List    ${full_list}    === MTM2_ilcData end of topic ===
    ${ilcData_list}=    Get Slice From List    ${full_list}    start=${ilcData_start}    end=${ilcData_end + 1}
    Log Many    ${ilcData_list}
    Should Contain    ${ilcData_list}    === MTM2_ilcData start of topic ===
    Should Contain    ${ilcData_list}    === MTM2_ilcData end of topic ===
    ${displacementSensors_start}=    Get Index From List    ${full_list}    === MTM2_displacementSensors start of topic ===
    ${displacementSensors_end}=    Get Index From List    ${full_list}    === MTM2_displacementSensors end of topic ===
    ${displacementSensors_list}=    Get Slice From List    ${full_list}    start=${displacementSensors_start}    end=${displacementSensors_end + 1}
    Log Many    ${displacementSensors_list}
    Should Contain    ${displacementSensors_list}    === MTM2_displacementSensors start of topic ===
    Should Contain    ${displacementSensors_list}    === MTM2_displacementSensors end of topic ===
    ${forceBalance_start}=    Get Index From List    ${full_list}    === MTM2_forceBalance start of topic ===
    ${forceBalance_end}=    Get Index From List    ${full_list}    === MTM2_forceBalance end of topic ===
    ${forceBalance_list}=    Get Slice From List    ${full_list}    start=${forceBalance_start}    end=${forceBalance_end + 1}
    Log Many    ${forceBalance_list}
    Should Contain    ${forceBalance_list}    === MTM2_forceBalance start of topic ===
    Should Contain    ${forceBalance_list}    === MTM2_forceBalance end of topic ===
    ${netForcesTotal_start}=    Get Index From List    ${full_list}    === MTM2_netForcesTotal start of topic ===
    ${netForcesTotal_end}=    Get Index From List    ${full_list}    === MTM2_netForcesTotal end of topic ===
    ${netForcesTotal_list}=    Get Slice From List    ${full_list}    start=${netForcesTotal_start}    end=${netForcesTotal_end + 1}
    Log Many    ${netForcesTotal_list}
    Should Contain    ${netForcesTotal_list}    === MTM2_netForcesTotal start of topic ===
    Should Contain    ${netForcesTotal_list}    === MTM2_netForcesTotal end of topic ===
    ${netMomentsTotal_start}=    Get Index From List    ${full_list}    === MTM2_netMomentsTotal start of topic ===
    ${netMomentsTotal_end}=    Get Index From List    ${full_list}    === MTM2_netMomentsTotal end of topic ===
    ${netMomentsTotal_list}=    Get Slice From List    ${full_list}    start=${netMomentsTotal_start}    end=${netMomentsTotal_end + 1}
    Log Many    ${netMomentsTotal_list}
    Should Contain    ${netMomentsTotal_list}    === MTM2_netMomentsTotal start of topic ===
    Should Contain    ${netMomentsTotal_list}    === MTM2_netMomentsTotal end of topic ===
    ${powerStatus_start}=    Get Index From List    ${full_list}    === MTM2_powerStatus start of topic ===
    ${powerStatus_end}=    Get Index From List    ${full_list}    === MTM2_powerStatus end of topic ===
    ${powerStatus_list}=    Get Slice From List    ${full_list}    start=${powerStatus_start}    end=${powerStatus_end + 1}
    Log Many    ${powerStatus_list}
    Should Contain    ${powerStatus_list}    === MTM2_powerStatus start of topic ===
    Should Contain    ${powerStatus_list}    === MTM2_powerStatus end of topic ===
