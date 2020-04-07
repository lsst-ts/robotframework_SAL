*** Settings ***
Documentation    DSM Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    DSM
${component}    all
${timeout}    15s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber

Start Subscriber
    [Tags]    functional
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdout.txt
    Comment    Sleep for 6s to allow DDS time to register all the topics.
    Sleep    6s
    ${output}=    Get File    ${EXECDIR}${/}${subSystem}_stdout.txt
    Should Contain    ${output}    ===== DSM subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_domeSeeing test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_domeSeeing
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === DSM_domeSeeing start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::domeSeeing_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === DSM_domeSeeing end of topic ===
    Comment    ======= Verify ${subSystem}_configuration test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_configuration
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === DSM_configuration start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::configuration_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === DSM_configuration end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== DSM subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${domeSeeing_start}=    Get Index From List    ${full_list}    === DSM_domeSeeing start of topic ===
    ${domeSeeing_end}=    Get Index From List    ${full_list}    === DSM_domeSeeing end of topic ===
    ${domeSeeing_list}=    Get Slice From List    ${full_list}    start=${domeSeeing_start}    end=${domeSeeing_end}
    Should Contain X Times    ${domeSeeing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dsmIndex : 1    10
    Should Contain X Times    ${domeSeeing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampCurrent : 1    10
    Should Contain X Times    ${domeSeeing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampFirstMeasurement : 1    10
    Should Contain X Times    ${domeSeeing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampLastMeasurement : 1    10
    Should Contain X Times    ${domeSeeing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rmsX : 1    10
    Should Contain X Times    ${domeSeeing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rmsY : 1    10
    Should Contain X Times    ${domeSeeing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}centroidX : 1    10
    Should Contain X Times    ${domeSeeing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}centroidY : 1    10
    Should Contain X Times    ${domeSeeing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flux : 1    10
    Should Contain X Times    ${domeSeeing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxADC : 1    10
    Should Contain X Times    ${domeSeeing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fwhm : 1    10
    ${configuration_start}=    Get Index From List    ${full_list}    === DSM_configuration start of topic ===
    ${configuration_end}=    Get Index From List    ${full_list}    === DSM_configuration end of topic ===
    ${configuration_list}=    Get Slice From List    ${full_list}    start=${configuration_start}    end=${configuration_end}
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dsmIndex : 1    10
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestampConfigStart : 1    10
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}uiVersionCode : LSST    10
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}uiVersionConfig : LSST    10
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}uiConfigFile : LSST    10
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cameraName : LSST    10
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cameraFps : 1    10
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dataBufferSize : 1    10
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dataAcquisitionTime : 1    10
