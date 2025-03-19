*** Settings ***
Documentation    MTMount_Commands communications tests.
Force Tags    messaging    cpp    mtmount    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}common.robot
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTMount
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
    Comment    ======= Verify ${subSystem}_closeMirrorCovers test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${closeMirrorCovers_start}=    Get Index From List    ${full_list}    === MTMount_closeMirrorCovers start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_closeMirrorCovers command*
    ${closeMirrorCovers_end}=    Get Index From List    ${full_list}    ${line}
    ${closeMirrorCovers_list}=    Get Slice From List    ${full_list}    start=${closeMirrorCovers_start}    end=${closeMirrorCovers_end+3}
    Log    ${closeMirrorCovers_list}
    Should Contain X Times    ${closeMirrorCovers_list}    === ${subSystem}_closeMirrorCovers start of topic ===    1
    Should Contain    ${closeMirrorCovers_list}    === issueCommand_closeMirrorCovers writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${closeMirrorCovers_list}[-2]    Command roundtrip was
    Should Be Equal    ${closeMirrorCovers_list}[-1]    303
    Should Contain    ${closeMirrorCovers_list}    === ${subSystem}_closeMirrorCovers end of topic ===
    Comment    ======= Verify ${subSystem}_openMirrorCovers test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${openMirrorCovers_start}=    Get Index From List    ${full_list}    === MTMount_openMirrorCovers start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_openMirrorCovers command*
    ${openMirrorCovers_end}=    Get Index From List    ${full_list}    ${line}
    ${openMirrorCovers_list}=    Get Slice From List    ${full_list}    start=${openMirrorCovers_start}    end=${openMirrorCovers_end+3}
    Log    ${openMirrorCovers_list}
    Should Contain X Times    ${openMirrorCovers_list}    === ${subSystem}_openMirrorCovers start of topic ===    1
    Should Contain X Times    ${openMirrorCovers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}leaf : 1    1
    Should Contain    ${openMirrorCovers_list}    === issueCommand_openMirrorCovers writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${openMirrorCovers_list}[-2]    Command roundtrip was
    Should Be Equal    ${openMirrorCovers_list}[-1]    303
    Should Contain    ${openMirrorCovers_list}    === ${subSystem}_openMirrorCovers end of topic ===
    Comment    ======= Verify ${subSystem}_disableCameraCableWrapFollowing test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${disableCameraCableWrapFollowing_start}=    Get Index From List    ${full_list}    === MTMount_disableCameraCableWrapFollowing start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_disableCameraCableWrapFollowing command*
    ${disableCameraCableWrapFollowing_end}=    Get Index From List    ${full_list}    ${line}
    ${disableCameraCableWrapFollowing_list}=    Get Slice From List    ${full_list}    start=${disableCameraCableWrapFollowing_start}    end=${disableCameraCableWrapFollowing_end+3}
    Log    ${disableCameraCableWrapFollowing_list}
    Should Contain X Times    ${disableCameraCableWrapFollowing_list}    === ${subSystem}_disableCameraCableWrapFollowing start of topic ===    1
    Should Contain    ${disableCameraCableWrapFollowing_list}    === issueCommand_disableCameraCableWrapFollowing writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${disableCameraCableWrapFollowing_list}[-2]    Command roundtrip was
    Should Be Equal    ${disableCameraCableWrapFollowing_list}[-1]    303
    Should Contain    ${disableCameraCableWrapFollowing_list}    === ${subSystem}_disableCameraCableWrapFollowing end of topic ===
    Comment    ======= Verify ${subSystem}_enableCameraCableWrapFollowing test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${enableCameraCableWrapFollowing_start}=    Get Index From List    ${full_list}    === MTMount_enableCameraCableWrapFollowing start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_enableCameraCableWrapFollowing command*
    ${enableCameraCableWrapFollowing_end}=    Get Index From List    ${full_list}    ${line}
    ${enableCameraCableWrapFollowing_list}=    Get Slice From List    ${full_list}    start=${enableCameraCableWrapFollowing_start}    end=${enableCameraCableWrapFollowing_end+3}
    Log    ${enableCameraCableWrapFollowing_list}
    Should Contain X Times    ${enableCameraCableWrapFollowing_list}    === ${subSystem}_enableCameraCableWrapFollowing start of topic ===    1
    Should Contain    ${enableCameraCableWrapFollowing_list}    === issueCommand_enableCameraCableWrapFollowing writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${enableCameraCableWrapFollowing_list}[-2]    Command roundtrip was
    Should Be Equal    ${enableCameraCableWrapFollowing_list}[-1]    303
    Should Contain    ${enableCameraCableWrapFollowing_list}    === ${subSystem}_enableCameraCableWrapFollowing end of topic ===
    Comment    ======= Verify ${subSystem}_homeBothAxes test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${homeBothAxes_start}=    Get Index From List    ${full_list}    === MTMount_homeBothAxes start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_homeBothAxes command*
    ${homeBothAxes_end}=    Get Index From List    ${full_list}    ${line}
    ${homeBothAxes_list}=    Get Slice From List    ${full_list}    start=${homeBothAxes_start}    end=${homeBothAxes_end+3}
    Log    ${homeBothAxes_list}
    Should Contain X Times    ${homeBothAxes_list}    === ${subSystem}_homeBothAxes start of topic ===    1
    Should Contain    ${homeBothAxes_list}    === issueCommand_homeBothAxes writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${homeBothAxes_list}[-2]    Command roundtrip was
    Should Be Equal    ${homeBothAxes_list}[-1]    303
    Should Contain    ${homeBothAxes_list}    === ${subSystem}_homeBothAxes end of topic ===
    Comment    ======= Verify ${subSystem}_park test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${park_start}=    Get Index From List    ${full_list}    === MTMount_park start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_park command*
    ${park_end}=    Get Index From List    ${full_list}    ${line}
    ${park_list}=    Get Slice From List    ${full_list}    start=${park_start}    end=${park_end+3}
    Log    ${park_list}
    Should Contain X Times    ${park_list}    === ${subSystem}_park start of topic ===    1
    Should Contain X Times    ${park_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 1    1
    Should Contain    ${park_list}    === issueCommand_park writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${park_list}[-2]    Command roundtrip was
    Should Be Equal    ${park_list}[-1]    303
    Should Contain    ${park_list}    === ${subSystem}_park end of topic ===
    Comment    ======= Verify ${subSystem}_unpark test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${unpark_start}=    Get Index From List    ${full_list}    === MTMount_unpark start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_unpark command*
    ${unpark_end}=    Get Index From List    ${full_list}    ${line}
    ${unpark_list}=    Get Slice From List    ${full_list}    start=${unpark_start}    end=${unpark_end+3}
    Log    ${unpark_list}
    Should Contain X Times    ${unpark_list}    === ${subSystem}_unpark start of topic ===    1
    Should Contain    ${unpark_list}    === issueCommand_unpark writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${unpark_list}[-2]    Command roundtrip was
    Should Be Equal    ${unpark_list}[-1]    303
    Should Contain    ${unpark_list}    === ${subSystem}_unpark end of topic ===
    Comment    ======= Verify ${subSystem}_restoreDefaultSettings test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${restoreDefaultSettings_start}=    Get Index From List    ${full_list}    === MTMount_restoreDefaultSettings start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_restoreDefaultSettings command*
    ${restoreDefaultSettings_end}=    Get Index From List    ${full_list}    ${line}
    ${restoreDefaultSettings_list}=    Get Slice From List    ${full_list}    start=${restoreDefaultSettings_start}    end=${restoreDefaultSettings_end+3}
    Log    ${restoreDefaultSettings_list}
    Should Contain X Times    ${restoreDefaultSettings_list}    === ${subSystem}_restoreDefaultSettings start of topic ===    1
    Should Contain    ${restoreDefaultSettings_list}    === issueCommand_restoreDefaultSettings writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${restoreDefaultSettings_list}[-2]    Command roundtrip was
    Should Be Equal    ${restoreDefaultSettings_list}[-1]    303
    Should Contain    ${restoreDefaultSettings_list}    === ${subSystem}_restoreDefaultSettings end of topic ===
    Comment    ======= Verify ${subSystem}_applySettingsSet test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${applySettingsSet_start}=    Get Index From List    ${full_list}    === MTMount_applySettingsSet start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_applySettingsSet command*
    ${applySettingsSet_end}=    Get Index From List    ${full_list}    ${line}
    ${applySettingsSet_list}=    Get Slice From List    ${full_list}    start=${applySettingsSet_start}    end=${applySettingsSet_end+3}
    Log    ${applySettingsSet_list}
    Should Contain X Times    ${applySettingsSet_list}    === ${subSystem}_applySettingsSet start of topic ===    1
    Should Contain X Times    ${applySettingsSet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}restoreDefaults : 1    1
    Should Contain X Times    ${applySettingsSet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settings : RO    1
    Should Contain    ${applySettingsSet_list}    === issueCommand_applySettingsSet writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${applySettingsSet_list}[-2]    Command roundtrip was
    Should Be Equal    ${applySettingsSet_list}[-1]    303
    Should Contain    ${applySettingsSet_list}    === ${subSystem}_applySettingsSet end of topic ===
    Comment    ======= Verify ${subSystem}_moveToTarget test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${moveToTarget_start}=    Get Index From List    ${full_list}    === MTMount_moveToTarget start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_moveToTarget command*
    ${moveToTarget_end}=    Get Index From List    ${full_list}    ${line}
    ${moveToTarget_list}=    Get Slice From List    ${full_list}    start=${moveToTarget_start}    end=${moveToTarget_end+3}
    Log    ${moveToTarget_list}
    Should Contain X Times    ${moveToTarget_list}    === ${subSystem}_moveToTarget start of topic ===    1
    Should Contain X Times    ${moveToTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${moveToTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain    ${moveToTarget_list}    === issueCommand_moveToTarget writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${moveToTarget_list}[-2]    Command roundtrip was
    Should Be Equal    ${moveToTarget_list}[-1]    303
    Should Contain    ${moveToTarget_list}    === ${subSystem}_moveToTarget end of topic ===
    Comment    ======= Verify ${subSystem}_setThermal test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${setThermal_start}=    Get Index From List    ${full_list}    === MTMount_setThermal start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_setThermal command*
    ${setThermal_end}=    Get Index From List    ${full_list}    ${line}
    ${setThermal_list}=    Get Slice From List    ${full_list}    start=${setThermal_start}    end=${setThermal_end+3}
    Log    ${setThermal_list}
    Should Contain X Times    ${setThermal_list}    === ${subSystem}_setThermal start of topic ===    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthDrivesState : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationDrivesState : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabinet0101State : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetState : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxiliaryCabinetsState : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilSupplySystemCabinetState : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}topEndChillerState : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthDrivesSetpoint : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationDrivesSetpoint : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabinet0101Setpoint : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetSetpoint : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxiliaryCabinetsSetpoint : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilSupplySystemCabinetSetpoint : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}topEndChillerSetpoint : 1    1
    Should Contain    ${setThermal_list}    === issueCommand_setThermal writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${setThermal_list}[-2]    Command roundtrip was
    Should Be Equal    ${setThermal_list}[-1]    303
    Should Contain    ${setThermal_list}    === ${subSystem}_setThermal end of topic ===
    Comment    ======= Verify ${subSystem}_startTracking test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${startTracking_start}=    Get Index From List    ${full_list}    === MTMount_startTracking start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_startTracking command*
    ${startTracking_end}=    Get Index From List    ${full_list}    ${line}
    ${startTracking_list}=    Get Slice From List    ${full_list}    start=${startTracking_start}    end=${startTracking_end+3}
    Log    ${startTracking_list}
    Should Contain X Times    ${startTracking_list}    === ${subSystem}_startTracking start of topic ===    1
    Should Contain    ${startTracking_list}    === issueCommand_startTracking writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${startTracking_list}[-2]    Command roundtrip was
    Should Be Equal    ${startTracking_list}[-1]    303
    Should Contain    ${startTracking_list}    === ${subSystem}_startTracking end of topic ===
    Comment    ======= Verify ${subSystem}_trackTarget test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${trackTarget_start}=    Get Index From List    ${full_list}    === MTMount_trackTarget start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_trackTarget command*
    ${trackTarget_end}=    Get Index From List    ${full_list}    ${line}
    ${trackTarget_list}=    Get Slice From List    ${full_list}    start=${trackTarget_start}    end=${trackTarget_end+3}
    Log    ${trackTarget_list}
    Should Contain X Times    ${trackTarget_list}    === ${subSystem}_trackTarget start of topic ===    1
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthVelocity : 1    1
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationVelocity : 1    1
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}taiTime : 1    1
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    1
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tracksys : RO    1
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}radesys : RO    1
    Should Contain    ${trackTarget_list}    === issueCommand_trackTarget writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${trackTarget_list}[-2]    Command roundtrip was
    Should Be Equal    ${trackTarget_list}[-1]    303
    Should Contain    ${trackTarget_list}    === ${subSystem}_trackTarget end of topic ===
    Comment    ======= Verify ${subSystem}_stopTracking test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${stopTracking_start}=    Get Index From List    ${full_list}    === MTMount_stopTracking start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_stopTracking command*
    ${stopTracking_end}=    Get Index From List    ${full_list}    ${line}
    ${stopTracking_list}=    Get Slice From List    ${full_list}    start=${stopTracking_start}    end=${stopTracking_end+3}
    Log    ${stopTracking_list}
    Should Contain X Times    ${stopTracking_list}    === ${subSystem}_stopTracking start of topic ===    1
    Should Contain    ${stopTracking_list}    === issueCommand_stopTracking writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${stopTracking_list}[-2]    Command roundtrip was
    Should Be Equal    ${stopTracking_list}[-1]    303
    Should Contain    ${stopTracking_list}    === ${subSystem}_stopTracking end of topic ===
    Comment    ======= Verify ${subSystem}_stop test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${stop_start}=    Get Index From List    ${full_list}    === MTMount_stop start of topic ===
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
    Comment    ======= Verify ${subSystem}_clearError test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${clearError_start}=    Get Index From List    ${full_list}    === MTMount_clearError start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_clearError command*
    ${clearError_end}=    Get Index From List    ${full_list}    ${line}
    ${clearError_list}=    Get Slice From List    ${full_list}    start=${clearError_start}    end=${clearError_end+3}
    Log    ${clearError_list}
    Should Contain X Times    ${clearError_list}    === ${subSystem}_clearError start of topic ===    1
    Should Contain X Times    ${clearError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mask : 1    1
    Should Contain    ${clearError_list}    === issueCommand_clearError writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${clearError_list}[-2]    Command roundtrip was
    Should Be Equal    ${clearError_list}[-1]    303
    Should Contain    ${clearError_list}    === ${subSystem}_clearError end of topic ===
    Comment    ======= Verify ${subSystem}_lockMotion test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${lockMotion_start}=    Get Index From List    ${full_list}    === MTMount_lockMotion start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_lockMotion command*
    ${lockMotion_end}=    Get Index From List    ${full_list}    ${line}
    ${lockMotion_list}=    Get Slice From List    ${full_list}    start=${lockMotion_start}    end=${lockMotion_end+3}
    Log    ${lockMotion_list}
    Should Contain X Times    ${lockMotion_list}    === ${subSystem}_lockMotion start of topic ===    1
    Should Contain    ${lockMotion_list}    === issueCommand_lockMotion writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${lockMotion_list}[-2]    Command roundtrip was
    Should Be Equal    ${lockMotion_list}[-1]    303
    Should Contain    ${lockMotion_list}    === ${subSystem}_lockMotion end of topic ===
    Comment    ======= Verify ${subSystem}_unlockMotion test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${unlockMotion_start}=    Get Index From List    ${full_list}    === MTMount_unlockMotion start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_unlockMotion command*
    ${unlockMotion_end}=    Get Index From List    ${full_list}    ${line}
    ${unlockMotion_list}=    Get Slice From List    ${full_list}    start=${unlockMotion_start}    end=${unlockMotion_end+3}
    Log    ${unlockMotion_list}
    Should Contain X Times    ${unlockMotion_list}    === ${subSystem}_unlockMotion start of topic ===    1
    Should Contain    ${unlockMotion_list}    === issueCommand_unlockMotion writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${unlockMotion_list}[-2]    Command roundtrip was
    Should Be Equal    ${unlockMotion_list}[-1]    303
    Should Contain    ${unlockMotion_list}    === ${subSystem}_unlockMotion end of topic ===
    Comment    ======= Verify ${subSystem}_disable test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${disable_start}=    Get Index From List    ${full_list}    === MTMount_disable start of topic ===
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
    ${enable_start}=    Get Index From List    ${full_list}    === MTMount_enable start of topic ===
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
    ${exitControl_start}=    Get Index From List    ${full_list}    === MTMount_exitControl start of topic ===
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
    ${setLogLevel_start}=    Get Index From List    ${full_list}    === MTMount_setLogLevel start of topic ===
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
    ${standby_start}=    Get Index From List    ${full_list}    === MTMount_standby start of topic ===
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
    ${start_start}=    Get Index From List    ${full_list}    === MTMount_start start of topic ===
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
    ${closeMirrorCovers_start}=    Get Index From List    ${full_list}    === MTMount_closeMirrorCovers start of topic ===
    ${closeMirrorCovers_end}=    Get Index From List    ${full_list}    === MTMount_closeMirrorCovers end of topic ===
    ${closeMirrorCovers_list}=    Get Slice From List    ${full_list}    start=${closeMirrorCovers_start}    end=${closeMirrorCovers_end+1}
    Log    ${closeMirrorCovers_list}
    Should Contain X Times    ${closeMirrorCovers_list}    === ${subSystem}_closeMirrorCovers start of topic ===    1
    Should Contain X Times    ${closeMirrorCovers_list}    === ackCommand_closeMirrorCovers acknowledging a command with :    2
    Should Contain X Times    ${closeMirrorCovers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${closeMirrorCovers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${closeMirrorCovers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${closeMirrorCovers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${closeMirrorCovers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${closeMirrorCovers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${closeMirrorCovers_list}    === ${subSystem}_closeMirrorCovers end of topic ===    1
    ${openMirrorCovers_start}=    Get Index From List    ${full_list}    === MTMount_openMirrorCovers start of topic ===
    ${openMirrorCovers_end}=    Get Index From List    ${full_list}    === MTMount_openMirrorCovers end of topic ===
    ${openMirrorCovers_list}=    Get Slice From List    ${full_list}    start=${openMirrorCovers_start}    end=${openMirrorCovers_end+1}
    Log    ${openMirrorCovers_list}
    Should Contain X Times    ${openMirrorCovers_list}    === ${subSystem}_openMirrorCovers start of topic ===    1
    Should Contain X Times    ${openMirrorCovers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}leaf : 1    1
    Should Contain X Times    ${openMirrorCovers_list}    === ackCommand_openMirrorCovers acknowledging a command with :    2
    Should Contain X Times    ${openMirrorCovers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${openMirrorCovers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${openMirrorCovers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${openMirrorCovers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${openMirrorCovers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${openMirrorCovers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${openMirrorCovers_list}    === ${subSystem}_openMirrorCovers end of topic ===    1
    ${disableCameraCableWrapFollowing_start}=    Get Index From List    ${full_list}    === MTMount_disableCameraCableWrapFollowing start of topic ===
    ${disableCameraCableWrapFollowing_end}=    Get Index From List    ${full_list}    === MTMount_disableCameraCableWrapFollowing end of topic ===
    ${disableCameraCableWrapFollowing_list}=    Get Slice From List    ${full_list}    start=${disableCameraCableWrapFollowing_start}    end=${disableCameraCableWrapFollowing_end+1}
    Log    ${disableCameraCableWrapFollowing_list}
    Should Contain X Times    ${disableCameraCableWrapFollowing_list}    === ${subSystem}_disableCameraCableWrapFollowing start of topic ===    1
    Should Contain X Times    ${disableCameraCableWrapFollowing_list}    === ackCommand_disableCameraCableWrapFollowing acknowledging a command with :    2
    Should Contain X Times    ${disableCameraCableWrapFollowing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${disableCameraCableWrapFollowing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${disableCameraCableWrapFollowing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${disableCameraCableWrapFollowing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${disableCameraCableWrapFollowing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${disableCameraCableWrapFollowing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${disableCameraCableWrapFollowing_list}    === ${subSystem}_disableCameraCableWrapFollowing end of topic ===    1
    ${enableCameraCableWrapFollowing_start}=    Get Index From List    ${full_list}    === MTMount_enableCameraCableWrapFollowing start of topic ===
    ${enableCameraCableWrapFollowing_end}=    Get Index From List    ${full_list}    === MTMount_enableCameraCableWrapFollowing end of topic ===
    ${enableCameraCableWrapFollowing_list}=    Get Slice From List    ${full_list}    start=${enableCameraCableWrapFollowing_start}    end=${enableCameraCableWrapFollowing_end+1}
    Log    ${enableCameraCableWrapFollowing_list}
    Should Contain X Times    ${enableCameraCableWrapFollowing_list}    === ${subSystem}_enableCameraCableWrapFollowing start of topic ===    1
    Should Contain X Times    ${enableCameraCableWrapFollowing_list}    === ackCommand_enableCameraCableWrapFollowing acknowledging a command with :    2
    Should Contain X Times    ${enableCameraCableWrapFollowing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${enableCameraCableWrapFollowing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${enableCameraCableWrapFollowing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${enableCameraCableWrapFollowing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${enableCameraCableWrapFollowing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${enableCameraCableWrapFollowing_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${enableCameraCableWrapFollowing_list}    === ${subSystem}_enableCameraCableWrapFollowing end of topic ===    1
    ${homeBothAxes_start}=    Get Index From List    ${full_list}    === MTMount_homeBothAxes start of topic ===
    ${homeBothAxes_end}=    Get Index From List    ${full_list}    === MTMount_homeBothAxes end of topic ===
    ${homeBothAxes_list}=    Get Slice From List    ${full_list}    start=${homeBothAxes_start}    end=${homeBothAxes_end+1}
    Log    ${homeBothAxes_list}
    Should Contain X Times    ${homeBothAxes_list}    === ${subSystem}_homeBothAxes start of topic ===    1
    Should Contain X Times    ${homeBothAxes_list}    === ackCommand_homeBothAxes acknowledging a command with :    2
    Should Contain X Times    ${homeBothAxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${homeBothAxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${homeBothAxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${homeBothAxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${homeBothAxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${homeBothAxes_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${homeBothAxes_list}    === ${subSystem}_homeBothAxes end of topic ===    1
    ${park_start}=    Get Index From List    ${full_list}    === MTMount_park start of topic ===
    ${park_end}=    Get Index From List    ${full_list}    === MTMount_park end of topic ===
    ${park_list}=    Get Slice From List    ${full_list}    start=${park_start}    end=${park_end+1}
    Log    ${park_list}
    Should Contain X Times    ${park_list}    === ${subSystem}_park start of topic ===    1
    Should Contain X Times    ${park_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 1    1
    Should Contain X Times    ${park_list}    === ackCommand_park acknowledging a command with :    2
    Should Contain X Times    ${park_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${park_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${park_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${park_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${park_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${park_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${park_list}    === ${subSystem}_park end of topic ===    1
    ${unpark_start}=    Get Index From List    ${full_list}    === MTMount_unpark start of topic ===
    ${unpark_end}=    Get Index From List    ${full_list}    === MTMount_unpark end of topic ===
    ${unpark_list}=    Get Slice From List    ${full_list}    start=${unpark_start}    end=${unpark_end+1}
    Log    ${unpark_list}
    Should Contain X Times    ${unpark_list}    === ${subSystem}_unpark start of topic ===    1
    Should Contain X Times    ${unpark_list}    === ackCommand_unpark acknowledging a command with :    2
    Should Contain X Times    ${unpark_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${unpark_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${unpark_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${unpark_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${unpark_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${unpark_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${unpark_list}    === ${subSystem}_unpark end of topic ===    1
    ${restoreDefaultSettings_start}=    Get Index From List    ${full_list}    === MTMount_restoreDefaultSettings start of topic ===
    ${restoreDefaultSettings_end}=    Get Index From List    ${full_list}    === MTMount_restoreDefaultSettings end of topic ===
    ${restoreDefaultSettings_list}=    Get Slice From List    ${full_list}    start=${restoreDefaultSettings_start}    end=${restoreDefaultSettings_end+1}
    Log    ${restoreDefaultSettings_list}
    Should Contain X Times    ${restoreDefaultSettings_list}    === ${subSystem}_restoreDefaultSettings start of topic ===    1
    Should Contain X Times    ${restoreDefaultSettings_list}    === ackCommand_restoreDefaultSettings acknowledging a command with :    2
    Should Contain X Times    ${restoreDefaultSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${restoreDefaultSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${restoreDefaultSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${restoreDefaultSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${restoreDefaultSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${restoreDefaultSettings_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${restoreDefaultSettings_list}    === ${subSystem}_restoreDefaultSettings end of topic ===    1
    ${applySettingsSet_start}=    Get Index From List    ${full_list}    === MTMount_applySettingsSet start of topic ===
    ${applySettingsSet_end}=    Get Index From List    ${full_list}    === MTMount_applySettingsSet end of topic ===
    ${applySettingsSet_list}=    Get Slice From List    ${full_list}    start=${applySettingsSet_start}    end=${applySettingsSet_end+1}
    Log    ${applySettingsSet_list}
    Should Contain X Times    ${applySettingsSet_list}    === ${subSystem}_applySettingsSet start of topic ===    1
    Should Contain X Times    ${applySettingsSet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}restoreDefaults : 1    1
    Should Contain X Times    ${applySettingsSet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settings : RO    1
    Should Contain X Times    ${applySettingsSet_list}    === ackCommand_applySettingsSet acknowledging a command with :    2
    Should Contain X Times    ${applySettingsSet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${applySettingsSet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${applySettingsSet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${applySettingsSet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${applySettingsSet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${applySettingsSet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${applySettingsSet_list}    === ${subSystem}_applySettingsSet end of topic ===    1
    ${moveToTarget_start}=    Get Index From List    ${full_list}    === MTMount_moveToTarget start of topic ===
    ${moveToTarget_end}=    Get Index From List    ${full_list}    === MTMount_moveToTarget end of topic ===
    ${moveToTarget_list}=    Get Slice From List    ${full_list}    start=${moveToTarget_start}    end=${moveToTarget_end+1}
    Log    ${moveToTarget_list}
    Should Contain X Times    ${moveToTarget_list}    === ${subSystem}_moveToTarget start of topic ===    1
    Should Contain X Times    ${moveToTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${moveToTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${moveToTarget_list}    === ackCommand_moveToTarget acknowledging a command with :    2
    Should Contain X Times    ${moveToTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${moveToTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${moveToTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${moveToTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${moveToTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${moveToTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${moveToTarget_list}    === ${subSystem}_moveToTarget end of topic ===    1
    ${setThermal_start}=    Get Index From List    ${full_list}    === MTMount_setThermal start of topic ===
    ${setThermal_end}=    Get Index From List    ${full_list}    === MTMount_setThermal end of topic ===
    ${setThermal_list}=    Get Slice From List    ${full_list}    start=${setThermal_start}    end=${setThermal_end+1}
    Log    ${setThermal_list}
    Should Contain X Times    ${setThermal_list}    === ${subSystem}_setThermal start of topic ===    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthDrivesState : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationDrivesState : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabinet0101State : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetState : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxiliaryCabinetsState : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilSupplySystemCabinetState : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}topEndChillerState : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthDrivesSetpoint : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationDrivesSetpoint : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabinet0101Setpoint : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mainCabinetSetpoint : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}auxiliaryCabinetsSetpoint : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilSupplySystemCabinetSetpoint : 1    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}topEndChillerSetpoint : 1    1
    Should Contain X Times    ${setThermal_list}    === ackCommand_setThermal acknowledging a command with :    2
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${setThermal_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${setThermal_list}    === ${subSystem}_setThermal end of topic ===    1
    ${startTracking_start}=    Get Index From List    ${full_list}    === MTMount_startTracking start of topic ===
    ${startTracking_end}=    Get Index From List    ${full_list}    === MTMount_startTracking end of topic ===
    ${startTracking_list}=    Get Slice From List    ${full_list}    start=${startTracking_start}    end=${startTracking_end+1}
    Log    ${startTracking_list}
    Should Contain X Times    ${startTracking_list}    === ${subSystem}_startTracking start of topic ===    1
    Should Contain X Times    ${startTracking_list}    === ackCommand_startTracking acknowledging a command with :    2
    Should Contain X Times    ${startTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${startTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${startTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${startTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${startTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${startTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${startTracking_list}    === ${subSystem}_startTracking end of topic ===    1
    ${trackTarget_start}=    Get Index From List    ${full_list}    === MTMount_trackTarget start of topic ===
    ${trackTarget_end}=    Get Index From List    ${full_list}    === MTMount_trackTarget end of topic ===
    ${trackTarget_list}=    Get Slice From List    ${full_list}    start=${trackTarget_start}    end=${trackTarget_end+1}
    Log    ${trackTarget_list}
    Should Contain X Times    ${trackTarget_list}    === ${subSystem}_trackTarget start of topic ===    1
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthVelocity : 1    1
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationVelocity : 1    1
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}taiTime : 1    1
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    1
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tracksys : RO    1
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}radesys : RO    1
    Should Contain X Times    ${trackTarget_list}    === ackCommand_trackTarget acknowledging a command with :    2
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${trackTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${trackTarget_list}    === ${subSystem}_trackTarget end of topic ===    1
    ${stopTracking_start}=    Get Index From List    ${full_list}    === MTMount_stopTracking start of topic ===
    ${stopTracking_end}=    Get Index From List    ${full_list}    === MTMount_stopTracking end of topic ===
    ${stopTracking_list}=    Get Slice From List    ${full_list}    start=${stopTracking_start}    end=${stopTracking_end+1}
    Log    ${stopTracking_list}
    Should Contain X Times    ${stopTracking_list}    === ${subSystem}_stopTracking start of topic ===    1
    Should Contain X Times    ${stopTracking_list}    === ackCommand_stopTracking acknowledging a command with :    2
    Should Contain X Times    ${stopTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${stopTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${stopTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${stopTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${stopTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${stopTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${stopTracking_list}    === ${subSystem}_stopTracking end of topic ===    1
    ${stop_start}=    Get Index From List    ${full_list}    === MTMount_stop start of topic ===
    ${stop_end}=    Get Index From List    ${full_list}    === MTMount_stop end of topic ===
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
    ${clearError_start}=    Get Index From List    ${full_list}    === MTMount_clearError start of topic ===
    ${clearError_end}=    Get Index From List    ${full_list}    === MTMount_clearError end of topic ===
    ${clearError_list}=    Get Slice From List    ${full_list}    start=${clearError_start}    end=${clearError_end+1}
    Log    ${clearError_list}
    Should Contain X Times    ${clearError_list}    === ${subSystem}_clearError start of topic ===    1
    Should Contain X Times    ${clearError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mask : 1    1
    Should Contain X Times    ${clearError_list}    === ackCommand_clearError acknowledging a command with :    2
    Should Contain X Times    ${clearError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${clearError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${clearError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${clearError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${clearError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${clearError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${clearError_list}    === ${subSystem}_clearError end of topic ===    1
    ${lockMotion_start}=    Get Index From List    ${full_list}    === MTMount_lockMotion start of topic ===
    ${lockMotion_end}=    Get Index From List    ${full_list}    === MTMount_lockMotion end of topic ===
    ${lockMotion_list}=    Get Slice From List    ${full_list}    start=${lockMotion_start}    end=${lockMotion_end+1}
    Log    ${lockMotion_list}
    Should Contain X Times    ${lockMotion_list}    === ${subSystem}_lockMotion start of topic ===    1
    Should Contain X Times    ${lockMotion_list}    === ackCommand_lockMotion acknowledging a command with :    2
    Should Contain X Times    ${lockMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${lockMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${lockMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${lockMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${lockMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${lockMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${lockMotion_list}    === ${subSystem}_lockMotion end of topic ===    1
    ${unlockMotion_start}=    Get Index From List    ${full_list}    === MTMount_unlockMotion start of topic ===
    ${unlockMotion_end}=    Get Index From List    ${full_list}    === MTMount_unlockMotion end of topic ===
    ${unlockMotion_list}=    Get Slice From List    ${full_list}    start=${unlockMotion_start}    end=${unlockMotion_end+1}
    Log    ${unlockMotion_list}
    Should Contain X Times    ${unlockMotion_list}    === ${subSystem}_unlockMotion start of topic ===    1
    Should Contain X Times    ${unlockMotion_list}    === ackCommand_unlockMotion acknowledging a command with :    2
    Should Contain X Times    ${unlockMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${unlockMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${unlockMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${unlockMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${unlockMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${unlockMotion_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${unlockMotion_list}    === ${subSystem}_unlockMotion end of topic ===    1
    ${disable_start}=    Get Index From List    ${full_list}    === MTMount_disable start of topic ===
    ${disable_end}=    Get Index From List    ${full_list}    === MTMount_disable end of topic ===
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
    ${enable_start}=    Get Index From List    ${full_list}    === MTMount_enable start of topic ===
    ${enable_end}=    Get Index From List    ${full_list}    === MTMount_enable end of topic ===
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
    ${exitControl_start}=    Get Index From List    ${full_list}    === MTMount_exitControl start of topic ===
    ${exitControl_end}=    Get Index From List    ${full_list}    === MTMount_exitControl end of topic ===
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
    ${setLogLevel_start}=    Get Index From List    ${full_list}    === MTMount_setLogLevel start of topic ===
    ${setLogLevel_end}=    Get Index From List    ${full_list}    === MTMount_setLogLevel end of topic ===
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
    ${standby_start}=    Get Index From List    ${full_list}    === MTMount_standby start of topic ===
    ${standby_end}=    Get Index From List    ${full_list}    === MTMount_standby end of topic ===
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
    ${start_start}=    Get Index From List    ${full_list}    === MTMount_start start of topic ===
    ${start_end}=    Get Index From List    ${full_list}    === MTMount_start end of topic ===
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
