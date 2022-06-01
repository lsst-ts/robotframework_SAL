*** Settings ***
Documentation    MTRotator_Events communications tests.
Force Tags    messaging    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${Build_Number}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTRotator
${component}    all
${timeout}    45s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}Event_${component}.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}EventLogger_${component}.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/src/test/java/${subSystem}Event_${component}.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/src/test/java/${subSystem}EventLogger_${component}.java

Start Logger
    [Tags]    functional
    Comment    Executing Combined Java Logger Program.
    ${loggerOutput}=    Start Process    mvn    -Dtest\=${subSystem}EventLogger_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/    alias=logger    stdout=${EXECDIR}${/}stdoutLogger.txt    stderr=${EXECDIR}${/}stderrLogger.txt
    Should Contain    "${loggerOutput}"    Popen
    Wait Until Keyword Succeeds    30    1s    File Should Not Be Empty    ${EXECDIR}${/}stdoutLogger.txt

Start Sender
    [Tags]    functional
    Comment    Sender program waiting for Logger program to be Ready.
    ${loggerOutput}=    Get File    ${EXECDIR}${/}stdoutLogger.txt
    FOR    ${i}    IN RANGE    30
        Exit For Loop If     'MTRotator all loggers ready' in $loggerOutput
        ${loggerOutput}=    Get File    ${EXECDIR}${/}stdoutLogger.txt
        Sleep    3s
    END
    Comment    Executing Combined Java Sender Program.
    ${senderOutput}=    Start Process    mvn    -Dtest\=${subSystem}Event_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/    alias=sender    stdout=${EXECDIR}${/}stdoutSender.txt    stderr=${EXECDIR}${/}stderrSender.txt
    Should Contain    "${senderOutput}"    Popen
    ${output}=    Wait For Process    sender    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all events ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${controllerState_start}=    Get Index From List    ${full_list}    === MTRotator_controllerState start of topic ===
    ${controllerState_end}=    Get Index From List    ${full_list}    === MTRotator_controllerState end of topic ===
    ${controllerState_list}=    Get Slice From List    ${full_list}    start=${controllerState_start}    end=${controllerState_end + 1}
    Log Many    ${controllerState_list}
    Should Contain    ${controllerState_list}    === MTRotator_controllerState start of topic ===
    Should Contain    ${controllerState_list}    === MTRotator_controllerState end of topic ===
    ${connected_start}=    Get Index From List    ${full_list}    === MTRotator_connected start of topic ===
    ${connected_end}=    Get Index From List    ${full_list}    === MTRotator_connected end of topic ===
    ${connected_list}=    Get Slice From List    ${full_list}    start=${connected_start}    end=${connected_end + 1}
    Log Many    ${connected_list}
    Should Contain    ${connected_list}    === MTRotator_connected start of topic ===
    Should Contain    ${connected_list}    === MTRotator_connected end of topic ===
    ${interlock_start}=    Get Index From List    ${full_list}    === MTRotator_interlock start of topic ===
    ${interlock_end}=    Get Index From List    ${full_list}    === MTRotator_interlock end of topic ===
    ${interlock_list}=    Get Slice From List    ${full_list}    start=${interlock_start}    end=${interlock_end + 1}
    Log Many    ${interlock_list}
    Should Contain    ${interlock_list}    === MTRotator_interlock start of topic ===
    Should Contain    ${interlock_list}    === MTRotator_interlock end of topic ===
    ${target_start}=    Get Index From List    ${full_list}    === MTRotator_target start of topic ===
    ${target_end}=    Get Index From List    ${full_list}    === MTRotator_target end of topic ===
    ${target_list}=    Get Slice From List    ${full_list}    start=${target_start}    end=${target_end + 1}
    Log Many    ${target_list}
    Should Contain    ${target_list}    === MTRotator_target start of topic ===
    Should Contain    ${target_list}    === MTRotator_target end of topic ===
    ${tracking_start}=    Get Index From List    ${full_list}    === MTRotator_tracking start of topic ===
    ${tracking_end}=    Get Index From List    ${full_list}    === MTRotator_tracking end of topic ===
    ${tracking_list}=    Get Slice From List    ${full_list}    start=${tracking_start}    end=${tracking_end + 1}
    Log Many    ${tracking_list}
    Should Contain    ${tracking_list}    === MTRotator_tracking start of topic ===
    Should Contain    ${tracking_list}    === MTRotator_tracking end of topic ===
    ${inPosition_start}=    Get Index From List    ${full_list}    === MTRotator_inPosition start of topic ===
    ${inPosition_end}=    Get Index From List    ${full_list}    === MTRotator_inPosition end of topic ===
    ${inPosition_list}=    Get Slice From List    ${full_list}    start=${inPosition_start}    end=${inPosition_end + 1}
    Log Many    ${inPosition_list}
    Should Contain    ${inPosition_list}    === MTRotator_inPosition start of topic ===
    Should Contain    ${inPosition_list}    === MTRotator_inPosition end of topic ===
    ${configuration_start}=    Get Index From List    ${full_list}    === MTRotator_configuration start of topic ===
    ${configuration_end}=    Get Index From List    ${full_list}    === MTRotator_configuration end of topic ===
    ${configuration_list}=    Get Slice From List    ${full_list}    start=${configuration_start}    end=${configuration_end + 1}
    Log Many    ${configuration_list}
    Should Contain    ${configuration_list}    === MTRotator_configuration start of topic ===
    Should Contain    ${configuration_list}    === MTRotator_configuration end of topic ===
    ${commandableByDDS_start}=    Get Index From List    ${full_list}    === MTRotator_commandableByDDS start of topic ===
    ${commandableByDDS_end}=    Get Index From List    ${full_list}    === MTRotator_commandableByDDS end of topic ===
    ${commandableByDDS_list}=    Get Slice From List    ${full_list}    start=${commandableByDDS_start}    end=${commandableByDDS_end + 1}
    Log Many    ${commandableByDDS_list}
    Should Contain    ${commandableByDDS_list}    === MTRotator_commandableByDDS start of topic ===
    Should Contain    ${commandableByDDS_list}    === MTRotator_commandableByDDS end of topic ===
    ${heartbeat_start}=    Get Index From List    ${full_list}    === MTRotator_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === MTRotator_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === MTRotator_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === MTRotator_heartbeat end of topic ===
    ${logLevel_start}=    Get Index From List    ${full_list}    === MTRotator_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === MTRotator_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end + 1}
    Log Many    ${logLevel_list}
    Should Contain    ${logLevel_list}    === MTRotator_logLevel start of topic ===
    Should Contain    ${logLevel_list}    === MTRotator_logLevel end of topic ===
    ${logMessage_start}=    Get Index From List    ${full_list}    === MTRotator_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === MTRotator_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end + 1}
    Log Many    ${logMessage_list}
    Should Contain    ${logMessage_list}    === MTRotator_logMessage start of topic ===
    Should Contain    ${logMessage_list}    === MTRotator_logMessage end of topic ===
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === MTRotator_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === MTRotator_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end + 1}
    Log Many    ${softwareVersions_list}
    Should Contain    ${softwareVersions_list}    === MTRotator_softwareVersions start of topic ===
    Should Contain    ${softwareVersions_list}    === MTRotator_softwareVersions end of topic ===
    ${authList_start}=    Get Index From List    ${full_list}    === MTRotator_authList start of topic ===
    ${authList_end}=    Get Index From List    ${full_list}    === MTRotator_authList end of topic ===
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end + 1}
    Log Many    ${authList_list}
    Should Contain    ${authList_list}    === MTRotator_authList start of topic ===
    Should Contain    ${authList_list}    === MTRotator_authList end of topic ===
    ${errorCode_start}=    Get Index From List    ${full_list}    === MTRotator_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === MTRotator_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end + 1}
    Log Many    ${errorCode_list}
    Should Contain    ${errorCode_list}    === MTRotator_errorCode start of topic ===
    Should Contain    ${errorCode_list}    === MTRotator_errorCode end of topic ===
    ${simulationMode_start}=    Get Index From List    ${full_list}    === MTRotator_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === MTRotator_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end + 1}
    Log Many    ${simulationMode_list}
    Should Contain    ${simulationMode_list}    === MTRotator_simulationMode start of topic ===
    Should Contain    ${simulationMode_list}    === MTRotator_simulationMode end of topic ===
    ${summaryState_start}=    Get Index From List    ${full_list}    === MTRotator_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === MTRotator_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end + 1}
    Log Many    ${summaryState_list}
    Should Contain    ${summaryState_list}    === MTRotator_summaryState start of topic ===
    Should Contain    ${summaryState_list}    === MTRotator_summaryState end of topic ===
    ${configurationApplied_start}=    Get Index From List    ${full_list}    === MTRotator_configurationApplied start of topic ===
    ${configurationApplied_end}=    Get Index From List    ${full_list}    === MTRotator_configurationApplied end of topic ===
    ${configurationApplied_list}=    Get Slice From List    ${full_list}    start=${configurationApplied_start}    end=${configurationApplied_end + 1}
    Log Many    ${configurationApplied_list}
    Should Contain    ${configurationApplied_list}    === MTRotator_configurationApplied start of topic ===
    Should Contain    ${configurationApplied_list}    === MTRotator_configurationApplied end of topic ===
    ${configurationsAvailable_start}=    Get Index From List    ${full_list}    === MTRotator_configurationsAvailable start of topic ===
    ${configurationsAvailable_end}=    Get Index From List    ${full_list}    === MTRotator_configurationsAvailable end of topic ===
    ${configurationsAvailable_list}=    Get Slice From List    ${full_list}    start=${configurationsAvailable_start}    end=${configurationsAvailable_end + 1}
    Log Many    ${configurationsAvailable_list}
    Should Contain    ${configurationsAvailable_list}    === MTRotator_configurationsAvailable start of topic ===
    Should Contain    ${configurationsAvailable_list}    === MTRotator_configurationsAvailable end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    logger
    ${output}=    Wait For Process    logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTRotator all loggers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${controllerState_start}=    Get Index From List    ${full_list}    === MTRotator_controllerState start of topic ===
    ${controllerState_end}=    Get Index From List    ${full_list}    === MTRotator_controllerState end of topic ===
    ${controllerState_list}=    Get Slice From List    ${full_list}    start=${controllerState_start}    end=${controllerState_end + 1}
    Log Many    ${controllerState_list}
    Should Contain    ${controllerState_list}    === MTRotator_controllerState start of topic ===
    Should Contain    ${controllerState_list}    === MTRotator_controllerState end of topic ===
    ${connected_start}=    Get Index From List    ${full_list}    === MTRotator_connected start of topic ===
    ${connected_end}=    Get Index From List    ${full_list}    === MTRotator_connected end of topic ===
    ${connected_list}=    Get Slice From List    ${full_list}    start=${connected_start}    end=${connected_end + 1}
    Log Many    ${connected_list}
    Should Contain    ${connected_list}    === MTRotator_connected start of topic ===
    Should Contain    ${connected_list}    === MTRotator_connected end of topic ===
    ${interlock_start}=    Get Index From List    ${full_list}    === MTRotator_interlock start of topic ===
    ${interlock_end}=    Get Index From List    ${full_list}    === MTRotator_interlock end of topic ===
    ${interlock_list}=    Get Slice From List    ${full_list}    start=${interlock_start}    end=${interlock_end + 1}
    Log Many    ${interlock_list}
    Should Contain    ${interlock_list}    === MTRotator_interlock start of topic ===
    Should Contain    ${interlock_list}    === MTRotator_interlock end of topic ===
    ${target_start}=    Get Index From List    ${full_list}    === MTRotator_target start of topic ===
    ${target_end}=    Get Index From List    ${full_list}    === MTRotator_target end of topic ===
    ${target_list}=    Get Slice From List    ${full_list}    start=${target_start}    end=${target_end + 1}
    Log Many    ${target_list}
    Should Contain    ${target_list}    === MTRotator_target start of topic ===
    Should Contain    ${target_list}    === MTRotator_target end of topic ===
    ${tracking_start}=    Get Index From List    ${full_list}    === MTRotator_tracking start of topic ===
    ${tracking_end}=    Get Index From List    ${full_list}    === MTRotator_tracking end of topic ===
    ${tracking_list}=    Get Slice From List    ${full_list}    start=${tracking_start}    end=${tracking_end + 1}
    Log Many    ${tracking_list}
    Should Contain    ${tracking_list}    === MTRotator_tracking start of topic ===
    Should Contain    ${tracking_list}    === MTRotator_tracking end of topic ===
    ${inPosition_start}=    Get Index From List    ${full_list}    === MTRotator_inPosition start of topic ===
    ${inPosition_end}=    Get Index From List    ${full_list}    === MTRotator_inPosition end of topic ===
    ${inPosition_list}=    Get Slice From List    ${full_list}    start=${inPosition_start}    end=${inPosition_end + 1}
    Log Many    ${inPosition_list}
    Should Contain    ${inPosition_list}    === MTRotator_inPosition start of topic ===
    Should Contain    ${inPosition_list}    === MTRotator_inPosition end of topic ===
    ${configuration_start}=    Get Index From List    ${full_list}    === MTRotator_configuration start of topic ===
    ${configuration_end}=    Get Index From List    ${full_list}    === MTRotator_configuration end of topic ===
    ${configuration_list}=    Get Slice From List    ${full_list}    start=${configuration_start}    end=${configuration_end + 1}
    Log Many    ${configuration_list}
    Should Contain    ${configuration_list}    === MTRotator_configuration start of topic ===
    Should Contain    ${configuration_list}    === MTRotator_configuration end of topic ===
    ${commandableByDDS_start}=    Get Index From List    ${full_list}    === MTRotator_commandableByDDS start of topic ===
    ${commandableByDDS_end}=    Get Index From List    ${full_list}    === MTRotator_commandableByDDS end of topic ===
    ${commandableByDDS_list}=    Get Slice From List    ${full_list}    start=${commandableByDDS_start}    end=${commandableByDDS_end + 1}
    Log Many    ${commandableByDDS_list}
    Should Contain    ${commandableByDDS_list}    === MTRotator_commandableByDDS start of topic ===
    Should Contain    ${commandableByDDS_list}    === MTRotator_commandableByDDS end of topic ===
    ${heartbeat_start}=    Get Index From List    ${full_list}    === MTRotator_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === MTRotator_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === MTRotator_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === MTRotator_heartbeat end of topic ===
    ${logLevel_start}=    Get Index From List    ${full_list}    === MTRotator_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === MTRotator_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end + 1}
    Log Many    ${logLevel_list}
    Should Contain    ${logLevel_list}    === MTRotator_logLevel start of topic ===
    Should Contain    ${logLevel_list}    === MTRotator_logLevel end of topic ===
    ${logMessage_start}=    Get Index From List    ${full_list}    === MTRotator_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === MTRotator_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end + 1}
    Log Many    ${logMessage_list}
    Should Contain    ${logMessage_list}    === MTRotator_logMessage start of topic ===
    Should Contain    ${logMessage_list}    === MTRotator_logMessage end of topic ===
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === MTRotator_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === MTRotator_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end + 1}
    Log Many    ${softwareVersions_list}
    Should Contain    ${softwareVersions_list}    === MTRotator_softwareVersions start of topic ===
    Should Contain    ${softwareVersions_list}    === MTRotator_softwareVersions end of topic ===
    ${authList_start}=    Get Index From List    ${full_list}    === MTRotator_authList start of topic ===
    ${authList_end}=    Get Index From List    ${full_list}    === MTRotator_authList end of topic ===
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end + 1}
    Log Many    ${authList_list}
    Should Contain    ${authList_list}    === MTRotator_authList start of topic ===
    Should Contain    ${authList_list}    === MTRotator_authList end of topic ===
    ${errorCode_start}=    Get Index From List    ${full_list}    === MTRotator_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === MTRotator_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end + 1}
    Log Many    ${errorCode_list}
    Should Contain    ${errorCode_list}    === MTRotator_errorCode start of topic ===
    Should Contain    ${errorCode_list}    === MTRotator_errorCode end of topic ===
    ${simulationMode_start}=    Get Index From List    ${full_list}    === MTRotator_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === MTRotator_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end + 1}
    Log Many    ${simulationMode_list}
    Should Contain    ${simulationMode_list}    === MTRotator_simulationMode start of topic ===
    Should Contain    ${simulationMode_list}    === MTRotator_simulationMode end of topic ===
    ${summaryState_start}=    Get Index From List    ${full_list}    === MTRotator_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === MTRotator_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end + 1}
    Log Many    ${summaryState_list}
    Should Contain    ${summaryState_list}    === MTRotator_summaryState start of topic ===
    Should Contain    ${summaryState_list}    === MTRotator_summaryState end of topic ===
    ${configurationApplied_start}=    Get Index From List    ${full_list}    === MTRotator_configurationApplied start of topic ===
    ${configurationApplied_end}=    Get Index From List    ${full_list}    === MTRotator_configurationApplied end of topic ===
    ${configurationApplied_list}=    Get Slice From List    ${full_list}    start=${configurationApplied_start}    end=${configurationApplied_end + 1}
    Log Many    ${configurationApplied_list}
    Should Contain    ${configurationApplied_list}    === MTRotator_configurationApplied start of topic ===
    Should Contain    ${configurationApplied_list}    === MTRotator_configurationApplied end of topic ===
    ${configurationsAvailable_start}=    Get Index From List    ${full_list}    === MTRotator_configurationsAvailable start of topic ===
    ${configurationsAvailable_end}=    Get Index From List    ${full_list}    === MTRotator_configurationsAvailable end of topic ===
    ${configurationsAvailable_list}=    Get Slice From List    ${full_list}    start=${configurationsAvailable_start}    end=${configurationsAvailable_end + 1}
    Log Many    ${configurationsAvailable_list}
    Should Contain    ${configurationsAvailable_list}    === MTRotator_configurationsAvailable start of topic ===
    Should Contain    ${configurationsAvailable_list}    === MTRotator_configurationsAvailable end of topic ===
