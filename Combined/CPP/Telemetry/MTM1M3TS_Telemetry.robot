*** Settings ***
Documentation    MTM1M3TS Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTM1M3TS
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
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=Subscriber    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    ===== MTM1M3TS subscribers ready =====
    Sleep    6s

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_thermalData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_thermalData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTM1M3TS_thermalData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::thermalData_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3TS_thermalData end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTM1M3TS subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${thermalData_start}=    Get Index From List    ${full_list}    === MTM1M3TS_thermalData start of topic ===
    ${thermalData_end}=    Get Index From List    ${full_list}    === MTM1M3TS_thermalData end of topic ===
    ${thermalData_list}=    Get Slice From List    ${full_list}    start=${thermalData_start}    end=${thermalData_end}
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner1 : 0    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner1 : 1    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner1 : 2    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner1 : 3    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner1 : 4    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner1 : 5    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner1 : 6    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner1 : 7    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner1 : 8    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner1 : 9    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner2 : 0    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner2 : 1    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner2 : 2    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner2 : 3    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner2 : 4    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner2 : 5    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner2 : 6    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner2 : 7    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner2 : 8    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner2 : 9    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner3 : 0    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner3 : 1    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner3 : 2    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner3 : 3    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner3 : 4    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner3 : 5    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner3 : 6    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner3 : 7    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner3 : 8    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner3 : 9    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner4 : 0    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner4 : 1    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner4 : 2    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner4 : 3    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner4 : 4    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner4 : 5    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner4 : 6    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner4 : 7    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner4 : 8    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}thermocoupleScanner4 : 9    1
