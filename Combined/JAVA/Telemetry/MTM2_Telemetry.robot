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

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}Publisher_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}Subscriber_all.java

Start Subscriber
    [Tags]    functional
    Comment    Executing Combined Java Subscriber Program.
    ${subscriberOutput}=    Start Process    mvn    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${SALVersion}/    alias=Subscriber    stdout=${EXECDIR}${/}stdoutSubscriber.txt    stderr=${EXECDIR}${/}stderrSubscriber.txt
    Log    ${subscriberOutput}
    Should Contain    "${subscriberOutput}"   "1"
    Wait Until Keyword Succeeds    30    1s    File Should Not Be Empty    ${EXECDIR}${/}stdoutSubscriber.txt
    Comment    Wait for Subscriber program to be ready.
    ${subscriberOutput}=    Get File    ${EXECDIR}${/}stdoutSubscriber.txt
    :FOR    ${i}    IN RANGE    30
    \    Exit For Loop If     '${subSystem} all subscribers ready' in $subscriberOutput
    \    ${subscriberOutput}=    Get File    ${EXECDIR}${/}stdoutSubscriber.txt
    \    Sleep    3s
    Log    ${subscriberOutput}
    Should Contain    ${subscriberOutput}    ===== ${subSystem} all subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Executing Combined Java Publisher Program.
    ${publisherOutput}=    Run Process    mvn    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${SALVersion}/    alias=Publisher    stdout=${EXECDIR}${/}stdoutPublisher.txt    stderr=${EXECDIR}${/}stderrPublisher.txt
    Log    ${publisherOutput.stdout}
    Should Contain    ${publisherOutput.stdout}    ===== ${subSystem} all publishers ready =====
    Should Contain    ${publisherOutput.stdout}    [INFO] BUILD SUCCESS

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTM2 all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${mirrorPositionMeasured_start}=    Get Index From List    ${full_list}    === MTM2_mirrorPositionMeasured start of topic ===
    ${mirrorPositionMeasured_end}=    Get Index From List    ${full_list}    === MTM2_mirrorPositionMeasured end of topic ===
    ${mirrorPositionMeasured_list}=    Get Slice From List    ${full_list}    start=${mirrorPositionMeasured_start}    end=${mirrorPositionMeasured_end + 1}
    Log Many    ${mirrorPositionMeasured_list}
    Should Contain    ${mirrorPositionMeasured_list}    === MTM2_mirrorPositionMeasured start of topic ===
    Should Contain    ${mirrorPositionMeasured_list}    === MTM2_mirrorPositionMeasured end of topic ===
    ${axialForcesMeasured_start}=    Get Index From List    ${full_list}    === MTM2_axialForcesMeasured start of topic ===
    ${axialForcesMeasured_end}=    Get Index From List    ${full_list}    === MTM2_axialForcesMeasured end of topic ===
    ${axialForcesMeasured_list}=    Get Slice From List    ${full_list}    start=${axialForcesMeasured_start}    end=${axialForcesMeasured_end + 1}
    Log Many    ${axialForcesMeasured_list}
    Should Contain    ${axialForcesMeasured_list}    === MTM2_axialForcesMeasured start of topic ===
    Should Contain    ${axialForcesMeasured_list}    === MTM2_axialForcesMeasured end of topic ===
    ${tangentForcesMeasured_start}=    Get Index From List    ${full_list}    === MTM2_tangentForcesMeasured start of topic ===
    ${tangentForcesMeasured_end}=    Get Index From List    ${full_list}    === MTM2_tangentForcesMeasured end of topic ===
    ${tangentForcesMeasured_list}=    Get Slice From List    ${full_list}    start=${tangentForcesMeasured_start}    end=${tangentForcesMeasured_end + 1}
    Log Many    ${tangentForcesMeasured_list}
    Should Contain    ${tangentForcesMeasured_list}    === MTM2_tangentForcesMeasured start of topic ===
    Should Contain    ${tangentForcesMeasured_list}    === MTM2_tangentForcesMeasured end of topic ===
    ${zenithAngleMeasured_start}=    Get Index From List    ${full_list}    === MTM2_zenithAngleMeasured start of topic ===
    ${zenithAngleMeasured_end}=    Get Index From List    ${full_list}    === MTM2_zenithAngleMeasured end of topic ===
    ${zenithAngleMeasured_list}=    Get Slice From List    ${full_list}    start=${zenithAngleMeasured_start}    end=${zenithAngleMeasured_end + 1}
    Log Many    ${zenithAngleMeasured_list}
    Should Contain    ${zenithAngleMeasured_list}    === MTM2_zenithAngleMeasured start of topic ===
    Should Contain    ${zenithAngleMeasured_list}    === MTM2_zenithAngleMeasured end of topic ===
    ${axialActuatorAbsolutePositionSteps_start}=    Get Index From List    ${full_list}    === MTM2_axialActuatorAbsolutePositionSteps start of topic ===
    ${axialActuatorAbsolutePositionSteps_end}=    Get Index From List    ${full_list}    === MTM2_axialActuatorAbsolutePositionSteps end of topic ===
    ${axialActuatorAbsolutePositionSteps_list}=    Get Slice From List    ${full_list}    start=${axialActuatorAbsolutePositionSteps_start}    end=${axialActuatorAbsolutePositionSteps_end + 1}
    Log Many    ${axialActuatorAbsolutePositionSteps_list}
    Should Contain    ${axialActuatorAbsolutePositionSteps_list}    === MTM2_axialActuatorAbsolutePositionSteps start of topic ===
    Should Contain    ${axialActuatorAbsolutePositionSteps_list}    === MTM2_axialActuatorAbsolutePositionSteps end of topic ===
    ${tangentActuatorAbsolutePositionSteps_start}=    Get Index From List    ${full_list}    === MTM2_tangentActuatorAbsolutePositionSteps start of topic ===
    ${tangentActuatorAbsolutePositionSteps_end}=    Get Index From List    ${full_list}    === MTM2_tangentActuatorAbsolutePositionSteps end of topic ===
    ${tangentActuatorAbsolutePositionSteps_list}=    Get Slice From List    ${full_list}    start=${tangentActuatorAbsolutePositionSteps_start}    end=${tangentActuatorAbsolutePositionSteps_end + 1}
    Log Many    ${tangentActuatorAbsolutePositionSteps_list}
    Should Contain    ${tangentActuatorAbsolutePositionSteps_list}    === MTM2_tangentActuatorAbsolutePositionSteps start of topic ===
    Should Contain    ${tangentActuatorAbsolutePositionSteps_list}    === MTM2_tangentActuatorAbsolutePositionSteps end of topic ===
    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_start}=    Get Index From List    ${full_list}    === MTM2_axialActuatorPositionAbsoluteEncoderPositionMeasured start of topic ===
    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_end}=    Get Index From List    ${full_list}    === MTM2_axialActuatorPositionAbsoluteEncoderPositionMeasured end of topic ===
    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}=    Get Slice From List    ${full_list}    start=${axialActuatorPositionAbsoluteEncoderPositionMeasured_start}    end=${axialActuatorPositionAbsoluteEncoderPositionMeasured_end + 1}
    Log Many    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}
    Should Contain    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    === MTM2_axialActuatorPositionAbsoluteEncoderPositionMeasured start of topic ===
    Should Contain    ${axialActuatorPositionAbsoluteEncoderPositionMeasured_list}    === MTM2_axialActuatorPositionAbsoluteEncoderPositionMeasured end of topic ===
    ${tangentActuatorPositionAbsoluteEncoderPositionMeasured_start}=    Get Index From List    ${full_list}    === MTM2_tangentActuatorPositionAbsoluteEncoderPositionMeasured start of topic ===
    ${tangentActuatorPositionAbsoluteEncoderPositionMeasured_end}=    Get Index From List    ${full_list}    === MTM2_tangentActuatorPositionAbsoluteEncoderPositionMeasured end of topic ===
    ${tangentActuatorPositionAbsoluteEncoderPositionMeasured_list}=    Get Slice From List    ${full_list}    start=${tangentActuatorPositionAbsoluteEncoderPositionMeasured_start}    end=${tangentActuatorPositionAbsoluteEncoderPositionMeasured_end + 1}
    Log Many    ${tangentActuatorPositionAbsoluteEncoderPositionMeasured_list}
    Should Contain    ${tangentActuatorPositionAbsoluteEncoderPositionMeasured_list}    === MTM2_tangentActuatorPositionAbsoluteEncoderPositionMeasured start of topic ===
    Should Contain    ${tangentActuatorPositionAbsoluteEncoderPositionMeasured_list}    === MTM2_tangentActuatorPositionAbsoluteEncoderPositionMeasured end of topic ===
    ${powerStatus_start}=    Get Index From List    ${full_list}    === MTM2_powerStatus start of topic ===
    ${powerStatus_end}=    Get Index From List    ${full_list}    === MTM2_powerStatus end of topic ===
    ${powerStatus_list}=    Get Slice From List    ${full_list}    start=${powerStatus_start}    end=${powerStatus_end + 1}
    Log Many    ${powerStatus_list}
    Should Contain    ${powerStatus_list}    === MTM2_powerStatus start of topic ===
    Should Contain    ${powerStatus_list}    === MTM2_powerStatus end of topic ===
    ${temperaturesMeasured_start}=    Get Index From List    ${full_list}    === MTM2_temperaturesMeasured start of topic ===
    ${temperaturesMeasured_end}=    Get Index From List    ${full_list}    === MTM2_temperaturesMeasured end of topic ===
    ${temperaturesMeasured_list}=    Get Slice From List    ${full_list}    start=${temperaturesMeasured_start}    end=${temperaturesMeasured_end + 1}
    Log Many    ${temperaturesMeasured_list}
    Should Contain    ${temperaturesMeasured_list}    === MTM2_temperaturesMeasured start of topic ===
    Should Contain    ${temperaturesMeasured_list}    === MTM2_temperaturesMeasured end of topic ===
    ${rawDisplacement_start}=    Get Index From List    ${full_list}    === MTM2_rawDisplacement start of topic ===
    ${rawDisplacement_end}=    Get Index From List    ${full_list}    === MTM2_rawDisplacement end of topic ===
    ${rawDisplacement_list}=    Get Slice From List    ${full_list}    start=${rawDisplacement_start}    end=${rawDisplacement_end + 1}
    Log Many    ${rawDisplacement_list}
    Should Contain    ${rawDisplacement_list}    === MTM2_rawDisplacement start of topic ===
    Should Contain    ${rawDisplacement_list}    === MTM2_rawDisplacement end of topic ===
    ${stepVectorUpdate_start}=    Get Index From List    ${full_list}    === MTM2_stepVectorUpdate start of topic ===
    ${stepVectorUpdate_end}=    Get Index From List    ${full_list}    === MTM2_stepVectorUpdate end of topic ===
    ${stepVectorUpdate_list}=    Get Slice From List    ${full_list}    start=${stepVectorUpdate_start}    end=${stepVectorUpdate_end + 1}
    Log Many    ${stepVectorUpdate_list}
    Should Contain    ${stepVectorUpdate_list}    === MTM2_stepVectorUpdate start of topic ===
    Should Contain    ${stepVectorUpdate_list}    === MTM2_stepVectorUpdate end of topic ===
    ${targetForces_start}=    Get Index From List    ${full_list}    === MTM2_targetForces start of topic ===
    ${targetForces_end}=    Get Index From List    ${full_list}    === MTM2_targetForces end of topic ===
    ${targetForces_list}=    Get Slice From List    ${full_list}    start=${targetForces_start}    end=${targetForces_end + 1}
    Log Many    ${targetForces_list}
    Should Contain    ${targetForces_list}    === MTM2_targetForces start of topic ===
    Should Contain    ${targetForces_list}    === MTM2_targetForces end of topic ===
    ${systemStatus_start}=    Get Index From List    ${full_list}    === MTM2_systemStatus start of topic ===
    ${systemStatus_end}=    Get Index From List    ${full_list}    === MTM2_systemStatus end of topic ===
    ${systemStatus_list}=    Get Slice From List    ${full_list}    start=${systemStatus_start}    end=${systemStatus_end + 1}
    Log Many    ${systemStatus_list}
    Should Contain    ${systemStatus_list}    === MTM2_systemStatus start of topic ===
    Should Contain    ${systemStatus_list}    === MTM2_systemStatus end of topic ===
    ${rawTelemetry_start}=    Get Index From List    ${full_list}    === MTM2_rawTelemetry start of topic ===
    ${rawTelemetry_end}=    Get Index From List    ${full_list}    === MTM2_rawTelemetry end of topic ===
    ${rawTelemetry_list}=    Get Slice From List    ${full_list}    start=${rawTelemetry_start}    end=${rawTelemetry_end + 1}
    Log Many    ${rawTelemetry_list}
    Should Contain    ${rawTelemetry_list}    === MTM2_rawTelemetry start of topic ===
    Should Contain    ${rawTelemetry_list}    === MTM2_rawTelemetry end of topic ===
    ${actuatorLimitSwitches_start}=    Get Index From List    ${full_list}    === MTM2_actuatorLimitSwitches start of topic ===
    ${actuatorLimitSwitches_end}=    Get Index From List    ${full_list}    === MTM2_actuatorLimitSwitches end of topic ===
    ${actuatorLimitSwitches_list}=    Get Slice From List    ${full_list}    start=${actuatorLimitSwitches_start}    end=${actuatorLimitSwitches_end + 1}
    Log Many    ${actuatorLimitSwitches_list}
    Should Contain    ${actuatorLimitSwitches_list}    === MTM2_actuatorLimitSwitches start of topic ===
    Should Contain    ${actuatorLimitSwitches_list}    === MTM2_actuatorLimitSwitches end of topic ===
