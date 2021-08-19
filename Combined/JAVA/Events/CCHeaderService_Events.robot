*** Settings ***
Documentation    CCHeaderService_Events communications tests.
Force Tags    messaging    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${Build_Number}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    CCHeaderService
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
    Wait Until Keyword Succeeds    30    1s    File Should Not Be Empty    ${EXECDIR}${/}stdoutLogger.txt

Start Sender
    [Tags]    functional
    Comment    Sender program waiting for Logger program to be Ready.
    ${loggerOutput}=    Get File    ${EXECDIR}${/}stdoutLogger.txt
    FOR    ${i}    IN RANGE    30
        Exit For Loop If     'CCHeaderService all loggers ready' in $loggerOutput
        ${loggerOutput}=    Get File    ${EXECDIR}${/}stdoutLogger.txt
        Sleep    3s
    END
    Comment    Executing Combined Java Sender Program.
    ${senderOutput}=    Start Process    mvn    -Dtest\=${subSystem}Event_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/    alias=sender    stdout=${EXECDIR}${/}stdoutSender.txt    stderr=${EXECDIR}${/}stderrSender.txt
    ${output}=    Wait For Process    sender    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all events ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${largeFileObjectAvailable_start}=    Get Index From List    ${full_list}    === CCHeaderService_largeFileObjectAvailable start of topic ===
    ${largeFileObjectAvailable_end}=    Get Index From List    ${full_list}    === CCHeaderService_largeFileObjectAvailable end of topic ===
    ${largeFileObjectAvailable_list}=    Get Slice From List    ${full_list}    start=${largeFileObjectAvailable_start}    end=${largeFileObjectAvailable_end + 1}
    Log Many    ${largeFileObjectAvailable_list}
    Should Contain    ${largeFileObjectAvailable_list}    === CCHeaderService_largeFileObjectAvailable start of topic ===
    Should Contain    ${largeFileObjectAvailable_list}    === CCHeaderService_largeFileObjectAvailable end of topic ===
    Should Contain    ${largeFileObjectAvailable_list}    === [putSample logevent_largeFileObjectAvailable] writing a message containing :
    ${settingVersions_start}=    Get Index From List    ${full_list}    === CCHeaderService_settingVersions start of topic ===
    ${settingVersions_end}=    Get Index From List    ${full_list}    === CCHeaderService_settingVersions end of topic ===
    ${settingVersions_list}=    Get Slice From List    ${full_list}    start=${settingVersions_start}    end=${settingVersions_end + 1}
    Log Many    ${settingVersions_list}
    Should Contain    ${settingVersions_list}    === CCHeaderService_settingVersions start of topic ===
    Should Contain    ${settingVersions_list}    === CCHeaderService_settingVersions end of topic ===
    Should Contain    ${settingVersions_list}    === [putSample logevent_settingVersions] writing a message containing :
    ${errorCode_start}=    Get Index From List    ${full_list}    === CCHeaderService_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === CCHeaderService_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end + 1}
    Log Many    ${errorCode_list}
    Should Contain    ${errorCode_list}    === CCHeaderService_errorCode start of topic ===
    Should Contain    ${errorCode_list}    === CCHeaderService_errorCode end of topic ===
    Should Contain    ${errorCode_list}    === [putSample logevent_errorCode] writing a message containing :
    ${summaryState_start}=    Get Index From List    ${full_list}    === CCHeaderService_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === CCHeaderService_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end + 1}
    Log Many    ${summaryState_list}
    Should Contain    ${summaryState_list}    === CCHeaderService_summaryState start of topic ===
    Should Contain    ${summaryState_list}    === CCHeaderService_summaryState end of topic ===
    Should Contain    ${summaryState_list}    === [putSample logevent_summaryState] writing a message containing :
    ${appliedSettingsMatchStart_start}=    Get Index From List    ${full_list}    === CCHeaderService_appliedSettingsMatchStart start of topic ===
    ${appliedSettingsMatchStart_end}=    Get Index From List    ${full_list}    === CCHeaderService_appliedSettingsMatchStart end of topic ===
    ${appliedSettingsMatchStart_list}=    Get Slice From List    ${full_list}    start=${appliedSettingsMatchStart_start}    end=${appliedSettingsMatchStart_end + 1}
    Log Many    ${appliedSettingsMatchStart_list}
    Should Contain    ${appliedSettingsMatchStart_list}    === CCHeaderService_appliedSettingsMatchStart start of topic ===
    Should Contain    ${appliedSettingsMatchStart_list}    === CCHeaderService_appliedSettingsMatchStart end of topic ===
    Should Contain    ${appliedSettingsMatchStart_list}    === [putSample logevent_appliedSettingsMatchStart] writing a message containing :
    ${logLevel_start}=    Get Index From List    ${full_list}    === CCHeaderService_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === CCHeaderService_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end + 1}
    Log Many    ${logLevel_list}
    Should Contain    ${logLevel_list}    === CCHeaderService_logLevel start of topic ===
    Should Contain    ${logLevel_list}    === CCHeaderService_logLevel end of topic ===
    Should Contain    ${logLevel_list}    === [putSample logevent_logLevel] writing a message containing :
    ${logMessage_start}=    Get Index From List    ${full_list}    === CCHeaderService_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === CCHeaderService_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end + 1}
    Log Many    ${logMessage_list}
    Should Contain    ${logMessage_list}    === CCHeaderService_logMessage start of topic ===
    Should Contain    ${logMessage_list}    === CCHeaderService_logMessage end of topic ===
    Should Contain    ${logMessage_list}    === [putSample logevent_logMessage] writing a message containing :
    ${settingsApplied_start}=    Get Index From List    ${full_list}    === CCHeaderService_settingsApplied start of topic ===
    ${settingsApplied_end}=    Get Index From List    ${full_list}    === CCHeaderService_settingsApplied end of topic ===
    ${settingsApplied_list}=    Get Slice From List    ${full_list}    start=${settingsApplied_start}    end=${settingsApplied_end + 1}
    Log Many    ${settingsApplied_list}
    Should Contain    ${settingsApplied_list}    === CCHeaderService_settingsApplied start of topic ===
    Should Contain    ${settingsApplied_list}    === CCHeaderService_settingsApplied end of topic ===
    Should Contain    ${settingsApplied_list}    === [putSample logevent_settingsApplied] writing a message containing :
    ${simulationMode_start}=    Get Index From List    ${full_list}    === CCHeaderService_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === CCHeaderService_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end + 1}
    Log Many    ${simulationMode_list}
    Should Contain    ${simulationMode_list}    === CCHeaderService_simulationMode start of topic ===
    Should Contain    ${simulationMode_list}    === CCHeaderService_simulationMode end of topic ===
    Should Contain    ${simulationMode_list}    === [putSample logevent_simulationMode] writing a message containing :
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === CCHeaderService_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === CCHeaderService_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end + 1}
    Log Many    ${softwareVersions_list}
    Should Contain    ${softwareVersions_list}    === CCHeaderService_softwareVersions start of topic ===
    Should Contain    ${softwareVersions_list}    === CCHeaderService_softwareVersions end of topic ===
    Should Contain    ${softwareVersions_list}    === [putSample logevent_softwareVersions] writing a message containing :
    ${heartbeat_start}=    Get Index From List    ${full_list}    === CCHeaderService_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === CCHeaderService_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === CCHeaderService_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === CCHeaderService_heartbeat end of topic ===
    Should Contain    ${heartbeat_list}    === [putSample logevent_heartbeat] writing a message containing :
    ${authList_start}=    Get Index From List    ${full_list}    === CCHeaderService_authList start of topic ===
    ${authList_end}=    Get Index From List    ${full_list}    === CCHeaderService_authList end of topic ===
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end + 1}
    Log Many    ${authList_list}
    Should Contain    ${authList_list}    === CCHeaderService_authList start of topic ===
    Should Contain    ${authList_list}    === CCHeaderService_authList end of topic ===
    Should Contain    ${authList_list}    === [putSample logevent_authList] writing a message containing :

Read Subscriber
    [Tags]    functional
    Switch Process    logger
    ${output}=    Wait For Process    logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== CCHeaderService all loggers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${largeFileObjectAvailable_start}=    Get Index From List    ${full_list}    === CCHeaderService_largeFileObjectAvailable start of topic ===
    ${largeFileObjectAvailable_end}=    Get Index From List    ${full_list}    === CCHeaderService_largeFileObjectAvailable end of topic ===
    ${largeFileObjectAvailable_list}=    Get Slice From List    ${full_list}    start=${largeFileObjectAvailable_start}    end=${largeFileObjectAvailable_end + 1}
    Log Many    ${largeFileObjectAvailable_list}
    Should Contain    ${largeFileObjectAvailable_list}    === CCHeaderService_largeFileObjectAvailable start of topic ===
    Should Contain    ${largeFileObjectAvailable_list}    === CCHeaderService_largeFileObjectAvailable end of topic ===
    Should Contain    ${largeFileObjectAvailable_list}    === [getSample logevent_largeFileObjectAvailable ] message received :0
    ${settingVersions_start}=    Get Index From List    ${full_list}    === CCHeaderService_settingVersions start of topic ===
    ${settingVersions_end}=    Get Index From List    ${full_list}    === CCHeaderService_settingVersions end of topic ===
    ${settingVersions_list}=    Get Slice From List    ${full_list}    start=${settingVersions_start}    end=${settingVersions_end + 1}
    Log Many    ${settingVersions_list}
    Should Contain    ${settingVersions_list}    === CCHeaderService_settingVersions start of topic ===
    Should Contain    ${settingVersions_list}    === CCHeaderService_settingVersions end of topic ===
    Should Contain    ${settingVersions_list}    === [getSample logevent_settingVersions ] message received :0
    ${errorCode_start}=    Get Index From List    ${full_list}    === CCHeaderService_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === CCHeaderService_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end + 1}
    Log Many    ${errorCode_list}
    Should Contain    ${errorCode_list}    === CCHeaderService_errorCode start of topic ===
    Should Contain    ${errorCode_list}    === CCHeaderService_errorCode end of topic ===
    Should Contain    ${errorCode_list}    === [getSample logevent_errorCode ] message received :0
    ${summaryState_start}=    Get Index From List    ${full_list}    === CCHeaderService_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === CCHeaderService_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end + 1}
    Log Many    ${summaryState_list}
    Should Contain    ${summaryState_list}    === CCHeaderService_summaryState start of topic ===
    Should Contain    ${summaryState_list}    === CCHeaderService_summaryState end of topic ===
    Should Contain    ${summaryState_list}    === [getSample logevent_summaryState ] message received :0
    ${appliedSettingsMatchStart_start}=    Get Index From List    ${full_list}    === CCHeaderService_appliedSettingsMatchStart start of topic ===
    ${appliedSettingsMatchStart_end}=    Get Index From List    ${full_list}    === CCHeaderService_appliedSettingsMatchStart end of topic ===
    ${appliedSettingsMatchStart_list}=    Get Slice From List    ${full_list}    start=${appliedSettingsMatchStart_start}    end=${appliedSettingsMatchStart_end + 1}
    Log Many    ${appliedSettingsMatchStart_list}
    Should Contain    ${appliedSettingsMatchStart_list}    === CCHeaderService_appliedSettingsMatchStart start of topic ===
    Should Contain    ${appliedSettingsMatchStart_list}    === CCHeaderService_appliedSettingsMatchStart end of topic ===
    Should Contain    ${appliedSettingsMatchStart_list}    === [getSample logevent_appliedSettingsMatchStart ] message received :0
    ${logLevel_start}=    Get Index From List    ${full_list}    === CCHeaderService_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === CCHeaderService_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end + 1}
    Log Many    ${logLevel_list}
    Should Contain    ${logLevel_list}    === CCHeaderService_logLevel start of topic ===
    Should Contain    ${logLevel_list}    === CCHeaderService_logLevel end of topic ===
    Should Contain    ${logLevel_list}    === [getSample logevent_logLevel ] message received :0
    ${logMessage_start}=    Get Index From List    ${full_list}    === CCHeaderService_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === CCHeaderService_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end + 1}
    Log Many    ${logMessage_list}
    Should Contain    ${logMessage_list}    === CCHeaderService_logMessage start of topic ===
    Should Contain    ${logMessage_list}    === CCHeaderService_logMessage end of topic ===
    Should Contain    ${logMessage_list}    === [getSample logevent_logMessage ] message received :0
    ${settingsApplied_start}=    Get Index From List    ${full_list}    === CCHeaderService_settingsApplied start of topic ===
    ${settingsApplied_end}=    Get Index From List    ${full_list}    === CCHeaderService_settingsApplied end of topic ===
    ${settingsApplied_list}=    Get Slice From List    ${full_list}    start=${settingsApplied_start}    end=${settingsApplied_end + 1}
    Log Many    ${settingsApplied_list}
    Should Contain    ${settingsApplied_list}    === CCHeaderService_settingsApplied start of topic ===
    Should Contain    ${settingsApplied_list}    === CCHeaderService_settingsApplied end of topic ===
    Should Contain    ${settingsApplied_list}    === [getSample logevent_settingsApplied ] message received :0
    ${simulationMode_start}=    Get Index From List    ${full_list}    === CCHeaderService_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === CCHeaderService_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end + 1}
    Log Many    ${simulationMode_list}
    Should Contain    ${simulationMode_list}    === CCHeaderService_simulationMode start of topic ===
    Should Contain    ${simulationMode_list}    === CCHeaderService_simulationMode end of topic ===
    Should Contain    ${simulationMode_list}    === [getSample logevent_simulationMode ] message received :0
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === CCHeaderService_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === CCHeaderService_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end + 1}
    Log Many    ${softwareVersions_list}
    Should Contain    ${softwareVersions_list}    === CCHeaderService_softwareVersions start of topic ===
    Should Contain    ${softwareVersions_list}    === CCHeaderService_softwareVersions end of topic ===
    Should Contain    ${softwareVersions_list}    === [getSample logevent_softwareVersions ] message received :0
    ${heartbeat_start}=    Get Index From List    ${full_list}    === CCHeaderService_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === CCHeaderService_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === CCHeaderService_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === CCHeaderService_heartbeat end of topic ===
    Should Contain    ${heartbeat_list}    === [getSample logevent_heartbeat ] message received :0
    ${authList_start}=    Get Index From List    ${full_list}    === CCHeaderService_authList start of topic ===
    ${authList_end}=    Get Index From List    ${full_list}    === CCHeaderService_authList end of topic ===
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end + 1}
    Log Many    ${authList_list}
    Should Contain    ${authList_list}    === CCHeaderService_authList start of topic ===
    Should Contain    ${authList_list}    === CCHeaderService_authList end of topic ===
    Should Contain    ${authList_list}    === [getSample logevent_authList ] message received :0
