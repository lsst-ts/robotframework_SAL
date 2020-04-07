*** Settings ***
Documentation    ATPtg_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATPtg
${component}    all
${timeout}    45s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger

Start Logger
    [Tags]    functional
    Comment    Start Logger.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger    alias=${subSystem}_Logger     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"    "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    Comment    Wait 3s to allow full output to be written to file.
    Sleep    3s
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    === ${subSystem} loggers ready
    Sleep    6s

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_focusNameSelected test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_focusNameSelected
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event focusNameSelected iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_focusNameSelected_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event focusNameSelected generated =
    Comment    ======= Verify ${subSystem}_sunProximityWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_sunProximityWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event sunProximityWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_sunProximityWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event sunProximityWarning generated =
    Comment    ======= Verify ${subSystem}_detailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_detailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event detailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_detailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event detailedState generated =
    Comment    ======= Verify ${subSystem}_mountGuideMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_mountGuideMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event mountGuideMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_mountGuideMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event mountGuideMode generated =
    Comment    ======= Verify ${subSystem}_azWrapWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azWrapWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event azWrapWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azWrapWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azWrapWarning generated =
    Comment    ======= Verify ${subSystem}_wavelength test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_wavelength
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event wavelength iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_wavelength_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event wavelength generated =
    Comment    ======= Verify ${subSystem}_inPositionEl test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_inPositionEl
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event inPositionEl iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_inPositionEl_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event inPositionEl generated =
    Comment    ======= Verify ${subSystem}_inBlindSpot test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_inBlindSpot
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event inBlindSpot iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_inBlindSpot_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event inBlindSpot generated =
    Comment    ======= Verify ${subSystem}_blindSpotWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_blindSpotWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event blindSpotWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_blindSpotWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event blindSpotWarning generated =
    Comment    ======= Verify ${subSystem}_axesTrackMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_axesTrackMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event axesTrackMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_axesTrackMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event axesTrackMode generated =
    Comment    ======= Verify ${subSystem}_objectSetWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_objectSetWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event objectSetWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_objectSetWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event objectSetWarning generated =
    Comment    ======= Verify ${subSystem}_pointingModel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_pointingModel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event pointingModel iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_pointingModel_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event pointingModel generated =
    Comment    ======= Verify ${subSystem}_airmassWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_airmassWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event airmassWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_airmassWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event airmassWarning generated =
    Comment    ======= Verify ${subSystem}_weatherDataInvalid test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_weatherDataInvalid
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event weatherDataInvalid iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_weatherDataInvalid_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event weatherDataInvalid generated =
    Comment    ======= Verify ${subSystem}_focusNameInconsistentWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_focusNameInconsistentWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event focusNameInconsistentWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_focusNameInconsistentWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event focusNameInconsistentWarning generated =
    Comment    ======= Verify ${subSystem}_currentTarget test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_currentTarget
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event currentTarget iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_currentTarget_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event currentTarget generated =
    Comment    ======= Verify ${subSystem}_iersOutOfDate test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_iersOutOfDate
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event iersOutOfDate iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_iersOutOfDate_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event iersOutOfDate generated =
    Comment    ======= Verify ${subSystem}_weatherDataApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_weatherDataApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event weatherDataApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_weatherDataApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event weatherDataApplied generated =
    Comment    ======= Verify ${subSystem}_currentDebugLevel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_currentDebugLevel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event currentDebugLevel iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_currentDebugLevel_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event currentDebugLevel generated =
    Comment    ======= Verify ${subSystem}_mountDataWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_mountDataWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event mountDataWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_mountDataWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event mountDataWarning generated =
    Comment    ======= Verify ${subSystem}_accessMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_accessMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event accessMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_accessMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event accessMode generated =
    Comment    ======= Verify ${subSystem}_rotWrapWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rotWrapWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rotWrapWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rotWrapWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rotWrapWarning generated =
    Comment    ======= Verify ${subSystem}_inPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_inPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event inPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_inPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event inPosition generated =
    Comment    ======= Verify ${subSystem}_inPositionRot test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_inPositionRot
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event inPositionRot iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_inPositionRot_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event inPositionRot generated =
    Comment    ======= Verify ${subSystem}_inPositionAz test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_inPositionAz
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event inPositionAz iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_inPositionAz_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event inPositionAz generated =
    Comment    ======= Verify ${subSystem}_iers test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_iers
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event iers iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_iers_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event iers generated =
    Comment    ======= Verify ${subSystem}_moonProximityWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_moonProximityWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event moonProximityWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_moonProximityWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event moonProximityWarning generated =
    Comment    ======= Verify ${subSystem}_trackPosting test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_trackPosting
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event trackPosting iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_trackPosting_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event trackPosting generated =
    Comment    ======= Verify ${subSystem}_ptgAzCurrentWrap test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_ptgAzCurrentWrap
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event ptgAzCurrentWrap iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_ptgAzCurrentWrap_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event ptgAzCurrentWrap generated =
    Comment    ======= Verify ${subSystem}_ptgRotCurrentWrap test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_ptgRotCurrentWrap
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event ptgRotCurrentWrap iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_ptgRotCurrentWrap_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event ptgRotCurrentWrap generated =
    Comment    ======= Verify ${subSystem}_elLimitWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_elLimitWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event elLimitWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_elLimitWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event elLimitWarning generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${focusNameSelected_start}=    Get Index From List    ${full_list}    === Event focusNameSelected received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${focusNameSelected_start}
    ${focusNameSelected_end}=    Evaluate    ${end}+${1}
    ${focusNameSelected_list}=    Get Slice From List    ${full_list}    start=${focusNameSelected_start}    end=${focusNameSelected_end}
    Should Contain X Times    ${focusNameSelected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}focus : 1    1
    Should Contain X Times    ${focusNameSelected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${sunProximityWarning_start}=    Get Index From List    ${full_list}    === Event sunProximityWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${sunProximityWarning_start}
    ${sunProximityWarning_end}=    Evaluate    ${end}+${1}
    ${sunProximityWarning_list}=    Get Slice From List    ${full_list}    start=${sunProximityWarning_start}    end=${sunProximityWarning_end}
    Should Contain X Times    ${sunProximityWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${sunProximityWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${detailedState_start}=    Get Index From List    ${full_list}    === Event detailedState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${detailedState_start}
    ${detailedState_end}=    Evaluate    ${end}+${1}
    ${detailedState_list}=    Get Slice From List    ${full_list}    start=${detailedState_start}    end=${detailedState_end}
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${mountGuideMode_start}=    Get Index From List    ${full_list}    === Event mountGuideMode received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${mountGuideMode_start}
    ${mountGuideMode_end}=    Evaluate    ${end}+${1}
    ${mountGuideMode_list}=    Get Slice From List    ${full_list}    start=${mountGuideMode_start}    end=${mountGuideMode_end}
    Should Contain X Times    ${mountGuideMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    Should Contain X Times    ${mountGuideMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azWrapWarning_start}=    Get Index From List    ${full_list}    === Event azWrapWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${azWrapWarning_start}
    ${azWrapWarning_end}=    Evaluate    ${end}+${1}
    ${azWrapWarning_list}=    Get Slice From List    ${full_list}    start=${azWrapWarning_start}    end=${azWrapWarning_end}
    Should Contain X Times    ${azWrapWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${azWrapWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${wavelength_start}=    Get Index From List    ${full_list}    === Event wavelength received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${wavelength_start}
    ${wavelength_end}=    Evaluate    ${end}+${1}
    ${wavelength_list}=    Get Slice From List    ${full_list}    start=${wavelength_start}    end=${wavelength_end}
    Should Contain X Times    ${wavelength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wavelength : 1    1
    Should Contain X Times    ${wavelength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${inPositionEl_start}=    Get Index From List    ${full_list}    === Event inPositionEl received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${inPositionEl_start}
    ${inPositionEl_end}=    Evaluate    ${end}+${1}
    ${inPositionEl_list}=    Get Slice From List    ${full_list}    start=${inPositionEl_start}    end=${inPositionEl_end}
    Should Contain X Times    ${inPositionEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    Should Contain X Times    ${inPositionEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${inBlindSpot_start}=    Get Index From List    ${full_list}    === Event inBlindSpot received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${inBlindSpot_start}
    ${inBlindSpot_end}=    Evaluate    ${end}+${1}
    ${inBlindSpot_list}=    Get Slice From List    ${full_list}    start=${inBlindSpot_start}    end=${inBlindSpot_end}
    Should Contain X Times    ${inBlindSpot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    Should Contain X Times    ${inBlindSpot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${blindSpotWarning_start}=    Get Index From List    ${full_list}    === Event blindSpotWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${blindSpotWarning_start}
    ${blindSpotWarning_end}=    Evaluate    ${end}+${1}
    ${blindSpotWarning_list}=    Get Slice From List    ${full_list}    start=${blindSpotWarning_start}    end=${blindSpotWarning_end}
    Should Contain X Times    ${blindSpotWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${blindSpotWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${axesTrackMode_start}=    Get Index From List    ${full_list}    === Event axesTrackMode received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${axesTrackMode_start}
    ${axesTrackMode_end}=    Evaluate    ${end}+${1}
    ${axesTrackMode_list}=    Get Slice From List    ${full_list}    start=${axesTrackMode_start}    end=${axesTrackMode_end}
    Should Contain X Times    ${axesTrackMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${axesTrackMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${axesTrackMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${objectSetWarning_start}=    Get Index From List    ${full_list}    === Event objectSetWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${objectSetWarning_start}
    ${objectSetWarning_end}=    Evaluate    ${end}+${1}
    ${objectSetWarning_list}=    Get Slice From List    ${full_list}    start=${objectSetWarning_start}    end=${objectSetWarning_end}
    Should Contain X Times    ${objectSetWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${objectSetWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${pointingModel_start}=    Get Index From List    ${full_list}    === Event pointingModel received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${pointingModel_start}
    ${pointingModel_end}=    Evaluate    ${end}+${1}
    ${pointingModel_list}=    Get Slice From List    ${full_list}    start=${pointingModel_start}    end=${pointingModel_end}
    Should Contain X Times    ${pointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${pointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingModelTermNames : LSST    1
    Should Contain X Times    ${pointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingModelTermValues : LSST    1
    Should Contain X Times    ${pointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${airmassWarning_start}=    Get Index From List    ${full_list}    === Event airmassWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${airmassWarning_start}
    ${airmassWarning_end}=    Evaluate    ${end}+${1}
    ${airmassWarning_list}=    Get Slice From List    ${full_list}    start=${airmassWarning_start}    end=${airmassWarning_end}
    Should Contain X Times    ${airmassWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${airmassWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${weatherDataInvalid_start}=    Get Index From List    ${full_list}    === Event weatherDataInvalid received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${weatherDataInvalid_start}
    ${weatherDataInvalid_end}=    Evaluate    ${end}+${1}
    ${weatherDataInvalid_list}=    Get Slice From List    ${full_list}    start=${weatherDataInvalid_start}    end=${weatherDataInvalid_end}
    Should Contain X Times    ${weatherDataInvalid_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    Should Contain X Times    ${weatherDataInvalid_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${focusNameInconsistentWarning_start}=    Get Index From List    ${full_list}    === Event focusNameInconsistentWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${focusNameInconsistentWarning_start}
    ${focusNameInconsistentWarning_end}=    Evaluate    ${end}+${1}
    ${focusNameInconsistentWarning_list}=    Get Slice From List    ${full_list}    start=${focusNameInconsistentWarning_start}    end=${focusNameInconsistentWarning_end}
    Should Contain X Times    ${focusNameInconsistentWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    Should Contain X Times    ${focusNameInconsistentWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${currentTarget_start}=    Get Index From List    ${full_list}    === Event currentTarget received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${currentTarget_start}
    ${currentTarget_end}=    Evaluate    ${end}+${1}
    ${currentTarget_list}=    Get Slice From List    ${full_list}    start=${currentTarget_start}    end=${currentTarget_end}
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetType : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetName : LSST    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}frame : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azDegs : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elDegs : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}planetName : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ephemFile : LSST    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}equinox : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raString : LSST    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decString : LSST    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}epoch : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}difftrackRA : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}difftrackDec : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}properMotionRA : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}properMotionDec : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}parallax : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}radvel : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotPA : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotFrame : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotMode : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raHours : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decDegs : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${iersOutOfDate_start}=    Get Index From List    ${full_list}    === Event iersOutOfDate received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${iersOutOfDate_start}
    ${iersOutOfDate_end}=    Evaluate    ${end}+${1}
    ${iersOutOfDate_list}=    Get Slice From List    ${full_list}    start=${iersOutOfDate_start}    end=${iersOutOfDate_end}
    Should Contain X Times    ${iersOutOfDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    Should Contain X Times    ${iersOutOfDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${weatherDataApplied_start}=    Get Index From List    ${full_list}    === Event weatherDataApplied received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${weatherDataApplied_start}
    ${weatherDataApplied_end}=    Evaluate    ${end}+${1}
    ${weatherDataApplied_list}=    Get Slice From List    ${full_list}    start=${weatherDataApplied_start}    end=${weatherDataApplied_end}
    Should Contain X Times    ${weatherDataApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambient_temp : 1    1
    Should Contain X Times    ${weatherDataApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure : 1    1
    Should Contain X Times    ${weatherDataApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}humidity : 1    1
    Should Contain X Times    ${weatherDataApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${currentDebugLevel_start}=    Get Index From List    ${full_list}    === Event currentDebugLevel received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${currentDebugLevel_start}
    ${currentDebugLevel_end}=    Evaluate    ${end}+${1}
    ${currentDebugLevel_list}=    Get Slice From List    ${full_list}    start=${currentDebugLevel_start}    end=${currentDebugLevel_end}
    Should Contain X Times    ${currentDebugLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentLevel : 1    1
    Should Contain X Times    ${currentDebugLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${mountDataWarning_start}=    Get Index From List    ${full_list}    === Event mountDataWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${mountDataWarning_start}
    ${mountDataWarning_end}=    Evaluate    ${end}+${1}
    ${mountDataWarning_list}=    Get Slice From List    ${full_list}    start=${mountDataWarning_start}    end=${mountDataWarning_end}
    Should Contain X Times    ${mountDataWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${mountDataWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${accessMode_start}=    Get Index From List    ${full_list}    === Event accessMode received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${accessMode_start}
    ${accessMode_end}=    Evaluate    ${end}+${1}
    ${accessMode_list}=    Get Slice From List    ${full_list}    start=${accessMode_start}    end=${accessMode_end}
    Should Contain X Times    ${accessMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    Should Contain X Times    ${accessMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rotWrapWarning_start}=    Get Index From List    ${full_list}    === Event rotWrapWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${rotWrapWarning_start}
    ${rotWrapWarning_end}=    Evaluate    ${end}+${1}
    ${rotWrapWarning_list}=    Get Slice From List    ${full_list}    start=${rotWrapWarning_start}    end=${rotWrapWarning_end}
    Should Contain X Times    ${rotWrapWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${rotWrapWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${inPosition_start}=    Get Index From List    ${full_list}    === Event inPosition received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${inPosition_start}
    ${inPosition_end}=    Evaluate    ${end}+${1}
    ${inPosition_list}=    Get Slice From List    ${full_list}    start=${inPosition_start}    end=${inPosition_end}
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${inPositionRot_start}=    Get Index From List    ${full_list}    === Event inPositionRot received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${inPositionRot_start}
    ${inPositionRot_end}=    Evaluate    ${end}+${1}
    ${inPositionRot_list}=    Get Slice From List    ${full_list}    start=${inPositionRot_start}    end=${inPositionRot_end}
    Should Contain X Times    ${inPositionRot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    Should Contain X Times    ${inPositionRot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${inPositionAz_start}=    Get Index From List    ${full_list}    === Event inPositionAz received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${inPositionAz_start}
    ${inPositionAz_end}=    Evaluate    ${end}+${1}
    ${inPositionAz_list}=    Get Slice From List    ${full_list}    start=${inPositionAz_start}    end=${inPositionAz_end}
    Should Contain X Times    ${inPositionAz_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    Should Contain X Times    ${inPositionAz_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${iers_start}=    Get Index From List    ${full_list}    === Event iers received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${iers_start}
    ${iers_end}=    Evaluate    ${end}+${1}
    ${iers_list}=    Get Slice From List    ${full_list}    start=${iers_start}    end=${iers_end}
    Should Contain X Times    ${iers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${iers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dut1 : 1    1
    Should Contain X Times    ${iers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}poleX : 1    1
    Should Contain X Times    ${iers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}poleY : 1    1
    Should Contain X Times    ${iers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${moonProximityWarning_start}=    Get Index From List    ${full_list}    === Event moonProximityWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${moonProximityWarning_start}
    ${moonProximityWarning_end}=    Evaluate    ${end}+${1}
    ${moonProximityWarning_list}=    Get Slice From List    ${full_list}    start=${moonProximityWarning_start}    end=${moonProximityWarning_end}
    Should Contain X Times    ${moonProximityWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${moonProximityWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${trackPosting_start}=    Get Index From List    ${full_list}    === Event trackPosting received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${trackPosting_start}
    ${trackPosting_end}=    Evaluate    ${end}+${1}
    ${trackPosting_list}=    Get Slice From List    ${full_list}    start=${trackPosting_start}    end=${trackPosting_end}
    Should Contain X Times    ${trackPosting_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 1    1
    Should Contain X Times    ${trackPosting_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${ptgAzCurrentWrap_start}=    Get Index From List    ${full_list}    === Event ptgAzCurrentWrap received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${ptgAzCurrentWrap_start}
    ${ptgAzCurrentWrap_end}=    Evaluate    ${end}+${1}
    ${ptgAzCurrentWrap_list}=    Get Slice From List    ${full_list}    start=${ptgAzCurrentWrap_start}    end=${ptgAzCurrentWrap_end}
    Should Contain X Times    ${ptgAzCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentWrap : 1    1
    Should Contain X Times    ${ptgAzCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${ptgRotCurrentWrap_start}=    Get Index From List    ${full_list}    === Event ptgRotCurrentWrap received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${ptgRotCurrentWrap_start}
    ${ptgRotCurrentWrap_end}=    Evaluate    ${end}+${1}
    ${ptgRotCurrentWrap_list}=    Get Slice From List    ${full_list}    start=${ptgRotCurrentWrap_start}    end=${ptgRotCurrentWrap_end}
    Should Contain X Times    ${ptgRotCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentWrap : 1    1
    Should Contain X Times    ${ptgRotCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${elLimitWarning_start}=    Get Index From List    ${full_list}    === Event elLimitWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${elLimitWarning_start}
    ${elLimitWarning_end}=    Evaluate    ${end}+${1}
    ${elLimitWarning_list}=    Get Slice From List    ${full_list}    start=${elLimitWarning_start}    end=${elLimitWarning_end}
    Should Contain X Times    ${elLimitWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${elLimitWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
