*** Settings ***
Documentation    MTVMS M1M3 communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTVMS
${component}    M1M3
${timeout}    15s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_sub

Start Subscriber
    [Tags]    functional
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_sub    alias=Subscriber
    Log    ${output}
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    ===== MTVMS subscribers ready =====
    Sleep    6s

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_cameraRotator test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_M1M3
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTVMS subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1XAcceleration : 0    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1XAcceleration : 1    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1XAcceleration : 2    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1XAcceleration : 3    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1XAcceleration : 4    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1XAcceleration : 5    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1XAcceleration : 6    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1XAcceleration : 7    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1XAcceleration : 8    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1XAcceleration : 9    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1YAcceleration : 0    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1YAcceleration : 1    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1YAcceleration : 2    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1YAcceleration : 3    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1YAcceleration : 4    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1YAcceleration : 5    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1YAcceleration : 6    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1YAcceleration : 7    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1YAcceleration : 8    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1YAcceleration : 9    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1ZAcceleration : 0    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1ZAcceleration : 1    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1ZAcceleration : 2    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1ZAcceleration : 3    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1ZAcceleration : 4    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1ZAcceleration : 5    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1ZAcceleration : 6    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1ZAcceleration : 7    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1ZAcceleration : 8    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor1ZAcceleration : 9    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2XAcceleration : 0    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2XAcceleration : 1    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2XAcceleration : 2    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2XAcceleration : 3    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2XAcceleration : 4    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2XAcceleration : 5    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2XAcceleration : 6    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2XAcceleration : 7    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2XAcceleration : 8    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2XAcceleration : 9    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2YAcceleration : 0    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2YAcceleration : 1    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2YAcceleration : 2    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2YAcceleration : 3    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2YAcceleration : 4    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2YAcceleration : 5    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2YAcceleration : 6    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2YAcceleration : 7    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2YAcceleration : 8    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2YAcceleration : 9    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2ZAcceleration : 0    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2ZAcceleration : 1    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2ZAcceleration : 2    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2ZAcceleration : 3    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2ZAcceleration : 4    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2ZAcceleration : 5    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2ZAcceleration : 6    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2ZAcceleration : 7    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2ZAcceleration : 8    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor2ZAcceleration : 9    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3XAcceleration : 0    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3XAcceleration : 1    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3XAcceleration : 2    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3XAcceleration : 3    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3XAcceleration : 4    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3XAcceleration : 5    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3XAcceleration : 6    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3XAcceleration : 7    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3XAcceleration : 8    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3XAcceleration : 9    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3YAcceleration : 0    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3YAcceleration : 1    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3YAcceleration : 2    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3YAcceleration : 3    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3YAcceleration : 4    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3YAcceleration : 5    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3YAcceleration : 6    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3YAcceleration : 7    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3YAcceleration : 8    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3YAcceleration : 9    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3ZAcceleration : 0    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3ZAcceleration : 1    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3ZAcceleration : 2    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3ZAcceleration : 3    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3ZAcceleration : 4    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3ZAcceleration : 5    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3ZAcceleration : 6    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3ZAcceleration : 7    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3ZAcceleration : 8    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor3ZAcceleration : 9    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4XAcceleration : 0    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4XAcceleration : 1    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4XAcceleration : 2    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4XAcceleration : 3    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4XAcceleration : 4    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4XAcceleration : 5    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4XAcceleration : 6    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4XAcceleration : 7    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4XAcceleration : 8    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4XAcceleration : 9    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4YAcceleration : 0    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4YAcceleration : 1    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4YAcceleration : 2    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4YAcceleration : 3    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4YAcceleration : 4    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4YAcceleration : 5    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4YAcceleration : 6    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4YAcceleration : 7    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4YAcceleration : 8    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4YAcceleration : 9    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4ZAcceleration : 0    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4ZAcceleration : 1    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4ZAcceleration : 2    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4ZAcceleration : 3    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4ZAcceleration : 4    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4ZAcceleration : 5    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4ZAcceleration : 6    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4ZAcceleration : 7    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4ZAcceleration : 8    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor4ZAcceleration : 9    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5XAcceleration : 0    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5XAcceleration : 1    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5XAcceleration : 2    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5XAcceleration : 3    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5XAcceleration : 4    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5XAcceleration : 5    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5XAcceleration : 6    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5XAcceleration : 7    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5XAcceleration : 8    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5XAcceleration : 9    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5YAcceleration : 0    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5YAcceleration : 1    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5YAcceleration : 2    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5YAcceleration : 3    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5YAcceleration : 4    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5YAcceleration : 5    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5YAcceleration : 6    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5YAcceleration : 7    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5YAcceleration : 8    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5YAcceleration : 9    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5ZAcceleration : 0    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5ZAcceleration : 1    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5ZAcceleration : 2    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5ZAcceleration : 3    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5ZAcceleration : 4    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5ZAcceleration : 5    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5ZAcceleration : 6    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5ZAcceleration : 7    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5ZAcceleration : 8    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor5ZAcceleration : 9    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6XAcceleration : 0    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6XAcceleration : 1    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6XAcceleration : 2    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6XAcceleration : 3    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6XAcceleration : 4    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6XAcceleration : 5    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6XAcceleration : 6    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6XAcceleration : 7    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6XAcceleration : 8    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6XAcceleration : 9    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6YAcceleration : 0    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6YAcceleration : 1    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6YAcceleration : 2    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6YAcceleration : 3    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6YAcceleration : 4    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6YAcceleration : 5    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6YAcceleration : 6    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6YAcceleration : 7    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6YAcceleration : 8    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6YAcceleration : 9    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6ZAcceleration : 0    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6ZAcceleration : 1    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6ZAcceleration : 2    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6ZAcceleration : 3    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6ZAcceleration : 4    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6ZAcceleration : 5    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6ZAcceleration : 6    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6ZAcceleration : 7    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6ZAcceleration : 8    1
    Should Contain X Times    ${M1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sensor6ZAcceleration : 9    1
