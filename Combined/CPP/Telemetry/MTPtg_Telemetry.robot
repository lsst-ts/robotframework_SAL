*** Settings ***
Documentation    MTPtg Telemetry communications tests.
Force Tags    messaging    cpp    mtptg    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}common.robot
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTPtg
${component}    all
${timeout}    480s

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
    Wait Until Keyword Succeeds    60s    10    File Should Contain    ${EXECDIR}${/}${subSystem}_stdout.txt    ===== MTPtg subscribers ready =====

Start Publisher
    [Tags]    functional    publisher    robot:continue-on-failure
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "currentTargetStatus"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_currentTargetStatus test messages =======
    Should Contain    ${output.stdout}    === MTPtg_currentTargetStatus start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.currentTargetStatus writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTPtg_currentTargetStatus end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "guiding"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_guiding test messages =======
    Should Contain    ${output.stdout}    === MTPtg_guiding start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.guiding writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTPtg_guiding end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "timeAndDate"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_timeAndDate test messages =======
    Should Contain    ${output.stdout}    === MTPtg_timeAndDate start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.timeAndDate writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTPtg_timeAndDate end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "mountStatus"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_mountStatus test messages =======
    Should Contain    ${output.stdout}    === MTPtg_mountStatus start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.mountStatus writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTPtg_mountStatus end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "skyEnvironment"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_skyEnvironment test messages =======
    Should Contain    ${output.stdout}    === MTPtg_skyEnvironment start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.skyEnvironment writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTPtg_skyEnvironment end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "namedAzEl"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_namedAzEl test messages =======
    Should Contain    ${output.stdout}    === MTPtg_namedAzEl start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.namedAzEl writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTPtg_namedAzEl end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "mountPosition"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_mountPosition test messages =======
    Should Contain    ${output.stdout}    === MTPtg_mountPosition start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.mountPosition writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTPtg_mountPosition end of topic ===

Read Subscriber
    [Tags]    functional    subscriber    robot:continue-on-failure
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    1/1 brokers are down
    Should Not Contain    ${output.stderr}    Consume failed
    Should Not Contain    ${output.stderr}    Broker: Unknown topic or partition
    Should Contain    ${output.stdout}    ===== MTPtg subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${currentTargetStatus_start}=    Get Index From List    ${full_list}    === MTPtg_currentTargetStatus start of topic ===
    ${currentTargetStatus_end}=    Get Index From List    ${full_list}    === MTPtg_currentTargetStatus end of topic ===
    ${currentTargetStatus_list}=    Get Slice From List    ${full_list}    start=${currentTargetStatus_start}    end=${currentTargetStatus_end}
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandAz : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandEl : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRot : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandAzVelocity : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandElVelocity : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRotVelocity : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ha : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}parAngle : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airmass : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRa : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandDec : 1    10
    ${guiding_start}=    Get Index From List    ${full_list}    === MTPtg_guiding start of topic ===
    ${guiding_end}=    Get Index From List    ${full_list}    === MTPtg_guiding end of topic ===
    ${guiding_list}=    Get Slice From List    ${full_list}    start=${guiding_start}    end=${guiding_end}
    Should Contain X Times    ${guiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${guiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}guideControlState : 1    10
    Should Contain X Times    ${guiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}guideAutoClearState : 1    10
    Should Contain X Times    ${guiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}guideGA : 1    10
    Should Contain X Times    ${guiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}guideGB : 1    10
    Should Contain X Times    ${guiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotation : 1    10
    ${timeAndDate_start}=    Get Index From List    ${full_list}    === MTPtg_timeAndDate start of topic ===
    ${timeAndDate_end}=    Get Index From List    ${full_list}    === MTPtg_timeAndDate end of topic ===
    ${timeAndDate_list}=    Get Slice From List    ${full_list}    start=${timeAndDate_start}    end=${timeAndDate_end}
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}utc : 1    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lst : 1    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mjd : 1    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}localTime : 1    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}localTimeString : RO    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}leapSecs : 1    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timezone : 1    10
    ${mountStatus_start}=    Get Index From List    ${full_list}    === MTPtg_mountStatus start of topic ===
    ${mountStatus_end}=    Get Index From List    ${full_list}    === MTPtg_mountStatus end of topic ===
    ${mountStatus_list}=    Get Slice From List    ${full_list}    start=${mountStatus_start}    end=${mountStatus_end}
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountRA : 1    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountDec : 1    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountAz : 1    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountEl : 1    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountRot : 1    10
    ${skyEnvironment_start}=    Get Index From List    ${full_list}    === MTPtg_skyEnvironment start of topic ===
    ${skyEnvironment_end}=    Get Index From List    ${full_list}    === MTPtg_skyEnvironment end of topic ===
    ${skyEnvironment_list}=    Get Slice From List    ${full_list}    start=${skyEnvironment_start}    end=${skyEnvironment_end}
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunsetTime : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}twilightEndTime : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}twilightBeginTime : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunriseTime : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonriseTime : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonsetTime : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonPhase : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunAltitude : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonAltitude : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunTargetDistance : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonTargetDistance : 1    10
    ${namedAzEl_start}=    Get Index From List    ${full_list}    === MTPtg_namedAzEl start of topic ===
    ${namedAzEl_end}=    Get Index From List    ${full_list}    === MTPtg_namedAzEl end of topic ===
    ${namedAzEl_list}=    Get Slice From List    ${full_list}    start=${namedAzEl_start}    end=${namedAzEl_end}
    Should Contain X Times    ${namedAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}names : RO    10
    Should Contain X Times    ${namedAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azPositions : RO    10
    Should Contain X Times    ${namedAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elPositions : RO    10
    Should Contain X Times    ${namedAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotPositions : RO    10
    ${mountPosition_start}=    Get Index From List    ${full_list}    === MTPtg_mountPosition start of topic ===
    ${mountPosition_end}=    Get Index From List    ${full_list}    === MTPtg_mountPosition end of topic ===
    ${mountPosition_list}=    Get Slice From List    ${full_list}    start=${mountPosition_start}    end=${mountPosition_end}
    Should Contain X Times    ${mountPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${mountPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthActualPosition : 1    10
    Should Contain X Times    ${mountPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationActualPosition : 1    10
    Should Contain X Times    ${mountPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotatorActualPosition : 1    10
    Should Contain X Times    ${mountPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 1    10
    Should Contain X Times    ${mountPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 1    10
    Should Contain X Times    ${mountPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyAngle : 1    10
