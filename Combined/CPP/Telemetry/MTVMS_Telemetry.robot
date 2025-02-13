*** Settings ***
Documentation    MTVMS Telemetry communications tests.
Force Tags    messaging    cpp    mtvms    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTVMS
${component}    all
${timeout}    120s

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
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdout.txt
    ${output}=    Get File    ${EXECDIR}${/}${subSystem}_stdout.txt
    Should Contain    ${output}    ===== MTVMS subscribers ready =====

Start Publisher
    [Tags]    functional    publisher    robot:continue-on-failure
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "data"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_data test messages =======
    Should Contain    ${output.stdout}    === MTVMS_data start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.data writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTVMS_data end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "psd"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_psd test messages =======
    Should Contain    ${output.stdout}    === MTVMS_psd start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.psd writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTVMS_psd end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "miscellaneous"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_miscellaneous test messages =======
    Should Contain    ${output.stdout}    === MTVMS_miscellaneous start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.miscellaneous writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTVMS_miscellaneous end of topic ===

Read Subscriber
    [Tags]    functional    subscriber    robot:continue-on-failure
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    1/1 brokers are down
    Should Not Contain    ${output.stderr}    Consume failed
    Should Not Contain    ${output.stderr}    Broker: Unknown topic or partition
    Should Contain    ${output.stdout}    ===== MTVMS subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${data_start}=    Get Index From List    ${full_list}    === MTVMS_data start of topic ===
    ${data_end}=    Get Index From List    ${full_list}    === MTVMS_data end of topic ===
    ${data_list}=    Get Slice From List    ${full_list}    start=${data_start}    end=${data_end}
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor : 1    10
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationX : 0    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationX : 1    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationX : 2    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationX : 3    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationX : 4    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationX : 5    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationX : 6    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationX : 7    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationX : 8    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationX : 9    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationY : 0    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationY : 1    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationY : 2    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationY : 3    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationY : 4    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationY : 5    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationY : 6    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationY : 7    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationY : 8    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationY : 9    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZ : 0    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZ : 1    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZ : 2    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZ : 3    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZ : 4    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZ : 5    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZ : 6    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZ : 7    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZ : 8    1
    Should Contain X Times    ${data_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationZ : 9    1
    ${psd_start}=    Get Index From List    ${full_list}    === MTVMS_psd start of topic ===
    ${psd_end}=    Get Index From List    ${full_list}    === MTVMS_psd end of topic ===
    ${psd_list}=    Get Slice From List    ${full_list}    start=${psd_start}    end=${psd_end}
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}interval : 1    10
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minPSDFrequency : 1    10
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxPSDFrequency : 1    10
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numDataPoints : 1    10
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor : 1    10
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDX : 0    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDX : 1    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDX : 2    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDX : 3    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDX : 4    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDX : 5    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDX : 6    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDX : 7    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDX : 8    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDX : 9    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDY : 0    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDY : 1    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDY : 2    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDY : 3    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDY : 4    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDY : 5    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDY : 6    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDY : 7    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDY : 8    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDY : 9    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDZ : 0    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDZ : 1    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDZ : 2    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDZ : 3    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDZ : 4    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDZ : 5    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDZ : 6    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDZ : 7    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDZ : 8    1
    Should Contain X Times    ${psd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationPSDZ : 9    1
    ${miscellaneous_start}=    Get Index From List    ${full_list}    === MTVMS_miscellaneous start of topic ===
    ${miscellaneous_end}=    Get Index From List    ${full_list}    === MTVMS_miscellaneous end of topic ===
    ${miscellaneous_list}=    Get Slice From List    ${full_list}    start=${miscellaneous_start}    end=${miscellaneous_end}
    Should Contain X Times    ${miscellaneous_list}    ${SPACE}${SPACE}${SPACE}${SPACE}chassisTemperature : 1    10
    Should Contain X Times    ${miscellaneous_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ticks : 1    10
