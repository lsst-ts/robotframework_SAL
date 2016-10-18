*** Settings ***
Documentation    Camera_Cold communications tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    camera
${component}    Cold
${timeout}    30s

*** Test Cases ***
Create Publisher Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Publisher    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_${component}

Create Subscriber Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Subscriber    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_${component}

Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_sub

Start Subscriber
    [Tags]    functional
    Switch Connection    Subscriber
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}_${component}/cpp/standalone
    Comment    Start Subscriber.
    ${input}=    Write    ./sacpp_${subSystem}_sub
    ${output}=    Read Until    [Subscriber] Ready
    Log    ${output}
    Should Contain    ${output}    [Subscriber] Ready

Start Publisher
    [Tags]    functional
    Switch Connection    Publisher
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}_${component}/cpp/standalone
    Comment    Start Publisher.
    ${input}=    Write    ./sacpp_${subSystem}_pub
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    [putSample] ${subSystem}::${component} writing a message containing :    9
    Should Contain X Times    ${output}    revCode \ : LSST TEST REVCODE    9

Read Subscriber
    [Tags]    functional
    Switch Connection    Subscriber
    ${output}=    Read    delay=1s
    Log    ${output}
    Should Contain X Times    ${output}    Compressor_load : 1    1
    Should Contain X Times    ${output}    Compressor_load : 2    1
    Should Contain X Times    ${output}    Compressor_load : 3    1
    Should Contain X Times    ${output}    Compressor_load : 4    1
    Should Contain X Times    ${output}    Compressor_load : 5    1
    Should Contain X Times    ${output}    Compressor_load : 6    1
    Should Contain X Times    ${output}    Compressor_load : 7    1
    Should Contain X Times    ${output}    Compressor_load : 8    1
    Should Contain X Times    ${output}    Compressor_load : 9    1
    Should Contain X Times    ${output}    Compressor_speed : 1    1
    Should Contain X Times    ${output}    Compressor_speed : 2    1
    Should Contain X Times    ${output}    Compressor_speed : 3    1
    Should Contain X Times    ${output}    Compressor_speed : 4    1
    Should Contain X Times    ${output}    Compressor_speed : 5    1
    Should Contain X Times    ${output}    Compressor_speed : 6    1
    Should Contain X Times    ${output}    Compressor_speed : 7    1
    Should Contain X Times    ${output}    Compressor_speed : 8    1
    Should Contain X Times    ${output}    Compressor_speed : 9    1
    Should Contain X Times    ${output}    Discharge_pressure : 1    1
    Should Contain X Times    ${output}    Discharge_pressure : 2    1
    Should Contain X Times    ${output}    Discharge_pressure : 3    1
    Should Contain X Times    ${output}    Discharge_pressure : 4    1
    Should Contain X Times    ${output}    Discharge_pressure : 5    1
    Should Contain X Times    ${output}    Discharge_pressure : 6    1
    Should Contain X Times    ${output}    Discharge_pressure : 7    1
    Should Contain X Times    ${output}    Discharge_pressure : 8    1
    Should Contain X Times    ${output}    Discharge_pressure : 9    1
    Should Contain X Times    ${output}    Discharge_temp : 1    1
    Should Contain X Times    ${output}    Discharge_temp : 2    1
    Should Contain X Times    ${output}    Discharge_temp : 3    1
    Should Contain X Times    ${output}    Discharge_temp : 4    1
    Should Contain X Times    ${output}    Discharge_temp : 5    1
    Should Contain X Times    ${output}    Discharge_temp : 6    1
    Should Contain X Times    ${output}    Discharge_temp : 7    1
    Should Contain X Times    ${output}    Discharge_temp : 8    1
    Should Contain X Times    ${output}    Discharge_temp : 9    1
    Should Contain X Times    ${output}    Flow_interlock : 1    1
    Should Contain X Times    ${output}    Flow_interlock : 2    1
    Should Contain X Times    ${output}    Flow_interlock : 3    1
    Should Contain X Times    ${output}    Flow_interlock : 4    1
    Should Contain X Times    ${output}    Flow_interlock : 5    1
    Should Contain X Times    ${output}    Flow_interlock : 6    1
    Should Contain X Times    ${output}    Flow_interlock : 7    1
    Should Contain X Times    ${output}    Flow_interlock : 8    1
    Should Contain X Times    ${output}    Flow_interlock : 9    1
    Should Contain X Times    ${output}    Heater_current : 1    1
    Should Contain X Times    ${output}    Heater_current : 2    1
    Should Contain X Times    ${output}    Heater_current : 3    1
    Should Contain X Times    ${output}    Heater_current : 4    1
    Should Contain X Times    ${output}    Heater_current : 5    1
    Should Contain X Times    ${output}    Heater_current : 6    1
    Should Contain X Times    ${output}    Heater_current : 7    1
    Should Contain X Times    ${output}    Heater_current : 8    1
    Should Contain X Times    ${output}    Heater_current : 9    1
    Should Contain X Times    ${output}    Heater_voltage : 1    1
    Should Contain X Times    ${output}    Heater_voltage : 2    1
    Should Contain X Times    ${output}    Heater_voltage : 3    1
    Should Contain X Times    ${output}    Heater_voltage : 4    1
    Should Contain X Times    ${output}    Heater_voltage : 5    1
    Should Contain X Times    ${output}    Heater_voltage : 6    1
    Should Contain X Times    ${output}    Heater_voltage : 7    1
    Should Contain X Times    ${output}    Heater_voltage : 8    1
    Should Contain X Times    ${output}    Heater_voltage : 9    1
    Should Contain X Times    ${output}    Intake_flow : 1    1
    Should Contain X Times    ${output}    Intake_flow : 2    1
    Should Contain X Times    ${output}    Intake_flow : 3    1
    Should Contain X Times    ${output}    Intake_flow : 4    1
    Should Contain X Times    ${output}    Intake_flow : 5    1
    Should Contain X Times    ${output}    Intake_flow : 6    1
    Should Contain X Times    ${output}    Intake_flow : 7    1
    Should Contain X Times    ${output}    Intake_flow : 8    1
    Should Contain X Times    ${output}    Intake_flow : 9    1
    Should Contain X Times    ${output}    Intake_pressure : 1    1
    Should Contain X Times    ${output}    Intake_pressure : 2    1
    Should Contain X Times    ${output}    Intake_pressure : 3    1
    Should Contain X Times    ${output}    Intake_pressure : 4    1
    Should Contain X Times    ${output}    Intake_pressure : 5    1
    Should Contain X Times    ${output}    Intake_pressure : 6    1
    Should Contain X Times    ${output}    Intake_pressure : 7    1
    Should Contain X Times    ${output}    Intake_pressure : 8    1
    Should Contain X Times    ${output}    Intake_pressure : 9    1
    Should Contain X Times    ${output}    Intake_temp : 1    1
    Should Contain X Times    ${output}    Intake_temp : 2    1
    Should Contain X Times    ${output}    Intake_temp : 3    1
    Should Contain X Times    ${output}    Intake_temp : 4    1
    Should Contain X Times    ${output}    Intake_temp : 5    1
    Should Contain X Times    ${output}    Intake_temp : 6    1
    Should Contain X Times    ${output}    Intake_temp : 7    1
    Should Contain X Times    ${output}    Intake_temp : 8    1
    Should Contain X Times    ${output}    Intake_temp : 9    1
    Should Contain X Times    ${output}    Ion_pump : 1    1
    Should Contain X Times    ${output}    Ion_pump : 2    1
    Should Contain X Times    ${output}    Ion_pump : 3    1
    Should Contain X Times    ${output}    Ion_pump : 4    1
    Should Contain X Times    ${output}    Ion_pump : 5    1
    Should Contain X Times    ${output}    Ion_pump : 6    1
    Should Contain X Times    ${output}    Ion_pump : 7    1
    Should Contain X Times    ${output}    Ion_pump : 8    1
    Should Contain X Times    ${output}    Ion_pump : 9    1
    Should Contain X Times    ${output}    Mech_pump : 1    1
    Should Contain X Times    ${output}    Mech_pump : 2    1
    Should Contain X Times    ${output}    Mech_pump : 3    1
    Should Contain X Times    ${output}    Mech_pump : 4    1
    Should Contain X Times    ${output}    Mech_pump : 5    1
    Should Contain X Times    ${output}    Mech_pump : 6    1
    Should Contain X Times    ${output}    Mech_pump : 7    1
    Should Contain X Times    ${output}    Mech_pump : 8    1
    Should Contain X Times    ${output}    Mech_pump : 9    1
    Should Contain X Times    ${output}    Post_expansion_pressure : 1    1
    Should Contain X Times    ${output}    Post_expansion_pressure : 2    1
    Should Contain X Times    ${output}    Post_expansion_pressure : 3    1
    Should Contain X Times    ${output}    Post_expansion_pressure : 4    1
    Should Contain X Times    ${output}    Post_expansion_pressure : 5    1
    Should Contain X Times    ${output}    Post_expansion_pressure : 6    1
    Should Contain X Times    ${output}    Post_expansion_pressure : 7    1
    Should Contain X Times    ${output}    Post_expansion_pressure : 8    1
    Should Contain X Times    ${output}    Post_expansion_pressure : 9    1
    Should Contain X Times    ${output}    Post_expansion_temp : 1    1
    Should Contain X Times    ${output}    Post_expansion_temp : 2    1
    Should Contain X Times    ${output}    Post_expansion_temp : 3    1
    Should Contain X Times    ${output}    Post_expansion_temp : 4    1
    Should Contain X Times    ${output}    Post_expansion_temp : 5    1
    Should Contain X Times    ${output}    Post_expansion_temp : 6    1
    Should Contain X Times    ${output}    Post_expansion_temp : 7    1
    Should Contain X Times    ${output}    Post_expansion_temp : 8    1
    Should Contain X Times    ${output}    Post_expansion_temp : 9    1
    Should Contain X Times    ${output}    Pre_expansion_pressure : 1    1
    Should Contain X Times    ${output}    Pre_expansion_pressure : 2    1
    Should Contain X Times    ${output}    Pre_expansion_pressure : 3    1
    Should Contain X Times    ${output}    Pre_expansion_pressure : 4    1
    Should Contain X Times    ${output}    Pre_expansion_pressure : 5    1
    Should Contain X Times    ${output}    Pre_expansion_pressure : 6    1
    Should Contain X Times    ${output}    Pre_expansion_pressure : 7    1
    Should Contain X Times    ${output}    Pre_expansion_pressure : 8    1
    Should Contain X Times    ${output}    Pre_expansion_pressure : 9    1
    Should Contain X Times    ${output}    Pre_expansion_temp : 1    1
    Should Contain X Times    ${output}    Pre_expansion_temp : 2    1
    Should Contain X Times    ${output}    Pre_expansion_temp : 3    1
    Should Contain X Times    ${output}    Pre_expansion_temp : 4    1
    Should Contain X Times    ${output}    Pre_expansion_temp : 5    1
    Should Contain X Times    ${output}    Pre_expansion_temp : 6    1
    Should Contain X Times    ${output}    Pre_expansion_temp : 7    1
    Should Contain X Times    ${output}    Pre_expansion_temp : 8    1
    Should Contain X Times    ${output}    Pre_expansion_temp : 9    1
    Should Contain X Times    ${output}    RGA : 1    1
    Should Contain X Times    ${output}    RGA : 2    1
    Should Contain X Times    ${output}    RGA : 3    1
    Should Contain X Times    ${output}    RGA : 4    1
    Should Contain X Times    ${output}    RGA : 5    1
    Should Contain X Times    ${output}    RGA : 6    1
    Should Contain X Times    ${output}    RGA : 7    1
    Should Contain X Times    ${output}    RGA : 8    1
    Should Contain X Times    ${output}    RGA : 9    1
    Should Contain X Times    ${output}    Return_temp : 1    1
    Should Contain X Times    ${output}    Return_temp : 2    1
    Should Contain X Times    ${output}    Return_temp : 3    1
    Should Contain X Times    ${output}    Return_temp : 4    1
    Should Contain X Times    ${output}    Return_temp : 5    1
    Should Contain X Times    ${output}    Return_temp : 6    1
    Should Contain X Times    ${output}    Return_temp : 7    1
    Should Contain X Times    ${output}    Return_temp : 8    1
    Should Contain X Times    ${output}    Return_temp : 9    1
    Should Contain X Times    ${output}    UtilityRoom_temperature : 1    9
    Should Contain X Times    ${output}    Vacuum_gauge : 1    1
    Should Contain X Times    ${output}    Vacuum_gauge : 2    1
    Should Contain X Times    ${output}    Vacuum_gauge : 3    1
    Should Contain X Times    ${output}    Vacuum_gauge : 4    1
    Should Contain X Times    ${output}    Vacuum_gauge : 5    1
    Should Contain X Times    ${output}    Vacuum_gauge : 6    1
    Should Contain X Times    ${output}    Vacuum_gauge : 7    1
    Should Contain X Times    ${output}    Vacuum_gauge : 8    1
    Should Contain X Times    ${output}    Vacuum_gauge : 9    1
    Should Contain X Times    ${output}    Valve_status : 1    1
    Should Contain X Times    ${output}    Valve_status : 2    1
    Should Contain X Times    ${output}    Valve_status : 3    1
    Should Contain X Times    ${output}    Valve_status : 4    1
    Should Contain X Times    ${output}    Valve_status : 5    1
    Should Contain X Times    ${output}    Valve_status : 6    1
    Should Contain X Times    ${output}    Valve_status : 7    1
    Should Contain X Times    ${output}    Valve_status : 8    1
    Should Contain X Times    ${output}    Valve_status : 9    1
