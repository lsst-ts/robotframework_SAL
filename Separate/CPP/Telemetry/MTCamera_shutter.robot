*** Settings ***
Documentation    MTCamera Shutter communications tests.
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
${component}    shutter
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

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_cold test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_shutter
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
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bladeHome : 0    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bladeHome : 1    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bladeHome : 2    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bladeHome : 3    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bladeHome : 4    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bladeHome : 5    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bladeHome : 6    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bladeHome : 7    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bladeHome : 8    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bladeHome : 9    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeProfile : 0    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeProfile : 1    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeProfile : 2    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeProfile : 3    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeProfile : 4    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeProfile : 5    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeProfile : 6    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeProfile : 7    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeProfile : 8    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeProfile : 9    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 0    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 1    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 2    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 3    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 4    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 5    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 6    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 7    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 8    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 9    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemp : 0    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemp : 1    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemp : 2    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemp : 3    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemp : 4    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemp : 5    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemp : 6    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemp : 7    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemp : 8    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemp : 9    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openDirection : 1    10
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openProfile : 0    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openProfile : 1    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openProfile : 2    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openProfile : 3    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openProfile : 4    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openProfile : 5    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openProfile : 6    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openProfile : 7    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openProfile : 8    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openProfile : 9    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}profileFunction : LSST    10
