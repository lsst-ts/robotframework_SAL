*** Settings ***
Documentation    MTM1M3TS_Events communications tests.
Force Tags    messaging    cpp    mtm1m3ts    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}common.robot
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTM1M3TS
${component}    all
${timeout}    180s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger

Start Logger
    [Tags]    functional    logger
    Comment    Start Logger.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger    alias=${subSystem}_Logger     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Be Equal    ${output.returncode}   ${NONE}
    Wait Until Keyword Succeeds    90s    5s    File Should Contain    ${EXECDIR}${/}stdout.txt    === ${subSystem} loggers ready
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Log    ${output}

Start Sender
    [Tags]    functional    sender    robot:continue-on-failure
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_engineeringMode"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_engineeringMode test messages =======
    Should Contain X Times    ${output.stdout}    === Event engineeringMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_engineeringMode writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event engineeringMode generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_appliedSetpoints"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_appliedSetpoints test messages =======
    Should Contain X Times    ${output.stdout}    === Event appliedSetpoints iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_appliedSetpoints writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event appliedSetpoints generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_fcuTargets"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_fcuTargets test messages =======
    Should Contain X Times    ${output.stdout}    === Event fcuTargets iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_fcuTargets writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event fcuTargets generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_enabledILC"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_enabledILC test messages =======
    Should Contain X Times    ${output.stdout}    === Event enabledILC iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_enabledILC writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event enabledILC generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_thermalInfo"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_thermalInfo test messages =======
    Should Contain X Times    ${output.stdout}    === Event thermalInfo iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_thermalInfo writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event thermalInfo generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_thermalWarning"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_thermalWarning test messages =======
    Should Contain X Times    ${output.stdout}    === Event thermalWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_thermalWarning writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event thermalWarning generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_powerStatus"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_powerStatus test messages =======
    Should Contain X Times    ${output.stdout}    === Event powerStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_powerStatus writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event powerStatus generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_thermalSettings"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_thermalSettings test messages =======
    Should Contain X Times    ${output.stdout}    === Event thermalSettings iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_thermalSettings writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event thermalSettings generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_mixingValveSettings"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_mixingValveSettings test messages =======
    Should Contain X Times    ${output.stdout}    === Event mixingValveSettings iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_mixingValveSettings writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event mixingValveSettings generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_glycolPumpStatus"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_glycolPumpStatus test messages =======
    Should Contain X Times    ${output.stdout}    === Event glycolPumpStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_glycolPumpStatus writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event glycolPumpStatus generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_heartbeat"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    Should Contain X Times    ${output.stdout}    === Event heartbeat iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_heartbeat writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event heartbeat generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_logLevel"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_logLevel test messages =======
    Should Contain X Times    ${output.stdout}    === Event logLevel iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_logLevel writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event logLevel generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_logMessage"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_logMessage test messages =======
    Should Contain X Times    ${output.stdout}    === Event logMessage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_logMessage writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event logMessage generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_softwareVersions"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_softwareVersions test messages =======
    Should Contain X Times    ${output.stdout}    === Event softwareVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_softwareVersions writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event softwareVersions generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_errorCode"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_errorCode test messages =======
    Should Contain X Times    ${output.stdout}    === Event errorCode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_errorCode writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event errorCode generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_simulationMode"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_simulationMode test messages =======
    Should Contain X Times    ${output.stdout}    === Event simulationMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_simulationMode writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event simulationMode generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_summaryState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_summaryState test messages =======
    Should Contain X Times    ${output.stdout}    === Event summaryState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_summaryState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event summaryState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_configurationApplied"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_configurationApplied test messages =======
    Should Contain X Times    ${output.stdout}    === Event configurationApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_configurationApplied writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event configurationApplied generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_configurationsAvailable"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_configurationsAvailable test messages =======
    Should Contain X Times    ${output.stdout}    === Event configurationsAvailable iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_configurationsAvailable writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event configurationsAvailable generated =

Read Logger
    [Tags]    functional    logger    robot:continue-on-failure
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Not Contain    ${output.stderr}    1/1 brokers are down
    Should Not Contain    ${output.stderr}    Consume failed
    Should Not Contain    ${output.stderr}    Broker: Unknown topic or partition
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${engineeringMode_start}=    Get Index From List    ${full_list}    === Event engineeringMode received =${SPACE}
    ${end}=    Evaluate    ${engineeringMode_start}+${3}
    ${engineeringMode_list}=    Get Slice From List    ${full_list}    start=${engineeringMode_start}    end=${end}
    Should Contain X Times    ${engineeringMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engineeringMode : 1    1
    ${appliedSetpoints_start}=    Get Index From List    ${full_list}    === Event appliedSetpoints received =${SPACE}
    ${end}=    Evaluate    ${appliedSetpoints_start}+${4}
    ${appliedSetpoints_list}=    Get Slice From List    ${full_list}    start=${appliedSetpoints_start}    end=${end}
    Should Contain X Times    ${appliedSetpoints_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolSetpoint : 1    1
    Should Contain X Times    ${appliedSetpoints_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heatersSetpoint : 1    1
    ${fcuTargets_start}=    Get Index From List    ${full_list}    === Event fcuTargets received =${SPACE}
    ${end}=    Evaluate    ${fcuTargets_start}+${4}
    ${fcuTargets_list}=    Get Slice From List    ${full_list}    start=${fcuTargets_start}    end=${end}
    Should Contain X Times    ${fcuTargets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterPWM : 0    1
    Should Contain X Times    ${fcuTargets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanRPM : 0    1
    ${enabledILC_start}=    Get Index From List    ${full_list}    === Event enabledILC received =${SPACE}
    ${end}=    Evaluate    ${enabledILC_start}+${3}
    ${enabledILC_list}=    Get Slice From List    ${full_list}    start=${enabledILC_start}    end=${end}
    Should Contain X Times    ${enabledILC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enabled : 0    1
    ${thermalInfo_start}=    Get Index From List    ${full_list}    === Event thermalInfo received =${SPACE}
    ${end}=    Evaluate    ${thermalInfo_start}+${12}
    ${thermalInfo_list}=    Get Slice From List    ${full_list}    start=${thermalInfo_start}    end=${end}
    Should Contain X Times    ${thermalInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}referenceId : 0    1
    Should Contain X Times    ${thermalInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}modbusAddress : 0    1
    Should Contain X Times    ${thermalInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xPosition : 0    1
    Should Contain X Times    ${thermalInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yPosition : 0    1
    Should Contain X Times    ${thermalInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zPosition : 0    1
    Should Contain X Times    ${thermalInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcUniqueId : 0    1
    Should Contain X Times    ${thermalInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcApplicationType : 0    1
    Should Contain X Times    ${thermalInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}networkNodeType : 0    1
    Should Contain X Times    ${thermalInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}majorRevision : 0    1
    Should Contain X Times    ${thermalInfo_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minorRevision : 0    1
    ${thermalWarning_start}=    Get Index From List    ${full_list}    === Event thermalWarning received =${SPACE}
    ${end}=    Evaluate    ${thermalWarning_start}+${45}
    ${thermalWarning_list}=    Get Slice From List    ${full_list}    start=${thermalWarning_start}    end=${end}
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWarning : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMajorFault : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}majorFault : 0    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyMinorFault : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minorFault : 0    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyFaultOverride : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}faultOverride : 0    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyRefResistorError : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refResistorError : 0    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyRTDError : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rtdError : 0    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyBreakerHeater1Error : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakerHeater1Error : 0    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyBreakerFan2Error : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}breakerFan2Error : 0    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyUniqueIdCRCError : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}uniqueIdCRCError : 0    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyApplicationTypeMismatch : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applicationTypeMismatch : 0    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyApplicationMissing : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applicationMissing : 0    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyApplicationCRCMismatch : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applicationCRCMismatch : 0    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyOneWireMissing : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oneWireMissing : 0    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyOneWire1Mismatch : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oneWire1Mismatch : 0    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyOneWire2Mismatch : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oneWire2Mismatch : 0    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyWatchdogReset : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}watchdogReset : 0    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyBrownOut : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brownOut : 0    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyEventTrapReset : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventTrapReset : 0    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anySSRPowerFault : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ssrPowerFault : 0    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyAuxPowerFault : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxPowerFault : 0    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyILCFault : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcFault : 0    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anyBroadcastCounterWarning : 1    1
    Should Contain X Times    ${thermalWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}broadcastCounterWarning : 0    1
    ${powerStatus_start}=    Get Index From List    ${full_list}    === Event powerStatus received =${SPACE}
    ${end}=    Evaluate    ${powerStatus_start}+${6}
    ${powerStatus_list}=    Get Slice From List    ${full_list}    start=${powerStatus_start}    end=${end}
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanCoilsHeatersCommandedOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanCoilsHeatersOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coolantPumpCommandedOn : 1    1
    Should Contain X Times    ${powerStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coolantPumpOn : 1    1
    ${thermalSettings_start}=    Get Index From List    ${full_list}    === Event thermalSettings received =${SPACE}
    ${end}=    Evaluate    ${thermalSettings_start}+${3}
    ${thermalSettings_list}=    Get Slice From List    ${full_list}    start=${thermalSettings_start}    end=${end}
    Should Contain X Times    ${thermalSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enabledFCU : 0    1
    ${mixingValveSettings_start}=    Get Index From List    ${full_list}    === Event mixingValveSettings received =${SPACE}
    ${end}=    Evaluate    ${mixingValveSettings_start}+${6}
    ${mixingValveSettings_list}=    Get Slice From List    ${full_list}    start=${mixingValveSettings_start}    end=${end}
    Should Contain X Times    ${mixingValveSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandingFullyClosed : 1    1
    Should Contain X Times    ${mixingValveSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandingFullyOpened : 1    1
    Should Contain X Times    ${mixingValveSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionFeedbackFullyClosed : 1    1
    Should Contain X Times    ${mixingValveSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionFeedbackFullyOpened : 1    1
    ${glycolPumpStatus_start}=    Get Index From List    ${full_list}    === Event glycolPumpStatus received =${SPACE}
    ${end}=    Evaluate    ${glycolPumpStatus_start}+${13}
    ${glycolPumpStatus_list}=    Get Slice From List    ${full_list}    start=${glycolPumpStatus_start}    end=${end}
    Should Contain X Times    ${glycolPumpStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ready : 1    1
    Should Contain X Times    ${glycolPumpStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}running : 1    1
    Should Contain X Times    ${glycolPumpStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forwardCommanded : 1    1
    Should Contain X Times    ${glycolPumpStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forwardRotating : 1    1
    Should Contain X Times    ${glycolPumpStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerating : 1    1
    Should Contain X Times    ${glycolPumpStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decelerating : 1    1
    Should Contain X Times    ${glycolPumpStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}faulted : 1    1
    Should Contain X Times    ${glycolPumpStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainFrequencyControlled : 1    1
    Should Contain X Times    ${glycolPumpStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}operationCommandControlled : 1    1
    Should Contain X Times    ${glycolPumpStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}parametersLocked : 1    1
    Should Contain X Times    ${glycolPumpStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    ${heartbeat_start}=    Get Index From List    ${full_list}    === Event heartbeat received =${SPACE}
    ${end}=    Evaluate    ${heartbeat_start}+${2}
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${end}
    ${logLevel_start}=    Get Index From List    ${full_list}    === Event logLevel received =${SPACE}
    ${end}=    Evaluate    ${logLevel_start}+${4}
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${end}
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystem : RO    1
    ${logMessage_start}=    Get Index From List    ${full_list}    === Event logMessage received =${SPACE}
    ${end}=    Evaluate    ${logMessage_start}+${11}
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${end}
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}message : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filePath : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}functionName : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lineNumber : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}process : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === Event softwareVersions received =${SPACE}
    ${end}=    Evaluate    ${softwareVersions_start}+${7}
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${end}
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xmlVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openSpliceVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cscVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystemVersions : RO    1
    ${errorCode_start}=    Get Index From List    ${full_list}    === Event errorCode received =${SPACE}
    ${end}=    Evaluate    ${errorCode_start}+${5}
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${end}
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorReport : RO    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    ${simulationMode_start}=    Get Index From List    ${full_list}    === Event simulationMode received =${SPACE}
    ${end}=    Evaluate    ${simulationMode_start}+${3}
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${end}
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    ${summaryState_start}=    Get Index From List    ${full_list}    === Event summaryState received =${SPACE}
    ${end}=    Evaluate    ${summaryState_start}+${3}
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${end}
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}summaryState : 1    1
    ${configurationApplied_start}=    Get Index From List    ${full_list}    === Event configurationApplied received =${SPACE}
    ${end}=    Evaluate    ${configurationApplied_start}+${7}
    ${configurationApplied_list}=    Get Slice From List    ${full_list}    start=${configurationApplied_start}    end=${end}
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}configurations : RO    1
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : RO    1
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}url : RO    1
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}schemaVersion : RO    1
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otherInfo : RO    1
    ${configurationsAvailable_start}=    Get Index From List    ${full_list}    === Event configurationsAvailable received =${SPACE}
    ${end}=    Evaluate    ${configurationsAvailable_start}+${6}
    ${configurationsAvailable_list}=    Get Slice From List    ${full_list}    start=${configurationsAvailable_start}    end=${end}
    Should Contain X Times    ${configurationsAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overrides : RO    1
    Should Contain X Times    ${configurationsAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : RO    1
    Should Contain X Times    ${configurationsAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}url : RO    1
    Should Contain X Times    ${configurationsAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}schemaVersion : RO    1
