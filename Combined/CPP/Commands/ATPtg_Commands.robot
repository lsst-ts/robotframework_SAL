*** Settings ***
Documentation    ATPtg_Commands communications tests.
Force Tags    messaging    cpp    atptg    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}common.robot
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATPtg
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
    Comment    ======= Verify ${subSystem}_pointCloseFile test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${pointCloseFile_start}=    Get Index From List    ${full_list}    === ATPtg_pointCloseFile start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_pointCloseFile command*
    ${pointCloseFile_end}=    Get Index From List    ${full_list}    ${line}
    ${pointCloseFile_list}=    Get Slice From List    ${full_list}    start=${pointCloseFile_start}    end=${pointCloseFile_end+3}
    Log    ${pointCloseFile_list}
    Should Contain X Times    ${pointCloseFile_list}    === ${subSystem}_pointCloseFile start of topic ===    1
    Should Contain X Times    ${pointCloseFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignored : 1    1
    Should Contain    ${pointCloseFile_list}    === issueCommand_pointCloseFile writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${pointCloseFile_list}[-2]    Command roundtrip was
    Should Be Equal    ${pointCloseFile_list}[-1]    303
    Should Contain    ${pointCloseFile_list}    === ${subSystem}_pointCloseFile end of topic ===
    Comment    ======= Verify ${subSystem}_poriginAbsorb test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${poriginAbsorb_start}=    Get Index From List    ${full_list}    === ATPtg_poriginAbsorb start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_poriginAbsorb command*
    ${poriginAbsorb_end}=    Get Index From List    ${full_list}    ${line}
    ${poriginAbsorb_list}=    Get Slice From List    ${full_list}    start=${poriginAbsorb_start}    end=${poriginAbsorb_end+3}
    Log    ${poriginAbsorb_list}
    Should Contain X Times    ${poriginAbsorb_list}    === ${subSystem}_poriginAbsorb start of topic ===    1
    Should Contain X Times    ${poriginAbsorb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}num : 1    1
    Should Contain    ${poriginAbsorb_list}    === issueCommand_poriginAbsorb writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${poriginAbsorb_list}[-2]    Command roundtrip was
    Should Be Equal    ${poriginAbsorb_list}[-1]    303
    Should Contain    ${poriginAbsorb_list}    === ${subSystem}_poriginAbsorb end of topic ===
    Comment    ======= Verify ${subSystem}_guideClear test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${guideClear_start}=    Get Index From List    ${full_list}    === ATPtg_guideClear start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_guideClear command*
    ${guideClear_end}=    Get Index From List    ${full_list}    ${line}
    ${guideClear_list}=    Get Slice From List    ${full_list}    start=${guideClear_start}    end=${guideClear_end+3}
    Log    ${guideClear_list}
    Should Contain X Times    ${guideClear_list}    === ${subSystem}_guideClear start of topic ===    1
    Should Contain X Times    ${guideClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignored : 1    1
    Should Contain    ${guideClear_list}    === issueCommand_guideClear writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${guideClear_list}[-2]    Command roundtrip was
    Should Be Equal    ${guideClear_list}[-1]    303
    Should Contain    ${guideClear_list}    === ${subSystem}_guideClear end of topic ===
    Comment    ======= Verify ${subSystem}_collOffset test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${collOffset_start}=    Get Index From List    ${full_list}    === ATPtg_collOffset start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_collOffset command*
    ${collOffset_end}=    Get Index From List    ${full_list}    ${line}
    ${collOffset_list}=    Get Slice From List    ${full_list}    start=${collOffset_start}    end=${collOffset_end+3}
    Log    ${collOffset_list}
    Should Contain X Times    ${collOffset_list}    === ${subSystem}_collOffset start of topic ===    1
    Should Contain X Times    ${collOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ca : 1    1
    Should Contain X Times    ${collOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ce : 1    1
    Should Contain X Times    ${collOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}num : 1    1
    Should Contain    ${collOffset_list}    === issueCommand_collOffset writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${collOffset_list}[-2]    Command roundtrip was
    Should Be Equal    ${collOffset_list}[-1]    303
    Should Contain    ${collOffset_list}    === ${subSystem}_collOffset end of topic ===
    Comment    ======= Verify ${subSystem}_rotOffset test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${rotOffset_start}=    Get Index From List    ${full_list}    === ATPtg_rotOffset start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_rotOffset command*
    ${rotOffset_end}=    Get Index From List    ${full_list}    ${line}
    ${rotOffset_list}=    Get Slice From List    ${full_list}    start=${rotOffset_start}    end=${rotOffset_end+3}
    Log    ${rotOffset_list}
    Should Contain X Times    ${rotOffset_list}    === ${subSystem}_rotOffset start of topic ===    1
    Should Contain X Times    ${rotOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}iaa : 1    1
    Should Contain    ${rotOffset_list}    === issueCommand_rotOffset writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${rotOffset_list}[-2]    Command roundtrip was
    Should Be Equal    ${rotOffset_list}[-1]    303
    Should Contain    ${rotOffset_list}    === ${subSystem}_rotOffset end of topic ===
    Comment    ======= Verify ${subSystem}_clearCollOffset test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${clearCollOffset_start}=    Get Index From List    ${full_list}    === ATPtg_clearCollOffset start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_clearCollOffset command*
    ${clearCollOffset_end}=    Get Index From List    ${full_list}    ${line}
    ${clearCollOffset_list}=    Get Slice From List    ${full_list}    start=${clearCollOffset_start}    end=${clearCollOffset_end+3}
    Log    ${clearCollOffset_list}
    Should Contain X Times    ${clearCollOffset_list}    === ${subSystem}_clearCollOffset start of topic ===    1
    Should Contain X Times    ${clearCollOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}num : 1    1
    Should Contain    ${clearCollOffset_list}    === issueCommand_clearCollOffset writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${clearCollOffset_list}[-2]    Command roundtrip was
    Should Be Equal    ${clearCollOffset_list}[-1]    303
    Should Contain    ${clearCollOffset_list}    === ${subSystem}_clearCollOffset end of topic ===
    Comment    ======= Verify ${subSystem}_poriginXY test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${poriginXY_start}=    Get Index From List    ${full_list}    === ATPtg_poriginXY start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_poriginXY command*
    ${poriginXY_end}=    Get Index From List    ${full_list}    ${line}
    ${poriginXY_list}=    Get Slice From List    ${full_list}    start=${poriginXY_start}    end=${poriginXY_end+3}
    Log    ${poriginXY_list}
    Should Contain X Times    ${poriginXY_list}    === ${subSystem}_poriginXY start of topic ===    1
    Should Contain X Times    ${poriginXY_list}    ${SPACE}${SPACE}${SPACE}${SPACE}x : 1    1
    Should Contain X Times    ${poriginXY_list}    ${SPACE}${SPACE}${SPACE}${SPACE}y : 1    1
    Should Contain    ${poriginXY_list}    === issueCommand_poriginXY writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${poriginXY_list}[-2]    Command roundtrip was
    Should Be Equal    ${poriginXY_list}[-1]    303
    Should Contain    ${poriginXY_list}    === ${subSystem}_poriginXY end of topic ===
    Comment    ======= Verify ${subSystem}_iersUpdate test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${iersUpdate_start}=    Get Index From List    ${full_list}    === ATPtg_iersUpdate start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_iersUpdate command*
    ${iersUpdate_end}=    Get Index From List    ${full_list}    ${line}
    ${iersUpdate_list}=    Get Slice From List    ${full_list}    start=${iersUpdate_start}    end=${iersUpdate_end+3}
    Log    ${iersUpdate_list}
    Should Contain X Times    ${iersUpdate_list}    === ${subSystem}_iersUpdate start of topic ===    1
    Should Contain X Times    ${iersUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignored : 1    1
    Should Contain    ${iersUpdate_list}    === issueCommand_iersUpdate writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${iersUpdate_list}[-2]    Command roundtrip was
    Should Be Equal    ${iersUpdate_list}[-1]    303
    Should Contain    ${iersUpdate_list}    === ${subSystem}_iersUpdate end of topic ===
    Comment    ======= Verify ${subSystem}_offsetRADec test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${offsetRADec_start}=    Get Index From List    ${full_list}    === ATPtg_offsetRADec start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_offsetRADec command*
    ${offsetRADec_end}=    Get Index From List    ${full_list}    ${line}
    ${offsetRADec_list}=    Get Slice From List    ${full_list}    start=${offsetRADec_start}    end=${offsetRADec_end+3}
    Log    ${offsetRADec_list}
    Should Contain X Times    ${offsetRADec_list}    === ${subSystem}_offsetRADec start of topic ===    1
    Should Contain X Times    ${offsetRADec_list}    ${SPACE}${SPACE}${SPACE}${SPACE}type : 1    1
    Should Contain X Times    ${offsetRADec_list}    ${SPACE}${SPACE}${SPACE}${SPACE}off1 : 1    1
    Should Contain X Times    ${offsetRADec_list}    ${SPACE}${SPACE}${SPACE}${SPACE}off2 : 1    1
    Should Contain X Times    ${offsetRADec_list}    ${SPACE}${SPACE}${SPACE}${SPACE}num : 1    1
    Should Contain    ${offsetRADec_list}    === issueCommand_offsetRADec writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${offsetRADec_list}[-2]    Command roundtrip was
    Should Be Equal    ${offsetRADec_list}[-1]    303
    Should Contain    ${offsetRADec_list}    === ${subSystem}_offsetRADec end of topic ===
    Comment    ======= Verify ${subSystem}_pointAddData test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${pointAddData_start}=    Get Index From List    ${full_list}    === ATPtg_pointAddData start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_pointAddData command*
    ${pointAddData_end}=    Get Index From List    ${full_list}    ${line}
    ${pointAddData_list}=    Get Slice From List    ${full_list}    start=${pointAddData_start}    end=${pointAddData_end+3}
    Log    ${pointAddData_list}
    Should Contain X Times    ${pointAddData_list}    === ${subSystem}_pointAddData start of topic ===    1
    Should Contain X Times    ${pointAddData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignored : 1    1
    Should Contain    ${pointAddData_list}    === issueCommand_pointAddData writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${pointAddData_list}[-2]    Command roundtrip was
    Should Be Equal    ${pointAddData_list}[-1]    303
    Should Contain    ${pointAddData_list}    === ${subSystem}_pointAddData end of topic ===
    Comment    ======= Verify ${subSystem}_guideControl test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${guideControl_start}=    Get Index From List    ${full_list}    === ATPtg_guideControl start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_guideControl command*
    ${guideControl_end}=    Get Index From List    ${full_list}    ${line}
    ${guideControl_list}=    Get Slice From List    ${full_list}    start=${guideControl_start}    end=${guideControl_end+3}
    Log    ${guideControl_list}
    Should Contain X Times    ${guideControl_list}    === ${subSystem}_guideControl start of topic ===    1
    Should Contain X Times    ${guideControl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain    ${guideControl_list}    === issueCommand_guideControl writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${guideControl_list}[-2]    Command roundtrip was
    Should Be Equal    ${guideControl_list}[-1]    303
    Should Contain    ${guideControl_list}    === ${subSystem}_guideControl end of topic ===
    Comment    ======= Verify ${subSystem}_offsetAbsorb test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${offsetAbsorb_start}=    Get Index From List    ${full_list}    === ATPtg_offsetAbsorb start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_offsetAbsorb command*
    ${offsetAbsorb_end}=    Get Index From List    ${full_list}    ${line}
    ${offsetAbsorb_list}=    Get Slice From List    ${full_list}    start=${offsetAbsorb_start}    end=${offsetAbsorb_end+3}
    Log    ${offsetAbsorb_list}
    Should Contain X Times    ${offsetAbsorb_list}    === ${subSystem}_offsetAbsorb start of topic ===    1
    Should Contain X Times    ${offsetAbsorb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}num : 1    1
    Should Contain    ${offsetAbsorb_list}    === issueCommand_offsetAbsorb writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${offsetAbsorb_list}[-2]    Command roundtrip was
    Should Be Equal    ${offsetAbsorb_list}[-1]    303
    Should Contain    ${offsetAbsorb_list}    === ${subSystem}_offsetAbsorb end of topic ===
    Comment    ======= Verify ${subSystem}_ephemTarget test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${ephemTarget_start}=    Get Index From List    ${full_list}    === ATPtg_ephemTarget start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_ephemTarget command*
    ${ephemTarget_end}=    Get Index From List    ${full_list}    ${line}
    ${ephemTarget_list}=    Get Slice From List    ${full_list}    start=${ephemTarget_start}    end=${ephemTarget_end+3}
    Log    ${ephemTarget_list}
    Should Contain X Times    ${ephemTarget_list}    === ${subSystem}_ephemTarget start of topic ===    1
    Should Contain X Times    ${ephemTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ephemFile : RO    1
    Should Contain X Times    ${ephemTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetName : RO    1
    Should Contain X Times    ${ephemTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dRA : 1    1
    Should Contain X Times    ${ephemTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dDec : 1    1
    Should Contain X Times    ${ephemTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    1
    Should Contain X Times    ${ephemTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotPA : 1    1
    Should Contain X Times    ${ephemTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}validateOnly : 1    1
    Should Contain    ${ephemTarget_list}    === issueCommand_ephemTarget writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${ephemTarget_list}[-2]    Command roundtrip was
    Should Be Equal    ${ephemTarget_list}[-1]    303
    Should Contain    ${ephemTarget_list}    === ${subSystem}_ephemTarget end of topic ===
    Comment    ======= Verify ${subSystem}_wavelength test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${wavelength_start}=    Get Index From List    ${full_list}    === ATPtg_wavelength start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_wavelength command*
    ${wavelength_end}=    Get Index From List    ${full_list}    ${line}
    ${wavelength_list}=    Get Slice From List    ${full_list}    start=${wavelength_start}    end=${wavelength_end+3}
    Log    ${wavelength_list}
    Should Contain X Times    ${wavelength_list}    === ${subSystem}_wavelength start of topic ===    1
    Should Contain X Times    ${wavelength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wavelength : 1    1
    Should Contain    ${wavelength_list}    === issueCommand_wavelength writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${wavelength_list}[-2]    Command roundtrip was
    Should Be Equal    ${wavelength_list}[-1]    303
    Should Contain    ${wavelength_list}    === ${subSystem}_wavelength end of topic ===
    Comment    ======= Verify ${subSystem}_pointLoadModel test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${pointLoadModel_start}=    Get Index From List    ${full_list}    === ATPtg_pointLoadModel start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_pointLoadModel command*
    ${pointLoadModel_end}=    Get Index From List    ${full_list}    ${line}
    ${pointLoadModel_list}=    Get Slice From List    ${full_list}    start=${pointLoadModel_start}    end=${pointLoadModel_end+3}
    Log    ${pointLoadModel_list}
    Should Contain X Times    ${pointLoadModel_list}    === ${subSystem}_pointLoadModel start of topic ===    1
    Should Contain X Times    ${pointLoadModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingFile : RO    1
    Should Contain    ${pointLoadModel_list}    === issueCommand_pointLoadModel writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${pointLoadModel_list}[-2]    Command roundtrip was
    Should Be Equal    ${pointLoadModel_list}[-1]    303
    Should Contain    ${pointLoadModel_list}    === ${subSystem}_pointLoadModel end of topic ===
    Comment    ======= Verify ${subSystem}_azCurrentWrap test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${azCurrentWrap_start}=    Get Index From List    ${full_list}    === ATPtg_azCurrentWrap start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_azCurrentWrap command*
    ${azCurrentWrap_end}=    Get Index From List    ${full_list}    ${line}
    ${azCurrentWrap_list}=    Get Slice From List    ${full_list}    start=${azCurrentWrap_start}    end=${azCurrentWrap_end+3}
    Log    ${azCurrentWrap_list}
    Should Contain X Times    ${azCurrentWrap_list}    === ${subSystem}_azCurrentWrap start of topic ===    1
    Should Contain X Times    ${azCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wrap : 1    1
    Should Contain    ${azCurrentWrap_list}    === issueCommand_azCurrentWrap writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${azCurrentWrap_list}[-2]    Command roundtrip was
    Should Be Equal    ${azCurrentWrap_list}[-1]    303
    Should Contain    ${azCurrentWrap_list}    === ${subSystem}_azCurrentWrap end of topic ===
    Comment    ======= Verify ${subSystem}_debugLevel test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${debugLevel_start}=    Get Index From List    ${full_list}    === ATPtg_debugLevel start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_debugLevel command*
    ${debugLevel_end}=    Get Index From List    ${full_list}    ${line}
    ${debugLevel_list}=    Get Slice From List    ${full_list}    start=${debugLevel_start}    end=${debugLevel_end+3}
    Log    ${debugLevel_list}
    Should Contain X Times    ${debugLevel_list}    === ${subSystem}_debugLevel start of topic ===    1
    Should Contain X Times    ${debugLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain    ${debugLevel_list}    === issueCommand_debugLevel writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${debugLevel_list}[-2]    Command roundtrip was
    Should Be Equal    ${debugLevel_list}[-1]    303
    Should Contain    ${debugLevel_list}    === ${subSystem}_debugLevel end of topic ===
    Comment    ======= Verify ${subSystem}_raDecTarget test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${raDecTarget_start}=    Get Index From List    ${full_list}    === ATPtg_raDecTarget start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_raDecTarget command*
    ${raDecTarget_end}=    Get Index From List    ${full_list}    ${line}
    ${raDecTarget_list}=    Get Slice From List    ${full_list}    start=${raDecTarget_start}    end=${raDecTarget_end+3}
    Log    ${raDecTarget_list}
    Should Contain X Times    ${raDecTarget_list}    === ${subSystem}_raDecTarget start of topic ===    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetName : RO    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}frame : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}epoch : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}equinox : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}parallax : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pmRA : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pmDec : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rv : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dRA : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dDec : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotAngle : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotStartFrame : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotTrackFrame : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotMode : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azWrapStrategy : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeOnTarget : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}validateOnly : 1    1
    Should Contain    ${raDecTarget_list}    === issueCommand_raDecTarget writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${raDecTarget_list}[-2]    Command roundtrip was
    Should Be Equal    ${raDecTarget_list}[-1]    303
    Should Contain    ${raDecTarget_list}    === ${subSystem}_raDecTarget end of topic ===
    Comment    ======= Verify ${subSystem}_offsetPA test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${offsetPA_start}=    Get Index From List    ${full_list}    === ATPtg_offsetPA start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_offsetPA command*
    ${offsetPA_end}=    Get Index From List    ${full_list}    ${line}
    ${offsetPA_list}=    Get Slice From List    ${full_list}    start=${offsetPA_start}    end=${offsetPA_end+3}
    Log    ${offsetPA_list}
    Should Contain X Times    ${offsetPA_list}    === ${subSystem}_offsetPA start of topic ===    1
    Should Contain X Times    ${offsetPA_list}    ${SPACE}${SPACE}${SPACE}${SPACE}angle : 1    1
    Should Contain X Times    ${offsetPA_list}    ${SPACE}${SPACE}${SPACE}${SPACE}radius : 1    1
    Should Contain    ${offsetPA_list}    === issueCommand_offsetPA writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${offsetPA_list}[-2]    Command roundtrip was
    Should Be Equal    ${offsetPA_list}[-1]    303
    Should Contain    ${offsetPA_list}    === ${subSystem}_offsetPA end of topic ===
    Comment    ======= Verify ${subSystem}_rotCurrentWrap test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${rotCurrentWrap_start}=    Get Index From List    ${full_list}    === ATPtg_rotCurrentWrap start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_rotCurrentWrap command*
    ${rotCurrentWrap_end}=    Get Index From List    ${full_list}    ${line}
    ${rotCurrentWrap_list}=    Get Slice From List    ${full_list}    start=${rotCurrentWrap_start}    end=${rotCurrentWrap_end+3}
    Log    ${rotCurrentWrap_list}
    Should Contain X Times    ${rotCurrentWrap_list}    === ${subSystem}_rotCurrentWrap start of topic ===    1
    Should Contain X Times    ${rotCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wrap : 1    1
    Should Contain    ${rotCurrentWrap_list}    === issueCommand_rotCurrentWrap writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${rotCurrentWrap_list}[-2]    Command roundtrip was
    Should Be Equal    ${rotCurrentWrap_list}[-1]    303
    Should Contain    ${rotCurrentWrap_list}    === ${subSystem}_rotCurrentWrap end of topic ===
    Comment    ======= Verify ${subSystem}_poriginOffset test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${poriginOffset_start}=    Get Index From List    ${full_list}    === ATPtg_poriginOffset start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_poriginOffset command*
    ${poriginOffset_end}=    Get Index From List    ${full_list}    ${line}
    ${poriginOffset_list}=    Get Slice From List    ${full_list}    start=${poriginOffset_start}    end=${poriginOffset_end+3}
    Log    ${poriginOffset_list}
    Should Contain X Times    ${poriginOffset_list}    === ${subSystem}_poriginOffset start of topic ===    1
    Should Contain X Times    ${poriginOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dx : 1    1
    Should Contain X Times    ${poriginOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dy : 1    1
    Should Contain X Times    ${poriginOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}num : 1    1
    Should Contain    ${poriginOffset_list}    === issueCommand_poriginOffset writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${poriginOffset_list}[-2]    Command roundtrip was
    Should Be Equal    ${poriginOffset_list}[-1]    303
    Should Contain    ${poriginOffset_list}    === ${subSystem}_poriginOffset end of topic ===
    Comment    ======= Verify ${subSystem}_offsetClear test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${offsetClear_start}=    Get Index From List    ${full_list}    === ATPtg_offsetClear start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_offsetClear command*
    ${offsetClear_end}=    Get Index From List    ${full_list}    ${line}
    ${offsetClear_list}=    Get Slice From List    ${full_list}    start=${offsetClear_start}    end=${offsetClear_end+3}
    Log    ${offsetClear_list}
    Should Contain X Times    ${offsetClear_list}    === ${subSystem}_offsetClear start of topic ===    1
    Should Contain X Times    ${offsetClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}num : 1    1
    Should Contain    ${offsetClear_list}    === issueCommand_offsetClear writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${offsetClear_list}[-2]    Command roundtrip was
    Should Be Equal    ${offsetClear_list}[-1]    303
    Should Contain    ${offsetClear_list}    === ${subSystem}_offsetClear end of topic ===
    Comment    ======= Verify ${subSystem}_offsetAzEl test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${offsetAzEl_start}=    Get Index From List    ${full_list}    === ATPtg_offsetAzEl start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_offsetAzEl command*
    ${offsetAzEl_end}=    Get Index From List    ${full_list}    ${line}
    ${offsetAzEl_list}=    Get Slice From List    ${full_list}    start=${offsetAzEl_start}    end=${offsetAzEl_end+3}
    Log    ${offsetAzEl_list}
    Should Contain X Times    ${offsetAzEl_list}    === ${subSystem}_offsetAzEl start of topic ===    1
    Should Contain X Times    ${offsetAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}az : 1    1
    Should Contain X Times    ${offsetAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}el : 1    1
    Should Contain X Times    ${offsetAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}num : 1    1
    Should Contain    ${offsetAzEl_list}    === issueCommand_offsetAzEl writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${offsetAzEl_list}[-2]    Command roundtrip was
    Should Be Equal    ${offsetAzEl_list}[-1]    303
    Should Contain    ${offsetAzEl_list}    === ${subSystem}_offsetAzEl end of topic ===
    Comment    ======= Verify ${subSystem}_azElTarget test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${azElTarget_start}=    Get Index From List    ${full_list}    === ATPtg_azElTarget start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_azElTarget command*
    ${azElTarget_end}=    Get Index From List    ${full_list}    ${line}
    ${azElTarget_list}=    Get Slice From List    ${full_list}    start=${azElTarget_start}    end=${azElTarget_end+3}
    Log    ${azElTarget_list}
    Should Contain X Times    ${azElTarget_list}    === ${subSystem}_azElTarget start of topic ===    1
    Should Contain X Times    ${azElTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetName : RO    1
    Should Contain X Times    ${azElTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azDegs : 1    1
    Should Contain X Times    ${azElTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elDegs : 1    1
    Should Contain X Times    ${azElTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    1
    Should Contain X Times    ${azElTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotPA : 1    1
    Should Contain    ${azElTarget_list}    === issueCommand_azElTarget writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${azElTarget_list}[-2]    Command roundtrip was
    Should Be Equal    ${azElTarget_list}[-1]    303
    Should Contain    ${azElTarget_list}    === ${subSystem}_azElTarget end of topic ===
    Comment    ======= Verify ${subSystem}_planetTarget test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${planetTarget_start}=    Get Index From List    ${full_list}    === ATPtg_planetTarget start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_planetTarget command*
    ${planetTarget_end}=    Get Index From List    ${full_list}    ${line}
    ${planetTarget_list}=    Get Slice From List    ${full_list}    start=${planetTarget_start}    end=${planetTarget_end+3}
    Log    ${planetTarget_list}
    Should Contain X Times    ${planetTarget_list}    === ${subSystem}_planetTarget start of topic ===    1
    Should Contain X Times    ${planetTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}planetName : 1    1
    Should Contain X Times    ${planetTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dRA : 1    1
    Should Contain X Times    ${planetTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dDec : 1    1
    Should Contain X Times    ${planetTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    1
    Should Contain X Times    ${planetTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotPA : 1    1
    Should Contain X Times    ${planetTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}validateOnly : 1    1
    Should Contain    ${planetTarget_list}    === issueCommand_planetTarget writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${planetTarget_list}[-2]    Command roundtrip was
    Should Be Equal    ${planetTarget_list}[-1]    303
    Should Contain    ${planetTarget_list}    === ${subSystem}_planetTarget end of topic ===
    Comment    ======= Verify ${subSystem}_pointNewFile test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${pointNewFile_start}=    Get Index From List    ${full_list}    === ATPtg_pointNewFile start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_pointNewFile command*
    ${pointNewFile_end}=    Get Index From List    ${full_list}    ${line}
    ${pointNewFile_list}=    Get Slice From List    ${full_list}    start=${pointNewFile_start}    end=${pointNewFile_end+3}
    Log    ${pointNewFile_list}
    Should Contain X Times    ${pointNewFile_list}    === ${subSystem}_pointNewFile start of topic ===    1
    Should Contain X Times    ${pointNewFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignored : 1    1
    Should Contain    ${pointNewFile_list}    === issueCommand_pointNewFile writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${pointNewFile_list}[-2]    Command roundtrip was
    Should Be Equal    ${pointNewFile_list}[-1]    303
    Should Contain    ${pointNewFile_list}    === ${subSystem}_pointNewFile end of topic ===
    Comment    ======= Verify ${subSystem}_poriginClear test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${poriginClear_start}=    Get Index From List    ${full_list}    === ATPtg_poriginClear start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_poriginClear command*
    ${poriginClear_end}=    Get Index From List    ${full_list}    ${line}
    ${poriginClear_list}=    Get Slice From List    ${full_list}    start=${poriginClear_start}    end=${poriginClear_end+3}
    Log    ${poriginClear_list}
    Should Contain X Times    ${poriginClear_list}    === ${subSystem}_poriginClear start of topic ===    1
    Should Contain X Times    ${poriginClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}num : 1    1
    Should Contain    ${poriginClear_list}    === issueCommand_poriginClear writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${poriginClear_list}[-2]    Command roundtrip was
    Should Be Equal    ${poriginClear_list}[-1]    303
    Should Contain    ${poriginClear_list}    === ${subSystem}_poriginClear end of topic ===
    Comment    ======= Verify ${subSystem}_focusName test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${focusName_start}=    Get Index From List    ${full_list}    === ATPtg_focusName start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_focusName command*
    ${focusName_end}=    Get Index From List    ${full_list}    ${line}
    ${focusName_list}=    Get Slice From List    ${full_list}    start=${focusName_start}    end=${focusName_end+3}
    Log    ${focusName_list}
    Should Contain X Times    ${focusName_list}    === ${subSystem}_focusName start of topic ===    1
    Should Contain X Times    ${focusName_list}    ${SPACE}${SPACE}${SPACE}${SPACE}focus : 1    1
    Should Contain    ${focusName_list}    === issueCommand_focusName writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${focusName_list}[-2]    Command roundtrip was
    Should Be Equal    ${focusName_list}[-1]    303
    Should Contain    ${focusName_list}    === ${subSystem}_focusName end of topic ===
    Comment    ======= Verify ${subSystem}_amLimitSet test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${amLimitSet_start}=    Get Index From List    ${full_list}    === ATPtg_amLimitSet start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_amLimitSet command*
    ${amLimitSet_end}=    Get Index From List    ${full_list}    ${line}
    ${amLimitSet_list}=    Get Slice From List    ${full_list}    start=${amLimitSet_start}    end=${amLimitSet_end+3}
    Log    ${amLimitSet_list}
    Should Contain X Times    ${amLimitSet_list}    === ${subSystem}_amLimitSet start of topic ===    1
    Should Contain X Times    ${amLimitSet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amlimit : 1    1
    Should Contain    ${amLimitSet_list}    === issueCommand_amLimitSet writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${amLimitSet_list}[-2]    Command roundtrip was
    Should Be Equal    ${amLimitSet_list}[-1]    303
    Should Contain    ${amLimitSet_list}    === ${subSystem}_amLimitSet end of topic ===
    Comment    ======= Verify ${subSystem}_stopTracking test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${stopTracking_start}=    Get Index From List    ${full_list}    === ATPtg_stopTracking start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_stopTracking command*
    ${stopTracking_end}=    Get Index From List    ${full_list}    ${line}
    ${stopTracking_list}=    Get Slice From List    ${full_list}    start=${stopTracking_start}    end=${stopTracking_end+3}
    Log    ${stopTracking_list}
    Should Contain X Times    ${stopTracking_list}    === ${subSystem}_stopTracking start of topic ===    1
    Should Contain X Times    ${stopTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignored : 1    1
    Should Contain    ${stopTracking_list}    === issueCommand_stopTracking writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${stopTracking_list}[-2]    Command roundtrip was
    Should Be Equal    ${stopTracking_list}[-1]    303
    Should Contain    ${stopTracking_list}    === ${subSystem}_stopTracking end of topic ===
    Comment    ======= Verify ${subSystem}_startTracking test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${startTracking_start}=    Get Index From List    ${full_list}    === ATPtg_startTracking start of topic ===
    ${line}=    Get Lines Matching Pattern    ${output.stdout}    === waitForCompletion_startTracking command*
    ${startTracking_end}=    Get Index From List    ${full_list}    ${line}
    ${startTracking_list}=    Get Slice From List    ${full_list}    start=${startTracking_start}    end=${startTracking_end+3}
    Log    ${startTracking_list}
    Should Contain X Times    ${startTracking_list}    === ${subSystem}_startTracking start of topic ===    1
    Should Contain X Times    ${startTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    1
    Should Contain    ${startTracking_list}    === issueCommand_startTracking writing a command containing :
    Should Contain    ${line}    completed ok
    Should Contain    ${startTracking_list}[-2]    Command roundtrip was
    Should Be Equal    ${startTracking_list}[-1]    303
    Should Contain    ${startTracking_list}    === ${subSystem}_startTracking end of topic ===
    Comment    ======= Verify ${subSystem}_disable test messages =======
    Should Contain    ${output.stdout}    ==== ${subSystem} all commanders ready ====
    ${disable_start}=    Get Index From List    ${full_list}    === ATPtg_disable start of topic ===
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
    ${enable_start}=    Get Index From List    ${full_list}    === ATPtg_enable start of topic ===
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
    ${exitControl_start}=    Get Index From List    ${full_list}    === ATPtg_exitControl start of topic ===
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
    ${setLogLevel_start}=    Get Index From List    ${full_list}    === ATPtg_setLogLevel start of topic ===
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
    ${standby_start}=    Get Index From List    ${full_list}    === ATPtg_standby start of topic ===
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
    ${start_start}=    Get Index From List    ${full_list}    === ATPtg_start start of topic ===
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
    ${pointCloseFile_start}=    Get Index From List    ${full_list}    === ATPtg_pointCloseFile start of topic ===
    ${pointCloseFile_end}=    Get Index From List    ${full_list}    === ATPtg_pointCloseFile end of topic ===
    ${pointCloseFile_list}=    Get Slice From List    ${full_list}    start=${pointCloseFile_start}    end=${pointCloseFile_end+1}
    Log    ${pointCloseFile_list}
    Should Contain X Times    ${pointCloseFile_list}    === ${subSystem}_pointCloseFile start of topic ===    1
    Should Contain X Times    ${pointCloseFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignored : 1    1
    Should Contain X Times    ${pointCloseFile_list}    === ackCommand_pointCloseFile acknowledging a command with :    2
    Should Contain X Times    ${pointCloseFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${pointCloseFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${pointCloseFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${pointCloseFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${pointCloseFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${pointCloseFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${pointCloseFile_list}    === ${subSystem}_pointCloseFile end of topic ===    1
    ${poriginAbsorb_start}=    Get Index From List    ${full_list}    === ATPtg_poriginAbsorb start of topic ===
    ${poriginAbsorb_end}=    Get Index From List    ${full_list}    === ATPtg_poriginAbsorb end of topic ===
    ${poriginAbsorb_list}=    Get Slice From List    ${full_list}    start=${poriginAbsorb_start}    end=${poriginAbsorb_end+1}
    Log    ${poriginAbsorb_list}
    Should Contain X Times    ${poriginAbsorb_list}    === ${subSystem}_poriginAbsorb start of topic ===    1
    Should Contain X Times    ${poriginAbsorb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}num : 1    1
    Should Contain X Times    ${poriginAbsorb_list}    === ackCommand_poriginAbsorb acknowledging a command with :    2
    Should Contain X Times    ${poriginAbsorb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${poriginAbsorb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${poriginAbsorb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${poriginAbsorb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${poriginAbsorb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${poriginAbsorb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${poriginAbsorb_list}    === ${subSystem}_poriginAbsorb end of topic ===    1
    ${guideClear_start}=    Get Index From List    ${full_list}    === ATPtg_guideClear start of topic ===
    ${guideClear_end}=    Get Index From List    ${full_list}    === ATPtg_guideClear end of topic ===
    ${guideClear_list}=    Get Slice From List    ${full_list}    start=${guideClear_start}    end=${guideClear_end+1}
    Log    ${guideClear_list}
    Should Contain X Times    ${guideClear_list}    === ${subSystem}_guideClear start of topic ===    1
    Should Contain X Times    ${guideClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignored : 1    1
    Should Contain X Times    ${guideClear_list}    === ackCommand_guideClear acknowledging a command with :    2
    Should Contain X Times    ${guideClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${guideClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${guideClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${guideClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${guideClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${guideClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${guideClear_list}    === ${subSystem}_guideClear end of topic ===    1
    ${collOffset_start}=    Get Index From List    ${full_list}    === ATPtg_collOffset start of topic ===
    ${collOffset_end}=    Get Index From List    ${full_list}    === ATPtg_collOffset end of topic ===
    ${collOffset_list}=    Get Slice From List    ${full_list}    start=${collOffset_start}    end=${collOffset_end+1}
    Log    ${collOffset_list}
    Should Contain X Times    ${collOffset_list}    === ${subSystem}_collOffset start of topic ===    1
    Should Contain X Times    ${collOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ca : 1    1
    Should Contain X Times    ${collOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ce : 1    1
    Should Contain X Times    ${collOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}num : 1    1
    Should Contain X Times    ${collOffset_list}    === ackCommand_collOffset acknowledging a command with :    2
    Should Contain X Times    ${collOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${collOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${collOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${collOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${collOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${collOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${collOffset_list}    === ${subSystem}_collOffset end of topic ===    1
    ${rotOffset_start}=    Get Index From List    ${full_list}    === ATPtg_rotOffset start of topic ===
    ${rotOffset_end}=    Get Index From List    ${full_list}    === ATPtg_rotOffset end of topic ===
    ${rotOffset_list}=    Get Slice From List    ${full_list}    start=${rotOffset_start}    end=${rotOffset_end+1}
    Log    ${rotOffset_list}
    Should Contain X Times    ${rotOffset_list}    === ${subSystem}_rotOffset start of topic ===    1
    Should Contain X Times    ${rotOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}iaa : 1    1
    Should Contain X Times    ${rotOffset_list}    === ackCommand_rotOffset acknowledging a command with :    2
    Should Contain X Times    ${rotOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${rotOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${rotOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${rotOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${rotOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${rotOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${rotOffset_list}    === ${subSystem}_rotOffset end of topic ===    1
    ${clearCollOffset_start}=    Get Index From List    ${full_list}    === ATPtg_clearCollOffset start of topic ===
    ${clearCollOffset_end}=    Get Index From List    ${full_list}    === ATPtg_clearCollOffset end of topic ===
    ${clearCollOffset_list}=    Get Slice From List    ${full_list}    start=${clearCollOffset_start}    end=${clearCollOffset_end+1}
    Log    ${clearCollOffset_list}
    Should Contain X Times    ${clearCollOffset_list}    === ${subSystem}_clearCollOffset start of topic ===    1
    Should Contain X Times    ${clearCollOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}num : 1    1
    Should Contain X Times    ${clearCollOffset_list}    === ackCommand_clearCollOffset acknowledging a command with :    2
    Should Contain X Times    ${clearCollOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${clearCollOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${clearCollOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${clearCollOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${clearCollOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${clearCollOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${clearCollOffset_list}    === ${subSystem}_clearCollOffset end of topic ===    1
    ${poriginXY_start}=    Get Index From List    ${full_list}    === ATPtg_poriginXY start of topic ===
    ${poriginXY_end}=    Get Index From List    ${full_list}    === ATPtg_poriginXY end of topic ===
    ${poriginXY_list}=    Get Slice From List    ${full_list}    start=${poriginXY_start}    end=${poriginXY_end+1}
    Log    ${poriginXY_list}
    Should Contain X Times    ${poriginXY_list}    === ${subSystem}_poriginXY start of topic ===    1
    Should Contain X Times    ${poriginXY_list}    ${SPACE}${SPACE}${SPACE}${SPACE}x : 1    1
    Should Contain X Times    ${poriginXY_list}    ${SPACE}${SPACE}${SPACE}${SPACE}y : 1    1
    Should Contain X Times    ${poriginXY_list}    === ackCommand_poriginXY acknowledging a command with :    2
    Should Contain X Times    ${poriginXY_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${poriginXY_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${poriginXY_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${poriginXY_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${poriginXY_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${poriginXY_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${poriginXY_list}    === ${subSystem}_poriginXY end of topic ===    1
    ${iersUpdate_start}=    Get Index From List    ${full_list}    === ATPtg_iersUpdate start of topic ===
    ${iersUpdate_end}=    Get Index From List    ${full_list}    === ATPtg_iersUpdate end of topic ===
    ${iersUpdate_list}=    Get Slice From List    ${full_list}    start=${iersUpdate_start}    end=${iersUpdate_end+1}
    Log    ${iersUpdate_list}
    Should Contain X Times    ${iersUpdate_list}    === ${subSystem}_iersUpdate start of topic ===    1
    Should Contain X Times    ${iersUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignored : 1    1
    Should Contain X Times    ${iersUpdate_list}    === ackCommand_iersUpdate acknowledging a command with :    2
    Should Contain X Times    ${iersUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${iersUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${iersUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${iersUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${iersUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${iersUpdate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${iersUpdate_list}    === ${subSystem}_iersUpdate end of topic ===    1
    ${offsetRADec_start}=    Get Index From List    ${full_list}    === ATPtg_offsetRADec start of topic ===
    ${offsetRADec_end}=    Get Index From List    ${full_list}    === ATPtg_offsetRADec end of topic ===
    ${offsetRADec_list}=    Get Slice From List    ${full_list}    start=${offsetRADec_start}    end=${offsetRADec_end+1}
    Log    ${offsetRADec_list}
    Should Contain X Times    ${offsetRADec_list}    === ${subSystem}_offsetRADec start of topic ===    1
    Should Contain X Times    ${offsetRADec_list}    ${SPACE}${SPACE}${SPACE}${SPACE}type : 1    1
    Should Contain X Times    ${offsetRADec_list}    ${SPACE}${SPACE}${SPACE}${SPACE}off1 : 1    1
    Should Contain X Times    ${offsetRADec_list}    ${SPACE}${SPACE}${SPACE}${SPACE}off2 : 1    1
    Should Contain X Times    ${offsetRADec_list}    ${SPACE}${SPACE}${SPACE}${SPACE}num : 1    1
    Should Contain X Times    ${offsetRADec_list}    === ackCommand_offsetRADec acknowledging a command with :    2
    Should Contain X Times    ${offsetRADec_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${offsetRADec_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${offsetRADec_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${offsetRADec_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${offsetRADec_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${offsetRADec_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${offsetRADec_list}    === ${subSystem}_offsetRADec end of topic ===    1
    ${pointAddData_start}=    Get Index From List    ${full_list}    === ATPtg_pointAddData start of topic ===
    ${pointAddData_end}=    Get Index From List    ${full_list}    === ATPtg_pointAddData end of topic ===
    ${pointAddData_list}=    Get Slice From List    ${full_list}    start=${pointAddData_start}    end=${pointAddData_end+1}
    Log    ${pointAddData_list}
    Should Contain X Times    ${pointAddData_list}    === ${subSystem}_pointAddData start of topic ===    1
    Should Contain X Times    ${pointAddData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignored : 1    1
    Should Contain X Times    ${pointAddData_list}    === ackCommand_pointAddData acknowledging a command with :    2
    Should Contain X Times    ${pointAddData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${pointAddData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${pointAddData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${pointAddData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${pointAddData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${pointAddData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${pointAddData_list}    === ${subSystem}_pointAddData end of topic ===    1
    ${guideControl_start}=    Get Index From List    ${full_list}    === ATPtg_guideControl start of topic ===
    ${guideControl_end}=    Get Index From List    ${full_list}    === ATPtg_guideControl end of topic ===
    ${guideControl_list}=    Get Slice From List    ${full_list}    start=${guideControl_start}    end=${guideControl_end+1}
    Log    ${guideControl_list}
    Should Contain X Times    ${guideControl_list}    === ${subSystem}_guideControl start of topic ===    1
    Should Contain X Times    ${guideControl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${guideControl_list}    === ackCommand_guideControl acknowledging a command with :    2
    Should Contain X Times    ${guideControl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${guideControl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${guideControl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${guideControl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${guideControl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${guideControl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${guideControl_list}    === ${subSystem}_guideControl end of topic ===    1
    ${offsetAbsorb_start}=    Get Index From List    ${full_list}    === ATPtg_offsetAbsorb start of topic ===
    ${offsetAbsorb_end}=    Get Index From List    ${full_list}    === ATPtg_offsetAbsorb end of topic ===
    ${offsetAbsorb_list}=    Get Slice From List    ${full_list}    start=${offsetAbsorb_start}    end=${offsetAbsorb_end+1}
    Log    ${offsetAbsorb_list}
    Should Contain X Times    ${offsetAbsorb_list}    === ${subSystem}_offsetAbsorb start of topic ===    1
    Should Contain X Times    ${offsetAbsorb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}num : 1    1
    Should Contain X Times    ${offsetAbsorb_list}    === ackCommand_offsetAbsorb acknowledging a command with :    2
    Should Contain X Times    ${offsetAbsorb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${offsetAbsorb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${offsetAbsorb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${offsetAbsorb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${offsetAbsorb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${offsetAbsorb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${offsetAbsorb_list}    === ${subSystem}_offsetAbsorb end of topic ===    1
    ${ephemTarget_start}=    Get Index From List    ${full_list}    === ATPtg_ephemTarget start of topic ===
    ${ephemTarget_end}=    Get Index From List    ${full_list}    === ATPtg_ephemTarget end of topic ===
    ${ephemTarget_list}=    Get Slice From List    ${full_list}    start=${ephemTarget_start}    end=${ephemTarget_end+1}
    Log    ${ephemTarget_list}
    Should Contain X Times    ${ephemTarget_list}    === ${subSystem}_ephemTarget start of topic ===    1
    Should Contain X Times    ${ephemTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ephemFile : RO    1
    Should Contain X Times    ${ephemTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetName : RO    1
    Should Contain X Times    ${ephemTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dRA : 1    1
    Should Contain X Times    ${ephemTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dDec : 1    1
    Should Contain X Times    ${ephemTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    1
    Should Contain X Times    ${ephemTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotPA : 1    1
    Should Contain X Times    ${ephemTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}validateOnly : 1    1
    Should Contain X Times    ${ephemTarget_list}    === ackCommand_ephemTarget acknowledging a command with :    2
    Should Contain X Times    ${ephemTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${ephemTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${ephemTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${ephemTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${ephemTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${ephemTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${ephemTarget_list}    === ${subSystem}_ephemTarget end of topic ===    1
    ${wavelength_start}=    Get Index From List    ${full_list}    === ATPtg_wavelength start of topic ===
    ${wavelength_end}=    Get Index From List    ${full_list}    === ATPtg_wavelength end of topic ===
    ${wavelength_list}=    Get Slice From List    ${full_list}    start=${wavelength_start}    end=${wavelength_end+1}
    Log    ${wavelength_list}
    Should Contain X Times    ${wavelength_list}    === ${subSystem}_wavelength start of topic ===    1
    Should Contain X Times    ${wavelength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wavelength : 1    1
    Should Contain X Times    ${wavelength_list}    === ackCommand_wavelength acknowledging a command with :    2
    Should Contain X Times    ${wavelength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${wavelength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${wavelength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${wavelength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${wavelength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${wavelength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${wavelength_list}    === ${subSystem}_wavelength end of topic ===    1
    ${pointLoadModel_start}=    Get Index From List    ${full_list}    === ATPtg_pointLoadModel start of topic ===
    ${pointLoadModel_end}=    Get Index From List    ${full_list}    === ATPtg_pointLoadModel end of topic ===
    ${pointLoadModel_list}=    Get Slice From List    ${full_list}    start=${pointLoadModel_start}    end=${pointLoadModel_end+1}
    Log    ${pointLoadModel_list}
    Should Contain X Times    ${pointLoadModel_list}    === ${subSystem}_pointLoadModel start of topic ===    1
    Should Contain X Times    ${pointLoadModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingFile : RO    1
    Should Contain X Times    ${pointLoadModel_list}    === ackCommand_pointLoadModel acknowledging a command with :    2
    Should Contain X Times    ${pointLoadModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${pointLoadModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${pointLoadModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${pointLoadModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${pointLoadModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${pointLoadModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${pointLoadModel_list}    === ${subSystem}_pointLoadModel end of topic ===    1
    ${azCurrentWrap_start}=    Get Index From List    ${full_list}    === ATPtg_azCurrentWrap start of topic ===
    ${azCurrentWrap_end}=    Get Index From List    ${full_list}    === ATPtg_azCurrentWrap end of topic ===
    ${azCurrentWrap_list}=    Get Slice From List    ${full_list}    start=${azCurrentWrap_start}    end=${azCurrentWrap_end+1}
    Log    ${azCurrentWrap_list}
    Should Contain X Times    ${azCurrentWrap_list}    === ${subSystem}_azCurrentWrap start of topic ===    1
    Should Contain X Times    ${azCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wrap : 1    1
    Should Contain X Times    ${azCurrentWrap_list}    === ackCommand_azCurrentWrap acknowledging a command with :    2
    Should Contain X Times    ${azCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${azCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${azCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${azCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${azCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${azCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${azCurrentWrap_list}    === ${subSystem}_azCurrentWrap end of topic ===    1
    ${debugLevel_start}=    Get Index From List    ${full_list}    === ATPtg_debugLevel start of topic ===
    ${debugLevel_end}=    Get Index From List    ${full_list}    === ATPtg_debugLevel end of topic ===
    ${debugLevel_list}=    Get Slice From List    ${full_list}    start=${debugLevel_start}    end=${debugLevel_end+1}
    Log    ${debugLevel_list}
    Should Contain X Times    ${debugLevel_list}    === ${subSystem}_debugLevel start of topic ===    1
    Should Contain X Times    ${debugLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${debugLevel_list}    === ackCommand_debugLevel acknowledging a command with :    2
    Should Contain X Times    ${debugLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${debugLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${debugLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${debugLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${debugLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${debugLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${debugLevel_list}    === ${subSystem}_debugLevel end of topic ===    1
    ${raDecTarget_start}=    Get Index From List    ${full_list}    === ATPtg_raDecTarget start of topic ===
    ${raDecTarget_end}=    Get Index From List    ${full_list}    === ATPtg_raDecTarget end of topic ===
    ${raDecTarget_list}=    Get Slice From List    ${full_list}    start=${raDecTarget_start}    end=${raDecTarget_end+1}
    Log    ${raDecTarget_list}
    Should Contain X Times    ${raDecTarget_list}    === ${subSystem}_raDecTarget start of topic ===    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetName : RO    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}frame : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}epoch : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}equinox : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}parallax : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pmRA : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pmDec : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rv : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dRA : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dDec : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotAngle : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotStartFrame : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotTrackFrame : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotMode : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azWrapStrategy : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeOnTarget : 1    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}validateOnly : 1    1
    Should Contain X Times    ${raDecTarget_list}    === ackCommand_raDecTarget acknowledging a command with :    2
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${raDecTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${raDecTarget_list}    === ${subSystem}_raDecTarget end of topic ===    1
    ${offsetPA_start}=    Get Index From List    ${full_list}    === ATPtg_offsetPA start of topic ===
    ${offsetPA_end}=    Get Index From List    ${full_list}    === ATPtg_offsetPA end of topic ===
    ${offsetPA_list}=    Get Slice From List    ${full_list}    start=${offsetPA_start}    end=${offsetPA_end+1}
    Log    ${offsetPA_list}
    Should Contain X Times    ${offsetPA_list}    === ${subSystem}_offsetPA start of topic ===    1
    Should Contain X Times    ${offsetPA_list}    ${SPACE}${SPACE}${SPACE}${SPACE}angle : 1    1
    Should Contain X Times    ${offsetPA_list}    ${SPACE}${SPACE}${SPACE}${SPACE}radius : 1    1
    Should Contain X Times    ${offsetPA_list}    === ackCommand_offsetPA acknowledging a command with :    2
    Should Contain X Times    ${offsetPA_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${offsetPA_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${offsetPA_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${offsetPA_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${offsetPA_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${offsetPA_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${offsetPA_list}    === ${subSystem}_offsetPA end of topic ===    1
    ${rotCurrentWrap_start}=    Get Index From List    ${full_list}    === ATPtg_rotCurrentWrap start of topic ===
    ${rotCurrentWrap_end}=    Get Index From List    ${full_list}    === ATPtg_rotCurrentWrap end of topic ===
    ${rotCurrentWrap_list}=    Get Slice From List    ${full_list}    start=${rotCurrentWrap_start}    end=${rotCurrentWrap_end+1}
    Log    ${rotCurrentWrap_list}
    Should Contain X Times    ${rotCurrentWrap_list}    === ${subSystem}_rotCurrentWrap start of topic ===    1
    Should Contain X Times    ${rotCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wrap : 1    1
    Should Contain X Times    ${rotCurrentWrap_list}    === ackCommand_rotCurrentWrap acknowledging a command with :    2
    Should Contain X Times    ${rotCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${rotCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${rotCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${rotCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${rotCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${rotCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${rotCurrentWrap_list}    === ${subSystem}_rotCurrentWrap end of topic ===    1
    ${poriginOffset_start}=    Get Index From List    ${full_list}    === ATPtg_poriginOffset start of topic ===
    ${poriginOffset_end}=    Get Index From List    ${full_list}    === ATPtg_poriginOffset end of topic ===
    ${poriginOffset_list}=    Get Slice From List    ${full_list}    start=${poriginOffset_start}    end=${poriginOffset_end+1}
    Log    ${poriginOffset_list}
    Should Contain X Times    ${poriginOffset_list}    === ${subSystem}_poriginOffset start of topic ===    1
    Should Contain X Times    ${poriginOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dx : 1    1
    Should Contain X Times    ${poriginOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dy : 1    1
    Should Contain X Times    ${poriginOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}num : 1    1
    Should Contain X Times    ${poriginOffset_list}    === ackCommand_poriginOffset acknowledging a command with :    2
    Should Contain X Times    ${poriginOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${poriginOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${poriginOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${poriginOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${poriginOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${poriginOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${poriginOffset_list}    === ${subSystem}_poriginOffset end of topic ===    1
    ${offsetClear_start}=    Get Index From List    ${full_list}    === ATPtg_offsetClear start of topic ===
    ${offsetClear_end}=    Get Index From List    ${full_list}    === ATPtg_offsetClear end of topic ===
    ${offsetClear_list}=    Get Slice From List    ${full_list}    start=${offsetClear_start}    end=${offsetClear_end+1}
    Log    ${offsetClear_list}
    Should Contain X Times    ${offsetClear_list}    === ${subSystem}_offsetClear start of topic ===    1
    Should Contain X Times    ${offsetClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}num : 1    1
    Should Contain X Times    ${offsetClear_list}    === ackCommand_offsetClear acknowledging a command with :    2
    Should Contain X Times    ${offsetClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${offsetClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${offsetClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${offsetClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${offsetClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${offsetClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${offsetClear_list}    === ${subSystem}_offsetClear end of topic ===    1
    ${offsetAzEl_start}=    Get Index From List    ${full_list}    === ATPtg_offsetAzEl start of topic ===
    ${offsetAzEl_end}=    Get Index From List    ${full_list}    === ATPtg_offsetAzEl end of topic ===
    ${offsetAzEl_list}=    Get Slice From List    ${full_list}    start=${offsetAzEl_start}    end=${offsetAzEl_end+1}
    Log    ${offsetAzEl_list}
    Should Contain X Times    ${offsetAzEl_list}    === ${subSystem}_offsetAzEl start of topic ===    1
    Should Contain X Times    ${offsetAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}az : 1    1
    Should Contain X Times    ${offsetAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}el : 1    1
    Should Contain X Times    ${offsetAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}num : 1    1
    Should Contain X Times    ${offsetAzEl_list}    === ackCommand_offsetAzEl acknowledging a command with :    2
    Should Contain X Times    ${offsetAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${offsetAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${offsetAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${offsetAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${offsetAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${offsetAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${offsetAzEl_list}    === ${subSystem}_offsetAzEl end of topic ===    1
    ${azElTarget_start}=    Get Index From List    ${full_list}    === ATPtg_azElTarget start of topic ===
    ${azElTarget_end}=    Get Index From List    ${full_list}    === ATPtg_azElTarget end of topic ===
    ${azElTarget_list}=    Get Slice From List    ${full_list}    start=${azElTarget_start}    end=${azElTarget_end+1}
    Log    ${azElTarget_list}
    Should Contain X Times    ${azElTarget_list}    === ${subSystem}_azElTarget start of topic ===    1
    Should Contain X Times    ${azElTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetName : RO    1
    Should Contain X Times    ${azElTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azDegs : 1    1
    Should Contain X Times    ${azElTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elDegs : 1    1
    Should Contain X Times    ${azElTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    1
    Should Contain X Times    ${azElTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotPA : 1    1
    Should Contain X Times    ${azElTarget_list}    === ackCommand_azElTarget acknowledging a command with :    2
    Should Contain X Times    ${azElTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${azElTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${azElTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${azElTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${azElTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${azElTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${azElTarget_list}    === ${subSystem}_azElTarget end of topic ===    1
    ${planetTarget_start}=    Get Index From List    ${full_list}    === ATPtg_planetTarget start of topic ===
    ${planetTarget_end}=    Get Index From List    ${full_list}    === ATPtg_planetTarget end of topic ===
    ${planetTarget_list}=    Get Slice From List    ${full_list}    start=${planetTarget_start}    end=${planetTarget_end+1}
    Log    ${planetTarget_list}
    Should Contain X Times    ${planetTarget_list}    === ${subSystem}_planetTarget start of topic ===    1
    Should Contain X Times    ${planetTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}planetName : 1    1
    Should Contain X Times    ${planetTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dRA : 1    1
    Should Contain X Times    ${planetTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dDec : 1    1
    Should Contain X Times    ${planetTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    1
    Should Contain X Times    ${planetTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotPA : 1    1
    Should Contain X Times    ${planetTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}validateOnly : 1    1
    Should Contain X Times    ${planetTarget_list}    === ackCommand_planetTarget acknowledging a command with :    2
    Should Contain X Times    ${planetTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${planetTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${planetTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${planetTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${planetTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${planetTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${planetTarget_list}    === ${subSystem}_planetTarget end of topic ===    1
    ${pointNewFile_start}=    Get Index From List    ${full_list}    === ATPtg_pointNewFile start of topic ===
    ${pointNewFile_end}=    Get Index From List    ${full_list}    === ATPtg_pointNewFile end of topic ===
    ${pointNewFile_list}=    Get Slice From List    ${full_list}    start=${pointNewFile_start}    end=${pointNewFile_end+1}
    Log    ${pointNewFile_list}
    Should Contain X Times    ${pointNewFile_list}    === ${subSystem}_pointNewFile start of topic ===    1
    Should Contain X Times    ${pointNewFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignored : 1    1
    Should Contain X Times    ${pointNewFile_list}    === ackCommand_pointNewFile acknowledging a command with :    2
    Should Contain X Times    ${pointNewFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${pointNewFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${pointNewFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${pointNewFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${pointNewFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${pointNewFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${pointNewFile_list}    === ${subSystem}_pointNewFile end of topic ===    1
    ${poriginClear_start}=    Get Index From List    ${full_list}    === ATPtg_poriginClear start of topic ===
    ${poriginClear_end}=    Get Index From List    ${full_list}    === ATPtg_poriginClear end of topic ===
    ${poriginClear_list}=    Get Slice From List    ${full_list}    start=${poriginClear_start}    end=${poriginClear_end+1}
    Log    ${poriginClear_list}
    Should Contain X Times    ${poriginClear_list}    === ${subSystem}_poriginClear start of topic ===    1
    Should Contain X Times    ${poriginClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}num : 1    1
    Should Contain X Times    ${poriginClear_list}    === ackCommand_poriginClear acknowledging a command with :    2
    Should Contain X Times    ${poriginClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${poriginClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${poriginClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${poriginClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${poriginClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${poriginClear_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${poriginClear_list}    === ${subSystem}_poriginClear end of topic ===    1
    ${focusName_start}=    Get Index From List    ${full_list}    === ATPtg_focusName start of topic ===
    ${focusName_end}=    Get Index From List    ${full_list}    === ATPtg_focusName end of topic ===
    ${focusName_list}=    Get Slice From List    ${full_list}    start=${focusName_start}    end=${focusName_end+1}
    Log    ${focusName_list}
    Should Contain X Times    ${focusName_list}    === ${subSystem}_focusName start of topic ===    1
    Should Contain X Times    ${focusName_list}    ${SPACE}${SPACE}${SPACE}${SPACE}focus : 1    1
    Should Contain X Times    ${focusName_list}    === ackCommand_focusName acknowledging a command with :    2
    Should Contain X Times    ${focusName_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${focusName_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${focusName_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${focusName_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${focusName_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${focusName_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${focusName_list}    === ${subSystem}_focusName end of topic ===    1
    ${amLimitSet_start}=    Get Index From List    ${full_list}    === ATPtg_amLimitSet start of topic ===
    ${amLimitSet_end}=    Get Index From List    ${full_list}    === ATPtg_amLimitSet end of topic ===
    ${amLimitSet_list}=    Get Slice From List    ${full_list}    start=${amLimitSet_start}    end=${amLimitSet_end+1}
    Log    ${amLimitSet_list}
    Should Contain X Times    ${amLimitSet_list}    === ${subSystem}_amLimitSet start of topic ===    1
    Should Contain X Times    ${amLimitSet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amlimit : 1    1
    Should Contain X Times    ${amLimitSet_list}    === ackCommand_amLimitSet acknowledging a command with :    2
    Should Contain X Times    ${amLimitSet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${amLimitSet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${amLimitSet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${amLimitSet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${amLimitSet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${amLimitSet_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${amLimitSet_list}    === ${subSystem}_amLimitSet end of topic ===    1
    ${stopTracking_start}=    Get Index From List    ${full_list}    === ATPtg_stopTracking start of topic ===
    ${stopTracking_end}=    Get Index From List    ${full_list}    === ATPtg_stopTracking end of topic ===
    ${stopTracking_list}=    Get Slice From List    ${full_list}    start=${stopTracking_start}    end=${stopTracking_end+1}
    Log    ${stopTracking_list}
    Should Contain X Times    ${stopTracking_list}    === ${subSystem}_stopTracking start of topic ===    1
    Should Contain X Times    ${stopTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ignored : 1    1
    Should Contain X Times    ${stopTracking_list}    === ackCommand_stopTracking acknowledging a command with :    2
    Should Contain X Times    ${stopTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${stopTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${stopTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${stopTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${stopTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${stopTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${stopTracking_list}    === ${subSystem}_stopTracking end of topic ===    1
    ${startTracking_start}=    Get Index From List    ${full_list}    === ATPtg_startTracking start of topic ===
    ${startTracking_end}=    Get Index From List    ${full_list}    === ATPtg_startTracking end of topic ===
    ${startTracking_list}=    Get Slice From List    ${full_list}    start=${startTracking_start}    end=${startTracking_end+1}
    Log    ${startTracking_list}
    Should Contain X Times    ${startTracking_list}    === ${subSystem}_startTracking start of topic ===    1
    Should Contain X Times    ${startTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    1
    Should Contain X Times    ${startTracking_list}    === ackCommand_startTracking acknowledging a command with :    2
    Should Contain X Times    ${startTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 301    1
    Should Contain X Times    ${startTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ack${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}: 303    1
    Should Contain X Times    ${startTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Ack : OK    1
    Should Contain X Times    ${startTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result${SPACE}${SPACE}${SPACE}: Done : OK    1
    Should Contain X Times    ${startTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error${SPACE}${SPACE}${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${startTracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout${SPACE}${SPACE}: 0    2
    Should Contain X Times    ${startTracking_list}    === ${subSystem}_startTracking end of topic ===    1
    ${disable_start}=    Get Index From List    ${full_list}    === ATPtg_disable start of topic ===
    ${disable_end}=    Get Index From List    ${full_list}    === ATPtg_disable end of topic ===
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
    ${enable_start}=    Get Index From List    ${full_list}    === ATPtg_enable start of topic ===
    ${enable_end}=    Get Index From List    ${full_list}    === ATPtg_enable end of topic ===
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
    ${exitControl_start}=    Get Index From List    ${full_list}    === ATPtg_exitControl start of topic ===
    ${exitControl_end}=    Get Index From List    ${full_list}    === ATPtg_exitControl end of topic ===
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
    ${setLogLevel_start}=    Get Index From List    ${full_list}    === ATPtg_setLogLevel start of topic ===
    ${setLogLevel_end}=    Get Index From List    ${full_list}    === ATPtg_setLogLevel end of topic ===
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
    ${standby_start}=    Get Index From List    ${full_list}    === ATPtg_standby start of topic ===
    ${standby_end}=    Get Index From List    ${full_list}    === ATPtg_standby end of topic ===
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
    ${start_start}=    Get Index From List    ${full_list}    === ATPtg_start start of topic ===
    ${start_end}=    Get Index From List    ${full_list}    === ATPtg_start end of topic ===
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
