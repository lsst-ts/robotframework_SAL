*** Settings ***
Documentation    MTM1M3_Commands communications tests.
Force Tags    messaging    cpp    mtm1m3    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}common.robot
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTM1M3
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
    Comment    ======= Verify ${subSystem}_panic test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${panic_start}=    Get Index From List    ${full_list}    === MTM1M3_panic start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_panic command*
    ${panic_end}=    Get Index From List    ${full_list}    ${line}
    ${panic_list}=    Get Slice From List    ${full_list}    start=${panic_start}    end=${panic_end+3}
    Log    ${panic_list}
    Should Contain X Times    ${panic_list}    === ${subSystem}_panic start of topic ===    1
    Should Contain    ${panic_list}    === issueCommand_panic writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${panic_list}[-2]    Command roundtrip was
    Should Be Equal    ${panic_list}[-1]    303
    Should Contain    ${panic_list}    === ${subSystem}_panic end of topic ===
    Comment    ======= Verify ${subSystem}_setSlewFlag test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${setSlewFlag_start}=    Get Index From List    ${full_list}    === MTM1M3_setSlewFlag start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_setSlewFlag command*
    ${setSlewFlag_end}=    Get Index From List    ${full_list}    ${line}
    ${setSlewFlag_list}=    Get Slice From List    ${full_list}    start=${setSlewFlag_start}    end=${setSlewFlag_end+3}
    Log    ${setSlewFlag_list}
    Should Contain X Times    ${setSlewFlag_list}    === ${subSystem}_setSlewFlag start of topic ===    1
    Should Contain    ${setSlewFlag_list}    === issueCommand_setSlewFlag writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${setSlewFlag_list}[-2]    Command roundtrip was
    Should Be Equal    ${setSlewFlag_list}[-1]    303
    Should Contain    ${setSlewFlag_list}    === ${subSystem}_setSlewFlag end of topic ===
    Comment    ======= Verify ${subSystem}_clearSlewFlag test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${clearSlewFlag_start}=    Get Index From List    ${full_list}    === MTM1M3_clearSlewFlag start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_clearSlewFlag command*
    ${clearSlewFlag_end}=    Get Index From List    ${full_list}    ${line}
    ${clearSlewFlag_list}=    Get Slice From List    ${full_list}    start=${clearSlewFlag_start}    end=${clearSlewFlag_end+3}
    Log    ${clearSlewFlag_list}
    Should Contain X Times    ${clearSlewFlag_list}    === ${subSystem}_clearSlewFlag start of topic ===    1
    Should Contain    ${clearSlewFlag_list}    === issueCommand_clearSlewFlag writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${clearSlewFlag_list}[-2]    Command roundtrip was
    Should Be Equal    ${clearSlewFlag_list}[-1]    303
    Should Contain    ${clearSlewFlag_list}    === ${subSystem}_clearSlewFlag end of topic ===
    Comment    ======= Verify ${subSystem}_raiseM1M3 test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${raiseM1M3_start}=    Get Index From List    ${full_list}    === MTM1M3_raiseM1M3 start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_raiseM1M3 command*
    ${raiseM1M3_end}=    Get Index From List    ${full_list}    ${line}
    ${raiseM1M3_list}=    Get Slice From List    ${full_list}    start=${raiseM1M3_start}    end=${raiseM1M3_end+3}
    Log    ${raiseM1M3_list}
    Should Contain X Times    ${raiseM1M3_list}    === ${subSystem}_raiseM1M3 start of topic ===    1
    Should Contain X Times    ${raiseM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bypassReferencePosition : 1    1
    Should Contain    ${raiseM1M3_list}    === issueCommand_raiseM1M3 writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${raiseM1M3_list}[-2]    Command roundtrip was
    Should Be Equal    ${raiseM1M3_list}[-1]    303
    Should Contain    ${raiseM1M3_list}    === ${subSystem}_raiseM1M3 end of topic ===
    Comment    ======= Verify ${subSystem}_abortRaiseM1M3 test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${abortRaiseM1M3_start}=    Get Index From List    ${full_list}    === MTM1M3_abortRaiseM1M3 start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_abortRaiseM1M3 command*
    ${abortRaiseM1M3_end}=    Get Index From List    ${full_list}    ${line}
    ${abortRaiseM1M3_list}=    Get Slice From List    ${full_list}    start=${abortRaiseM1M3_start}    end=${abortRaiseM1M3_end+3}
    Log    ${abortRaiseM1M3_list}
    Should Contain X Times    ${abortRaiseM1M3_list}    === ${subSystem}_abortRaiseM1M3 start of topic ===    1
    Should Contain    ${abortRaiseM1M3_list}    === issueCommand_abortRaiseM1M3 writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${abortRaiseM1M3_list}[-2]    Command roundtrip was
    Should Be Equal    ${abortRaiseM1M3_list}[-1]    303
    Should Contain    ${abortRaiseM1M3_list}    === ${subSystem}_abortRaiseM1M3 end of topic ===
    Comment    ======= Verify ${subSystem}_lowerM1M3 test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${lowerM1M3_start}=    Get Index From List    ${full_list}    === MTM1M3_lowerM1M3 start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_lowerM1M3 command*
    ${lowerM1M3_end}=    Get Index From List    ${full_list}    ${line}
    ${lowerM1M3_list}=    Get Slice From List    ${full_list}    start=${lowerM1M3_start}    end=${lowerM1M3_end+3}
    Log    ${lowerM1M3_list}
    Should Contain X Times    ${lowerM1M3_list}    === ${subSystem}_lowerM1M3 start of topic ===    1
    Should Contain    ${lowerM1M3_list}    === issueCommand_lowerM1M3 writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${lowerM1M3_list}[-2]    Command roundtrip was
    Should Be Equal    ${lowerM1M3_list}[-1]    303
    Should Contain    ${lowerM1M3_list}    === ${subSystem}_lowerM1M3 end of topic ===
    Comment    ======= Verify ${subSystem}_pauseM1M3RaisingLowering test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${pauseM1M3RaisingLowering_start}=    Get Index From List    ${full_list}    === MTM1M3_pauseM1M3RaisingLowering start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_pauseM1M3RaisingLowering command*
    ${pauseM1M3RaisingLowering_end}=    Get Index From List    ${full_list}    ${line}
    ${pauseM1M3RaisingLowering_list}=    Get Slice From List    ${full_list}    start=${pauseM1M3RaisingLowering_start}    end=${pauseM1M3RaisingLowering_end+3}
    Log    ${pauseM1M3RaisingLowering_list}
    Should Contain X Times    ${pauseM1M3RaisingLowering_list}    === ${subSystem}_pauseM1M3RaisingLowering start of topic ===    1
    Should Contain    ${pauseM1M3RaisingLowering_list}    === issueCommand_pauseM1M3RaisingLowering writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${pauseM1M3RaisingLowering_list}[-2]    Command roundtrip was
    Should Be Equal    ${pauseM1M3RaisingLowering_list}[-1]    303
    Should Contain    ${pauseM1M3RaisingLowering_list}    === ${subSystem}_pauseM1M3RaisingLowering end of topic ===
    Comment    ======= Verify ${subSystem}_resumeM1M3RaisingLowering test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${resumeM1M3RaisingLowering_start}=    Get Index From List    ${full_list}    === MTM1M3_resumeM1M3RaisingLowering start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_resumeM1M3RaisingLowering command*
    ${resumeM1M3RaisingLowering_end}=    Get Index From List    ${full_list}    ${line}
    ${resumeM1M3RaisingLowering_list}=    Get Slice From List    ${full_list}    start=${resumeM1M3RaisingLowering_start}    end=${resumeM1M3RaisingLowering_end+3}
    Log    ${resumeM1M3RaisingLowering_list}
    Should Contain X Times    ${resumeM1M3RaisingLowering_list}    === ${subSystem}_resumeM1M3RaisingLowering start of topic ===    1
    Should Contain    ${resumeM1M3RaisingLowering_list}    === issueCommand_resumeM1M3RaisingLowering writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${resumeM1M3RaisingLowering_list}[-2]    Command roundtrip was
    Should Be Equal    ${resumeM1M3RaisingLowering_list}[-1]    303
    Should Contain    ${resumeM1M3RaisingLowering_list}    === ${subSystem}_resumeM1M3RaisingLowering end of topic ===
    Comment    ======= Verify ${subSystem}_enterEngineering test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${enterEngineering_start}=    Get Index From List    ${full_list}    === MTM1M3_enterEngineering start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_enterEngineering command*
    ${enterEngineering_end}=    Get Index From List    ${full_list}    ${line}
    ${enterEngineering_list}=    Get Slice From List    ${full_list}    start=${enterEngineering_start}    end=${enterEngineering_end+3}
    Log    ${enterEngineering_list}
    Should Contain X Times    ${enterEngineering_list}    === ${subSystem}_enterEngineering start of topic ===    1
    Should Contain    ${enterEngineering_list}    === issueCommand_enterEngineering writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${enterEngineering_list}[-2]    Command roundtrip was
    Should Be Equal    ${enterEngineering_list}[-1]    303
    Should Contain    ${enterEngineering_list}    === ${subSystem}_enterEngineering end of topic ===
    Comment    ======= Verify ${subSystem}_exitEngineering test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${exitEngineering_start}=    Get Index From List    ${full_list}    === MTM1M3_exitEngineering start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_exitEngineering command*
    ${exitEngineering_end}=    Get Index From List    ${full_list}    ${line}
    ${exitEngineering_list}=    Get Slice From List    ${full_list}    start=${exitEngineering_start}    end=${exitEngineering_end+3}
    Log    ${exitEngineering_list}
    Should Contain X Times    ${exitEngineering_list}    === ${subSystem}_exitEngineering start of topic ===    1
    Should Contain    ${exitEngineering_list}    === issueCommand_exitEngineering writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${exitEngineering_list}[-2]    Command roundtrip was
    Should Be Equal    ${exitEngineering_list}[-1]    303
    Should Contain    ${exitEngineering_list}    === ${subSystem}_exitEngineering end of topic ===
    Comment    ======= Verify ${subSystem}_turnAirOn test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${turnAirOn_start}=    Get Index From List    ${full_list}    === MTM1M3_turnAirOn start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_turnAirOn command*
    ${turnAirOn_end}=    Get Index From List    ${full_list}    ${line}
    ${turnAirOn_list}=    Get Slice From List    ${full_list}    start=${turnAirOn_start}    end=${turnAirOn_end+3}
    Log    ${turnAirOn_list}
    Should Contain X Times    ${turnAirOn_list}    === ${subSystem}_turnAirOn start of topic ===    1
    Should Contain    ${turnAirOn_list}    === issueCommand_turnAirOn writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${turnAirOn_list}[-2]    Command roundtrip was
    Should Be Equal    ${turnAirOn_list}[-1]    303
    Should Contain    ${turnAirOn_list}    === ${subSystem}_turnAirOn end of topic ===
    Comment    ======= Verify ${subSystem}_turnAirOff test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${turnAirOff_start}=    Get Index From List    ${full_list}    === MTM1M3_turnAirOff start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_turnAirOff command*
    ${turnAirOff_end}=    Get Index From List    ${full_list}    ${line}
    ${turnAirOff_list}=    Get Slice From List    ${full_list}    start=${turnAirOff_start}    end=${turnAirOff_end+3}
    Log    ${turnAirOff_list}
    Should Contain X Times    ${turnAirOff_list}    === ${subSystem}_turnAirOff start of topic ===    1
    Should Contain    ${turnAirOff_list}    === issueCommand_turnAirOff writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${turnAirOff_list}[-2]    Command roundtrip was
    Should Be Equal    ${turnAirOff_list}[-1]    303
    Should Contain    ${turnAirOff_list}    === ${subSystem}_turnAirOff end of topic ===
    Comment    ======= Verify ${subSystem}_boosterValveOpen test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${boosterValveOpen_start}=    Get Index From List    ${full_list}    === MTM1M3_boosterValveOpen start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_boosterValveOpen command*
    ${boosterValveOpen_end}=    Get Index From List    ${full_list}    ${line}
    ${boosterValveOpen_list}=    Get Slice From List    ${full_list}    start=${boosterValveOpen_start}    end=${boosterValveOpen_end+3}
    Log    ${boosterValveOpen_list}
    Should Contain X Times    ${boosterValveOpen_list}    === ${subSystem}_boosterValveOpen start of topic ===    1
    Should Contain    ${boosterValveOpen_list}    === issueCommand_boosterValveOpen writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${boosterValveOpen_list}[-2]    Command roundtrip was
    Should Be Equal    ${boosterValveOpen_list}[-1]    303
    Should Contain    ${boosterValveOpen_list}    === ${subSystem}_boosterValveOpen end of topic ===
    Comment    ======= Verify ${subSystem}_boosterValveClose test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${boosterValveClose_start}=    Get Index From List    ${full_list}    === MTM1M3_boosterValveClose start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_boosterValveClose command*
    ${boosterValveClose_end}=    Get Index From List    ${full_list}    ${line}
    ${boosterValveClose_list}=    Get Slice From List    ${full_list}    start=${boosterValveClose_start}    end=${boosterValveClose_end+3}
    Log    ${boosterValveClose_list}
    Should Contain X Times    ${boosterValveClose_list}    === ${subSystem}_boosterValveClose start of topic ===    1
    Should Contain    ${boosterValveClose_list}    === issueCommand_boosterValveClose writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${boosterValveClose_list}[-2]    Command roundtrip was
    Should Be Equal    ${boosterValveClose_list}[-1]    303
    Should Contain    ${boosterValveClose_list}    === ${subSystem}_boosterValveClose end of topic ===
    Comment    ======= Verify ${subSystem}_moveHardpointActuators test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${moveHardpointActuators_start}=    Get Index From List    ${full_list}    === MTM1M3_moveHardpointActuators start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_moveHardpointActuators command*
    ${moveHardpointActuators_end}=    Get Index From List    ${full_list}    ${line}
    ${moveHardpointActuators_list}=    Get Slice From List    ${full_list}    start=${moveHardpointActuators_start}    end=${moveHardpointActuators_end+3}
    Log    ${moveHardpointActuators_list}
    Should Contain X Times    ${moveHardpointActuators_list}    === ${subSystem}_moveHardpointActuators start of topic ===    1
    Should Contain X Times    ${moveHardpointActuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}steps : 0    1
    Should Contain    ${moveHardpointActuators_list}    === issueCommand_moveHardpointActuators writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${moveHardpointActuators_list}[-2]    Command roundtrip was
    Should Be Equal    ${moveHardpointActuators_list}[-1]    303
    Should Contain    ${moveHardpointActuators_list}    === ${subSystem}_moveHardpointActuators end of topic ===
    Comment    ======= Verify ${subSystem}_stopHardpointMotion test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${stopHardpointMotion_start}=    Get Index From List    ${full_list}    === MTM1M3_stopHardpointMotion start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_stopHardpointMotion command*
    ${stopHardpointMotion_end}=    Get Index From List    ${full_list}    ${line}
    ${stopHardpointMotion_list}=    Get Slice From List    ${full_list}    start=${stopHardpointMotion_start}    end=${stopHardpointMotion_end+3}
    Log    ${stopHardpointMotion_list}
    Should Contain X Times    ${stopHardpointMotion_list}    === ${subSystem}_stopHardpointMotion start of topic ===    1
    Should Contain    ${stopHardpointMotion_list}    === issueCommand_stopHardpointMotion writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${stopHardpointMotion_list}[-2]    Command roundtrip was
    Should Be Equal    ${stopHardpointMotion_list}[-1]    303
    Should Contain    ${stopHardpointMotion_list}    === ${subSystem}_stopHardpointMotion end of topic ===
    Comment    ======= Verify ${subSystem}_testHardpoint test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${testHardpoint_start}=    Get Index From List    ${full_list}    === MTM1M3_testHardpoint start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_testHardpoint command*
    ${testHardpoint_end}=    Get Index From List    ${full_list}    ${line}
    ${testHardpoint_list}=    Get Slice From List    ${full_list}    start=${testHardpoint_start}    end=${testHardpoint_end+3}
    Log    ${testHardpoint_list}
    Should Contain X Times    ${testHardpoint_list}    === ${subSystem}_testHardpoint start of topic ===    1
    Should Contain X Times    ${testHardpoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointActuator : 1    1
    Should Contain    ${testHardpoint_list}    === issueCommand_testHardpoint writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${testHardpoint_list}[-2]    Command roundtrip was
    Should Be Equal    ${testHardpoint_list}[-1]    303
    Should Contain    ${testHardpoint_list}    === ${subSystem}_testHardpoint end of topic ===
    Comment    ======= Verify ${subSystem}_killHardpointTest test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${killHardpointTest_start}=    Get Index From List    ${full_list}    === MTM1M3_killHardpointTest start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_killHardpointTest command*
    ${killHardpointTest_end}=    Get Index From List    ${full_list}    ${line}
    ${killHardpointTest_list}=    Get Slice From List    ${full_list}    start=${killHardpointTest_start}    end=${killHardpointTest_end+3}
    Log    ${killHardpointTest_list}
    Should Contain X Times    ${killHardpointTest_list}    === ${subSystem}_killHardpointTest start of topic ===    1
    Should Contain X Times    ${killHardpointTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointActuator : 1    1
    Should Contain    ${killHardpointTest_list}    === issueCommand_killHardpointTest writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${killHardpointTest_list}[-2]    Command roundtrip was
    Should Be Equal    ${killHardpointTest_list}[-1]    303
    Should Contain    ${killHardpointTest_list}    === ${subSystem}_killHardpointTest end of topic ===
    Comment    ======= Verify ${subSystem}_enableHardpointChase test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${enableHardpointChase_start}=    Get Index From List    ${full_list}    === MTM1M3_enableHardpointChase start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_enableHardpointChase command*
    ${enableHardpointChase_end}=    Get Index From List    ${full_list}    ${line}
    ${enableHardpointChase_list}=    Get Slice From List    ${full_list}    start=${enableHardpointChase_start}    end=${enableHardpointChase_end+3}
    Log    ${enableHardpointChase_list}
    Should Contain X Times    ${enableHardpointChase_list}    === ${subSystem}_enableHardpointChase start of topic ===    1
    Should Contain    ${enableHardpointChase_list}    === issueCommand_enableHardpointChase writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${enableHardpointChase_list}[-2]    Command roundtrip was
    Should Be Equal    ${enableHardpointChase_list}[-1]    303
    Should Contain    ${enableHardpointChase_list}    === ${subSystem}_enableHardpointChase end of topic ===
    Comment    ======= Verify ${subSystem}_disableHardpointChase test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${disableHardpointChase_start}=    Get Index From List    ${full_list}    === MTM1M3_disableHardpointChase start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_disableHardpointChase command*
    ${disableHardpointChase_end}=    Get Index From List    ${full_list}    ${line}
    ${disableHardpointChase_list}=    Get Slice From List    ${full_list}    start=${disableHardpointChase_start}    end=${disableHardpointChase_end+3}
    Log    ${disableHardpointChase_list}
    Should Contain X Times    ${disableHardpointChase_list}    === ${subSystem}_disableHardpointChase start of topic ===    1
    Should Contain    ${disableHardpointChase_list}    === issueCommand_disableHardpointChase writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${disableHardpointChase_list}[-2]    Command roundtrip was
    Should Be Equal    ${disableHardpointChase_list}[-1]    303
    Should Contain    ${disableHardpointChase_list}    === ${subSystem}_disableHardpointChase end of topic ===
    Comment    ======= Verify ${subSystem}_applyOffsetForces test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${applyOffsetForces_start}=    Get Index From List    ${full_list}    === MTM1M3_applyOffsetForces start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_applyOffsetForces command*
    ${applyOffsetForces_end}=    Get Index From List    ${full_list}    ${line}
    ${applyOffsetForces_list}=    Get Slice From List    ${full_list}    start=${applyOffsetForces_start}    end=${applyOffsetForces_end+3}
    Log    ${applyOffsetForces_list}
    Should Contain X Times    ${applyOffsetForces_list}    === ${subSystem}_applyOffsetForces start of topic ===    1
    Should Contain X Times    ${applyOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${applyOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${applyOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain    ${applyOffsetForces_list}    === issueCommand_applyOffsetForces writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${applyOffsetForces_list}[-2]    Command roundtrip was
    Should Be Equal    ${applyOffsetForces_list}[-1]    303
    Should Contain    ${applyOffsetForces_list}    === ${subSystem}_applyOffsetForces end of topic ===
    Comment    ======= Verify ${subSystem}_translateM1M3 test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${translateM1M3_start}=    Get Index From List    ${full_list}    === MTM1M3_translateM1M3 start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_translateM1M3 command*
    ${translateM1M3_end}=    Get Index From List    ${full_list}    ${line}
    ${translateM1M3_list}=    Get Slice From List    ${full_list}    start=${translateM1M3_start}    end=${translateM1M3_end+3}
    Log    ${translateM1M3_list}
    Should Contain X Times    ${translateM1M3_list}    === ${subSystem}_translateM1M3 start of topic ===    1
    Should Contain X Times    ${translateM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xTranslation : 1    1
    Should Contain X Times    ${translateM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yTranslation : 1    1
    Should Contain X Times    ${translateM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zTranslation : 1    1
    Should Contain X Times    ${translateM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xRotation : 1    1
    Should Contain X Times    ${translateM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yRotation : 1    1
    Should Contain X Times    ${translateM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zRotation : 1    1
    Should Contain    ${translateM1M3_list}    === issueCommand_translateM1M3 writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${translateM1M3_list}[-2]    Command roundtrip was
    Should Be Equal    ${translateM1M3_list}[-1]    303
    Should Contain    ${translateM1M3_list}    === ${subSystem}_translateM1M3 end of topic ===
    Comment    ======= Verify ${subSystem}_clearOffsetForces test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${clearOffsetForces_start}=    Get Index From List    ${full_list}    === MTM1M3_clearOffsetForces start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_clearOffsetForces command*
    ${clearOffsetForces_end}=    Get Index From List    ${full_list}    ${line}
    ${clearOffsetForces_list}=    Get Slice From List    ${full_list}    start=${clearOffsetForces_start}    end=${clearOffsetForces_end+3}
    Log    ${clearOffsetForces_list}
    Should Contain X Times    ${clearOffsetForces_list}    === ${subSystem}_clearOffsetForces start of topic ===    1
    Should Contain    ${clearOffsetForces_list}    === issueCommand_clearOffsetForces writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${clearOffsetForces_list}[-2]    Command roundtrip was
    Should Be Equal    ${clearOffsetForces_list}[-1]    303
    Should Contain    ${clearOffsetForces_list}    === ${subSystem}_clearOffsetForces end of topic ===
    Comment    ======= Verify ${subSystem}_applyActiveOpticForces test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${applyActiveOpticForces_start}=    Get Index From List    ${full_list}    === MTM1M3_applyActiveOpticForces start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_applyActiveOpticForces command*
    ${applyActiveOpticForces_end}=    Get Index From List    ${full_list}    ${line}
    ${applyActiveOpticForces_list}=    Get Slice From List    ${full_list}    start=${applyActiveOpticForces_start}    end=${applyActiveOpticForces_end+3}
    Log    ${applyActiveOpticForces_list}
    Should Contain X Times    ${applyActiveOpticForces_list}    === ${subSystem}_applyActiveOpticForces start of topic ===    1
    Should Contain X Times    ${applyActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain    ${applyActiveOpticForces_list}    === issueCommand_applyActiveOpticForces writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${applyActiveOpticForces_list}[-2]    Command roundtrip was
    Should Be Equal    ${applyActiveOpticForces_list}[-1]    303
    Should Contain    ${applyActiveOpticForces_list}    === ${subSystem}_applyActiveOpticForces end of topic ===
    Comment    ======= Verify ${subSystem}_clearActiveOpticForces test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${clearActiveOpticForces_start}=    Get Index From List    ${full_list}    === MTM1M3_clearActiveOpticForces start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_clearActiveOpticForces command*
    ${clearActiveOpticForces_end}=    Get Index From List    ${full_list}    ${line}
    ${clearActiveOpticForces_list}=    Get Slice From List    ${full_list}    start=${clearActiveOpticForces_start}    end=${clearActiveOpticForces_end+3}
    Log    ${clearActiveOpticForces_list}
    Should Contain X Times    ${clearActiveOpticForces_list}    === ${subSystem}_clearActiveOpticForces start of topic ===    1
    Should Contain    ${clearActiveOpticForces_list}    === issueCommand_clearActiveOpticForces writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${clearActiveOpticForces_list}[-2]    Command roundtrip was
    Should Be Equal    ${clearActiveOpticForces_list}[-1]    303
    Should Contain    ${clearActiveOpticForces_list}    === ${subSystem}_clearActiveOpticForces end of topic ===
    Comment    ======= Verify ${subSystem}_positionM1M3 test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${positionM1M3_start}=    Get Index From List    ${full_list}    === MTM1M3_positionM1M3 start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_positionM1M3 command*
    ${positionM1M3_end}=    Get Index From List    ${full_list}    ${line}
    ${positionM1M3_list}=    Get Slice From List    ${full_list}    start=${positionM1M3_start}    end=${positionM1M3_end+3}
    Log    ${positionM1M3_list}
    Should Contain X Times    ${positionM1M3_list}    === ${subSystem}_positionM1M3 start of topic ===    1
    Should Contain X Times    ${positionM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xPosition : 1    1
    Should Contain X Times    ${positionM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yPosition : 1    1
    Should Contain X Times    ${positionM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zPosition : 1    1
    Should Contain X Times    ${positionM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xRotation : 1    1
    Should Contain X Times    ${positionM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yRotation : 1    1
    Should Contain X Times    ${positionM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zRotation : 1    1
    Should Contain    ${positionM1M3_list}    === issueCommand_positionM1M3 writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${positionM1M3_list}[-2]    Command roundtrip was
    Should Be Equal    ${positionM1M3_list}[-1]    303
    Should Contain    ${positionM1M3_list}    === ${subSystem}_positionM1M3 end of topic ===
    Comment    ======= Verify ${subSystem}_turnLightsOn test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${turnLightsOn_start}=    Get Index From List    ${full_list}    === MTM1M3_turnLightsOn start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_turnLightsOn command*
    ${turnLightsOn_end}=    Get Index From List    ${full_list}    ${line}
    ${turnLightsOn_list}=    Get Slice From List    ${full_list}    start=${turnLightsOn_start}    end=${turnLightsOn_end+3}
    Log    ${turnLightsOn_list}
    Should Contain X Times    ${turnLightsOn_list}    === ${subSystem}_turnLightsOn start of topic ===    1
    Should Contain    ${turnLightsOn_list}    === issueCommand_turnLightsOn writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${turnLightsOn_list}[-2]    Command roundtrip was
    Should Be Equal    ${turnLightsOn_list}[-1]    303
    Should Contain    ${turnLightsOn_list}    === ${subSystem}_turnLightsOn end of topic ===
    Comment    ======= Verify ${subSystem}_turnLightsOff test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${turnLightsOff_start}=    Get Index From List    ${full_list}    === MTM1M3_turnLightsOff start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_turnLightsOff command*
    ${turnLightsOff_end}=    Get Index From List    ${full_list}    ${line}
    ${turnLightsOff_list}=    Get Slice From List    ${full_list}    start=${turnLightsOff_start}    end=${turnLightsOff_end+3}
    Log    ${turnLightsOff_list}
    Should Contain X Times    ${turnLightsOff_list}    === ${subSystem}_turnLightsOff start of topic ===    1
    Should Contain    ${turnLightsOff_list}    === issueCommand_turnLightsOff writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${turnLightsOff_list}[-2]    Command roundtrip was
    Should Be Equal    ${turnLightsOff_list}[-1]    303
    Should Contain    ${turnLightsOff_list}    === ${subSystem}_turnLightsOff end of topic ===
    Comment    ======= Verify ${subSystem}_turnPowerOn test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${turnPowerOn_start}=    Get Index From List    ${full_list}    === MTM1M3_turnPowerOn start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_turnPowerOn command*
    ${turnPowerOn_end}=    Get Index From List    ${full_list}    ${line}
    ${turnPowerOn_list}=    Get Slice From List    ${full_list}    start=${turnPowerOn_start}    end=${turnPowerOn_end+3}
    Log    ${turnPowerOn_list}
    Should Contain X Times    ${turnPowerOn_list}    === ${subSystem}_turnPowerOn start of topic ===    1
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnPowerNetworkAOn : 1    1
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnPowerNetworkBOn : 1    1
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnPowerNetworkCOn : 1    1
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnPowerNetworkDOn : 1    1
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnAuxPowerNetworkAOn : 1    1
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnAuxPowerNetworkBOn : 1    1
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnAuxPowerNetworkCOn : 1    1
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnAuxPowerNetworkDOn : 1    1
    Should Contain    ${turnPowerOn_list}    === issueCommand_turnPowerOn writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${turnPowerOn_list}[-2]    Command roundtrip was
    Should Be Equal    ${turnPowerOn_list}[-1]    303
    Should Contain    ${turnPowerOn_list}    === ${subSystem}_turnPowerOn end of topic ===
    Comment    ======= Verify ${subSystem}_turnPowerOff test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${turnPowerOff_start}=    Get Index From List    ${full_list}    === MTM1M3_turnPowerOff start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_turnPowerOff command*
    ${turnPowerOff_end}=    Get Index From List    ${full_list}    ${line}
    ${turnPowerOff_list}=    Get Slice From List    ${full_list}    start=${turnPowerOff_start}    end=${turnPowerOff_end+3}
    Log    ${turnPowerOff_list}
    Should Contain X Times    ${turnPowerOff_list}    === ${subSystem}_turnPowerOff start of topic ===    1
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnPowerNetworkAOff : 1    1
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnPowerNetworkBOff : 1    1
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnPowerNetworkCOff : 1    1
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnPowerNetworkDOff : 1    1
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnAuxPowerNetworkAOff : 1    1
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnAuxPowerNetworkBOff : 1    1
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnAuxPowerNetworkCOff : 1    1
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnAuxPowerNetworkDOff : 1    1
    Should Contain    ${turnPowerOff_list}    === issueCommand_turnPowerOff writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${turnPowerOff_list}[-2]    Command roundtrip was
    Should Be Equal    ${turnPowerOff_list}[-1]    303
    Should Contain    ${turnPowerOff_list}    === ${subSystem}_turnPowerOff end of topic ===
    Comment    ======= Verify ${subSystem}_enableHardpointCorrections test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${enableHardpointCorrections_start}=    Get Index From List    ${full_list}    === MTM1M3_enableHardpointCorrections start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_enableHardpointCorrections command*
    ${enableHardpointCorrections_end}=    Get Index From List    ${full_list}    ${line}
    ${enableHardpointCorrections_list}=    Get Slice From List    ${full_list}    start=${enableHardpointCorrections_start}    end=${enableHardpointCorrections_end+3}
    Log    ${enableHardpointCorrections_list}
    Should Contain X Times    ${enableHardpointCorrections_list}    === ${subSystem}_enableHardpointCorrections start of topic ===    1
    Should Contain    ${enableHardpointCorrections_list}    === issueCommand_enableHardpointCorrections writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${enableHardpointCorrections_list}[-2]    Command roundtrip was
    Should Be Equal    ${enableHardpointCorrections_list}[-1]    303
    Should Contain    ${enableHardpointCorrections_list}    === ${subSystem}_enableHardpointCorrections end of topic ===
    Comment    ======= Verify ${subSystem}_disableHardpointCorrections test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${disableHardpointCorrections_start}=    Get Index From List    ${full_list}    === MTM1M3_disableHardpointCorrections start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_disableHardpointCorrections command*
    ${disableHardpointCorrections_end}=    Get Index From List    ${full_list}    ${line}
    ${disableHardpointCorrections_list}=    Get Slice From List    ${full_list}    start=${disableHardpointCorrections_start}    end=${disableHardpointCorrections_end+3}
    Log    ${disableHardpointCorrections_list}
    Should Contain X Times    ${disableHardpointCorrections_list}    === ${subSystem}_disableHardpointCorrections start of topic ===    1
    Should Contain    ${disableHardpointCorrections_list}    === issueCommand_disableHardpointCorrections writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${disableHardpointCorrections_list}[-2]    Command roundtrip was
    Should Be Equal    ${disableHardpointCorrections_list}[-1]    303
    Should Contain    ${disableHardpointCorrections_list}    === ${subSystem}_disableHardpointCorrections end of topic ===
    Comment    ======= Verify ${subSystem}_runMirrorForceProfile test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${runMirrorForceProfile_start}=    Get Index From List    ${full_list}    === MTM1M3_runMirrorForceProfile start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_runMirrorForceProfile command*
    ${runMirrorForceProfile_end}=    Get Index From List    ${full_list}    ${line}
    ${runMirrorForceProfile_list}=    Get Slice From List    ${full_list}    start=${runMirrorForceProfile_start}    end=${runMirrorForceProfile_end+3}
    Log    ${runMirrorForceProfile_list}
    Should Contain X Times    ${runMirrorForceProfile_list}    === ${subSystem}_runMirrorForceProfile start of topic ===    1
    Should Contain X Times    ${runMirrorForceProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForce : 0    1
    Should Contain X Times    ${runMirrorForceProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForce : 0    1
    Should Contain X Times    ${runMirrorForceProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForce : 0    1
    Should Contain X Times    ${runMirrorForceProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xMoment : 0    1
    Should Contain X Times    ${runMirrorForceProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yMoment : 0    1
    Should Contain X Times    ${runMirrorForceProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zMoment : 0    1
    Should Contain    ${runMirrorForceProfile_list}    === issueCommand_runMirrorForceProfile writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${runMirrorForceProfile_list}[-2]    Command roundtrip was
    Should Be Equal    ${runMirrorForceProfile_list}[-1]    303
    Should Contain    ${runMirrorForceProfile_list}    === ${subSystem}_runMirrorForceProfile end of topic ===
    Comment    ======= Verify ${subSystem}_abortProfile test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${abortProfile_start}=    Get Index From List    ${full_list}    === MTM1M3_abortProfile start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_abortProfile command*
    ${abortProfile_end}=    Get Index From List    ${full_list}    ${line}
    ${abortProfile_list}=    Get Slice From List    ${full_list}    start=${abortProfile_start}    end=${abortProfile_end+3}
    Log    ${abortProfile_list}
    Should Contain X Times    ${abortProfile_list}    === ${subSystem}_abortProfile start of topic ===    1
    Should Contain    ${abortProfile_list}    === issueCommand_abortProfile writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${abortProfile_list}[-2]    Command roundtrip was
    Should Be Equal    ${abortProfile_list}[-1]    303
    Should Contain    ${abortProfile_list}    === ${subSystem}_abortProfile end of topic ===
    Comment    ======= Verify ${subSystem}_applyOffsetForcesByMirrorForce test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${applyOffsetForcesByMirrorForce_start}=    Get Index From List    ${full_list}    === MTM1M3_applyOffsetForcesByMirrorForce start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_applyOffsetForcesByMirrorForce command*
    ${applyOffsetForcesByMirrorForce_end}=    Get Index From List    ${full_list}    ${line}
    ${applyOffsetForcesByMirrorForce_list}=    Get Slice From List    ${full_list}    start=${applyOffsetForcesByMirrorForce_start}    end=${applyOffsetForcesByMirrorForce_end+3}
    Log    ${applyOffsetForcesByMirrorForce_list}
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    === ${subSystem}_applyOffsetForcesByMirrorForce start of topic ===    1
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForce : 1    1
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForce : 1    1
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForce : 1    1
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xMoment : 1    1
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yMoment : 1    1
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zMoment : 1    1
    Should Contain    ${applyOffsetForcesByMirrorForce_list}    === issueCommand_applyOffsetForcesByMirrorForce writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${applyOffsetForcesByMirrorForce_list}[-2]    Command roundtrip was
    Should Be Equal    ${applyOffsetForcesByMirrorForce_list}[-1]    303
    Should Contain    ${applyOffsetForcesByMirrorForce_list}    === ${subSystem}_applyOffsetForcesByMirrorForce end of topic ===
    Comment    ======= Verify ${subSystem}_updatePID test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${updatePID_start}=    Get Index From List    ${full_list}    === MTM1M3_updatePID start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_updatePID command*
    ${updatePID_end}=    Get Index From List    ${full_list}    ${line}
    ${updatePID_list}=    Get Slice From List    ${full_list}    start=${updatePID_start}    end=${updatePID_end+3}
    Log    ${updatePID_list}
    Should Contain X Times    ${updatePID_list}    === ${subSystem}_updatePID start of topic ===    1
    Should Contain X Times    ${updatePID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pid : 1    1
    Should Contain X Times    ${updatePID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestep : 1    1
    Should Contain X Times    ${updatePID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}p : 1    1
    Should Contain X Times    ${updatePID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 1    1
    Should Contain X Times    ${updatePID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}d : 1    1
    Should Contain X Times    ${updatePID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}n : 1    1
    Should Contain    ${updatePID_list}    === issueCommand_updatePID writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${updatePID_list}[-2]    Command roundtrip was
    Should Be Equal    ${updatePID_list}[-1]    303
    Should Contain    ${updatePID_list}    === ${subSystem}_updatePID end of topic ===
    Comment    ======= Verify ${subSystem}_resetPID test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${resetPID_start}=    Get Index From List    ${full_list}    === MTM1M3_resetPID start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_resetPID command*
    ${resetPID_end}=    Get Index From List    ${full_list}    ${line}
    ${resetPID_list}=    Get Slice From List    ${full_list}    start=${resetPID_start}    end=${resetPID_end+3}
    Log    ${resetPID_list}
    Should Contain X Times    ${resetPID_list}    === ${subSystem}_resetPID start of topic ===    1
    Should Contain X Times    ${resetPID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pid : 1    1
    Should Contain    ${resetPID_list}    === issueCommand_resetPID writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${resetPID_list}[-2]    Command roundtrip was
    Should Be Equal    ${resetPID_list}[-1]    303
    Should Contain    ${resetPID_list}    === ${subSystem}_resetPID end of topic ===
    Comment    ======= Verify ${subSystem}_forceActuatorBumpTest test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${forceActuatorBumpTest_start}=    Get Index From List    ${full_list}    === MTM1M3_forceActuatorBumpTest start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_forceActuatorBumpTest command*
    ${forceActuatorBumpTest_end}=    Get Index From List    ${full_list}    ${line}
    ${forceActuatorBumpTest_list}=    Get Slice From List    ${full_list}    start=${forceActuatorBumpTest_start}    end=${forceActuatorBumpTest_end+3}
    Log    ${forceActuatorBumpTest_list}
    Should Contain X Times    ${forceActuatorBumpTest_list}    === ${subSystem}_forceActuatorBumpTest start of topic ===    1
    Should Contain X Times    ${forceActuatorBumpTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actuatorId : 1    1
    Should Contain X Times    ${forceActuatorBumpTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}testPrimary : 1    1
    Should Contain X Times    ${forceActuatorBumpTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}testSecondary : 1    1
    Should Contain    ${forceActuatorBumpTest_list}    === issueCommand_forceActuatorBumpTest writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${forceActuatorBumpTest_list}[-2]    Command roundtrip was
    Should Be Equal    ${forceActuatorBumpTest_list}[-1]    303
    Should Contain    ${forceActuatorBumpTest_list}    === ${subSystem}_forceActuatorBumpTest end of topic ===
    Comment    ======= Verify ${subSystem}_killForceActuatorBumpTest test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${killForceActuatorBumpTest_start}=    Get Index From List    ${full_list}    === MTM1M3_killForceActuatorBumpTest start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_killForceActuatorBumpTest command*
    ${killForceActuatorBumpTest_end}=    Get Index From List    ${full_list}    ${line}
    ${killForceActuatorBumpTest_list}=    Get Slice From List    ${full_list}    start=${killForceActuatorBumpTest_start}    end=${killForceActuatorBumpTest_end+3}
    Log    ${killForceActuatorBumpTest_list}
    Should Contain X Times    ${killForceActuatorBumpTest_list}    === ${subSystem}_killForceActuatorBumpTest start of topic ===    1
    Should Contain    ${killForceActuatorBumpTest_list}    === issueCommand_killForceActuatorBumpTest writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${killForceActuatorBumpTest_list}[-2]    Command roundtrip was
    Should Be Equal    ${killForceActuatorBumpTest_list}[-1]    303
    Should Contain    ${killForceActuatorBumpTest_list}    === ${subSystem}_killForceActuatorBumpTest end of topic ===
    Comment    ======= Verify ${subSystem}_disableForceActuator test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${disableForceActuator_start}=    Get Index From List    ${full_list}    === MTM1M3_disableForceActuator start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_disableForceActuator command*
    ${disableForceActuator_end}=    Get Index From List    ${full_list}    ${line}
    ${disableForceActuator_list}=    Get Slice From List    ${full_list}    start=${disableForceActuator_start}    end=${disableForceActuator_end+3}
    Log    ${disableForceActuator_list}
    Should Contain X Times    ${disableForceActuator_list}    === ${subSystem}_disableForceActuator start of topic ===    1
    Should Contain X Times    ${disableForceActuator_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actuatorId : 1    1
    Should Contain    ${disableForceActuator_list}    === issueCommand_disableForceActuator writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${disableForceActuator_list}[-2]    Command roundtrip was
    Should Be Equal    ${disableForceActuator_list}[-1]    303
    Should Contain    ${disableForceActuator_list}    === ${subSystem}_disableForceActuator end of topic ===
    Comment    ======= Verify ${subSystem}_enableForceActuator test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${enableForceActuator_start}=    Get Index From List    ${full_list}    === MTM1M3_enableForceActuator start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_enableForceActuator command*
    ${enableForceActuator_end}=    Get Index From List    ${full_list}    ${line}
    ${enableForceActuator_list}=    Get Slice From List    ${full_list}    start=${enableForceActuator_start}    end=${enableForceActuator_end+3}
    Log    ${enableForceActuator_list}
    Should Contain X Times    ${enableForceActuator_list}    === ${subSystem}_enableForceActuator start of topic ===    1
    Should Contain X Times    ${enableForceActuator_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actuatorId : 1    1
    Should Contain    ${enableForceActuator_list}    === issueCommand_enableForceActuator writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${enableForceActuator_list}[-2]    Command roundtrip was
    Should Be Equal    ${enableForceActuator_list}[-1]    303
    Should Contain    ${enableForceActuator_list}    === ${subSystem}_enableForceActuator end of topic ===
    Comment    ======= Verify ${subSystem}_enableAllForceActuators test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${enableAllForceActuators_start}=    Get Index From List    ${full_list}    === MTM1M3_enableAllForceActuators start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_enableAllForceActuators command*
    ${enableAllForceActuators_end}=    Get Index From List    ${full_list}    ${line}
    ${enableAllForceActuators_list}=    Get Slice From List    ${full_list}    start=${enableAllForceActuators_start}    end=${enableAllForceActuators_end+3}
    Log    ${enableAllForceActuators_list}
    Should Contain X Times    ${enableAllForceActuators_list}    === ${subSystem}_enableAllForceActuators start of topic ===    1
    Should Contain    ${enableAllForceActuators_list}    === issueCommand_enableAllForceActuators writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${enableAllForceActuators_list}[-2]    Command roundtrip was
    Should Be Equal    ${enableAllForceActuators_list}[-1]    303
    Should Contain    ${enableAllForceActuators_list}    === ${subSystem}_enableAllForceActuators end of topic ===
    Comment    ======= Verify ${subSystem}_enableDisableForceComponent test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${enableDisableForceComponent_start}=    Get Index From List    ${full_list}    === MTM1M3_enableDisableForceComponent start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_enableDisableForceComponent command*
    ${enableDisableForceComponent_end}=    Get Index From List    ${full_list}    ${line}
    ${enableDisableForceComponent_list}=    Get Slice From List    ${full_list}    start=${enableDisableForceComponent_start}    end=${enableDisableForceComponent_end+3}
    Log    ${enableDisableForceComponent_list}
    Should Contain X Times    ${enableDisableForceComponent_list}    === ${subSystem}_enableDisableForceComponent start of topic ===    1
    Should Contain X Times    ${enableDisableForceComponent_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceComponent : 1    1
    Should Contain X Times    ${enableDisableForceComponent_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enable : 1    1
    Should Contain    ${enableDisableForceComponent_list}    === issueCommand_enableDisableForceComponent writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${enableDisableForceComponent_list}[-2]    Command roundtrip was
    Should Be Equal    ${enableDisableForceComponent_list}[-1]    303
    Should Contain    ${enableDisableForceComponent_list}    === ${subSystem}_enableDisableForceComponent end of topic ===
    Comment    ======= Verify ${subSystem}_setSlewControllerSettings test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${setSlewControllerSettings_start}=    Get Index From List    ${full_list}    === MTM1M3_setSlewControllerSettings start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_setSlewControllerSettings command*
    ${setSlewControllerSettings_end}=    Get Index From List    ${full_list}    ${line}
    ${setSlewControllerSettings_list}=    Get Slice From List    ${full_list}    start=${setSlewControllerSettings_start}    end=${setSlewControllerSettings_end+3}
    Log    ${setSlewControllerSettings_list}
    Should Contain X Times    ${setSlewControllerSettings_list}    === ${subSystem}_setSlewControllerSettings start of topic ===    1
    Should Contain X Times    ${setSlewControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}slewSettings : 1    1
    Should Contain X Times    ${setSlewControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enableSlewManagement : 1    1
    Should Contain    ${setSlewControllerSettings_list}    === issueCommand_setSlewControllerSettings writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${setSlewControllerSettings_list}[-2]    Command roundtrip was
    Should Be Equal    ${setSlewControllerSettings_list}[-1]    303
    Should Contain    ${setSlewControllerSettings_list}    === ${subSystem}_setSlewControllerSettings end of topic ===
    Comment    ======= Verify ${subSystem}_disable test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${disable_start}=    Get Index From List    ${full_list}    === MTM1M3_disable start of topic ===
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
    ${enable_start}=    Get Index From List    ${full_list}    === MTM1M3_enable start of topic ===
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
    ${exitControl_start}=    Get Index From List    ${full_list}    === MTM1M3_exitControl start of topic ===
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
    ${setLogLevel_start}=    Get Index From List    ${full_list}    === MTM1M3_setLogLevel start of topic ===
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
    ${standby_start}=    Get Index From List    ${full_list}    === MTM1M3_standby start of topic ===
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
    ${start_start}=    Get Index From List    ${full_list}    === MTM1M3_start start of topic ===
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
    ${panic_start}=    Get Index From List    ${full_list}    === MTM1M3_panic start of topic ===
    ${panic_end}=    Get Index From List    ${full_list}    === MTM1M3_panic end of topic ===
    ${panic_list}=    Get Slice From List    ${full_list}    start=${panic_start}    end=${panic_end+1}
    Log    ${panic_list}
    Should Contain X Times    ${panic_list}    === ${subSystem}_panic start of topic ===    1
    Should Contain X Times    ${panic_list}    === ackCommand_panic acknowledging a command with :    2
    Should Contain X Times    ${panic_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${panic_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${panic_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${panic_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${panic_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${panic_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${panic_list}    === ${subSystem}_panic end of topic ===    1
    ${setSlewFlag_start}=    Get Index From List    ${full_list}    === MTM1M3_setSlewFlag start of topic ===
    ${setSlewFlag_end}=    Get Index From List    ${full_list}    === MTM1M3_setSlewFlag end of topic ===
    ${setSlewFlag_list}=    Get Slice From List    ${full_list}    start=${setSlewFlag_start}    end=${setSlewFlag_end+1}
    Log    ${setSlewFlag_list}
    Should Contain X Times    ${setSlewFlag_list}    === ${subSystem}_setSlewFlag start of topic ===    1
    Should Contain X Times    ${setSlewFlag_list}    === ackCommand_setSlewFlag acknowledging a command with :    2
    Should Contain X Times    ${setSlewFlag_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${setSlewFlag_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${setSlewFlag_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${setSlewFlag_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${setSlewFlag_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${setSlewFlag_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${setSlewFlag_list}    === ${subSystem}_setSlewFlag end of topic ===    1
    ${clearSlewFlag_start}=    Get Index From List    ${full_list}    === MTM1M3_clearSlewFlag start of topic ===
    ${clearSlewFlag_end}=    Get Index From List    ${full_list}    === MTM1M3_clearSlewFlag end of topic ===
    ${clearSlewFlag_list}=    Get Slice From List    ${full_list}    start=${clearSlewFlag_start}    end=${clearSlewFlag_end+1}
    Log    ${clearSlewFlag_list}
    Should Contain X Times    ${clearSlewFlag_list}    === ${subSystem}_clearSlewFlag start of topic ===    1
    Should Contain X Times    ${clearSlewFlag_list}    === ackCommand_clearSlewFlag acknowledging a command with :    2
    Should Contain X Times    ${clearSlewFlag_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${clearSlewFlag_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${clearSlewFlag_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${clearSlewFlag_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${clearSlewFlag_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${clearSlewFlag_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${clearSlewFlag_list}    === ${subSystem}_clearSlewFlag end of topic ===    1
    ${raiseM1M3_start}=    Get Index From List    ${full_list}    === MTM1M3_raiseM1M3 start of topic ===
    ${raiseM1M3_end}=    Get Index From List    ${full_list}    === MTM1M3_raiseM1M3 end of topic ===
    ${raiseM1M3_list}=    Get Slice From List    ${full_list}    start=${raiseM1M3_start}    end=${raiseM1M3_end+1}
    Log    ${raiseM1M3_list}
    Should Contain X Times    ${raiseM1M3_list}    === ${subSystem}_raiseM1M3 start of topic ===    1
    Should Contain X Times    ${raiseM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bypassReferencePosition : 1    1
    Should Contain X Times    ${raiseM1M3_list}    === ackCommand_raiseM1M3 acknowledging a command with :    2
    Should Contain X Times    ${raiseM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${raiseM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${raiseM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${raiseM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${raiseM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${raiseM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${raiseM1M3_list}    === ${subSystem}_raiseM1M3 end of topic ===    1
    ${abortRaiseM1M3_start}=    Get Index From List    ${full_list}    === MTM1M3_abortRaiseM1M3 start of topic ===
    ${abortRaiseM1M3_end}=    Get Index From List    ${full_list}    === MTM1M3_abortRaiseM1M3 end of topic ===
    ${abortRaiseM1M3_list}=    Get Slice From List    ${full_list}    start=${abortRaiseM1M3_start}    end=${abortRaiseM1M3_end+1}
    Log    ${abortRaiseM1M3_list}
    Should Contain X Times    ${abortRaiseM1M3_list}    === ${subSystem}_abortRaiseM1M3 start of topic ===    1
    Should Contain X Times    ${abortRaiseM1M3_list}    === ackCommand_abortRaiseM1M3 acknowledging a command with :    2
    Should Contain X Times    ${abortRaiseM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${abortRaiseM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${abortRaiseM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${abortRaiseM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${abortRaiseM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${abortRaiseM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${abortRaiseM1M3_list}    === ${subSystem}_abortRaiseM1M3 end of topic ===    1
    ${lowerM1M3_start}=    Get Index From List    ${full_list}    === MTM1M3_lowerM1M3 start of topic ===
    ${lowerM1M3_end}=    Get Index From List    ${full_list}    === MTM1M3_lowerM1M3 end of topic ===
    ${lowerM1M3_list}=    Get Slice From List    ${full_list}    start=${lowerM1M3_start}    end=${lowerM1M3_end+1}
    Log    ${lowerM1M3_list}
    Should Contain X Times    ${lowerM1M3_list}    === ${subSystem}_lowerM1M3 start of topic ===    1
    Should Contain X Times    ${lowerM1M3_list}    === ackCommand_lowerM1M3 acknowledging a command with :    2
    Should Contain X Times    ${lowerM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${lowerM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${lowerM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${lowerM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${lowerM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${lowerM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${lowerM1M3_list}    === ${subSystem}_lowerM1M3 end of topic ===    1
    ${pauseM1M3RaisingLowering_start}=    Get Index From List    ${full_list}    === MTM1M3_pauseM1M3RaisingLowering start of topic ===
    ${pauseM1M3RaisingLowering_end}=    Get Index From List    ${full_list}    === MTM1M3_pauseM1M3RaisingLowering end of topic ===
    ${pauseM1M3RaisingLowering_list}=    Get Slice From List    ${full_list}    start=${pauseM1M3RaisingLowering_start}    end=${pauseM1M3RaisingLowering_end+1}
    Log    ${pauseM1M3RaisingLowering_list}
    Should Contain X Times    ${pauseM1M3RaisingLowering_list}    === ${subSystem}_pauseM1M3RaisingLowering start of topic ===    1
    Should Contain X Times    ${pauseM1M3RaisingLowering_list}    === ackCommand_pauseM1M3RaisingLowering acknowledging a command with :    2
    Should Contain X Times    ${pauseM1M3RaisingLowering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${pauseM1M3RaisingLowering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${pauseM1M3RaisingLowering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${pauseM1M3RaisingLowering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${pauseM1M3RaisingLowering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${pauseM1M3RaisingLowering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${pauseM1M3RaisingLowering_list}    === ${subSystem}_pauseM1M3RaisingLowering end of topic ===    1
    ${resumeM1M3RaisingLowering_start}=    Get Index From List    ${full_list}    === MTM1M3_resumeM1M3RaisingLowering start of topic ===
    ${resumeM1M3RaisingLowering_end}=    Get Index From List    ${full_list}    === MTM1M3_resumeM1M3RaisingLowering end of topic ===
    ${resumeM1M3RaisingLowering_list}=    Get Slice From List    ${full_list}    start=${resumeM1M3RaisingLowering_start}    end=${resumeM1M3RaisingLowering_end+1}
    Log    ${resumeM1M3RaisingLowering_list}
    Should Contain X Times    ${resumeM1M3RaisingLowering_list}    === ${subSystem}_resumeM1M3RaisingLowering start of topic ===    1
    Should Contain X Times    ${resumeM1M3RaisingLowering_list}    === ackCommand_resumeM1M3RaisingLowering acknowledging a command with :    2
    Should Contain X Times    ${resumeM1M3RaisingLowering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${resumeM1M3RaisingLowering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${resumeM1M3RaisingLowering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${resumeM1M3RaisingLowering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${resumeM1M3RaisingLowering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${resumeM1M3RaisingLowering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${resumeM1M3RaisingLowering_list}    === ${subSystem}_resumeM1M3RaisingLowering end of topic ===    1
    ${enterEngineering_start}=    Get Index From List    ${full_list}    === MTM1M3_enterEngineering start of topic ===
    ${enterEngineering_end}=    Get Index From List    ${full_list}    === MTM1M3_enterEngineering end of topic ===
    ${enterEngineering_list}=    Get Slice From List    ${full_list}    start=${enterEngineering_start}    end=${enterEngineering_end+1}
    Log    ${enterEngineering_list}
    Should Contain X Times    ${enterEngineering_list}    === ${subSystem}_enterEngineering start of topic ===    1
    Should Contain X Times    ${enterEngineering_list}    === ackCommand_enterEngineering acknowledging a command with :    2
    Should Contain X Times    ${enterEngineering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${enterEngineering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${enterEngineering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${enterEngineering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${enterEngineering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${enterEngineering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${enterEngineering_list}    === ${subSystem}_enterEngineering end of topic ===    1
    ${exitEngineering_start}=    Get Index From List    ${full_list}    === MTM1M3_exitEngineering start of topic ===
    ${exitEngineering_end}=    Get Index From List    ${full_list}    === MTM1M3_exitEngineering end of topic ===
    ${exitEngineering_list}=    Get Slice From List    ${full_list}    start=${exitEngineering_start}    end=${exitEngineering_end+1}
    Log    ${exitEngineering_list}
    Should Contain X Times    ${exitEngineering_list}    === ${subSystem}_exitEngineering start of topic ===    1
    Should Contain X Times    ${exitEngineering_list}    === ackCommand_exitEngineering acknowledging a command with :    2
    Should Contain X Times    ${exitEngineering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${exitEngineering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${exitEngineering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${exitEngineering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${exitEngineering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${exitEngineering_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${exitEngineering_list}    === ${subSystem}_exitEngineering end of topic ===    1
    ${turnAirOn_start}=    Get Index From List    ${full_list}    === MTM1M3_turnAirOn start of topic ===
    ${turnAirOn_end}=    Get Index From List    ${full_list}    === MTM1M3_turnAirOn end of topic ===
    ${turnAirOn_list}=    Get Slice From List    ${full_list}    start=${turnAirOn_start}    end=${turnAirOn_end+1}
    Log    ${turnAirOn_list}
    Should Contain X Times    ${turnAirOn_list}    === ${subSystem}_turnAirOn start of topic ===    1
    Should Contain X Times    ${turnAirOn_list}    === ackCommand_turnAirOn acknowledging a command with :    2
    Should Contain X Times    ${turnAirOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${turnAirOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${turnAirOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${turnAirOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${turnAirOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${turnAirOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${turnAirOn_list}    === ${subSystem}_turnAirOn end of topic ===    1
    ${turnAirOff_start}=    Get Index From List    ${full_list}    === MTM1M3_turnAirOff start of topic ===
    ${turnAirOff_end}=    Get Index From List    ${full_list}    === MTM1M3_turnAirOff end of topic ===
    ${turnAirOff_list}=    Get Slice From List    ${full_list}    start=${turnAirOff_start}    end=${turnAirOff_end+1}
    Log    ${turnAirOff_list}
    Should Contain X Times    ${turnAirOff_list}    === ${subSystem}_turnAirOff start of topic ===    1
    Should Contain X Times    ${turnAirOff_list}    === ackCommand_turnAirOff acknowledging a command with :    2
    Should Contain X Times    ${turnAirOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${turnAirOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${turnAirOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${turnAirOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${turnAirOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${turnAirOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${turnAirOff_list}    === ${subSystem}_turnAirOff end of topic ===    1
    ${boosterValveOpen_start}=    Get Index From List    ${full_list}    === MTM1M3_boosterValveOpen start of topic ===
    ${boosterValveOpen_end}=    Get Index From List    ${full_list}    === MTM1M3_boosterValveOpen end of topic ===
    ${boosterValveOpen_list}=    Get Slice From List    ${full_list}    start=${boosterValveOpen_start}    end=${boosterValveOpen_end+1}
    Log    ${boosterValveOpen_list}
    Should Contain X Times    ${boosterValveOpen_list}    === ${subSystem}_boosterValveOpen start of topic ===    1
    Should Contain X Times    ${boosterValveOpen_list}    === ackCommand_boosterValveOpen acknowledging a command with :    2
    Should Contain X Times    ${boosterValveOpen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${boosterValveOpen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${boosterValveOpen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${boosterValveOpen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${boosterValveOpen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${boosterValveOpen_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${boosterValveOpen_list}    === ${subSystem}_boosterValveOpen end of topic ===    1
    ${boosterValveClose_start}=    Get Index From List    ${full_list}    === MTM1M3_boosterValveClose start of topic ===
    ${boosterValveClose_end}=    Get Index From List    ${full_list}    === MTM1M3_boosterValveClose end of topic ===
    ${boosterValveClose_list}=    Get Slice From List    ${full_list}    start=${boosterValveClose_start}    end=${boosterValveClose_end+1}
    Log    ${boosterValveClose_list}
    Should Contain X Times    ${boosterValveClose_list}    === ${subSystem}_boosterValveClose start of topic ===    1
    Should Contain X Times    ${boosterValveClose_list}    === ackCommand_boosterValveClose acknowledging a command with :    2
    Should Contain X Times    ${boosterValveClose_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${boosterValveClose_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${boosterValveClose_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${boosterValveClose_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${boosterValveClose_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${boosterValveClose_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${boosterValveClose_list}    === ${subSystem}_boosterValveClose end of topic ===    1
    ${moveHardpointActuators_start}=    Get Index From List    ${full_list}    === MTM1M3_moveHardpointActuators start of topic ===
    ${moveHardpointActuators_end}=    Get Index From List    ${full_list}    === MTM1M3_moveHardpointActuators end of topic ===
    ${moveHardpointActuators_list}=    Get Slice From List    ${full_list}    start=${moveHardpointActuators_start}    end=${moveHardpointActuators_end+1}
    Log    ${moveHardpointActuators_list}
    Should Contain X Times    ${moveHardpointActuators_list}    === ${subSystem}_moveHardpointActuators start of topic ===    1
    Should Contain X Times    ${moveHardpointActuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}steps : 0    1
    Should Contain X Times    ${moveHardpointActuators_list}    === ackCommand_moveHardpointActuators acknowledging a command with :    2
    Should Contain X Times    ${moveHardpointActuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${moveHardpointActuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${moveHardpointActuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${moveHardpointActuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${moveHardpointActuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${moveHardpointActuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${moveHardpointActuators_list}    === ${subSystem}_moveHardpointActuators end of topic ===    1
    ${stopHardpointMotion_start}=    Get Index From List    ${full_list}    === MTM1M3_stopHardpointMotion start of topic ===
    ${stopHardpointMotion_end}=    Get Index From List    ${full_list}    === MTM1M3_stopHardpointMotion end of topic ===
    ${stopHardpointMotion_list}=    Get Slice From List    ${full_list}    start=${stopHardpointMotion_start}    end=${stopHardpointMotion_end+1}
    Log    ${stopHardpointMotion_list}
    Should Contain X Times    ${stopHardpointMotion_list}    === ${subSystem}_stopHardpointMotion start of topic ===    1
    Should Contain X Times    ${stopHardpointMotion_list}    === ackCommand_stopHardpointMotion acknowledging a command with :    2
    Should Contain X Times    ${stopHardpointMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${stopHardpointMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${stopHardpointMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${stopHardpointMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${stopHardpointMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${stopHardpointMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${stopHardpointMotion_list}    === ${subSystem}_stopHardpointMotion end of topic ===    1
    ${testHardpoint_start}=    Get Index From List    ${full_list}    === MTM1M3_testHardpoint start of topic ===
    ${testHardpoint_end}=    Get Index From List    ${full_list}    === MTM1M3_testHardpoint end of topic ===
    ${testHardpoint_list}=    Get Slice From List    ${full_list}    start=${testHardpoint_start}    end=${testHardpoint_end+1}
    Log    ${testHardpoint_list}
    Should Contain X Times    ${testHardpoint_list}    === ${subSystem}_testHardpoint start of topic ===    1
    Should Contain X Times    ${testHardpoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointActuator : 1    1
    Should Contain X Times    ${testHardpoint_list}    === ackCommand_testHardpoint acknowledging a command with :    2
    Should Contain X Times    ${testHardpoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${testHardpoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${testHardpoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${testHardpoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${testHardpoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${testHardpoint_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${testHardpoint_list}    === ${subSystem}_testHardpoint end of topic ===    1
    ${killHardpointTest_start}=    Get Index From List    ${full_list}    === MTM1M3_killHardpointTest start of topic ===
    ${killHardpointTest_end}=    Get Index From List    ${full_list}    === MTM1M3_killHardpointTest end of topic ===
    ${killHardpointTest_list}=    Get Slice From List    ${full_list}    start=${killHardpointTest_start}    end=${killHardpointTest_end+1}
    Log    ${killHardpointTest_list}
    Should Contain X Times    ${killHardpointTest_list}    === ${subSystem}_killHardpointTest start of topic ===    1
    Should Contain X Times    ${killHardpointTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hardpointActuator : 1    1
    Should Contain X Times    ${killHardpointTest_list}    === ackCommand_killHardpointTest acknowledging a command with :    2
    Should Contain X Times    ${killHardpointTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${killHardpointTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${killHardpointTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${killHardpointTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${killHardpointTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${killHardpointTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${killHardpointTest_list}    === ${subSystem}_killHardpointTest end of topic ===    1
    ${enableHardpointChase_start}=    Get Index From List    ${full_list}    === MTM1M3_enableHardpointChase start of topic ===
    ${enableHardpointChase_end}=    Get Index From List    ${full_list}    === MTM1M3_enableHardpointChase end of topic ===
    ${enableHardpointChase_list}=    Get Slice From List    ${full_list}    start=${enableHardpointChase_start}    end=${enableHardpointChase_end+1}
    Log    ${enableHardpointChase_list}
    Should Contain X Times    ${enableHardpointChase_list}    === ${subSystem}_enableHardpointChase start of topic ===    1
    Should Contain X Times    ${enableHardpointChase_list}    === ackCommand_enableHardpointChase acknowledging a command with :    2
    Should Contain X Times    ${enableHardpointChase_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${enableHardpointChase_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${enableHardpointChase_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${enableHardpointChase_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${enableHardpointChase_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${enableHardpointChase_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${enableHardpointChase_list}    === ${subSystem}_enableHardpointChase end of topic ===    1
    ${disableHardpointChase_start}=    Get Index From List    ${full_list}    === MTM1M3_disableHardpointChase start of topic ===
    ${disableHardpointChase_end}=    Get Index From List    ${full_list}    === MTM1M3_disableHardpointChase end of topic ===
    ${disableHardpointChase_list}=    Get Slice From List    ${full_list}    start=${disableHardpointChase_start}    end=${disableHardpointChase_end+1}
    Log    ${disableHardpointChase_list}
    Should Contain X Times    ${disableHardpointChase_list}    === ${subSystem}_disableHardpointChase start of topic ===    1
    Should Contain X Times    ${disableHardpointChase_list}    === ackCommand_disableHardpointChase acknowledging a command with :    2
    Should Contain X Times    ${disableHardpointChase_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${disableHardpointChase_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${disableHardpointChase_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${disableHardpointChase_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${disableHardpointChase_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${disableHardpointChase_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${disableHardpointChase_list}    === ${subSystem}_disableHardpointChase end of topic ===    1
    ${applyOffsetForces_start}=    Get Index From List    ${full_list}    === MTM1M3_applyOffsetForces start of topic ===
    ${applyOffsetForces_end}=    Get Index From List    ${full_list}    === MTM1M3_applyOffsetForces end of topic ===
    ${applyOffsetForces_list}=    Get Slice From List    ${full_list}    start=${applyOffsetForces_start}    end=${applyOffsetForces_end+1}
    Log    ${applyOffsetForces_list}
    Should Contain X Times    ${applyOffsetForces_list}    === ${subSystem}_applyOffsetForces start of topic ===    1
    Should Contain X Times    ${applyOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForces : 0    1
    Should Contain X Times    ${applyOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForces : 0    1
    Should Contain X Times    ${applyOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${applyOffsetForces_list}    === ackCommand_applyOffsetForces acknowledging a command with :    2
    Should Contain X Times    ${applyOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${applyOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${applyOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${applyOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${applyOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${applyOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${applyOffsetForces_list}    === ${subSystem}_applyOffsetForces end of topic ===    1
    ${translateM1M3_start}=    Get Index From List    ${full_list}    === MTM1M3_translateM1M3 start of topic ===
    ${translateM1M3_end}=    Get Index From List    ${full_list}    === MTM1M3_translateM1M3 end of topic ===
    ${translateM1M3_list}=    Get Slice From List    ${full_list}    start=${translateM1M3_start}    end=${translateM1M3_end+1}
    Log    ${translateM1M3_list}
    Should Contain X Times    ${translateM1M3_list}    === ${subSystem}_translateM1M3 start of topic ===    1
    Should Contain X Times    ${translateM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xTranslation : 1    1
    Should Contain X Times    ${translateM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yTranslation : 1    1
    Should Contain X Times    ${translateM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zTranslation : 1    1
    Should Contain X Times    ${translateM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xRotation : 1    1
    Should Contain X Times    ${translateM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yRotation : 1    1
    Should Contain X Times    ${translateM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zRotation : 1    1
    Should Contain X Times    ${translateM1M3_list}    === ackCommand_translateM1M3 acknowledging a command with :    2
    Should Contain X Times    ${translateM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${translateM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${translateM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${translateM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${translateM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${translateM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${translateM1M3_list}    === ${subSystem}_translateM1M3 end of topic ===    1
    ${clearOffsetForces_start}=    Get Index From List    ${full_list}    === MTM1M3_clearOffsetForces start of topic ===
    ${clearOffsetForces_end}=    Get Index From List    ${full_list}    === MTM1M3_clearOffsetForces end of topic ===
    ${clearOffsetForces_list}=    Get Slice From List    ${full_list}    start=${clearOffsetForces_start}    end=${clearOffsetForces_end+1}
    Log    ${clearOffsetForces_list}
    Should Contain X Times    ${clearOffsetForces_list}    === ${subSystem}_clearOffsetForces start of topic ===    1
    Should Contain X Times    ${clearOffsetForces_list}    === ackCommand_clearOffsetForces acknowledging a command with :    2
    Should Contain X Times    ${clearOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${clearOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${clearOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${clearOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${clearOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${clearOffsetForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${clearOffsetForces_list}    === ${subSystem}_clearOffsetForces end of topic ===    1
    ${applyActiveOpticForces_start}=    Get Index From List    ${full_list}    === MTM1M3_applyActiveOpticForces start of topic ===
    ${applyActiveOpticForces_end}=    Get Index From List    ${full_list}    === MTM1M3_applyActiveOpticForces end of topic ===
    ${applyActiveOpticForces_list}=    Get Slice From List    ${full_list}    start=${applyActiveOpticForces_start}    end=${applyActiveOpticForces_end+1}
    Log    ${applyActiveOpticForces_list}
    Should Contain X Times    ${applyActiveOpticForces_list}    === ${subSystem}_applyActiveOpticForces start of topic ===    1
    Should Contain X Times    ${applyActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForces : 0    1
    Should Contain X Times    ${applyActiveOpticForces_list}    === ackCommand_applyActiveOpticForces acknowledging a command with :    2
    Should Contain X Times    ${applyActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${applyActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${applyActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${applyActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${applyActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${applyActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${applyActiveOpticForces_list}    === ${subSystem}_applyActiveOpticForces end of topic ===    1
    ${clearActiveOpticForces_start}=    Get Index From List    ${full_list}    === MTM1M3_clearActiveOpticForces start of topic ===
    ${clearActiveOpticForces_end}=    Get Index From List    ${full_list}    === MTM1M3_clearActiveOpticForces end of topic ===
    ${clearActiveOpticForces_list}=    Get Slice From List    ${full_list}    start=${clearActiveOpticForces_start}    end=${clearActiveOpticForces_end+1}
    Log    ${clearActiveOpticForces_list}
    Should Contain X Times    ${clearActiveOpticForces_list}    === ${subSystem}_clearActiveOpticForces start of topic ===    1
    Should Contain X Times    ${clearActiveOpticForces_list}    === ackCommand_clearActiveOpticForces acknowledging a command with :    2
    Should Contain X Times    ${clearActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${clearActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${clearActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${clearActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${clearActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${clearActiveOpticForces_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${clearActiveOpticForces_list}    === ${subSystem}_clearActiveOpticForces end of topic ===    1
    ${positionM1M3_start}=    Get Index From List    ${full_list}    === MTM1M3_positionM1M3 start of topic ===
    ${positionM1M3_end}=    Get Index From List    ${full_list}    === MTM1M3_positionM1M3 end of topic ===
    ${positionM1M3_list}=    Get Slice From List    ${full_list}    start=${positionM1M3_start}    end=${positionM1M3_end+1}
    Log    ${positionM1M3_list}
    Should Contain X Times    ${positionM1M3_list}    === ${subSystem}_positionM1M3 start of topic ===    1
    Should Contain X Times    ${positionM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xPosition : 1    1
    Should Contain X Times    ${positionM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yPosition : 1    1
    Should Contain X Times    ${positionM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zPosition : 1    1
    Should Contain X Times    ${positionM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xRotation : 1    1
    Should Contain X Times    ${positionM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yRotation : 1    1
    Should Contain X Times    ${positionM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zRotation : 1    1
    Should Contain X Times    ${positionM1M3_list}    === ackCommand_positionM1M3 acknowledging a command with :    2
    Should Contain X Times    ${positionM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${positionM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${positionM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${positionM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${positionM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${positionM1M3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${positionM1M3_list}    === ${subSystem}_positionM1M3 end of topic ===    1
    ${turnLightsOn_start}=    Get Index From List    ${full_list}    === MTM1M3_turnLightsOn start of topic ===
    ${turnLightsOn_end}=    Get Index From List    ${full_list}    === MTM1M3_turnLightsOn end of topic ===
    ${turnLightsOn_list}=    Get Slice From List    ${full_list}    start=${turnLightsOn_start}    end=${turnLightsOn_end+1}
    Log    ${turnLightsOn_list}
    Should Contain X Times    ${turnLightsOn_list}    === ${subSystem}_turnLightsOn start of topic ===    1
    Should Contain X Times    ${turnLightsOn_list}    === ackCommand_turnLightsOn acknowledging a command with :    2
    Should Contain X Times    ${turnLightsOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${turnLightsOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${turnLightsOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${turnLightsOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${turnLightsOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${turnLightsOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${turnLightsOn_list}    === ${subSystem}_turnLightsOn end of topic ===    1
    ${turnLightsOff_start}=    Get Index From List    ${full_list}    === MTM1M3_turnLightsOff start of topic ===
    ${turnLightsOff_end}=    Get Index From List    ${full_list}    === MTM1M3_turnLightsOff end of topic ===
    ${turnLightsOff_list}=    Get Slice From List    ${full_list}    start=${turnLightsOff_start}    end=${turnLightsOff_end+1}
    Log    ${turnLightsOff_list}
    Should Contain X Times    ${turnLightsOff_list}    === ${subSystem}_turnLightsOff start of topic ===    1
    Should Contain X Times    ${turnLightsOff_list}    === ackCommand_turnLightsOff acknowledging a command with :    2
    Should Contain X Times    ${turnLightsOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${turnLightsOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${turnLightsOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${turnLightsOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${turnLightsOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${turnLightsOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${turnLightsOff_list}    === ${subSystem}_turnLightsOff end of topic ===    1
    ${turnPowerOn_start}=    Get Index From List    ${full_list}    === MTM1M3_turnPowerOn start of topic ===
    ${turnPowerOn_end}=    Get Index From List    ${full_list}    === MTM1M3_turnPowerOn end of topic ===
    ${turnPowerOn_list}=    Get Slice From List    ${full_list}    start=${turnPowerOn_start}    end=${turnPowerOn_end+1}
    Log    ${turnPowerOn_list}
    Should Contain X Times    ${turnPowerOn_list}    === ${subSystem}_turnPowerOn start of topic ===    1
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnPowerNetworkAOn : 1    1
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnPowerNetworkBOn : 1    1
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnPowerNetworkCOn : 1    1
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnPowerNetworkDOn : 1    1
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnAuxPowerNetworkAOn : 1    1
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnAuxPowerNetworkBOn : 1    1
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnAuxPowerNetworkCOn : 1    1
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnAuxPowerNetworkDOn : 1    1
    Should Contain X Times    ${turnPowerOn_list}    === ackCommand_turnPowerOn acknowledging a command with :    2
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${turnPowerOn_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${turnPowerOn_list}    === ${subSystem}_turnPowerOn end of topic ===    1
    ${turnPowerOff_start}=    Get Index From List    ${full_list}    === MTM1M3_turnPowerOff start of topic ===
    ${turnPowerOff_end}=    Get Index From List    ${full_list}    === MTM1M3_turnPowerOff end of topic ===
    ${turnPowerOff_list}=    Get Slice From List    ${full_list}    start=${turnPowerOff_start}    end=${turnPowerOff_end+1}
    Log    ${turnPowerOff_list}
    Should Contain X Times    ${turnPowerOff_list}    === ${subSystem}_turnPowerOff start of topic ===    1
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnPowerNetworkAOff : 1    1
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnPowerNetworkBOff : 1    1
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnPowerNetworkCOff : 1    1
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnPowerNetworkDOff : 1    1
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnAuxPowerNetworkAOff : 1    1
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnAuxPowerNetworkBOff : 1    1
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnAuxPowerNetworkCOff : 1    1
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turnAuxPowerNetworkDOff : 1    1
    Should Contain X Times    ${turnPowerOff_list}    === ackCommand_turnPowerOff acknowledging a command with :    2
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${turnPowerOff_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${turnPowerOff_list}    === ${subSystem}_turnPowerOff end of topic ===    1
    ${enableHardpointCorrections_start}=    Get Index From List    ${full_list}    === MTM1M3_enableHardpointCorrections start of topic ===
    ${enableHardpointCorrections_end}=    Get Index From List    ${full_list}    === MTM1M3_enableHardpointCorrections end of topic ===
    ${enableHardpointCorrections_list}=    Get Slice From List    ${full_list}    start=${enableHardpointCorrections_start}    end=${enableHardpointCorrections_end+1}
    Log    ${enableHardpointCorrections_list}
    Should Contain X Times    ${enableHardpointCorrections_list}    === ${subSystem}_enableHardpointCorrections start of topic ===    1
    Should Contain X Times    ${enableHardpointCorrections_list}    === ackCommand_enableHardpointCorrections acknowledging a command with :    2
    Should Contain X Times    ${enableHardpointCorrections_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${enableHardpointCorrections_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${enableHardpointCorrections_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${enableHardpointCorrections_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${enableHardpointCorrections_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${enableHardpointCorrections_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${enableHardpointCorrections_list}    === ${subSystem}_enableHardpointCorrections end of topic ===    1
    ${disableHardpointCorrections_start}=    Get Index From List    ${full_list}    === MTM1M3_disableHardpointCorrections start of topic ===
    ${disableHardpointCorrections_end}=    Get Index From List    ${full_list}    === MTM1M3_disableHardpointCorrections end of topic ===
    ${disableHardpointCorrections_list}=    Get Slice From List    ${full_list}    start=${disableHardpointCorrections_start}    end=${disableHardpointCorrections_end+1}
    Log    ${disableHardpointCorrections_list}
    Should Contain X Times    ${disableHardpointCorrections_list}    === ${subSystem}_disableHardpointCorrections start of topic ===    1
    Should Contain X Times    ${disableHardpointCorrections_list}    === ackCommand_disableHardpointCorrections acknowledging a command with :    2
    Should Contain X Times    ${disableHardpointCorrections_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${disableHardpointCorrections_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${disableHardpointCorrections_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${disableHardpointCorrections_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${disableHardpointCorrections_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${disableHardpointCorrections_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${disableHardpointCorrections_list}    === ${subSystem}_disableHardpointCorrections end of topic ===    1
    ${runMirrorForceProfile_start}=    Get Index From List    ${full_list}    === MTM1M3_runMirrorForceProfile start of topic ===
    ${runMirrorForceProfile_end}=    Get Index From List    ${full_list}    === MTM1M3_runMirrorForceProfile end of topic ===
    ${runMirrorForceProfile_list}=    Get Slice From List    ${full_list}    start=${runMirrorForceProfile_start}    end=${runMirrorForceProfile_end+1}
    Log    ${runMirrorForceProfile_list}
    Should Contain X Times    ${runMirrorForceProfile_list}    === ${subSystem}_runMirrorForceProfile start of topic ===    1
    Should Contain X Times    ${runMirrorForceProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForce : 0    1
    Should Contain X Times    ${runMirrorForceProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForce : 0    1
    Should Contain X Times    ${runMirrorForceProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForce : 0    1
    Should Contain X Times    ${runMirrorForceProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xMoment : 0    1
    Should Contain X Times    ${runMirrorForceProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yMoment : 0    1
    Should Contain X Times    ${runMirrorForceProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zMoment : 0    1
    Should Contain X Times    ${runMirrorForceProfile_list}    === ackCommand_runMirrorForceProfile acknowledging a command with :    2
    Should Contain X Times    ${runMirrorForceProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${runMirrorForceProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${runMirrorForceProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${runMirrorForceProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${runMirrorForceProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${runMirrorForceProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${runMirrorForceProfile_list}    === ${subSystem}_runMirrorForceProfile end of topic ===    1
    ${abortProfile_start}=    Get Index From List    ${full_list}    === MTM1M3_abortProfile start of topic ===
    ${abortProfile_end}=    Get Index From List    ${full_list}    === MTM1M3_abortProfile end of topic ===
    ${abortProfile_list}=    Get Slice From List    ${full_list}    start=${abortProfile_start}    end=${abortProfile_end+1}
    Log    ${abortProfile_list}
    Should Contain X Times    ${abortProfile_list}    === ${subSystem}_abortProfile start of topic ===    1
    Should Contain X Times    ${abortProfile_list}    === ackCommand_abortProfile acknowledging a command with :    2
    Should Contain X Times    ${abortProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${abortProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${abortProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${abortProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${abortProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${abortProfile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${abortProfile_list}    === ${subSystem}_abortProfile end of topic ===    1
    ${applyOffsetForcesByMirrorForce_start}=    Get Index From List    ${full_list}    === MTM1M3_applyOffsetForcesByMirrorForce start of topic ===
    ${applyOffsetForcesByMirrorForce_end}=    Get Index From List    ${full_list}    === MTM1M3_applyOffsetForcesByMirrorForce end of topic ===
    ${applyOffsetForcesByMirrorForce_list}=    Get Slice From List    ${full_list}    start=${applyOffsetForcesByMirrorForce_start}    end=${applyOffsetForcesByMirrorForce_end+1}
    Log    ${applyOffsetForcesByMirrorForce_list}
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    === ${subSystem}_applyOffsetForcesByMirrorForce start of topic ===    1
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xForce : 1    1
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yForce : 1    1
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zForce : 1    1
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xMoment : 1    1
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yMoment : 1    1
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zMoment : 1    1
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    === ackCommand_applyOffsetForcesByMirrorForce acknowledging a command with :    2
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${applyOffsetForcesByMirrorForce_list}    === ${subSystem}_applyOffsetForcesByMirrorForce end of topic ===    1
    ${updatePID_start}=    Get Index From List    ${full_list}    === MTM1M3_updatePID start of topic ===
    ${updatePID_end}=    Get Index From List    ${full_list}    === MTM1M3_updatePID end of topic ===
    ${updatePID_list}=    Get Slice From List    ${full_list}    start=${updatePID_start}    end=${updatePID_end+1}
    Log    ${updatePID_list}
    Should Contain X Times    ${updatePID_list}    === ${subSystem}_updatePID start of topic ===    1
    Should Contain X Times    ${updatePID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pid : 1    1
    Should Contain X Times    ${updatePID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestep : 1    1
    Should Contain X Times    ${updatePID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}p : 1    1
    Should Contain X Times    ${updatePID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 1    1
    Should Contain X Times    ${updatePID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}d : 1    1
    Should Contain X Times    ${updatePID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}n : 1    1
    Should Contain X Times    ${updatePID_list}    === ackCommand_updatePID acknowledging a command with :    2
    Should Contain X Times    ${updatePID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${updatePID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${updatePID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${updatePID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${updatePID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${updatePID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${updatePID_list}    === ${subSystem}_updatePID end of topic ===    1
    ${resetPID_start}=    Get Index From List    ${full_list}    === MTM1M3_resetPID start of topic ===
    ${resetPID_end}=    Get Index From List    ${full_list}    === MTM1M3_resetPID end of topic ===
    ${resetPID_list}=    Get Slice From List    ${full_list}    start=${resetPID_start}    end=${resetPID_end+1}
    Log    ${resetPID_list}
    Should Contain X Times    ${resetPID_list}    === ${subSystem}_resetPID start of topic ===    1
    Should Contain X Times    ${resetPID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pid : 1    1
    Should Contain X Times    ${resetPID_list}    === ackCommand_resetPID acknowledging a command with :    2
    Should Contain X Times    ${resetPID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${resetPID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${resetPID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${resetPID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${resetPID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${resetPID_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${resetPID_list}    === ${subSystem}_resetPID end of topic ===    1
    ${forceActuatorBumpTest_start}=    Get Index From List    ${full_list}    === MTM1M3_forceActuatorBumpTest start of topic ===
    ${forceActuatorBumpTest_end}=    Get Index From List    ${full_list}    === MTM1M3_forceActuatorBumpTest end of topic ===
    ${forceActuatorBumpTest_list}=    Get Slice From List    ${full_list}    start=${forceActuatorBumpTest_start}    end=${forceActuatorBumpTest_end+1}
    Log    ${forceActuatorBumpTest_list}
    Should Contain X Times    ${forceActuatorBumpTest_list}    === ${subSystem}_forceActuatorBumpTest start of topic ===    1
    Should Contain X Times    ${forceActuatorBumpTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actuatorId : 1    1
    Should Contain X Times    ${forceActuatorBumpTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}testPrimary : 1    1
    Should Contain X Times    ${forceActuatorBumpTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}testSecondary : 1    1
    Should Contain X Times    ${forceActuatorBumpTest_list}    === ackCommand_forceActuatorBumpTest acknowledging a command with :    2
    Should Contain X Times    ${forceActuatorBumpTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${forceActuatorBumpTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${forceActuatorBumpTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${forceActuatorBumpTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${forceActuatorBumpTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${forceActuatorBumpTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${forceActuatorBumpTest_list}    === ${subSystem}_forceActuatorBumpTest end of topic ===    1
    ${killForceActuatorBumpTest_start}=    Get Index From List    ${full_list}    === MTM1M3_killForceActuatorBumpTest start of topic ===
    ${killForceActuatorBumpTest_end}=    Get Index From List    ${full_list}    === MTM1M3_killForceActuatorBumpTest end of topic ===
    ${killForceActuatorBumpTest_list}=    Get Slice From List    ${full_list}    start=${killForceActuatorBumpTest_start}    end=${killForceActuatorBumpTest_end+1}
    Log    ${killForceActuatorBumpTest_list}
    Should Contain X Times    ${killForceActuatorBumpTest_list}    === ${subSystem}_killForceActuatorBumpTest start of topic ===    1
    Should Contain X Times    ${killForceActuatorBumpTest_list}    === ackCommand_killForceActuatorBumpTest acknowledging a command with :    2
    Should Contain X Times    ${killForceActuatorBumpTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${killForceActuatorBumpTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${killForceActuatorBumpTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${killForceActuatorBumpTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${killForceActuatorBumpTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${killForceActuatorBumpTest_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${killForceActuatorBumpTest_list}    === ${subSystem}_killForceActuatorBumpTest end of topic ===    1
    ${disableForceActuator_start}=    Get Index From List    ${full_list}    === MTM1M3_disableForceActuator start of topic ===
    ${disableForceActuator_end}=    Get Index From List    ${full_list}    === MTM1M3_disableForceActuator end of topic ===
    ${disableForceActuator_list}=    Get Slice From List    ${full_list}    start=${disableForceActuator_start}    end=${disableForceActuator_end+1}
    Log    ${disableForceActuator_list}
    Should Contain X Times    ${disableForceActuator_list}    === ${subSystem}_disableForceActuator start of topic ===    1
    Should Contain X Times    ${disableForceActuator_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actuatorId : 1    1
    Should Contain X Times    ${disableForceActuator_list}    === ackCommand_disableForceActuator acknowledging a command with :    2
    Should Contain X Times    ${disableForceActuator_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${disableForceActuator_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${disableForceActuator_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${disableForceActuator_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${disableForceActuator_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${disableForceActuator_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${disableForceActuator_list}    === ${subSystem}_disableForceActuator end of topic ===    1
    ${enableForceActuator_start}=    Get Index From List    ${full_list}    === MTM1M3_enableForceActuator start of topic ===
    ${enableForceActuator_end}=    Get Index From List    ${full_list}    === MTM1M3_enableForceActuator end of topic ===
    ${enableForceActuator_list}=    Get Slice From List    ${full_list}    start=${enableForceActuator_start}    end=${enableForceActuator_end+1}
    Log    ${enableForceActuator_list}
    Should Contain X Times    ${enableForceActuator_list}    === ${subSystem}_enableForceActuator start of topic ===    1
    Should Contain X Times    ${enableForceActuator_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actuatorId : 1    1
    Should Contain X Times    ${enableForceActuator_list}    === ackCommand_enableForceActuator acknowledging a command with :    2
    Should Contain X Times    ${enableForceActuator_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${enableForceActuator_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${enableForceActuator_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${enableForceActuator_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${enableForceActuator_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${enableForceActuator_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${enableForceActuator_list}    === ${subSystem}_enableForceActuator end of topic ===    1
    ${enableAllForceActuators_start}=    Get Index From List    ${full_list}    === MTM1M3_enableAllForceActuators start of topic ===
    ${enableAllForceActuators_end}=    Get Index From List    ${full_list}    === MTM1M3_enableAllForceActuators end of topic ===
    ${enableAllForceActuators_list}=    Get Slice From List    ${full_list}    start=${enableAllForceActuators_start}    end=${enableAllForceActuators_end+1}
    Log    ${enableAllForceActuators_list}
    Should Contain X Times    ${enableAllForceActuators_list}    === ${subSystem}_enableAllForceActuators start of topic ===    1
    Should Contain X Times    ${enableAllForceActuators_list}    === ackCommand_enableAllForceActuators acknowledging a command with :    2
    Should Contain X Times    ${enableAllForceActuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${enableAllForceActuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${enableAllForceActuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${enableAllForceActuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${enableAllForceActuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${enableAllForceActuators_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${enableAllForceActuators_list}    === ${subSystem}_enableAllForceActuators end of topic ===    1
    ${enableDisableForceComponent_start}=    Get Index From List    ${full_list}    === MTM1M3_enableDisableForceComponent start of topic ===
    ${enableDisableForceComponent_end}=    Get Index From List    ${full_list}    === MTM1M3_enableDisableForceComponent end of topic ===
    ${enableDisableForceComponent_list}=    Get Slice From List    ${full_list}    start=${enableDisableForceComponent_start}    end=${enableDisableForceComponent_end+1}
    Log    ${enableDisableForceComponent_list}
    Should Contain X Times    ${enableDisableForceComponent_list}    === ${subSystem}_enableDisableForceComponent start of topic ===    1
    Should Contain X Times    ${enableDisableForceComponent_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forceComponent : 1    1
    Should Contain X Times    ${enableDisableForceComponent_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enable : 1    1
    Should Contain X Times    ${enableDisableForceComponent_list}    === ackCommand_enableDisableForceComponent acknowledging a command with :    2
    Should Contain X Times    ${enableDisableForceComponent_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${enableDisableForceComponent_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${enableDisableForceComponent_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${enableDisableForceComponent_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${enableDisableForceComponent_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${enableDisableForceComponent_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${enableDisableForceComponent_list}    === ${subSystem}_enableDisableForceComponent end of topic ===    1
    ${setSlewControllerSettings_start}=    Get Index From List    ${full_list}    === MTM1M3_setSlewControllerSettings start of topic ===
    ${setSlewControllerSettings_end}=    Get Index From List    ${full_list}    === MTM1M3_setSlewControllerSettings end of topic ===
    ${setSlewControllerSettings_list}=    Get Slice From List    ${full_list}    start=${setSlewControllerSettings_start}    end=${setSlewControllerSettings_end+1}
    Log    ${setSlewControllerSettings_list}
    Should Contain X Times    ${setSlewControllerSettings_list}    === ${subSystem}_setSlewControllerSettings start of topic ===    1
    Should Contain X Times    ${setSlewControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}slewSettings : 1    1
    Should Contain X Times    ${setSlewControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enableSlewManagement : 1    1
    Should Contain X Times    ${setSlewControllerSettings_list}    === ackCommand_setSlewControllerSettings acknowledging a command with :    2
    Should Contain X Times    ${setSlewControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${setSlewControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${setSlewControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${setSlewControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${setSlewControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${setSlewControllerSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${setSlewControllerSettings_list}    === ${subSystem}_setSlewControllerSettings end of topic ===    1
    ${disable_start}=    Get Index From List    ${full_list}    === MTM1M3_disable start of topic ===
    ${disable_end}=    Get Index From List    ${full_list}    === MTM1M3_disable end of topic ===
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
    ${enable_start}=    Get Index From List    ${full_list}    === MTM1M3_enable start of topic ===
    ${enable_end}=    Get Index From List    ${full_list}    === MTM1M3_enable end of topic ===
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
    ${exitControl_start}=    Get Index From List    ${full_list}    === MTM1M3_exitControl start of topic ===
    ${exitControl_end}=    Get Index From List    ${full_list}    === MTM1M3_exitControl end of topic ===
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
    ${setLogLevel_start}=    Get Index From List    ${full_list}    === MTM1M3_setLogLevel start of topic ===
    ${setLogLevel_end}=    Get Index From List    ${full_list}    === MTM1M3_setLogLevel end of topic ===
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
    ${standby_start}=    Get Index From List    ${full_list}    === MTM1M3_standby start of topic ===
    ${standby_end}=    Get Index From List    ${full_list}    === MTM1M3_standby end of topic ===
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
    ${start_start}=    Get Index From List    ${full_list}    === MTM1M3_start start of topic ===
    ${start_end}=    Get Index From List    ${full_list}    === MTM1M3_start end of topic ===
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
