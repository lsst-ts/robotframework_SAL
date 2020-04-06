*** Settings ***
Documentation    MTM2_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
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
${maven}        ${SALVersion}_${XML_Version}${MavenVersion}

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${maven}/src/test/java/${subSystem}Publisher_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${maven}/src/test/java/${subSystem}Subscriber_all.java

Start Subscriber
    [Tags]    functional
    Comment    Executing Combined Java Subscriber Program.
    ${output}=    Start Process    mvn    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${maven}/    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt    stderr=${EXECDIR}${/}${subSystem}_stderrSubscriber.txt
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
    ${output}=    Run Process    mvn    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${maven}/    alias=${subSystem}_Publisher    stdout=${EXECDIR}${/}${subSystem}_stdoutPublisher.txt    stderr=${EXECDIR}${/}${subSystem}_stderrPublisher.txt
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
    ${mirrorPositionMeasured_start}=    Get Index From List    ${full_list}    === MTM2_mirrorPositionMeasured start of topic ===
    ${mirrorPositionMeasured_end}=    Get Index From List    ${full_list}    === MTM2_mirrorPositionMeasured end of topic ===
    ${mirrorPositionMeasured_list}=    Get Slice From List    ${full_list}    start=${mirrorPositionMeasured_start}    end=${mirrorPositionMeasured_end + 1}
    Log Many    ${mirrorPositionMeasured_list}
    Should Contain    ${mirrorPositionMeasured_list}    === MTM2_mirrorPositionMeasured start of topic ===
    Should Contain    ${mirrorPositionMeasured_list}    === MTM2_mirrorPositionMeasured end of topic ===
    ${axialForceData_start}=    Get Index From List    ${full_list}    === MTM2_axialForceData start of topic ===
    ${axialForceData_end}=    Get Index From List    ${full_list}    === MTM2_axialForceData end of topic ===
    ${axialForceData_list}=    Get Slice From List    ${full_list}    start=${axialForceData_start}    end=${axialForceData_end + 1}
    Log Many    ${axialForceData_list}
    Should Contain    ${axialForceData_list}    === MTM2_axialForceData start of topic ===
    Should Contain    ${axialForceData_list}    === MTM2_axialForceData end of topic ===
    ${tangentForceData_start}=    Get Index From List    ${full_list}    === MTM2_tangentForceData start of topic ===
    ${tangentForceData_end}=    Get Index From List    ${full_list}    === MTM2_tangentForceData end of topic ===
    ${tangentForceData_list}=    Get Slice From List    ${full_list}    start=${tangentForceData_start}    end=${tangentForceData_end + 1}
    Log Many    ${tangentForceData_list}
    Should Contain    ${tangentForceData_list}    === MTM2_tangentForceData start of topic ===
    Should Contain    ${tangentForceData_list}    === MTM2_tangentForceData end of topic ===
    ${temperaturesMeasured_start}=    Get Index From List    ${full_list}    === MTM2_temperaturesMeasured start of topic ===
    ${temperaturesMeasured_end}=    Get Index From List    ${full_list}    === MTM2_temperaturesMeasured end of topic ===
    ${temperaturesMeasured_list}=    Get Slice From List    ${full_list}    start=${temperaturesMeasured_start}    end=${temperaturesMeasured_end + 1}
    Log Many    ${temperaturesMeasured_list}
    Should Contain    ${temperaturesMeasured_list}    === MTM2_temperaturesMeasured start of topic ===
    Should Contain    ${temperaturesMeasured_list}    === MTM2_temperaturesMeasured end of topic ===
    ${zenithAngleData_start}=    Get Index From List    ${full_list}    === MTM2_zenithAngleData start of topic ===
    ${zenithAngleData_end}=    Get Index From List    ${full_list}    === MTM2_zenithAngleData end of topic ===
    ${zenithAngleData_list}=    Get Slice From List    ${full_list}    start=${zenithAngleData_start}    end=${zenithAngleData_end + 1}
    Log Many    ${zenithAngleData_list}
    Should Contain    ${zenithAngleData_list}    === MTM2_zenithAngleData start of topic ===
    Should Contain    ${zenithAngleData_list}    === MTM2_zenithAngleData end of topic ===
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
