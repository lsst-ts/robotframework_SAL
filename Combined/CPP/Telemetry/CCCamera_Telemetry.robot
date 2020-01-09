*** Settings ***
Documentation    CCCamera Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    CCCamera
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
    Should Contain    ${output}    ===== CCCamera subscribers ready =====
    Sleep    6s

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_filterChanger test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_filterChanger
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === CCCamera_filterChanger start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::filterChanger_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_filterChanger end of topic ===
    Comment    ======= Verify ${subSystem}_vacuumTurboPump test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuumTurboPump
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === CCCamera_vacuumTurboPump start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuumTurboPump_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_vacuumTurboPump end of topic ===
    Comment    ======= Verify ${subSystem}_vacuumIonPump test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuumIonPump
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === CCCamera_vacuumIonPump start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuumIonPump_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_vacuumIonPump end of topic ===
    Comment    ======= Verify ${subSystem}_vacuumCryoTelColdPlate1 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuumCryoTelColdPlate1
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === CCCamera_vacuumCryoTelColdPlate1 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuumCryoTelColdPlate1_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_vacuumCryoTelColdPlate1 end of topic ===
    Comment    ======= Verify ${subSystem}_vacuumCryoTelColdPlate2 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuumCryoTelColdPlate2
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === CCCamera_vacuumCryoTelColdPlate2 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuumCryoTelColdPlate2_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_vacuumCryoTelColdPlate2 end of topic ===
    Comment    ======= Verify ${subSystem}_vacuumCryoTelCryoPlate test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuumCryoTelCryoPlate
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === CCCamera_vacuumCryoTelCryoPlate start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuumCryoTelCryoPlate_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_vacuumCryoTelCryoPlate end of topic ===
    Comment    ======= Verify ${subSystem}_vacuumPressureGauge test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuumPressureGauge
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === CCCamera_vacuumPressureGauge start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuumPressureGauge_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_vacuumPressureGauge end of topic ===
    Comment    ======= Verify ${subSystem}_bonnShutter test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_bonnShutter
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === CCCamera_bonnShutter start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::bonnShutter_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_bonnShutter end of topic ===
    Comment    ======= Verify ${subSystem}_vacuumPowerDistributionUnit test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuumPowerDistributionUnit
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === CCCamera_vacuumPowerDistributionUnit start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuumPowerDistributionUnit_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_vacuumPowerDistributionUnit end of topic ===
    Comment    ======= Verify ${subSystem}_vacuumStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuumStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === CCCamera_vacuumStatus start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuumStatus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_vacuumStatus end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== CCCamera subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${filterChanger_start}=    Get Index From List    ${full_list}    === CCCamera_filterChanger start of topic ===
    ${filterChanger_end}=    Get Index From List    ${full_list}    === CCCamera_filterChanger end of topic ===
    ${filterChanger_list}=    Get Slice From List    ${full_list}    start=${filterChanger_start}    end=${filterChanger_end}
    Should Contain X Times    ${filterChanger_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemperature : 1    10
    Should Contain X Times    ${filterChanger_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorEncoder : 1    10
    Should Contain X Times    ${filterChanger_list}    ${SPACE}${SPACE}${SPACE}${SPACE}linearPosition : 1    10
    ${vacuumTurboPump_start}=    Get Index From List    ${full_list}    === CCCamera_vacuumTurboPump start of topic ===
    ${vacuumTurboPump_end}=    Get Index From List    ${full_list}    === CCCamera_vacuumTurboPump end of topic ===
    ${vacuumTurboPump_list}=    Get Slice From List    ${full_list}    start=${vacuumTurboPump_start}    end=${vacuumTurboPump_end}
    Should Contain X Times    ${vacuumTurboPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turboContTempAir : 1    10
    Should Contain X Times    ${vacuumTurboPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turboContTempSink : 1    10
    Should Contain X Times    ${vacuumTurboPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turboCurrent : 1    10
    Should Contain X Times    ${vacuumTurboPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turboDriveFreq : 1    10
    Should Contain X Times    ${vacuumTurboPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turboPower : 1    10
    Should Contain X Times    ${vacuumTurboPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turboPumpTemp : 1    10
    Should Contain X Times    ${vacuumTurboPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turboRPM : 1    10
    Should Contain X Times    ${vacuumTurboPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turboSpeed : 1    10
    Should Contain X Times    ${vacuumTurboPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turboStatus : 1    10
    Should Contain X Times    ${vacuumTurboPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turboVoltage : 1    10
    ${vacuumIonPump_start}=    Get Index From List    ${full_list}    === CCCamera_vacuumIonPump start of topic ===
    ${vacuumIonPump_end}=    Get Index From List    ${full_list}    === CCCamera_vacuumIonPump end of topic ===
    ${vacuumIonPump_list}=    Get Slice From List    ${full_list}    start=${vacuumIonPump_start}    end=${vacuumIonPump_end}
    Should Contain X Times    ${vacuumIonPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cIP1_V : 1    10
    Should Contain X Times    ${vacuumIonPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cIP1_I : 1    10
    ${vacuumCryoTelColdPlate1_start}=    Get Index From List    ${full_list}    === CCCamera_vacuumCryoTelColdPlate1 start of topic ===
    ${vacuumCryoTelColdPlate1_end}=    Get Index From List    ${full_list}    === CCCamera_vacuumCryoTelColdPlate1 end of topic ===
    ${vacuumCryoTelColdPlate1_list}=    Get Slice From List    ${full_list}    start=${vacuumCryoTelColdPlate1_start}    end=${vacuumCryoTelColdPlate1_end}
    Should Contain X Times    ${vacuumCryoTelColdPlate1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cold1AutoOff : 1    10
    Should Contain X Times    ${vacuumCryoTelColdPlate1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cold1Pwr : 1    10
    Should Contain X Times    ${vacuumCryoTelColdPlate1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cold1RejectTemp : 1    10
    Should Contain X Times    ${vacuumCryoTelColdPlate1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cold1Temp : 1    10
    Should Contain X Times    ${vacuumCryoTelColdPlate1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cold1SetPt : 1    10
    Should Contain X Times    ${vacuumCryoTelColdPlate1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cold1SetPwr : 1    10
    Should Contain X Times    ${vacuumCryoTelColdPlate1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cold1AutoOffTemp : 1    10
    Should Contain X Times    ${vacuumCryoTelColdPlate1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cold1AutoOnTemp : 1    10
    ${vacuumCryoTelColdPlate2_start}=    Get Index From List    ${full_list}    === CCCamera_vacuumCryoTelColdPlate2 start of topic ===
    ${vacuumCryoTelColdPlate2_end}=    Get Index From List    ${full_list}    === CCCamera_vacuumCryoTelColdPlate2 end of topic ===
    ${vacuumCryoTelColdPlate2_list}=    Get Slice From List    ${full_list}    start=${vacuumCryoTelColdPlate2_start}    end=${vacuumCryoTelColdPlate2_end}
    Should Contain X Times    ${vacuumCryoTelColdPlate2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cold2AutoOff : 1    10
    Should Contain X Times    ${vacuumCryoTelColdPlate2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cold2Pwr : 1    10
    Should Contain X Times    ${vacuumCryoTelColdPlate2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cold2RejectTemp : 1    10
    Should Contain X Times    ${vacuumCryoTelColdPlate2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cold2Temp : 1    10
    Should Contain X Times    ${vacuumCryoTelColdPlate2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cold2SetPt : 1    10
    Should Contain X Times    ${vacuumCryoTelColdPlate2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cold2SetPwr : 1    10
    Should Contain X Times    ${vacuumCryoTelColdPlate2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cold2AutoOffTemp : 1    10
    Should Contain X Times    ${vacuumCryoTelColdPlate2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cold2AutoOnTemp : 1    10
    ${vacuumCryoTelCryoPlate_start}=    Get Index From List    ${full_list}    === CCCamera_vacuumCryoTelCryoPlate start of topic ===
    ${vacuumCryoTelCryoPlate_end}=    Get Index From List    ${full_list}    === CCCamera_vacuumCryoTelCryoPlate end of topic ===
    ${vacuumCryoTelCryoPlate_list}=    Get Slice From List    ${full_list}    start=${vacuumCryoTelCryoPlate_start}    end=${vacuumCryoTelCryoPlate_end}
    Should Contain X Times    ${vacuumCryoTelCryoPlate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoAutoOff : 1    10
    Should Contain X Times    ${vacuumCryoTelCryoPlate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoPwr : 1    10
    Should Contain X Times    ${vacuumCryoTelCryoPlate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoRejectTemp : 1    10
    Should Contain X Times    ${vacuumCryoTelCryoPlate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemp : 1    10
    Should Contain X Times    ${vacuumCryoTelCryoPlate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoSetPt : 1    10
    Should Contain X Times    ${vacuumCryoTelCryoPlate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoSetPwr : 1    10
    Should Contain X Times    ${vacuumCryoTelCryoPlate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoAutoOffTemp : 1    10
    Should Contain X Times    ${vacuumCryoTelCryoPlate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoAutoOnTemp : 1    10
    ${vacuumPressureGauge_start}=    Get Index From List    ${full_list}    === CCCamera_vacuumPressureGauge start of topic ===
    ${vacuumPressureGauge_end}=    Get Index From List    ${full_list}    === CCCamera_vacuumPressureGauge end of topic ===
    ${vacuumPressureGauge_list}=    Get Slice From List    ${full_list}    start=${vacuumPressureGauge_start}    end=${vacuumPressureGauge_end}
    Should Contain X Times    ${vacuumPressureGauge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vqmpressure : 1    10
    ${bonnShutter_start}=    Get Index From List    ${full_list}    === CCCamera_bonnShutter start of topic ===
    ${bonnShutter_end}=    Get Index From List    ${full_list}    === CCCamera_bonnShutter end of topic ===
    ${bonnShutter_list}=    Get Slice From List    ${full_list}    start=${bonnShutter_start}    end=${bonnShutter_end}
    Should Contain X Times    ${bonnShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}shutter5V : 1    10
    Should Contain X Times    ${bonnShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}shutter36V : 1    10
    ${vacuumPowerDistributionUnit_start}=    Get Index From List    ${full_list}    === CCCamera_vacuumPowerDistributionUnit start of topic ===
    ${vacuumPowerDistributionUnit_end}=    Get Index From List    ${full_list}    === CCCamera_vacuumPowerDistributionUnit end of topic ===
    ${vacuumPowerDistributionUnit_list}=    Get Slice From List    ${full_list}    start=${vacuumPowerDistributionUnit_start}    end=${vacuumPowerDistributionUnit_end}
    Should Contain X Times    ${vacuumPowerDistributionUnit_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pDU20Current : 1    10
    Should Contain X Times    ${vacuumPowerDistributionUnit_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pDU20Power : 1    10
    Should Contain X Times    ${vacuumPowerDistributionUnit_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pDU15Current : 1    10
    Should Contain X Times    ${vacuumPowerDistributionUnit_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pDU15Power : 1    10
    ${vacuumStatus_start}=    Get Index From List    ${full_list}    === CCCamera_vacuumStatus start of topic ===
    ${vacuumStatus_end}=    Get Index From List    ${full_list}    === CCCamera_vacuumStatus end of topic ===
    ${vacuumStatus_list}=    Get Slice From List    ${full_list}    start=${vacuumStatus_start}    end=${vacuumStatus_end}
    Should Contain X Times    ${vacuumStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vQMState : 1    10
