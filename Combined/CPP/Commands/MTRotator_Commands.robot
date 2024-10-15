*** Settings ***
Documentation    MTRotator_Commands communications tests.
Force Tags    messaging    cpp    mtrotator    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}common.robot
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTRotator
${component}    all
${timeout}    180s

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
    [Tags]    functional    commander    robot:continue-on-failure
    Comment    Start Commander.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_commander
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    1/1 brokers are down
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Comment    ======= Verify ${subSystem}_configureAcceleration test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${configureAcceleration_start}=    Get Index From List    ${full_list}    === MTRotator_configureAcceleration start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_configureAcceleration command*
    ${configureAcceleration_end}=    Get Index From List    ${full_list}    ${line}
    ${configureAcceleration_list}=    Get Slice From List    ${full_list}    start=${configureAcceleration_start}    end=${configureAcceleration_end+3}
    Log    ${configureAcceleration_list}
    Should Contain X Times    ${configureAcceleration_list}    === ${subSystem}_configureAcceleration start of topic ===    1
    Should Contain X Times    ${configureAcceleration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}alimit : 1    1
    Should Contain    ${configureAcceleration_list}    === issueCommand_configureAcceleration writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${configureAcceleration_list}[-2]    Command roundtrip was
    Should Be Equal    ${configureAcceleration_list}[-1]    303
    Should Contain    ${configureAcceleration_list}    === ${subSystem}_configureAcceleration end of topic ===
    Comment    ======= Verify ${subSystem}_configureVelocity test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${configureVelocity_start}=    Get Index From List    ${full_list}    === MTRotator_configureVelocity start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_configureVelocity command*
    ${configureVelocity_end}=    Get Index From List    ${full_list}    ${line}
    ${configureVelocity_list}=    Get Slice From List    ${full_list}    start=${configureVelocity_start}    end=${configureVelocity_end+3}
    Log    ${configureVelocity_list}
    Should Contain X Times    ${configureVelocity_list}    === ${subSystem}_configureVelocity start of topic ===    1
    Should Contain X Times    ${configureVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vlimit : 1    1
    Should Contain    ${configureVelocity_list}    === issueCommand_configureVelocity writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${configureVelocity_list}[-2]    Command roundtrip was
    Should Be Equal    ${configureVelocity_list}[-1]    303
    Should Contain    ${configureVelocity_list}    === ${subSystem}_configureVelocity end of topic ===
    Comment    ======= Verify ${subSystem}_configureJerk test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${configureJerk_start}=    Get Index From List    ${full_list}    === MTRotator_configureJerk start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_configureJerk command*
    ${configureJerk_end}=    Get Index From List    ${full_list}    ${line}
    ${configureJerk_list}=    Get Slice From List    ${full_list}    start=${configureJerk_start}    end=${configureJerk_end+3}
    Log    ${configureJerk_list}
    Should Contain X Times    ${configureJerk_list}    === ${subSystem}_configureJerk start of topic ===    1
    Should Contain X Times    ${configureJerk_list}    ${SPACE}${SPACE}${SPACE}${SPACE}jlimit : 1    1
    Should Contain    ${configureJerk_list}    === issueCommand_configureJerk writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${configureJerk_list}[-2]    Command roundtrip was
    Should Be Equal    ${configureJerk_list}[-1]    303
    Should Contain    ${configureJerk_list}    === ${subSystem}_configureJerk end of topic ===
    Comment    ======= Verify ${subSystem}_configureEmergencyAcceleration test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${configureEmergencyAcceleration_start}=    Get Index From List    ${full_list}    === MTRotator_configureEmergencyAcceleration start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_configureEmergencyAcceleration command*
    ${configureEmergencyAcceleration_end}=    Get Index From List    ${full_list}    ${line}
    ${configureEmergencyAcceleration_list}=    Get Slice From List    ${full_list}    start=${configureEmergencyAcceleration_start}    end=${configureEmergencyAcceleration_end+3}
    Log    ${configureEmergencyAcceleration_list}
    Should Contain X Times    ${configureEmergencyAcceleration_list}    === ${subSystem}_configureEmergencyAcceleration start of topic ===    1
    Should Contain X Times    ${configureEmergencyAcceleration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}alimit : 1    1
    Should Contain    ${configureEmergencyAcceleration_list}    === issueCommand_configureEmergencyAcceleration writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${configureEmergencyAcceleration_list}[-2]    Command roundtrip was
    Should Be Equal    ${configureEmergencyAcceleration_list}[-1]    303
    Should Contain    ${configureEmergencyAcceleration_list}    === ${subSystem}_configureEmergencyAcceleration end of topic ===
    Comment    ======= Verify ${subSystem}_configureEmergencyJerk test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${configureEmergencyJerk_start}=    Get Index From List    ${full_list}    === MTRotator_configureEmergencyJerk start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_configureEmergencyJerk command*
    ${configureEmergencyJerk_end}=    Get Index From List    ${full_list}    ${line}
    ${configureEmergencyJerk_list}=    Get Slice From List    ${full_list}    start=${configureEmergencyJerk_start}    end=${configureEmergencyJerk_end+3}
    Log    ${configureEmergencyJerk_list}
    Should Contain X Times    ${configureEmergencyJerk_list}    === ${subSystem}_configureEmergencyJerk start of topic ===    1
    Should Contain X Times    ${configureEmergencyJerk_list}    ${SPACE}${SPACE}${SPACE}${SPACE}jlimit : 1    1
    Should Contain    ${configureEmergencyJerk_list}    === issueCommand_configureEmergencyJerk writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${configureEmergencyJerk_list}[-2]    Command roundtrip was
    Should Be Equal    ${configureEmergencyJerk_list}[-1]    303
    Should Contain    ${configureEmergencyJerk_list}    === ${subSystem}_configureEmergencyJerk end of topic ===
    Comment    ======= Verify ${subSystem}_fault test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${fault_start}=    Get Index From List    ${full_list}    === MTRotator_fault start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_fault command*
    ${fault_end}=    Get Index From List    ${full_list}    ${line}
    ${fault_list}=    Get Slice From List    ${full_list}    start=${fault_start}    end=${fault_end+3}
    Log    ${fault_list}
    Should Contain X Times    ${fault_list}    === ${subSystem}_fault start of topic ===    1
    Should Contain    ${fault_list}    === issueCommand_fault writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${fault_list}[-2]    Command roundtrip was
    Should Be Equal    ${fault_list}[-1]    303
    Should Contain    ${fault_list}    === ${subSystem}_fault end of topic ===
    Comment    ======= Verify ${subSystem}_move test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${move_start}=    Get Index From List    ${full_list}    === MTRotator_move start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_move command*
    ${move_end}=    Get Index From List    ${full_list}    ${line}
    ${move_list}=    Get Slice From List    ${full_list}    start=${move_start}    end=${move_end+3}
    Log    ${move_list}
    Should Contain X Times    ${move_list}    === ${subSystem}_move start of topic ===    1
    Should Contain X Times    ${move_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 1    1
    Should Contain    ${move_list}    === issueCommand_move writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${move_list}[-2]    Command roundtrip was
    Should Be Equal    ${move_list}[-1]    303
    Should Contain    ${move_list}    === ${subSystem}_move end of topic ===
    Comment    ======= Verify ${subSystem}_track test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${track_start}=    Get Index From List    ${full_list}    === MTRotator_track start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_track command*
    ${track_end}=    Get Index From List    ${full_list}    ${line}
    ${track_list}=    Get Slice From List    ${full_list}    start=${track_start}    end=${track_end+3}
    Log    ${track_list}
    Should Contain X Times    ${track_list}    === ${subSystem}_track start of topic ===    1
    Should Contain X Times    ${track_list}    ${SPACE}${SPACE}${SPACE}${SPACE}angle : 1    1
    Should Contain X Times    ${track_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocity : 1    1
    Should Contain X Times    ${track_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tai : 1    1
    Should Contain    ${track_list}    === issueCommand_track writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${track_list}[-2]    Command roundtrip was
    Should Be Equal    ${track_list}[-1]    303
    Should Contain    ${track_list}    === ${subSystem}_track end of topic ===
    Comment    ======= Verify ${subSystem}_trackStart test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${trackStart_start}=    Get Index From List    ${full_list}    === MTRotator_trackStart start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_trackStart command*
    ${trackStart_end}=    Get Index From List    ${full_list}    ${line}
    ${trackStart_list}=    Get Slice From List    ${full_list}    start=${trackStart_start}    end=${trackStart_end+3}
    Log    ${trackStart_list}
    Should Contain X Times    ${trackStart_list}    === ${subSystem}_trackStart start of topic ===    1
    Should Contain    ${trackStart_list}    === issueCommand_trackStart writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${trackStart_list}[-2]    Command roundtrip was
    Should Be Equal    ${trackStart_list}[-1]    303
    Should Contain    ${trackStart_list}    === ${subSystem}_trackStart end of topic ===
    Comment    ======= Verify ${subSystem}_stop test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${stop_start}=    Get Index From List    ${full_list}    === MTRotator_stop start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_stop command*
    ${stop_end}=    Get Index From List    ${full_list}    ${line}
    ${stop_list}=    Get Slice From List    ${full_list}    start=${stop_start}    end=${stop_end+3}
    Log    ${stop_list}
    Should Contain X Times    ${stop_list}    === ${subSystem}_stop start of topic ===    1
    Should Contain    ${stop_list}    === issueCommand_stop writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${stop_list}[-2]    Command roundtrip was
    Should Be Equal    ${stop_list}[-1]    303
    Should Contain    ${stop_list}    === ${subSystem}_stop end of topic ===
    Comment    ======= Verify ${subSystem}_disable test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${disable_start}=    Get Index From List    ${full_list}    === MTRotator_disable start of topic ===
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
    ${enable_start}=    Get Index From List    ${full_list}    === MTRotator_enable start of topic ===
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
    ${exitControl_start}=    Get Index From List    ${full_list}    === MTRotator_exitControl start of topic ===
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
    ${setLogLevel_start}=    Get Index From List    ${full_list}    === MTRotator_setLogLevel start of topic ===
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
    ${standby_start}=    Get Index From List    ${full_list}    === MTRotator_standby start of topic ===
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
    ${start_start}=    Get Index From List    ${full_list}    === MTRotator_start start of topic ===
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
    [Tags]    functional    controller    robot:continue-on-failure
    Switch Process    ${subSystem}_Controller
    ${output}=    Wait For Process    handle=${subSystem}_Controller    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    1/1 brokers are down
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    ==== ${subSystem} all controllers ready ====
    ${configureAcceleration_start}=    Get Index From List    ${full_list}    === MTRotator_configureAcceleration start of topic ===
    ${configureAcceleration_end}=    Get Index From List    ${full_list}    === MTRotator_configureAcceleration end of topic ===
    ${configureAcceleration_list}=    Get Slice From List    ${full_list}    start=${configureAcceleration_start}    end=${configureAcceleration_end+1}
    Log    ${configureAcceleration_list}
    Should Contain X Times    ${configureAcceleration_list}    === ${subSystem}_configureAcceleration start of topic ===    1
    Should Contain X Times    ${configureAcceleration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}alimit : 1    1
    Should Contain X Times    ${configureAcceleration_list}    === ackCommand_configureAcceleration acknowledging a command with :    2
    Should Contain X Times    ${configureAcceleration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${configureAcceleration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${configureAcceleration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${configureAcceleration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${configureAcceleration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${configureAcceleration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${configureAcceleration_list}    === ${subSystem}_configureAcceleration end of topic ===    1
    ${configureVelocity_start}=    Get Index From List    ${full_list}    === MTRotator_configureVelocity start of topic ===
    ${configureVelocity_end}=    Get Index From List    ${full_list}    === MTRotator_configureVelocity end of topic ===
    ${configureVelocity_list}=    Get Slice From List    ${full_list}    start=${configureVelocity_start}    end=${configureVelocity_end+1}
    Log    ${configureVelocity_list}
    Should Contain X Times    ${configureVelocity_list}    === ${subSystem}_configureVelocity start of topic ===    1
    Should Contain X Times    ${configureVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vlimit : 1    1
    Should Contain X Times    ${configureVelocity_list}    === ackCommand_configureVelocity acknowledging a command with :    2
    Should Contain X Times    ${configureVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${configureVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${configureVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${configureVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${configureVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${configureVelocity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${configureVelocity_list}    === ${subSystem}_configureVelocity end of topic ===    1
    ${configureJerk_start}=    Get Index From List    ${full_list}    === MTRotator_configureJerk start of topic ===
    ${configureJerk_end}=    Get Index From List    ${full_list}    === MTRotator_configureJerk end of topic ===
    ${configureJerk_list}=    Get Slice From List    ${full_list}    start=${configureJerk_start}    end=${configureJerk_end+1}
    Log    ${configureJerk_list}
    Should Contain X Times    ${configureJerk_list}    === ${subSystem}_configureJerk start of topic ===    1
    Should Contain X Times    ${configureJerk_list}    ${SPACE}${SPACE}${SPACE}${SPACE}jlimit : 1    1
    Should Contain X Times    ${configureJerk_list}    === ackCommand_configureJerk acknowledging a command with :    2
    Should Contain X Times    ${configureJerk_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${configureJerk_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${configureJerk_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${configureJerk_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${configureJerk_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${configureJerk_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${configureJerk_list}    === ${subSystem}_configureJerk end of topic ===    1
    ${configureEmergencyAcceleration_start}=    Get Index From List    ${full_list}    === MTRotator_configureEmergencyAcceleration start of topic ===
    ${configureEmergencyAcceleration_end}=    Get Index From List    ${full_list}    === MTRotator_configureEmergencyAcceleration end of topic ===
    ${configureEmergencyAcceleration_list}=    Get Slice From List    ${full_list}    start=${configureEmergencyAcceleration_start}    end=${configureEmergencyAcceleration_end+1}
    Log    ${configureEmergencyAcceleration_list}
    Should Contain X Times    ${configureEmergencyAcceleration_list}    === ${subSystem}_configureEmergencyAcceleration start of topic ===    1
    Should Contain X Times    ${configureEmergencyAcceleration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}alimit : 1    1
    Should Contain X Times    ${configureEmergencyAcceleration_list}    === ackCommand_configureEmergencyAcceleration acknowledging a command with :    2
    Should Contain X Times    ${configureEmergencyAcceleration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${configureEmergencyAcceleration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${configureEmergencyAcceleration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${configureEmergencyAcceleration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${configureEmergencyAcceleration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${configureEmergencyAcceleration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${configureEmergencyAcceleration_list}    === ${subSystem}_configureEmergencyAcceleration end of topic ===    1
    ${configureEmergencyJerk_start}=    Get Index From List    ${full_list}    === MTRotator_configureEmergencyJerk start of topic ===
    ${configureEmergencyJerk_end}=    Get Index From List    ${full_list}    === MTRotator_configureEmergencyJerk end of topic ===
    ${configureEmergencyJerk_list}=    Get Slice From List    ${full_list}    start=${configureEmergencyJerk_start}    end=${configureEmergencyJerk_end+1}
    Log    ${configureEmergencyJerk_list}
    Should Contain X Times    ${configureEmergencyJerk_list}    === ${subSystem}_configureEmergencyJerk start of topic ===    1
    Should Contain X Times    ${configureEmergencyJerk_list}    ${SPACE}${SPACE}${SPACE}${SPACE}jlimit : 1    1
    Should Contain X Times    ${configureEmergencyJerk_list}    === ackCommand_configureEmergencyJerk acknowledging a command with :    2
    Should Contain X Times    ${configureEmergencyJerk_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${configureEmergencyJerk_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${configureEmergencyJerk_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${configureEmergencyJerk_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${configureEmergencyJerk_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${configureEmergencyJerk_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${configureEmergencyJerk_list}    === ${subSystem}_configureEmergencyJerk end of topic ===    1
    ${fault_start}=    Get Index From List    ${full_list}    === MTRotator_fault start of topic ===
    ${fault_end}=    Get Index From List    ${full_list}    === MTRotator_fault end of topic ===
    ${fault_list}=    Get Slice From List    ${full_list}    start=${fault_start}    end=${fault_end+1}
    Log    ${fault_list}
    Should Contain X Times    ${fault_list}    === ${subSystem}_fault start of topic ===    1
    Should Contain X Times    ${fault_list}    === ackCommand_fault acknowledging a command with :    2
    Should Contain X Times    ${fault_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${fault_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${fault_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${fault_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${fault_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${fault_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${fault_list}    === ${subSystem}_fault end of topic ===    1
    ${move_start}=    Get Index From List    ${full_list}    === MTRotator_move start of topic ===
    ${move_end}=    Get Index From List    ${full_list}    === MTRotator_move end of topic ===
    ${move_list}=    Get Slice From List    ${full_list}    start=${move_start}    end=${move_end+1}
    Log    ${move_list}
    Should Contain X Times    ${move_list}    === ${subSystem}_move start of topic ===    1
    Should Contain X Times    ${move_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 1    1
    Should Contain X Times    ${move_list}    === ackCommand_move acknowledging a command with :    2
    Should Contain X Times    ${move_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${move_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${move_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${move_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${move_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${move_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${move_list}    === ${subSystem}_move end of topic ===    1
    ${track_start}=    Get Index From List    ${full_list}    === MTRotator_track start of topic ===
    ${track_end}=    Get Index From List    ${full_list}    === MTRotator_track end of topic ===
    ${track_list}=    Get Slice From List    ${full_list}    start=${track_start}    end=${track_end+1}
    Log    ${track_list}
    Should Contain X Times    ${track_list}    === ${subSystem}_track start of topic ===    1
    Should Contain X Times    ${track_list}    ${SPACE}${SPACE}${SPACE}${SPACE}angle : 1    1
    Should Contain X Times    ${track_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocity : 1    1
    Should Contain X Times    ${track_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tai : 1    1
    Should Contain X Times    ${track_list}    === ackCommand_track acknowledging a command with :    2
    Should Contain X Times    ${track_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${track_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${track_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${track_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${track_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${track_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${track_list}    === ${subSystem}_track end of topic ===    1
    ${trackStart_start}=    Get Index From List    ${full_list}    === MTRotator_trackStart start of topic ===
    ${trackStart_end}=    Get Index From List    ${full_list}    === MTRotator_trackStart end of topic ===
    ${trackStart_list}=    Get Slice From List    ${full_list}    start=${trackStart_start}    end=${trackStart_end+1}
    Log    ${trackStart_list}
    Should Contain X Times    ${trackStart_list}    === ${subSystem}_trackStart start of topic ===    1
    Should Contain X Times    ${trackStart_list}    === ackCommand_trackStart acknowledging a command with :    2
    Should Contain X Times    ${trackStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${trackStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${trackStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${trackStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${trackStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${trackStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${trackStart_list}    === ${subSystem}_trackStart end of topic ===    1
    ${stop_start}=    Get Index From List    ${full_list}    === MTRotator_stop start of topic ===
    ${stop_end}=    Get Index From List    ${full_list}    === MTRotator_stop end of topic ===
    ${stop_list}=    Get Slice From List    ${full_list}    start=${stop_start}    end=${stop_end+1}
    Log    ${stop_list}
    Should Contain X Times    ${stop_list}    === ${subSystem}_stop start of topic ===    1
    Should Contain X Times    ${stop_list}    === ackCommand_stop acknowledging a command with :    2
    Should Contain X Times    ${stop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${stop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${stop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${stop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${stop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${stop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${stop_list}    === ${subSystem}_stop end of topic ===    1
    ${disable_start}=    Get Index From List    ${full_list}    === MTRotator_disable start of topic ===
    ${disable_end}=    Get Index From List    ${full_list}    === MTRotator_disable end of topic ===
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
    ${enable_start}=    Get Index From List    ${full_list}    === MTRotator_enable start of topic ===
    ${enable_end}=    Get Index From List    ${full_list}    === MTRotator_enable end of topic ===
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
    ${exitControl_start}=    Get Index From List    ${full_list}    === MTRotator_exitControl start of topic ===
    ${exitControl_end}=    Get Index From List    ${full_list}    === MTRotator_exitControl end of topic ===
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
    ${setLogLevel_start}=    Get Index From List    ${full_list}    === MTRotator_setLogLevel start of topic ===
    ${setLogLevel_end}=    Get Index From List    ${full_list}    === MTRotator_setLogLevel end of topic ===
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
    ${standby_start}=    Get Index From List    ${full_list}    === MTRotator_standby start of topic ===
    ${standby_end}=    Get Index From List    ${full_list}    === MTRotator_standby end of topic ===
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
    ${start_start}=    Get Index From List    ${full_list}    === MTRotator_start start of topic ===
    ${start_end}=    Get Index From List    ${full_list}    === MTRotator_start end of topic ===
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
