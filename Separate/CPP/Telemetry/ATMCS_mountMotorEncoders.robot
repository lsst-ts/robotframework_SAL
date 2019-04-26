*** Settings ***
Documentation    ATMCS MountMotorEncoders communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATMCS
${component}    mountMotorEncoders
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
    Should Contain    ${output}    ===== ATMCS subscribers ready =====
    Sleep    6s

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_mountMotorEncoders test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_mountMotorEncoders
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ATMCS subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoder : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1Encoder : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2Encoder : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1Encoder : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2Encoder : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3Encoder : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationEncoderRaw : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth1EncoderRaw : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth2EncoderRaw : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth1EncoderRaw : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmyth2EncoderRaw : 1    10
    Should Contain X Times    ${mountMotorEncoders_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m3EncoderRaw : 1    10
