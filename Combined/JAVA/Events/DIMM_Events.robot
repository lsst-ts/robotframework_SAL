*** Settings ***
Documentation    DIMM_Events communications tests.
Force Tags    messaging    java    dimm    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    DIMM
${component}    all
${timeout}    45s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}Event_${component}.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/${subSystem}EventLogger_${component}.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/src/test/java/${subSystem}Event_${component}.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/src/test/java/${subSystem}EventLogger_${component}.java

Start Logger
    [Tags]    functional
    Comment    Executing Combined Java Logger Program.
    ${loggerOutput}=    Start Process    mvn    -Dtest\=${subSystem}EventLogger_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/    alias=logger    stdout=${EXECDIR}${/}stdoutLogger.txt    stderr=${EXECDIR}${/}stderrLogger.txt
    Should Be Equal    ${loggerOutput.returncode}   ${NONE}
    Wait Until Keyword Succeeds    30    1s    File Should Not Be Empty    ${EXECDIR}${/}stdoutLogger.txt

Start Sender
    [Tags]    functional
    Comment    Sender program waiting for Logger program to be Ready.
    ${loggerOutput}=    Get File    ${EXECDIR}${/}stdoutLogger.txt
    FOR    ${i}    IN RANGE    30
        Exit For Loop If     'DIMM all loggers ready' in $loggerOutput
        ${loggerOutput}=    Get File    ${EXECDIR}${/}stdoutLogger.txt
        Sleep    3s
    END
    Comment    Executing Combined Java Sender Program.
    ${senderOutput}=    Start Process    mvn    -Dtest\=${subSystem}Event_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/    alias=sender    stdout=${EXECDIR}${/}stdoutSender.txt    stderr=${EXECDIR}${/}stderrSender.txt
    Should Be Equal    ${senderOutput.returncode}   ${NONE}
    ${output}=    Wait For Process    sender    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all events ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS
    @{full_list}=    Split To Lines    ${output.stdout}    start=27
    ${moduleStatus_start}=    Get Index From List    ${full_list}    === DIMM_moduleStatus start of topic ===
    ${moduleStatus_end}=    Get Index From List    ${full_list}    === DIMM_moduleStatus end of topic ===
    ${moduleStatus_list}=    Get Slice From List    ${full_list}    start=${moduleStatus_start}    end=${moduleStatus_end + 1}
    Log Many    ${moduleStatus_list}
    Should Contain    ${moduleStatus_list}    === DIMM_moduleStatus start of topic ===
    Should Contain    ${moduleStatus_list}    === DIMM_moduleStatus end of topic ===
    ${dimmMeasurement_start}=    Get Index From List    ${full_list}    === DIMM_dimmMeasurement start of topic ===
    ${dimmMeasurement_end}=    Get Index From List    ${full_list}    === DIMM_dimmMeasurement end of topic ===
    ${dimmMeasurement_list}=    Get Slice From List    ${full_list}    start=${dimmMeasurement_start}    end=${dimmMeasurement_end + 1}
    Log Many    ${dimmMeasurement_list}
    Should Contain    ${dimmMeasurement_list}    === DIMM_dimmMeasurement start of topic ===
    Should Contain    ${dimmMeasurement_list}    === DIMM_dimmMeasurement end of topic ===
    ${dimmData_start}=    Get Index From List    ${full_list}    === DIMM_dimmData start of topic ===
    ${dimmData_end}=    Get Index From List    ${full_list}    === DIMM_dimmData end of topic ===
    ${dimmData_list}=    Get Slice From List    ${full_list}    start=${dimmData_start}    end=${dimmData_end + 1}
    Log Many    ${dimmData_list}
    Should Contain    ${dimmData_list}    === DIMM_dimmData start of topic ===
    Should Contain    ${dimmData_list}    === DIMM_dimmData end of topic ===
    ${heartbeat_start}=    Get Index From List    ${full_list}    === DIMM_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === DIMM_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === DIMM_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === DIMM_heartbeat end of topic ===
    ${logLevel_start}=    Get Index From List    ${full_list}    === DIMM_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === DIMM_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end + 1}
    Log Many    ${logLevel_list}
    Should Contain    ${logLevel_list}    === DIMM_logLevel start of topic ===
    Should Contain    ${logLevel_list}    === DIMM_logLevel end of topic ===
    ${logMessage_start}=    Get Index From List    ${full_list}    === DIMM_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === DIMM_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end + 1}
    Log Many    ${logMessage_list}
    Should Contain    ${logMessage_list}    === DIMM_logMessage start of topic ===
    Should Contain    ${logMessage_list}    === DIMM_logMessage end of topic ===
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === DIMM_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === DIMM_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end + 1}
    Log Many    ${softwareVersions_list}
    Should Contain    ${softwareVersions_list}    === DIMM_softwareVersions start of topic ===
    Should Contain    ${softwareVersions_list}    === DIMM_softwareVersions end of topic ===
    ${authList_start}=    Get Index From List    ${full_list}    === DIMM_authList start of topic ===
    ${authList_end}=    Get Index From List    ${full_list}    === DIMM_authList end of topic ===
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end + 1}
    Log Many    ${authList_list}
    Should Contain    ${authList_list}    === DIMM_authList start of topic ===
    Should Contain    ${authList_list}    === DIMM_authList end of topic ===
    ${errorCode_start}=    Get Index From List    ${full_list}    === DIMM_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === DIMM_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end + 1}
    Log Many    ${errorCode_list}
    Should Contain    ${errorCode_list}    === DIMM_errorCode start of topic ===
    Should Contain    ${errorCode_list}    === DIMM_errorCode end of topic ===
    ${simulationMode_start}=    Get Index From List    ${full_list}    === DIMM_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === DIMM_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end + 1}
    Log Many    ${simulationMode_list}
    Should Contain    ${simulationMode_list}    === DIMM_simulationMode start of topic ===
    Should Contain    ${simulationMode_list}    === DIMM_simulationMode end of topic ===
    ${summaryState_start}=    Get Index From List    ${full_list}    === DIMM_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === DIMM_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end + 1}
    Log Many    ${summaryState_list}
    Should Contain    ${summaryState_list}    === DIMM_summaryState start of topic ===
    Should Contain    ${summaryState_list}    === DIMM_summaryState end of topic ===
    ${configurationApplied_start}=    Get Index From List    ${full_list}    === DIMM_configurationApplied start of topic ===
    ${configurationApplied_end}=    Get Index From List    ${full_list}    === DIMM_configurationApplied end of topic ===
    ${configurationApplied_list}=    Get Slice From List    ${full_list}    start=${configurationApplied_start}    end=${configurationApplied_end + 1}
    Log Many    ${configurationApplied_list}
    Should Contain    ${configurationApplied_list}    === DIMM_configurationApplied start of topic ===
    Should Contain    ${configurationApplied_list}    === DIMM_configurationApplied end of topic ===
    ${configurationsAvailable_start}=    Get Index From List    ${full_list}    === DIMM_configurationsAvailable start of topic ===
    ${configurationsAvailable_end}=    Get Index From List    ${full_list}    === DIMM_configurationsAvailable end of topic ===
    ${configurationsAvailable_list}=    Get Slice From List    ${full_list}    start=${configurationsAvailable_start}    end=${configurationsAvailable_end + 1}
    Log Many    ${configurationsAvailable_list}
    Should Contain    ${configurationsAvailable_list}    === DIMM_configurationsAvailable start of topic ===
    Should Contain    ${configurationsAvailable_list}    === DIMM_configurationsAvailable end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    logger
    ${output}=    Wait For Process    logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== DIMM all loggers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=27
    ${moduleStatus_start}=    Get Index From List    ${full_list}    === DIMM_moduleStatus start of topic ===
    ${moduleStatus_end}=    Get Index From List    ${full_list}    === DIMM_moduleStatus end of topic ===
    ${moduleStatus_list}=    Get Slice From List    ${full_list}    start=${moduleStatus_start}    end=${moduleStatus_end + 1}
    Log Many    ${moduleStatus_list}
    Should Contain    ${moduleStatus_list}    === DIMM_moduleStatus start of topic ===
    Should Contain    ${moduleStatus_list}    === DIMM_moduleStatus end of topic ===
    ${dimmMeasurement_start}=    Get Index From List    ${full_list}    === DIMM_dimmMeasurement start of topic ===
    ${dimmMeasurement_end}=    Get Index From List    ${full_list}    === DIMM_dimmMeasurement end of topic ===
    ${dimmMeasurement_list}=    Get Slice From List    ${full_list}    start=${dimmMeasurement_start}    end=${dimmMeasurement_end + 1}
    Log Many    ${dimmMeasurement_list}
    Should Contain    ${dimmMeasurement_list}    === DIMM_dimmMeasurement start of topic ===
    Should Contain    ${dimmMeasurement_list}    === DIMM_dimmMeasurement end of topic ===
    ${dimmData_start}=    Get Index From List    ${full_list}    === DIMM_dimmData start of topic ===
    ${dimmData_end}=    Get Index From List    ${full_list}    === DIMM_dimmData end of topic ===
    ${dimmData_list}=    Get Slice From List    ${full_list}    start=${dimmData_start}    end=${dimmData_end + 1}
    Log Many    ${dimmData_list}
    Should Contain    ${dimmData_list}    === DIMM_dimmData start of topic ===
    Should Contain    ${dimmData_list}    === DIMM_dimmData end of topic ===
    ${heartbeat_start}=    Get Index From List    ${full_list}    === DIMM_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === DIMM_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === DIMM_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === DIMM_heartbeat end of topic ===
    ${logLevel_start}=    Get Index From List    ${full_list}    === DIMM_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === DIMM_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end + 1}
    Log Many    ${logLevel_list}
    Should Contain    ${logLevel_list}    === DIMM_logLevel start of topic ===
    Should Contain    ${logLevel_list}    === DIMM_logLevel end of topic ===
    ${logMessage_start}=    Get Index From List    ${full_list}    === DIMM_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === DIMM_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end + 1}
    Log Many    ${logMessage_list}
    Should Contain    ${logMessage_list}    === DIMM_logMessage start of topic ===
    Should Contain    ${logMessage_list}    === DIMM_logMessage end of topic ===
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === DIMM_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === DIMM_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end + 1}
    Log Many    ${softwareVersions_list}
    Should Contain    ${softwareVersions_list}    === DIMM_softwareVersions start of topic ===
    Should Contain    ${softwareVersions_list}    === DIMM_softwareVersions end of topic ===
    ${authList_start}=    Get Index From List    ${full_list}    === DIMM_authList start of topic ===
    ${authList_end}=    Get Index From List    ${full_list}    === DIMM_authList end of topic ===
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end + 1}
    Log Many    ${authList_list}
    Should Contain    ${authList_list}    === DIMM_authList start of topic ===
    Should Contain    ${authList_list}    === DIMM_authList end of topic ===
    ${errorCode_start}=    Get Index From List    ${full_list}    === DIMM_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === DIMM_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end + 1}
    Log Many    ${errorCode_list}
    Should Contain    ${errorCode_list}    === DIMM_errorCode start of topic ===
    Should Contain    ${errorCode_list}    === DIMM_errorCode end of topic ===
    ${simulationMode_start}=    Get Index From List    ${full_list}    === DIMM_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === DIMM_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end + 1}
    Log Many    ${simulationMode_list}
    Should Contain    ${simulationMode_list}    === DIMM_simulationMode start of topic ===
    Should Contain    ${simulationMode_list}    === DIMM_simulationMode end of topic ===
    ${summaryState_start}=    Get Index From List    ${full_list}    === DIMM_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === DIMM_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end + 1}
    Log Many    ${summaryState_list}
    Should Contain    ${summaryState_list}    === DIMM_summaryState start of topic ===
    Should Contain    ${summaryState_list}    === DIMM_summaryState end of topic ===
    ${configurationApplied_start}=    Get Index From List    ${full_list}    === DIMM_configurationApplied start of topic ===
    ${configurationApplied_end}=    Get Index From List    ${full_list}    === DIMM_configurationApplied end of topic ===
    ${configurationApplied_list}=    Get Slice From List    ${full_list}    start=${configurationApplied_start}    end=${configurationApplied_end + 1}
    Log Many    ${configurationApplied_list}
    Should Contain    ${configurationApplied_list}    === DIMM_configurationApplied start of topic ===
    Should Contain    ${configurationApplied_list}    === DIMM_configurationApplied end of topic ===
    ${configurationsAvailable_start}=    Get Index From List    ${full_list}    === DIMM_configurationsAvailable start of topic ===
    ${configurationsAvailable_end}=    Get Index From List    ${full_list}    === DIMM_configurationsAvailable end of topic ===
    ${configurationsAvailable_list}=    Get Slice From List    ${full_list}    start=${configurationsAvailable_start}    end=${configurationsAvailable_end + 1}
    Log Many    ${configurationsAvailable_list}
    Should Contain    ${configurationsAvailable_list}    === DIMM_configurationsAvailable start of topic ===
    Should Contain    ${configurationsAvailable_list}    === DIMM_configurationsAvailable end of topic ===
