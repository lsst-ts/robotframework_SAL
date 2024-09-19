*** Settings ***
Documentation    Test Telemetry communications tests.
Force Tags    messaging    cpp    test    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Test
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
    Should Be Equal    ${output.returncode}   ${NONE}
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdout.txt
    Comment    Sleep for 6s to allow DDS time to register all the topics.
    Sleep    6s
    ${output}=    Get File    ${EXECDIR}${/}${subSystem}_stdout.txt
    Should Contain    ${output}    ===== Test subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    1/1 brokers are down
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "scalars"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_scalars test messages =======
    Should Contain    ${output.stdout}    === Test_scalars start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.scalars writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Test_scalars end of topic ===
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "arrays"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_arrays test messages =======
    Should Contain    ${output.stdout}    === Test_arrays start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}.arrays writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Test_arrays end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    1/1 brokers are down
    Should Not Contain    ${output.stderr}    Consume failed
    Should Not Contain    ${output.stderr}    Broker: Unknown topic or partition
    Should Contain    ${output.stdout}    ===== Test subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${scalars_start}=    Get Index From List    ${full_list}    === Test_scalars start of topic ===
    ${scalars_end}=    Get Index From List    ${full_list}    === Test_scalars end of topic ===
    ${scalars_list}=    Get Slice From List    ${full_list}    start=${scalars_start}    end=${scalars_end}
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 1    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x01    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 1    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 1    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 1    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 1    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 1    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 1    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 1    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 1    10
    Should Contain X Times    ${scalars_list}    ${SPACE}${SPACE}${SPACE}${SPACE}string0 : RO    10
    ${arrays_start}=    Get Index From List    ${full_list}    === Test_arrays start of topic ===
    ${arrays_end}=    Get Index From List    ${full_list}    === Test_arrays end of topic ===
    ${arrays_list}=    Get Slice From List    ${full_list}    start=${arrays_start}    end=${arrays_end}
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 1    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 2    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 3    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 4    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 5    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 6    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 7    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 8    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 9    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x00    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x01    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x02    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x03    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x04    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x05    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x06    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x07    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x08    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x09    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 1    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 2    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 3    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 4    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 5    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 6    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 7    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 8    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 9    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 1    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 2    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 3    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 4    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 5    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 6    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 7    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 8    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 9    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 1    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 2    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 3    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 4    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 5    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 6    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 7    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 8    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 9    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 1    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 2    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 3    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 4    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 5    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 6    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 7    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 8    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 9    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 1    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 2    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 3    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 4    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 5    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 6    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 7    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 8    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 9    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 1    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 2    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 3    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 4    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 5    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 6    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 7    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 8    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 9    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 1    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 2    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 3    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 4    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 5    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 6    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 7    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 8    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 9    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 1    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 2    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 3    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 4    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 5    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 6    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 7    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 8    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 9    1
