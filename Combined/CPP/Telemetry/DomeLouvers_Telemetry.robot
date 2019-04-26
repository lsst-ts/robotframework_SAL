*** Settings ***
Documentation    DomeLouvers Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    DomeLouvers
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
    Should Contain    ${output}    ===== DomeLouvers subscribers ready =====
    Sleep    6s

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_status test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_status
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === DomeLouvers_status start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::status_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === DomeLouvers_status end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== DomeLouvers subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${status_start}=    Get Index From List    ${full_list}    === DomeLouvers_status start of topic ===
    ${status_end}=    Get Index From List    ${full_list}    === DomeLouvers_status end of topic ===
    ${status_list}=    Get Slice From List    ${full_list}    start=${status_start}    end=${status_end}
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 0    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 1    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 2    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 3    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 4    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 5    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 6    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 7    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 8    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionError : 9    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 0    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 1    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 2    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 3    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 4    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 5    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 6    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 7    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 8    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 9    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 0    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 1    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 2    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 3    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 4    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 5    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 6    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 7    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 8    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCmd : 9    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 0    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 1    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 2    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 3    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 4    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 5    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 6    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 7    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 8    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 9    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 0    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 1    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 2    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 3    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 4    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 5    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 6    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 7    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 8    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueError : 9    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 0    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 1    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 2    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 3    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 4    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 5    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 6    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 7    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 8    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCmd : 9    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 0    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 1    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 2    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 3    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 4    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 5    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 6    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 7    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 8    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 9    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 0    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 1    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 2    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 3    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 4    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 5    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 6    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 7    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 8    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTempActual : 9    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 0    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 1    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 2    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 3    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 4    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 5    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 6    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 7    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 8    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 9    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 0    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 1    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 2    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 3    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 4    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 5    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 6    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 7    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 8    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 9    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerAbsortion : 1    10
