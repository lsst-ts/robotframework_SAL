*** Settings ***
Documentation    TunableLaser Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    TunableLaser
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
    Should Contain    ${output}    ===== TunableLaser subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_temperature test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_temperature
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === TunableLaser_temperature start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::temperature_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === TunableLaser_temperature end of topic ===
    Comment    ======= Verify ${subSystem}_wavelength test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_wavelength
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === TunableLaser_wavelength start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::wavelength_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === TunableLaser_wavelength end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== TunableLaser subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${temperature_start}=    Get Index From List    ${full_list}    === TunableLaser_temperature start of topic ===
    ${temperature_end}=    Get Index From List    ${full_list}    === TunableLaser_temperature end of topic ===
    ${temperature_list}=    Get Slice From List    ${full_list}    start=${temperature_start}    end=${temperature_end}
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tk6_temperature : 1    10
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tk6_temperature_2 : 1    10
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ldco48bp_temperature : 1    10
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ldco48bp_temperature_2 : 1    10
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ldco48bp_temperature_3 : 1    10
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m_ldco48_temperature : 1    10
    Should Contain X Times    ${temperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m_ldco48_temperature_2 : 1    10
    ${wavelength_start}=    Get Index From List    ${full_list}    === TunableLaser_wavelength start of topic ===
    ${wavelength_end}=    Get Index From List    ${full_list}    === TunableLaser_wavelength end of topic ===
    ${wavelength_list}=    Get Slice From List    ${full_list}    start=${wavelength_start}    end=${wavelength_end}
    Should Contain X Times    ${wavelength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wavelength : 1    10
