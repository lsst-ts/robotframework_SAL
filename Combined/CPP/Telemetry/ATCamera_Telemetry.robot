*** Settings ***
Documentation    ATCamera Telemetry communications tests.
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
    Should Contain    ${output}    ===== ATCamera subscribers ready =====
    Sleep    6s

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_heartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATCamera_heartbeat start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::heartbeat_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATCamera_heartbeat end of topic ===
    Comment    ======= Verify ${subSystem}_wreb test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_wreb
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATCamera_wreb start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::wreb_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATCamera_wreb end of topic ===
    Comment    ======= Verify ${subSystem}_bonnShutter test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_bonnShutter
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATCamera_bonnShutter start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::bonnShutter_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATCamera_bonnShutter end of topic ===
    Comment    ======= Verify ${subSystem}_wrebPower test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_wrebPower
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATCamera_wrebPower start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::wrebPower_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATCamera_wrebPower end of topic ===
    Comment    ======= Verify ${subSystem}_vacuum test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuum
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === ATCamera_vacuum start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuum_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATCamera_vacuum end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ATCamera subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${heartbeat_start}=    Get Index From List    ${full_list}    === ATCamera_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === ATCamera_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end}
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeat : 1    10
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    10
    ${wreb_start}=    Get Index From List    ${full_list}    === ATCamera_wreb start of topic ===
    ${wreb_end}=    Get Index From List    ${full_list}    === ATCamera_wreb end of topic ===
    ${wreb_list}=    Get Slice From List    ${full_list}    start=${wreb_start}    end=${wreb_end}
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ckPSH_V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ckPOV : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ogoV : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}atemp0U : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}atemp0L : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdTemp0 : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digPS_V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digPS_I : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaPS_V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaPS_I : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHPS_V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHPS_I : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}odPS_V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}odPS_I : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPS_V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPS_I : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sckU_V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sckL_V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rgU_V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rgL_V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cks0V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rg0V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od0V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rd0V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gd0V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od0I : 1    10
    ${bonnShutter_start}=    Get Index From List    ${full_list}    === ATCamera_bonnShutter start of topic ===
    ${bonnShutter_end}=    Get Index From List    ${full_list}    === ATCamera_bonnShutter end of topic ===
    ${bonnShutter_list}=    Get Slice From List    ${full_list}    start=${bonnShutter_start}    end=${bonnShutter_end}
    Should Contain X Times    ${bonnShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}shutter5V : 1    10
    Should Contain X Times    ${bonnShutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}shutter36V : 1    10
    ${wrebPower_start}=    Get Index From List    ${full_list}    === ATCamera_wrebPower start of topic ===
    ${wrebPower_end}=    Get Index From List    ${full_list}    === ATCamera_wrebPower end of topic ===
    ${wrebPower_list}=    Get Slice From List    ${full_list}    start=${wrebPower_start}    end=${wrebPower_end}
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
    ${vacuum_start}=    Get Index From List    ${full_list}    === ATCamera_vacuum start of topic ===
    ${vacuum_end}=    Get Index From List    ${full_list}    === ATCamera_vacuum end of topic ===
    ${vacuum_list}=    Get Slice From List    ${full_list}    start=${vacuum_start}    end=${vacuum_end}
    Should Contain X Times    ${vacuum_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tempCCD : 1    10
    Should Contain X Times    ${vacuum_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tempColdPlate : 1    10
    Should Contain X Times    ${vacuum_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tempCryoHead : 1    10
    Should Contain X Times    ${vacuum_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuum : 1    10
    Should Contain X Times    ${vacuum_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tempCCDSetPoint : 1    10
