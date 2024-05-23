*** Settings ***
Documentation    MTHeaderService_Events communications tests.
Force Tags    messaging    java    mtheaderservice    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTHeaderService
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
        Exit For Loop If     'MTHeaderService all loggers ready' in $loggerOutput
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
    ${heartbeat_start}=    Get Index From List    ${full_list}    === MTHeaderService_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === MTHeaderService_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === MTHeaderService_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === MTHeaderService_heartbeat end of topic ===
    ${largeFileObjectAvailable_start}=    Get Index From List    ${full_list}    === MTHeaderService_largeFileObjectAvailable start of topic ===
    ${largeFileObjectAvailable_end}=    Get Index From List    ${full_list}    === MTHeaderService_largeFileObjectAvailable end of topic ===
    ${largeFileObjectAvailable_list}=    Get Slice From List    ${full_list}    start=${largeFileObjectAvailable_start}    end=${largeFileObjectAvailable_end + 1}
    Log Many    ${largeFileObjectAvailable_list}
    Should Contain    ${largeFileObjectAvailable_list}    === MTHeaderService_largeFileObjectAvailable start of topic ===
    Should Contain    ${largeFileObjectAvailable_list}    === MTHeaderService_largeFileObjectAvailable end of topic ===
    ${logLevel_start}=    Get Index From List    ${full_list}    === MTHeaderService_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === MTHeaderService_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end + 1}
    Log Many    ${logLevel_list}
    Should Contain    ${logLevel_list}    === MTHeaderService_logLevel start of topic ===
    Should Contain    ${logLevel_list}    === MTHeaderService_logLevel end of topic ===
    ${logMessage_start}=    Get Index From List    ${full_list}    === MTHeaderService_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === MTHeaderService_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end + 1}
    Log Many    ${logMessage_list}
    Should Contain    ${logMessage_list}    === MTHeaderService_logMessage start of topic ===
    Should Contain    ${logMessage_list}    === MTHeaderService_logMessage end of topic ===
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === MTHeaderService_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === MTHeaderService_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end + 1}
    Log Many    ${softwareVersions_list}
    Should Contain    ${softwareVersions_list}    === MTHeaderService_softwareVersions start of topic ===
    Should Contain    ${softwareVersions_list}    === MTHeaderService_softwareVersions end of topic ===
    ${errorCode_start}=    Get Index From List    ${full_list}    === MTHeaderService_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === MTHeaderService_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end + 1}
    Log Many    ${errorCode_list}
    Should Contain    ${errorCode_list}    === MTHeaderService_errorCode start of topic ===
    Should Contain    ${errorCode_list}    === MTHeaderService_errorCode end of topic ===
    ${simulationMode_start}=    Get Index From List    ${full_list}    === MTHeaderService_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === MTHeaderService_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end + 1}
    Log Many    ${simulationMode_list}
    Should Contain    ${simulationMode_list}    === MTHeaderService_simulationMode start of topic ===
    Should Contain    ${simulationMode_list}    === MTHeaderService_simulationMode end of topic ===
    ${summaryState_start}=    Get Index From List    ${full_list}    === MTHeaderService_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === MTHeaderService_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end + 1}
    Log Many    ${summaryState_list}
    Should Contain    ${summaryState_list}    === MTHeaderService_summaryState start of topic ===
    Should Contain    ${summaryState_list}    === MTHeaderService_summaryState end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    logger
    ${output}=    Wait For Process    logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTHeaderService all loggers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=27
    ${heartbeat_start}=    Get Index From List    ${full_list}    === MTHeaderService_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === MTHeaderService_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end + 1}
    Log Many    ${heartbeat_list}
    Should Contain    ${heartbeat_list}    === MTHeaderService_heartbeat start of topic ===
    Should Contain    ${heartbeat_list}    === MTHeaderService_heartbeat end of topic ===
    ${largeFileObjectAvailable_start}=    Get Index From List    ${full_list}    === MTHeaderService_largeFileObjectAvailable start of topic ===
    ${largeFileObjectAvailable_end}=    Get Index From List    ${full_list}    === MTHeaderService_largeFileObjectAvailable end of topic ===
    ${largeFileObjectAvailable_list}=    Get Slice From List    ${full_list}    start=${largeFileObjectAvailable_start}    end=${largeFileObjectAvailable_end + 1}
    Log Many    ${largeFileObjectAvailable_list}
    Should Contain    ${largeFileObjectAvailable_list}    === MTHeaderService_largeFileObjectAvailable start of topic ===
    Should Contain    ${largeFileObjectAvailable_list}    === MTHeaderService_largeFileObjectAvailable end of topic ===
    ${logLevel_start}=    Get Index From List    ${full_list}    === MTHeaderService_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === MTHeaderService_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end + 1}
    Log Many    ${logLevel_list}
    Should Contain    ${logLevel_list}    === MTHeaderService_logLevel start of topic ===
    Should Contain    ${logLevel_list}    === MTHeaderService_logLevel end of topic ===
    ${logMessage_start}=    Get Index From List    ${full_list}    === MTHeaderService_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === MTHeaderService_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end + 1}
    Log Many    ${logMessage_list}
    Should Contain    ${logMessage_list}    === MTHeaderService_logMessage start of topic ===
    Should Contain    ${logMessage_list}    === MTHeaderService_logMessage end of topic ===
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === MTHeaderService_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === MTHeaderService_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end + 1}
    Log Many    ${softwareVersions_list}
    Should Contain    ${softwareVersions_list}    === MTHeaderService_softwareVersions start of topic ===
    Should Contain    ${softwareVersions_list}    === MTHeaderService_softwareVersions end of topic ===
    ${errorCode_start}=    Get Index From List    ${full_list}    === MTHeaderService_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === MTHeaderService_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end + 1}
    Log Many    ${errorCode_list}
    Should Contain    ${errorCode_list}    === MTHeaderService_errorCode start of topic ===
    Should Contain    ${errorCode_list}    === MTHeaderService_errorCode end of topic ===
    ${simulationMode_start}=    Get Index From List    ${full_list}    === MTHeaderService_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === MTHeaderService_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end + 1}
    Log Many    ${simulationMode_list}
    Should Contain    ${simulationMode_list}    === MTHeaderService_simulationMode start of topic ===
    Should Contain    ${simulationMode_list}    === MTHeaderService_simulationMode end of topic ===
    ${summaryState_start}=    Get Index From List    ${full_list}    === MTHeaderService_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === MTHeaderService_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end + 1}
    Log Many    ${summaryState_list}
    Should Contain    ${summaryState_list}    === MTHeaderService_summaryState start of topic ===
    Should Contain    ${summaryState_list}    === MTHeaderService_summaryState end of topic ===
