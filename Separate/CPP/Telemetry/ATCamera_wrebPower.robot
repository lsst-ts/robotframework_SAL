*** Settings ***
Documentation    ATCamera WrebPower communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATCamera
${component}    wrebPower
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
    Should Contain    ${output}    ===== ATCamera subscribers ready =====
    Sleep    6s

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_wrebPower test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_wrebPower
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ATCamera subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${wrebPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_V : 1    10
    Should Contain X Times    ${wrebPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_I : 1    10
    Should Contain X Times    ${wrebPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_V : 1    10
    Should Contain X Times    ${wrebPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_I : 1    10
    Should Contain X Times    ${wrebPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHigh_V : 1    10
    Should Contain X Times    ${wrebPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHigh_I : 1    10
    Should Contain X Times    ${wrebPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLow_V : 1    10
    Should Contain X Times    ${wrebPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLow_I : 1    10
    Should Contain X Times    ${wrebPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_V : 1    10
    Should Contain X Times    ${wrebPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_I : 1    10
    Should Contain X Times    ${wrebPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_V : 1    10
    Should Contain X Times    ${wrebPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_I : 1    10
    Should Contain X Times    ${wrebPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_V : 1    10
    Should Contain X Times    ${wrebPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_I : 1    10
    Should Contain X Times    ${wrebPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_V : 1    10
    Should Contain X Times    ${wrebPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_I : 1    10
