*** Settings ***
Documentation    MTM1M3TS_Commands communications tests.
Force Tags    messaging    cpp    mtm1m3ts    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}common.robot
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTM1M3TS
${component}    all
${timeout}    300s

*** Test Cases ***
Verify Component Commander and Controller
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_controller

Start Controller
    [Tags]    functional    controller
    Comment    Start Controller.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_controller    alias=${subSystem}_Controller     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Be Equal    ${output.returncode}   ${NONE}
    Wait Until Keyword Succeeds    90s    5s    File Should Contain    ${EXECDIR}${/}stdout.txt    === ${subSystem} all controllers ready
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Log    ${output}

Start Commander
    [Tags]    functional    commander    DM-49462    robot:continue-on-failure
    Comment    Start Commander.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_commander
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    1/1 brokers are down
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Comment    ======= Verify ${subSystem}_setEngineeringMode test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${setEngineeringMode_start}=    Get Index From List    ${full_list}    === MTM1M3TS_setEngineeringMode start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_setEngineeringMode command*
    ${setEngineeringMode_end}=    Get Index From List    ${full_list}    ${line}
    ${setEngineeringMode_list}=    Get Slice From List    ${full_list}    start=${setEngineeringMode_start}    end=${setEngineeringMode_end+3}
    Log    ${setEngineeringMode_list}
    Should Contain X Times    ${setEngineeringMode_list}    === ${subSystem}_setEngineeringMode start of topic ===    1
    Should Contain X Times    ${setEngineeringMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enableEngineeringMode : 1    1
    Should Contain    ${setEngineeringMode_list}    === issueCommand_setEngineeringMode writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${setEngineeringMode_list}[-2]    Command roundtrip was
    Should Be Equal    ${setEngineeringMode_list}[-1]    303
    Should Contain    ${setEngineeringMode_list}    === ${subSystem}_setEngineeringMode end of topic ===
    Comment    ======= Verify ${subSystem}_applySetpoint test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${applySetpoint_start}=    Get Index From List    ${full_list}    === MTM1M3TS_applySetpoint start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_applySetpoint command*
    ${applySetpoint_end}=    Get Index From List    ${full_list}    ${line}
    ${applySetpoint_list}=    Get Slice From List    ${full_list}    start=${applySetpoint_start}    end=${applySetpoint_end+3}
    Log    ${applySetpoint_list}
    Should Contain X Times    ${applySetpoint_list}    === ${subSystem}_applySetpoint start of topic ===    1
    Should Contain X Times    ${applySetpoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolSetpoint : 1    1
    Should Contain X Times    ${applySetpoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heatersSetpoint : 1    1
    Should Contain    ${applySetpoint_list}    === issueCommand_applySetpoint writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${applySetpoint_list}[-2]    Command roundtrip was
    Should Be Equal    ${applySetpoint_list}[-1]    303
    Should Contain    ${applySetpoint_list}    === ${subSystem}_applySetpoint end of topic ===
    Comment    ======= Verify ${subSystem}_heaterFanDemand test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${heaterFanDemand_start}=    Get Index From List    ${full_list}    === MTM1M3TS_heaterFanDemand start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_heaterFanDemand command*
    ${heaterFanDemand_end}=    Get Index From List    ${full_list}    ${line}
    ${heaterFanDemand_list}=    Get Slice From List    ${full_list}    start=${heaterFanDemand_start}    end=${heaterFanDemand_end+3}
    Log    ${heaterFanDemand_list}
    Should Contain X Times    ${heaterFanDemand_list}    === ${subSystem}_heaterFanDemand start of topic ===    1
    Should Contain X Times    ${heaterFanDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterPWM : 0    1
    Should Contain X Times    ${heaterFanDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanRPM : 0    1
    Should Contain    ${heaterFanDemand_list}    === issueCommand_heaterFanDemand writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${heaterFanDemand_list}[-2]    Command roundtrip was
    Should Be Equal    ${heaterFanDemand_list}[-1]    303
    Should Contain    ${heaterFanDemand_list}    === ${subSystem}_heaterFanDemand end of topic ===
    Comment    ======= Verify ${subSystem}_fanCoilsHeatersPower test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${fanCoilsHeatersPower_start}=    Get Index From List    ${full_list}    === MTM1M3TS_fanCoilsHeatersPower start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_fanCoilsHeatersPower command*
    ${fanCoilsHeatersPower_end}=    Get Index From List    ${full_list}    ${line}
    ${fanCoilsHeatersPower_list}=    Get Slice From List    ${full_list}    start=${fanCoilsHeatersPower_start}    end=${fanCoilsHeatersPower_end+3}
    Log    ${fanCoilsHeatersPower_list}
    Should Contain X Times    ${fanCoilsHeatersPower_list}    === ${subSystem}_fanCoilsHeatersPower start of topic ===    1
    Should Contain X Times    ${fanCoilsHeatersPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 1    1
    Should Contain    ${fanCoilsHeatersPower_list}    === issueCommand_fanCoilsHeatersPower writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${fanCoilsHeatersPower_list}[-2]    Command roundtrip was
    Should Be Equal    ${fanCoilsHeatersPower_list}[-1]    303
    Should Contain    ${fanCoilsHeatersPower_list}    === ${subSystem}_fanCoilsHeatersPower end of topic ===
    Comment    ======= Verify ${subSystem}_coolantPumpPower test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${coolantPumpPower_start}=    Get Index From List    ${full_list}    === MTM1M3TS_coolantPumpPower start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_coolantPumpPower command*
    ${coolantPumpPower_end}=    Get Index From List    ${full_list}    ${line}
    ${coolantPumpPower_list}=    Get Slice From List    ${full_list}    start=${coolantPumpPower_start}    end=${coolantPumpPower_end+3}
    Log    ${coolantPumpPower_list}
    Should Contain X Times    ${coolantPumpPower_list}    === ${subSystem}_coolantPumpPower start of topic ===    1
    Should Contain X Times    ${coolantPumpPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 1    1
    Should Contain    ${coolantPumpPower_list}    === issueCommand_coolantPumpPower writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${coolantPumpPower_list}[-2]    Command roundtrip was
    Should Be Equal    ${coolantPumpPower_list}[-1]    303
    Should Contain    ${coolantPumpPower_list}    === ${subSystem}_coolantPumpPower end of topic ===
    Comment    ======= Verify ${subSystem}_setMixingValve test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${setMixingValve_start}=    Get Index From List    ${full_list}    === MTM1M3TS_setMixingValve start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_setMixingValve command*
    ${setMixingValve_end}=    Get Index From List    ${full_list}    ${line}
    ${setMixingValve_list}=    Get Slice From List    ${full_list}    start=${setMixingValve_start}    end=${setMixingValve_end+3}
    Log    ${setMixingValve_list}
    Should Contain X Times    ${setMixingValve_list}    === ${subSystem}_setMixingValve start of topic ===    1
    Should Contain X Times    ${setMixingValve_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mixingValveTarget : 1    1
    Should Contain    ${setMixingValve_list}    === issueCommand_setMixingValve writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${setMixingValve_list}[-2]    Command roundtrip was
    Should Be Equal    ${setMixingValve_list}[-1]    303
    Should Contain    ${setMixingValve_list}    === ${subSystem}_setMixingValve end of topic ===
    Comment    ======= Verify ${subSystem}_coolantPumpStart test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${coolantPumpStart_start}=    Get Index From List    ${full_list}    === MTM1M3TS_coolantPumpStart start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_coolantPumpStart command*
    ${coolantPumpStart_end}=    Get Index From List    ${full_list}    ${line}
    ${coolantPumpStart_list}=    Get Slice From List    ${full_list}    start=${coolantPumpStart_start}    end=${coolantPumpStart_end+3}
    Log    ${coolantPumpStart_list}
    Should Contain X Times    ${coolantPumpStart_list}    === ${subSystem}_coolantPumpStart start of topic ===    1
    Should Contain    ${coolantPumpStart_list}    === issueCommand_coolantPumpStart writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${coolantPumpStart_list}[-2]    Command roundtrip was
    Should Be Equal    ${coolantPumpStart_list}[-1]    303
    Should Contain    ${coolantPumpStart_list}    === ${subSystem}_coolantPumpStart end of topic ===
    Comment    ======= Verify ${subSystem}_coolantPumpStop test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${coolantPumpStop_start}=    Get Index From List    ${full_list}    === MTM1M3TS_coolantPumpStop start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_coolantPumpStop command*
    ${coolantPumpStop_end}=    Get Index From List    ${full_list}    ${line}
    ${coolantPumpStop_list}=    Get Slice From List    ${full_list}    start=${coolantPumpStop_start}    end=${coolantPumpStop_end+3}
    Log    ${coolantPumpStop_list}
    Should Contain X Times    ${coolantPumpStop_list}    === ${subSystem}_coolantPumpStop start of topic ===    1
    Should Contain    ${coolantPumpStop_list}    === issueCommand_coolantPumpStop writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${coolantPumpStop_list}[-2]    Command roundtrip was
    Should Be Equal    ${coolantPumpStop_list}[-1]    303
    Should Contain    ${coolantPumpStop_list}    === ${subSystem}_coolantPumpStop end of topic ===
    Comment    ======= Verify ${subSystem}_coolantPumpFrequency test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${coolantPumpFrequency_start}=    Get Index From List    ${full_list}    === MTM1M3TS_coolantPumpFrequency start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_coolantPumpFrequency command*
    ${coolantPumpFrequency_end}=    Get Index From List    ${full_list}    ${line}
    ${coolantPumpFrequency_list}=    Get Slice From List    ${full_list}    start=${coolantPumpFrequency_start}    end=${coolantPumpFrequency_end+3}
    Log    ${coolantPumpFrequency_list}
    Should Contain X Times    ${coolantPumpFrequency_list}    === ${subSystem}_coolantPumpFrequency start of topic ===    1
    Should Contain X Times    ${coolantPumpFrequency_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetFrequency : 1    1
    Should Contain    ${coolantPumpFrequency_list}    === issueCommand_coolantPumpFrequency writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${coolantPumpFrequency_list}[-2]    Command roundtrip was
    Should Be Equal    ${coolantPumpFrequency_list}[-1]    303
    Should Contain    ${coolantPumpFrequency_list}    === ${subSystem}_coolantPumpFrequency end of topic ===
    Comment    ======= Verify ${subSystem}_coolantPumpReset test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${coolantPumpReset_start}=    Get Index From List    ${full_list}    === MTM1M3TS_coolantPumpReset start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_coolantPumpReset command*
    ${coolantPumpReset_end}=    Get Index From List    ${full_list}    ${line}
    ${coolantPumpReset_list}=    Get Slice From List    ${full_list}    start=${coolantPumpReset_start}    end=${coolantPumpReset_end+3}
    Log    ${coolantPumpReset_list}
    Should Contain X Times    ${coolantPumpReset_list}    === ${subSystem}_coolantPumpReset start of topic ===    1
    Should Contain    ${coolantPumpReset_list}    === issueCommand_coolantPumpReset writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${coolantPumpReset_list}[-2]    Command roundtrip was
    Should Be Equal    ${coolantPumpReset_list}[-1]    303
    Should Contain    ${coolantPumpReset_list}    === ${subSystem}_coolantPumpReset end of topic ===
    Comment    ======= Verify ${subSystem}_disable test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${disable_start}=    Get Index From List    ${full_list}    === MTM1M3TS_disable start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_disable command*
    ${disable_end}=    Get Index From List    ${full_list}    ${line}
    ${disable_list}=    Get Slice From List    ${full_list}    start=${disable_start}    end=${disable_end+3}
    Log    ${disable_list}
    Should Contain X Times    ${disable_list}    === ${subSystem}_disable start of topic ===    1
    Should Contain    ${disable_list}    === issueCommand_disable writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${disable_list}[-2]    Command roundtrip was
    Should Be Equal    ${disable_list}[-1]    303
    Should Contain    ${disable_list}    === ${subSystem}_disable end of topic ===
    Comment    ======= Verify ${subSystem}_enable test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${enable_start}=    Get Index From List    ${full_list}    === MTM1M3TS_enable start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_enable command*
    ${enable_end}=    Get Index From List    ${full_list}    ${line}
    ${enable_list}=    Get Slice From List    ${full_list}    start=${enable_start}    end=${enable_end+3}
    Log    ${enable_list}
    Should Contain X Times    ${enable_list}    === ${subSystem}_enable start of topic ===    1
    Should Contain    ${enable_list}    === issueCommand_enable writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${enable_list}[-2]    Command roundtrip was
    Should Be Equal    ${enable_list}[-1]    303
    Should Contain    ${enable_list}    === ${subSystem}_enable end of topic ===
    Comment    ======= Verify ${subSystem}_exitControl test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${exitControl_start}=    Get Index From List    ${full_list}    === MTM1M3TS_exitControl start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_exitControl command*
    ${exitControl_end}=    Get Index From List    ${full_list}    ${line}
    ${exitControl_list}=    Get Slice From List    ${full_list}    start=${exitControl_start}    end=${exitControl_end+3}
    Log    ${exitControl_list}
    Should Contain X Times    ${exitControl_list}    === ${subSystem}_exitControl start of topic ===    1
    Should Contain    ${exitControl_list}    === issueCommand_exitControl writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${exitControl_list}[-2]    Command roundtrip was
    Should Be Equal    ${exitControl_list}[-1]    303
    Should Contain    ${exitControl_list}    === ${subSystem}_exitControl end of topic ===
    Comment    ======= Verify ${subSystem}_setLogLevel test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${setLogLevel_start}=    Get Index From List    ${full_list}    === MTM1M3TS_setLogLevel start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_setLogLevel command*
    ${setLogLevel_end}=    Get Index From List    ${full_list}    ${line}
    ${setLogLevel_list}=    Get Slice From List    ${full_list}    start=${setLogLevel_start}    end=${setLogLevel_end+3}
    Log    ${setLogLevel_list}
    Should Contain X Times    ${setLogLevel_list}    === ${subSystem}_setLogLevel start of topic ===    1
    Should Contain    ${setLogLevel_list}    === issueCommand_setLogLevel writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${setLogLevel_list}[-2]    Command roundtrip was
    Should Be Equal    ${setLogLevel_list}[-1]    303
    Should Contain    ${setLogLevel_list}    === ${subSystem}_setLogLevel end of topic ===
    Comment    ======= Verify ${subSystem}_standby test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${standby_start}=    Get Index From List    ${full_list}    === MTM1M3TS_standby start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_standby command*
    ${standby_end}=    Get Index From List    ${full_list}    ${line}
    ${standby_list}=    Get Slice From List    ${full_list}    start=${standby_start}    end=${standby_end+3}
    Log    ${standby_list}
    Should Contain X Times    ${standby_list}    === ${subSystem}_standby start of topic ===    1
    Should Contain    ${standby_list}    === issueCommand_standby writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${standby_list}[-2]    Command roundtrip was
    Should Be Equal    ${standby_list}[-1]    303
    Should Contain    ${standby_list}    === ${subSystem}_standby end of topic ===
    Comment    ======= Verify ${subSystem}_start test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${start_start}=    Get Index From List    ${full_list}    === MTM1M3TS_start start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_start command*
    ${start_end}=    Get Index From List    ${full_list}    ${line}
    ${start_list}=    Get Slice From List    ${full_list}    start=${start_start}    end=${start_end+3}
    Log    ${start_list}
    Should Contain X Times    ${start_list}    === ${subSystem}_start start of topic ===    1
    Should Contain    ${start_list}    === issueCommand_start writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${start_list}[-2]    Command roundtrip was
    Should Be Equal    ${start_list}[-1]    303
    Should Contain    ${start_list}    === ${subSystem}_start end of topic ===

Read Controller
    [Tags]    functional    controller    DM-49462    robot:continue-on-failure
    Switch Process    ${subSystem}_Controller
    ${output}=    Wait For Process    handle=${subSystem}_Controller    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    1/1 brokers are down
    Should Not Contain    ${output.stderr}    Consume failed
    Should Not Contain    ${output.stderr}    Broker: Unknown topic or partition
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    ==== ${subSystem} all controllers ready ====
    ${setEngineeringMode_start}=    Get Index From List    ${full_list}    === MTM1M3TS_setEngineeringMode start of topic ===
    ${setEngineeringMode_end}=    Get Index From List    ${full_list}    === MTM1M3TS_setEngineeringMode end of topic ===
    ${setEngineeringMode_list}=    Get Slice From List    ${full_list}    start=${setEngineeringMode_start}    end=${setEngineeringMode_end+1}
    Log    ${setEngineeringMode_list}
    Should Contain X Times    ${setEngineeringMode_list}    === ${subSystem}_setEngineeringMode start of topic ===    1
    Should Contain X Times    ${setEngineeringMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enableEngineeringMode : 1    1
    Should Contain X Times    ${setEngineeringMode_list}    === ackCommand_setEngineeringMode acknowledging a command with :    2
    Should Contain X Times    ${setEngineeringMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${setEngineeringMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${setEngineeringMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${setEngineeringMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${setEngineeringMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${setEngineeringMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${setEngineeringMode_list}    === ${subSystem}_setEngineeringMode end of topic ===    1
    ${applySetpoint_start}=    Get Index From List    ${full_list}    === MTM1M3TS_applySetpoint start of topic ===
    ${applySetpoint_end}=    Get Index From List    ${full_list}    === MTM1M3TS_applySetpoint end of topic ===
    ${applySetpoint_list}=    Get Slice From List    ${full_list}    start=${applySetpoint_start}    end=${applySetpoint_end+1}
    Log    ${applySetpoint_list}
    Should Contain X Times    ${applySetpoint_list}    === ${subSystem}_applySetpoint start of topic ===    1
    Should Contain X Times    ${applySetpoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}glycolSetpoint : 1    1
    Should Contain X Times    ${applySetpoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heatersSetpoint : 1    1
    Should Contain X Times    ${applySetpoint_list}    === ackCommand_applySetpoint acknowledging a command with :    2
    Should Contain X Times    ${applySetpoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${applySetpoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${applySetpoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${applySetpoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${applySetpoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${applySetpoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${applySetpoint_list}    === ${subSystem}_applySetpoint end of topic ===    1
    ${heaterFanDemand_start}=    Get Index From List    ${full_list}    === MTM1M3TS_heaterFanDemand start of topic ===
    ${heaterFanDemand_end}=    Get Index From List    ${full_list}    === MTM1M3TS_heaterFanDemand end of topic ===
    ${heaterFanDemand_list}=    Get Slice From List    ${full_list}    start=${heaterFanDemand_start}    end=${heaterFanDemand_end+1}
    Log    ${heaterFanDemand_list}
    Should Contain X Times    ${heaterFanDemand_list}    === ${subSystem}_heaterFanDemand start of topic ===    1
    Should Contain X Times    ${heaterFanDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterPWM : 0    1
    Should Contain X Times    ${heaterFanDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanRPM : 0    1
    Should Contain X Times    ${heaterFanDemand_list}    === ackCommand_heaterFanDemand acknowledging a command with :    2
    Should Contain X Times    ${heaterFanDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${heaterFanDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${heaterFanDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${heaterFanDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${heaterFanDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${heaterFanDemand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${heaterFanDemand_list}    === ${subSystem}_heaterFanDemand end of topic ===    1
    ${fanCoilsHeatersPower_start}=    Get Index From List    ${full_list}    === MTM1M3TS_fanCoilsHeatersPower start of topic ===
    ${fanCoilsHeatersPower_end}=    Get Index From List    ${full_list}    === MTM1M3TS_fanCoilsHeatersPower end of topic ===
    ${fanCoilsHeatersPower_list}=    Get Slice From List    ${full_list}    start=${fanCoilsHeatersPower_start}    end=${fanCoilsHeatersPower_end+1}
    Log    ${fanCoilsHeatersPower_list}
    Should Contain X Times    ${fanCoilsHeatersPower_list}    === ${subSystem}_fanCoilsHeatersPower start of topic ===    1
    Should Contain X Times    ${fanCoilsHeatersPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 1    1
    Should Contain X Times    ${fanCoilsHeatersPower_list}    === ackCommand_fanCoilsHeatersPower acknowledging a command with :    2
    Should Contain X Times    ${fanCoilsHeatersPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${fanCoilsHeatersPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${fanCoilsHeatersPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${fanCoilsHeatersPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${fanCoilsHeatersPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${fanCoilsHeatersPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${fanCoilsHeatersPower_list}    === ${subSystem}_fanCoilsHeatersPower end of topic ===    1
    ${coolantPumpPower_start}=    Get Index From List    ${full_list}    === MTM1M3TS_coolantPumpPower start of topic ===
    ${coolantPumpPower_end}=    Get Index From List    ${full_list}    === MTM1M3TS_coolantPumpPower end of topic ===
    ${coolantPumpPower_list}=    Get Slice From List    ${full_list}    start=${coolantPumpPower_start}    end=${coolantPumpPower_end+1}
    Log    ${coolantPumpPower_list}
    Should Contain X Times    ${coolantPumpPower_list}    === ${subSystem}_coolantPumpPower start of topic ===    1
    Should Contain X Times    ${coolantPumpPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 1    1
    Should Contain X Times    ${coolantPumpPower_list}    === ackCommand_coolantPumpPower acknowledging a command with :    2
    Should Contain X Times    ${coolantPumpPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${coolantPumpPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${coolantPumpPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${coolantPumpPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${coolantPumpPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${coolantPumpPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${coolantPumpPower_list}    === ${subSystem}_coolantPumpPower end of topic ===    1
    ${setMixingValve_start}=    Get Index From List    ${full_list}    === MTM1M3TS_setMixingValve start of topic ===
    ${setMixingValve_end}=    Get Index From List    ${full_list}    === MTM1M3TS_setMixingValve end of topic ===
    ${setMixingValve_list}=    Get Slice From List    ${full_list}    start=${setMixingValve_start}    end=${setMixingValve_end+1}
    Log    ${setMixingValve_list}
    Should Contain X Times    ${setMixingValve_list}    === ${subSystem}_setMixingValve start of topic ===    1
    Should Contain X Times    ${setMixingValve_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mixingValveTarget : 1    1
    Should Contain X Times    ${setMixingValve_list}    === ackCommand_setMixingValve acknowledging a command with :    2
    Should Contain X Times    ${setMixingValve_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${setMixingValve_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${setMixingValve_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${setMixingValve_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${setMixingValve_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${setMixingValve_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${setMixingValve_list}    === ${subSystem}_setMixingValve end of topic ===    1
    ${coolantPumpStart_start}=    Get Index From List    ${full_list}    === MTM1M3TS_coolantPumpStart start of topic ===
    ${coolantPumpStart_end}=    Get Index From List    ${full_list}    === MTM1M3TS_coolantPumpStart end of topic ===
    ${coolantPumpStart_list}=    Get Slice From List    ${full_list}    start=${coolantPumpStart_start}    end=${coolantPumpStart_end+1}
    Log    ${coolantPumpStart_list}
    Should Contain X Times    ${coolantPumpStart_list}    === ${subSystem}_coolantPumpStart start of topic ===    1
    Should Contain X Times    ${coolantPumpStart_list}    === ackCommand_coolantPumpStart acknowledging a command with :    2
    Should Contain X Times    ${coolantPumpStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${coolantPumpStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${coolantPumpStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${coolantPumpStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${coolantPumpStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${coolantPumpStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${coolantPumpStart_list}    === ${subSystem}_coolantPumpStart end of topic ===    1
    ${coolantPumpStop_start}=    Get Index From List    ${full_list}    === MTM1M3TS_coolantPumpStop start of topic ===
    ${coolantPumpStop_end}=    Get Index From List    ${full_list}    === MTM1M3TS_coolantPumpStop end of topic ===
    ${coolantPumpStop_list}=    Get Slice From List    ${full_list}    start=${coolantPumpStop_start}    end=${coolantPumpStop_end+1}
    Log    ${coolantPumpStop_list}
    Should Contain X Times    ${coolantPumpStop_list}    === ${subSystem}_coolantPumpStop start of topic ===    1
    Should Contain X Times    ${coolantPumpStop_list}    === ackCommand_coolantPumpStop acknowledging a command with :    2
    Should Contain X Times    ${coolantPumpStop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${coolantPumpStop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${coolantPumpStop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${coolantPumpStop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${coolantPumpStop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${coolantPumpStop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${coolantPumpStop_list}    === ${subSystem}_coolantPumpStop end of topic ===    1
    ${coolantPumpFrequency_start}=    Get Index From List    ${full_list}    === MTM1M3TS_coolantPumpFrequency start of topic ===
    ${coolantPumpFrequency_end}=    Get Index From List    ${full_list}    === MTM1M3TS_coolantPumpFrequency end of topic ===
    ${coolantPumpFrequency_list}=    Get Slice From List    ${full_list}    start=${coolantPumpFrequency_start}    end=${coolantPumpFrequency_end+1}
    Log    ${coolantPumpFrequency_list}
    Should Contain X Times    ${coolantPumpFrequency_list}    === ${subSystem}_coolantPumpFrequency start of topic ===    1
    Should Contain X Times    ${coolantPumpFrequency_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetFrequency : 1    1
    Should Contain X Times    ${coolantPumpFrequency_list}    === ackCommand_coolantPumpFrequency acknowledging a command with :    2
    Should Contain X Times    ${coolantPumpFrequency_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${coolantPumpFrequency_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${coolantPumpFrequency_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${coolantPumpFrequency_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${coolantPumpFrequency_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${coolantPumpFrequency_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${coolantPumpFrequency_list}    === ${subSystem}_coolantPumpFrequency end of topic ===    1
    ${coolantPumpReset_start}=    Get Index From List    ${full_list}    === MTM1M3TS_coolantPumpReset start of topic ===
    ${coolantPumpReset_end}=    Get Index From List    ${full_list}    === MTM1M3TS_coolantPumpReset end of topic ===
    ${coolantPumpReset_list}=    Get Slice From List    ${full_list}    start=${coolantPumpReset_start}    end=${coolantPumpReset_end+1}
    Log    ${coolantPumpReset_list}
    Should Contain X Times    ${coolantPumpReset_list}    === ${subSystem}_coolantPumpReset start of topic ===    1
    Should Contain X Times    ${coolantPumpReset_list}    === ackCommand_coolantPumpReset acknowledging a command with :    2
    Should Contain X Times    ${coolantPumpReset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${coolantPumpReset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${coolantPumpReset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${coolantPumpReset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${coolantPumpReset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${coolantPumpReset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${coolantPumpReset_list}    === ${subSystem}_coolantPumpReset end of topic ===    1
    ${disable_start}=    Get Index From List    ${full_list}    === MTM1M3TS_disable start of topic ===
    ${disable_end}=    Get Index From List    ${full_list}    === MTM1M3TS_disable end of topic ===
    ${disable_list}=    Get Slice From List    ${full_list}    start=${disable_start}    end=${disable_end+1}
    Log    ${disable_list}
    Should Contain X Times    ${disable_list}    === ${subSystem}_disable start of topic ===    1
    Should Contain X Times    ${disable_list}    === ackCommand_disable acknowledging a command with :    2
    Should Contain X Times    ${disable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${disable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${disable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${disable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${disable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${disable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${disable_list}    === ${subSystem}_disable end of topic ===    1
    ${enable_start}=    Get Index From List    ${full_list}    === MTM1M3TS_enable start of topic ===
    ${enable_end}=    Get Index From List    ${full_list}    === MTM1M3TS_enable end of topic ===
    ${enable_list}=    Get Slice From List    ${full_list}    start=${enable_start}    end=${enable_end+1}
    Log    ${enable_list}
    Should Contain X Times    ${enable_list}    === ${subSystem}_enable start of topic ===    1
    Should Contain X Times    ${enable_list}    === ackCommand_enable acknowledging a command with :    2
    Should Contain X Times    ${enable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${enable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${enable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${enable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${enable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${enable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${enable_list}    === ${subSystem}_enable end of topic ===    1
    ${exitControl_start}=    Get Index From List    ${full_list}    === MTM1M3TS_exitControl start of topic ===
    ${exitControl_end}=    Get Index From List    ${full_list}    === MTM1M3TS_exitControl end of topic ===
    ${exitControl_list}=    Get Slice From List    ${full_list}    start=${exitControl_start}    end=${exitControl_end+1}
    Log    ${exitControl_list}
    Should Contain X Times    ${exitControl_list}    === ${subSystem}_exitControl start of topic ===    1
    Should Contain X Times    ${exitControl_list}    === ackCommand_exitControl acknowledging a command with :    2
    Should Contain X Times    ${exitControl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${exitControl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${exitControl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${exitControl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${exitControl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${exitControl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${exitControl_list}    === ${subSystem}_exitControl end of topic ===    1
    ${setLogLevel_start}=    Get Index From List    ${full_list}    === MTM1M3TS_setLogLevel start of topic ===
    ${setLogLevel_end}=    Get Index From List    ${full_list}    === MTM1M3TS_setLogLevel end of topic ===
    ${setLogLevel_list}=    Get Slice From List    ${full_list}    start=${setLogLevel_start}    end=${setLogLevel_end+1}
    Log    ${setLogLevel_list}
    Should Contain X Times    ${setLogLevel_list}    === ${subSystem}_setLogLevel start of topic ===    1
    Should Contain X Times    ${setLogLevel_list}    === ackCommand_setLogLevel acknowledging a command with :    2
    Should Contain X Times    ${setLogLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${setLogLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${setLogLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${setLogLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${setLogLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${setLogLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${setLogLevel_list}    === ${subSystem}_setLogLevel end of topic ===    1
    ${standby_start}=    Get Index From List    ${full_list}    === MTM1M3TS_standby start of topic ===
    ${standby_end}=    Get Index From List    ${full_list}    === MTM1M3TS_standby end of topic ===
    ${standby_list}=    Get Slice From List    ${full_list}    start=${standby_start}    end=${standby_end+1}
    Log    ${standby_list}
    Should Contain X Times    ${standby_list}    === ${subSystem}_standby start of topic ===    1
    Should Contain X Times    ${standby_list}    === ackCommand_standby acknowledging a command with :    2
    Should Contain X Times    ${standby_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${standby_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${standby_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${standby_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${standby_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${standby_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${standby_list}    === ${subSystem}_standby end of topic ===    1
    ${start_start}=    Get Index From List    ${full_list}    === MTM1M3TS_start start of topic ===
    ${start_end}=    Get Index From List    ${full_list}    === MTM1M3TS_start end of topic ===
    ${start_list}=    Get Slice From List    ${full_list}    start=${start_start}    end=${start_end+1}
    Log    ${start_list}
    Should Contain X Times    ${start_list}    === ${subSystem}_start start of topic ===    1
    Should Contain X Times    ${start_list}    === ackCommand_start acknowledging a command with :    2
    Should Contain X Times    ${start_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${start_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${start_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${start_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${start_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${start_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${start_list}    === ${subSystem}_start end of topic ===    1
