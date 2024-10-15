*** Settings ***
Documentation    Guider_Commands communications tests.
Force Tags    messaging    cpp    guider    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}common.robot
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Guider
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
    Comment    ======= Verify ${subSystem}_startGuiding test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${startGuiding_start}=    Get Index From List    ${full_list}    === Guider_startGuiding start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_startGuiding command*
    ${startGuiding_end}=    Get Index From List    ${full_list}    ${line}
    ${startGuiding_list}=    Get Slice From List    ${full_list}    start=${startGuiding_start}    end=${startGuiding_end+3}
    Log    ${startGuiding_list}
    Should Contain X Times    ${startGuiding_list}    === ${subSystem}_startGuiding start of topic ===    1
    Should Contain X Times    ${startGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}roiXLeft : 0    1
    Should Contain X Times    ${startGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}roiXRight : 0    1
    Should Contain X Times    ${startGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}roiYBottom : 0    1
    Should Contain X Times    ${startGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}roiYTop : 0    1
    Should Contain X Times    ${startGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}expTime : 1    1
    Should Contain X Times    ${startGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}binning : 1    1
    Should Contain    ${startGuiding_list}    === issueCommand_startGuiding writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${startGuiding_list}[-2]    Command roundtrip was
    Should Be Equal    ${startGuiding_list}[-1]    303
    Should Contain    ${startGuiding_list}    === ${subSystem}_startGuiding end of topic ===
    Comment    ======= Verify ${subSystem}_stopGuiding test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${stopGuiding_start}=    Get Index From List    ${full_list}    === Guider_stopGuiding start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_stopGuiding command*
    ${stopGuiding_end}=    Get Index From List    ${full_list}    ${line}
    ${stopGuiding_list}=    Get Slice From List    ${full_list}    start=${stopGuiding_start}    end=${stopGuiding_end+3}
    Log    ${stopGuiding_list}
    Should Contain X Times    ${stopGuiding_list}    === ${subSystem}_stopGuiding start of topic ===    1
    Should Contain    ${stopGuiding_list}    === issueCommand_stopGuiding writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${stopGuiding_list}[-2]    Command roundtrip was
    Should Be Equal    ${stopGuiding_list}[-1]    303
    Should Contain    ${stopGuiding_list}    === ${subSystem}_stopGuiding end of topic ===
    Comment    ======= Verify ${subSystem}_resumeGuiding test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${resumeGuiding_start}=    Get Index From List    ${full_list}    === Guider_resumeGuiding start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_resumeGuiding command*
    ${resumeGuiding_end}=    Get Index From List    ${full_list}    ${line}
    ${resumeGuiding_list}=    Get Slice From List    ${full_list}    start=${resumeGuiding_start}    end=${resumeGuiding_end+3}
    Log    ${resumeGuiding_list}
    Should Contain X Times    ${resumeGuiding_list}    === ${subSystem}_resumeGuiding start of topic ===    1
    Should Contain    ${resumeGuiding_list}    === issueCommand_resumeGuiding writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${resumeGuiding_list}[-2]    Command roundtrip was
    Should Be Equal    ${resumeGuiding_list}[-1]    303
    Should Contain    ${resumeGuiding_list}    === ${subSystem}_resumeGuiding end of topic ===
    Comment    ======= Verify ${subSystem}_disable test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${disable_start}=    Get Index From List    ${full_list}    === Guider_disable start of topic ===
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
    ${enable_start}=    Get Index From List    ${full_list}    === Guider_enable start of topic ===
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
    ${exitControl_start}=    Get Index From List    ${full_list}    === Guider_exitControl start of topic ===
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
    ${setLogLevel_start}=    Get Index From List    ${full_list}    === Guider_setLogLevel start of topic ===
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
    ${standby_start}=    Get Index From List    ${full_list}    === Guider_standby start of topic ===
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
    ${start_start}=    Get Index From List    ${full_list}    === Guider_start start of topic ===
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
    ${startGuiding_start}=    Get Index From List    ${full_list}    === Guider_startGuiding start of topic ===
    ${startGuiding_end}=    Get Index From List    ${full_list}    === Guider_startGuiding end of topic ===
    ${startGuiding_list}=    Get Slice From List    ${full_list}    start=${startGuiding_start}    end=${startGuiding_end+1}
    Log    ${startGuiding_list}
    Should Contain X Times    ${startGuiding_list}    === ${subSystem}_startGuiding start of topic ===    1
    Should Contain X Times    ${startGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}roiXLeft : 0    1
    Should Contain X Times    ${startGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}roiXRight : 0    1
    Should Contain X Times    ${startGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}roiYBottom : 0    1
    Should Contain X Times    ${startGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}roiYTop : 0    1
    Should Contain X Times    ${startGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}expTime : 1    1
    Should Contain X Times    ${startGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}binning : 1    1
    Should Contain X Times    ${startGuiding_list}    === ackCommand_startGuiding acknowledging a command with :    2
    Should Contain X Times    ${startGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${startGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${startGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${startGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${startGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${startGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${startGuiding_list}    === ${subSystem}_startGuiding end of topic ===    1
    ${stopGuiding_start}=    Get Index From List    ${full_list}    === Guider_stopGuiding start of topic ===
    ${stopGuiding_end}=    Get Index From List    ${full_list}    === Guider_stopGuiding end of topic ===
    ${stopGuiding_list}=    Get Slice From List    ${full_list}    start=${stopGuiding_start}    end=${stopGuiding_end+1}
    Log    ${stopGuiding_list}
    Should Contain X Times    ${stopGuiding_list}    === ${subSystem}_stopGuiding start of topic ===    1
    Should Contain X Times    ${stopGuiding_list}    === ackCommand_stopGuiding acknowledging a command with :    2
    Should Contain X Times    ${stopGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${stopGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${stopGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${stopGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${stopGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${stopGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${stopGuiding_list}    === ${subSystem}_stopGuiding end of topic ===    1
    ${resumeGuiding_start}=    Get Index From List    ${full_list}    === Guider_resumeGuiding start of topic ===
    ${resumeGuiding_end}=    Get Index From List    ${full_list}    === Guider_resumeGuiding end of topic ===
    ${resumeGuiding_list}=    Get Slice From List    ${full_list}    start=${resumeGuiding_start}    end=${resumeGuiding_end+1}
    Log    ${resumeGuiding_list}
    Should Contain X Times    ${resumeGuiding_list}    === ${subSystem}_resumeGuiding start of topic ===    1
    Should Contain X Times    ${resumeGuiding_list}    === ackCommand_resumeGuiding acknowledging a command with :    2
    Should Contain X Times    ${resumeGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${resumeGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${resumeGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${resumeGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${resumeGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${resumeGuiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${resumeGuiding_list}    === ${subSystem}_resumeGuiding end of topic ===    1
    ${disable_start}=    Get Index From List    ${full_list}    === Guider_disable start of topic ===
    ${disable_end}=    Get Index From List    ${full_list}    === Guider_disable end of topic ===
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
    ${enable_start}=    Get Index From List    ${full_list}    === Guider_enable start of topic ===
    ${enable_end}=    Get Index From List    ${full_list}    === Guider_enable end of topic ===
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
    ${exitControl_start}=    Get Index From List    ${full_list}    === Guider_exitControl start of topic ===
    ${exitControl_end}=    Get Index From List    ${full_list}    === Guider_exitControl end of topic ===
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
    ${setLogLevel_start}=    Get Index From List    ${full_list}    === Guider_setLogLevel start of topic ===
    ${setLogLevel_end}=    Get Index From List    ${full_list}    === Guider_setLogLevel end of topic ===
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
    ${standby_start}=    Get Index From List    ${full_list}    === Guider_standby start of topic ===
    ${standby_end}=    Get Index From List    ${full_list}    === Guider_standby end of topic ===
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
    ${start_start}=    Get Index From List    ${full_list}    === Guider_start start of topic ===
    ${start_end}=    Get Index From List    ${full_list}    === Guider_start end of topic ===
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
