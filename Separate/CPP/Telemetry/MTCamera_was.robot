*** Settings ***
Documentation    MTCamera Was communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTCamera
${component}    was
${timeout}    30s

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
    ${object}=    Get Process Object    Subscriber
    Log    ${object.stdout.peek()}
    ${string}=    Convert To String    ${object.stdout.peek()}
    Should Contain    ${string}    ===== MTCamera subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_cold test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_was
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTCamera subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardID : 1    10
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 0    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 1    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 2    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 3    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 4    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 5    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 6    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 7    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 8    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 9    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 0    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 1    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 2    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 3    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 4    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 5    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 6    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 7    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 8    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 9    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 0    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 1    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 2    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 3    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 4    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 5    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 6    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 7    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 8    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 9    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 0    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 1    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 2    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 3    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 4    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 5    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 6    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 7    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 8    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 9    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdID : 1    10
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdtemp : 1    10
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 0    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 1    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 2    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 3    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 4    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 5    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 6    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 7    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 8    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 9    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebID : 1    10
