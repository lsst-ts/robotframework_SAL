*** Settings ***
Documentation    Dome Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Dome
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
    Should Contain    ${output}    ===== Dome subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_azimuth test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_azimuth
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Dome_azimuth start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::azimuth_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Dome_azimuth end of topic ===
    Comment    ======= Verify ${subSystem}_lightWindScreen test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_lightWindScreen
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Dome_lightWindScreen start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::lightWindScreen_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Dome_lightWindScreen end of topic ===
    Comment    ======= Verify ${subSystem}_apertureShutter test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_apertureShutter
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Dome_apertureShutter start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::apertureShutter_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Dome_apertureShutter end of topic ===
    Comment    ======= Verify ${subSystem}_louvers test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_louvers
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Dome_louvers start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::louvers_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Dome_louvers end of topic ===
    Comment    ======= Verify ${subSystem}_interlocks test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_interlocks
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Dome_interlocks start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::interlocks_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Dome_interlocks end of topic ===
    Comment    ======= Verify ${subSystem}_thermal test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_thermal
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === Dome_thermal start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::thermal_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Dome_thermal end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Dome subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${azimuth_start}=    Get Index From List    ${full_list}    === Dome_azimuth start of topic ===
    ${azimuth_end}=    Get Index From List    ${full_list}    === Dome_azimuth end of topic ===
    ${azimuth_list}=    Get Slice From List    ${full_list}    start=${azimuth_start}    end=${azimuth_end}
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCommanded : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocityActual : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocityCommanded : 1    10
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 0    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 1    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 2    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 3    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 4    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 5    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 6    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 7    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 8    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 9    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 0    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 1    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 2    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 3    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 4    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 5    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 6    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 7    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 8    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 9    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 0    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 1    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 2    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 3    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 4    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 5    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 6    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 7    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 8    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 9    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 0    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 1    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 2    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 3    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 4    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 5    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 6    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 7    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 8    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 9    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 0    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 1    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 2    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 3    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 4    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 5    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 6    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 7    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 8    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 9    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 0    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 1    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 2    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 3    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 4    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 5    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 6    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 7    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 8    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 9    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 0    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 1    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 2    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 3    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 4    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 5    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 6    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 7    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 8    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 9    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 0    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 1    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 2    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 3    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 4    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 5    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 6    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 7    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 8    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 9    1
    Should Contain X Times    ${azimuth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${lightWindScreen_start}=    Get Index From List    ${full_list}    === Dome_lightWindScreen start of topic ===
    ${lightWindScreen_end}=    Get Index From List    ${full_list}    === Dome_lightWindScreen end of topic ===
    ${lightWindScreen_list}=    Get Slice From List    ${full_list}    start=${lightWindScreen_start}    end=${lightWindScreen_end}
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 1    10
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCommanded : 1    10
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocityActual : 1    10
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocityCommanded : 1    10
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 0    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 1    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 2    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 3    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 4    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 5    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 6    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 7    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 8    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 9    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 0    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 1    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 2    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 3    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 4    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 5    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 6    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 7    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 8    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 9    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 0    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 1    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 2    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 3    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 4    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 5    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 6    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 7    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 8    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 9    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 0    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 1    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 2    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 3    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 4    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 5    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 6    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 7    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 8    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 9    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 0    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 1    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 2    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 3    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 4    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 5    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 6    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 7    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 8    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 9    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 0    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 1    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 2    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 3    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 4    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 5    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 6    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 7    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 8    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 9    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 0    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 1    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 2    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 3    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 4    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 5    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 6    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 7    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 8    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverRaw : 9    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 0    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 1    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 2    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 3    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 4    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 5    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 6    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 7    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 8    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverCalibrated : 9    1
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerDraw : 1    10
    Should Contain X Times    ${lightWindScreen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${apertureShutter_start}=    Get Index From List    ${full_list}    === Dome_apertureShutter start of topic ===
    ${apertureShutter_end}=    Get Index From List    ${full_list}    === Dome_apertureShutter end of topic ===
    ${apertureShutter_list}=    Get Slice From List    ${full_list}    start=${apertureShutter_start}    end=${apertureShutter_end}
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 1    10
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCommanded : 1    10
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 0    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 1    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 2    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 3    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 4    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 5    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 6    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 7    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 8    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 9    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 0    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 1    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 2    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 3    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 4    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 5    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 6    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 7    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 8    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 9    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 0    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 1    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 2    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 3    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 4    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 5    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 6    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 7    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 8    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 9    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 0    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 1    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 2    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 3    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 4    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 5    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 6    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 7    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 8    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 9    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadRaw : 0    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadRaw : 1    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadRaw : 2    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadRaw : 3    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadRaw : 4    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadRaw : 5    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadRaw : 6    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadRaw : 7    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadRaw : 8    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadRaw : 9    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadCalibrated : 0    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadCalibrated : 1    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadCalibrated : 2    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadCalibrated : 3    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadCalibrated : 4    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadCalibrated : 5    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadCalibrated : 6    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadCalibrated : 7    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadCalibrated : 8    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resolverHeadCalibrated : 9    1
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerDraw : 1    10
    Should Contain X Times    ${apertureShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${louvers_start}=    Get Index From List    ${full_list}    === Dome_louvers start of topic ===
    ${louvers_end}=    Get Index From List    ${full_list}    === Dome_louvers end of topic ===
    ${louvers_list}=    Get Slice From List    ${full_list}    start=${louvers_start}    end=${louvers_end}
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 0    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 1    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 2    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 3    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 4    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 5    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 6    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 7    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 8    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionActual : 9    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCommanded : 0    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCommanded : 1    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCommanded : 2    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCommanded : 3    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCommanded : 4    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCommanded : 5    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCommanded : 6    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCommanded : 7    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCommanded : 8    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionCommanded : 9    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 0    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 1    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 2    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 3    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 4    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 5    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 6    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 7    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 8    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueActual : 9    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 0    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 1    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 2    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 3    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 4    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 5    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 6    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 7    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 8    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTorqueCommanded : 9    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 0    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 1    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 2    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 3    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 4    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 5    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 6    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 7    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 8    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveCurrentActual : 9    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 0    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 1    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 2    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 3    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 4    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 5    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 6    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 7    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 8    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveTemperature : 9    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 0    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 1    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 2    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 3    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 4    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 5    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 6    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 7    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 8    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadRaw : 9    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 0    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 1    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 2    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 3    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 4    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 5    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 6    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 7    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 8    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}encoderHeadCalibrated : 9    1
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}powerDraw : 1    10
    Should Contain X Times    ${louvers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${interlocks_start}=    Get Index From List    ${full_list}    === Dome_interlocks start of topic ===
    ${interlocks_end}=    Get Index From List    ${full_list}    === Dome_interlocks end of topic ===
    ${interlocks_list}=    Get Slice From List    ${full_list}    start=${interlocks_start}    end=${interlocks_end}
    Should Contain X Times    ${interlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 0    1
    Should Contain X Times    ${interlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 1    1
    Should Contain X Times    ${interlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 2    1
    Should Contain X Times    ${interlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 3    1
    Should Contain X Times    ${interlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 4    1
    Should Contain X Times    ${interlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 5    1
    Should Contain X Times    ${interlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 6    1
    Should Contain X Times    ${interlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 7    1
    Should Contain X Times    ${interlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 8    1
    Should Contain X Times    ${interlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}data : 9    1
    Should Contain X Times    ${interlocks_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    ${thermal_start}=    Get Index From List    ${full_list}    === Dome_thermal start of topic ===
    ${thermal_end}=    Get Index From List    ${full_list}    === Dome_thermal end of topic ===
    ${thermal_list}=    Get Slice From List    ${full_list}    start=${thermal_start}    end=${thermal_end}
    Should Contain X Times    ${thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 0    1
    Should Contain X Times    ${thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 1    1
    Should Contain X Times    ${thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 2    1
    Should Contain X Times    ${thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 3    1
    Should Contain X Times    ${thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 4    1
    Should Contain X Times    ${thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 5    1
    Should Contain X Times    ${thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 6    1
    Should Contain X Times    ${thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 7    1
    Should Contain X Times    ${thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 8    1
    Should Contain X Times    ${thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperature : 9    1
    Should Contain X Times    ${thermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
