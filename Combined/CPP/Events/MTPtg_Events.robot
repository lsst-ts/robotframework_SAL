*** Settings ***
Documentation    MTPtg_Events communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}common.robot
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTPtg
${component}    all
${timeout}    180s

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
    Wait Until Keyword Succeeds    90s    5s    File Should Contain    ${EXECDIR}${/}stdout.txt    === ${subSystem} loggers ready
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Log    ${output}

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_focusNameSelected test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_focusNameSelected
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event focusNameSelected iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_focusNameSelected_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event focusNameSelected generated =
    Comment    ======= Verify ${subSystem}_sunProximityWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_sunProximityWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event sunProximityWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_sunProximityWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event sunProximityWarning generated =
    Comment    ======= Verify ${subSystem}_detailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_detailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event detailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_detailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event detailedState generated =
    Comment    ======= Verify ${subSystem}_mountGuideMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_mountGuideMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event mountGuideMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_mountGuideMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event mountGuideMode generated =
    Comment    ======= Verify ${subSystem}_azWrapWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_azWrapWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event azWrapWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_azWrapWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event azWrapWarning generated =
    Comment    ======= Verify ${subSystem}_wavelength test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_wavelength
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event wavelength iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_wavelength_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event wavelength generated =
    Comment    ======= Verify ${subSystem}_inPositionEl test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_inPositionEl
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event inPositionEl iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_inPositionEl_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event inPositionEl generated =
    Comment    ======= Verify ${subSystem}_axesTrackMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_axesTrackMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event axesTrackMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_axesTrackMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event axesTrackMode generated =
    Comment    ======= Verify ${subSystem}_objectSetWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_objectSetWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event objectSetWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_objectSetWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event objectSetWarning generated =
    Comment    ======= Verify ${subSystem}_pointingModel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_pointingModel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event pointingModel iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_pointingModel_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event pointingModel generated =
    Comment    ======= Verify ${subSystem}_airmassWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_airmassWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event airmassWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_airmassWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event airmassWarning generated =
    Comment    ======= Verify ${subSystem}_weatherDataInvalid test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_weatherDataInvalid
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event weatherDataInvalid iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_weatherDataInvalid_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event weatherDataInvalid generated =
    Comment    ======= Verify ${subSystem}_focusNameInconsistentWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_focusNameInconsistentWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event focusNameInconsistentWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_focusNameInconsistentWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event focusNameInconsistentWarning generated =
    Comment    ======= Verify ${subSystem}_currentTarget test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_currentTarget
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event currentTarget iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_currentTarget_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event currentTarget generated =
    Comment    ======= Verify ${subSystem}_iersOutOfDate test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_iersOutOfDate
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event iersOutOfDate iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_iersOutOfDate_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event iersOutOfDate generated =
    Comment    ======= Verify ${subSystem}_weatherDataApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_weatherDataApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event weatherDataApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_weatherDataApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event weatherDataApplied generated =
    Comment    ======= Verify ${subSystem}_currentDebugLevel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_currentDebugLevel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event currentDebugLevel iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_currentDebugLevel_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event currentDebugLevel generated =
    Comment    ======= Verify ${subSystem}_mountDataWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_mountDataWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event mountDataWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_mountDataWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event mountDataWarning generated =
    Comment    ======= Verify ${subSystem}_accessMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_accessMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event accessMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_accessMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event accessMode generated =
    Comment    ======= Verify ${subSystem}_rotWrapWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rotWrapWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event rotWrapWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rotWrapWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rotWrapWarning generated =
    Comment    ======= Verify ${subSystem}_inPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_inPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event inPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_inPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event inPosition generated =
    Comment    ======= Verify ${subSystem}_inPositionRot test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_inPositionRot
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event inPositionRot iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_inPositionRot_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event inPositionRot generated =
    Comment    ======= Verify ${subSystem}_inPositionAz test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_inPositionAz
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event inPositionAz iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_inPositionAz_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event inPositionAz generated =
    Comment    ======= Verify ${subSystem}_iers test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_iers
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event iers iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_iers_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event iers generated =
    Comment    ======= Verify ${subSystem}_moonProximityWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_moonProximityWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event moonProximityWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_moonProximityWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event moonProximityWarning generated =
    Comment    ======= Verify ${subSystem}_trackPosting test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_trackPosting
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event trackPosting iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_trackPosting_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event trackPosting generated =
    Comment    ======= Verify ${subSystem}_ptgAzCurrentWrap test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_ptgAzCurrentWrap
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event ptgAzCurrentWrap iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_ptgAzCurrentWrap_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event ptgAzCurrentWrap generated =
    Comment    ======= Verify ${subSystem}_ptgRotCurrentWrap test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_ptgRotCurrentWrap
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event ptgRotCurrentWrap iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_ptgRotCurrentWrap_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event ptgRotCurrentWrap generated =
    Comment    ======= Verify ${subSystem}_elLimitWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_elLimitWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event elLimitWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_elLimitWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event elLimitWarning generated =
    Comment    ======= Verify ${subSystem}_pointingFile test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_pointingFile
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event pointingFile iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_pointingFile_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event pointingFile generated =
    Comment    ======= Verify ${subSystem}_timesOfLimits test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_timesOfLimits
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event timesOfLimits iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_timesOfLimits_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event timesOfLimits generated =
    Comment    ======= Verify ${subSystem}_validatedTarget test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_validatedTarget
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event validatedTarget iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_validatedTarget_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event validatedTarget generated =
    Comment    ======= Verify ${subSystem}_offsetSummary test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_offsetSummary
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event offsetSummary iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_offsetSummary_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event offsetSummary generated =
    Comment    ======= Verify ${subSystem}_pointData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_pointData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event pointData iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_pointData_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event pointData generated =
    Comment    ======= Verify ${subSystem}_settingVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingVersions generated =
    Comment    ======= Verify ${subSystem}_errorCode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_errorCode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event errorCode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_errorCode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event errorCode generated =
    Comment    ======= Verify ${subSystem}_summaryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_summaryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event summaryState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_summaryState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event summaryState generated =
    Comment    ======= Verify ${subSystem}_appliedSettingsMatchStart test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedSettingsMatchStart
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedSettingsMatchStart iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedSettingsMatchStart_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedSettingsMatchStart generated =
    Comment    ======= Verify ${subSystem}_logLevel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logLevel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event logLevel iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logLevel_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logLevel generated =
    Comment    ======= Verify ${subSystem}_logMessage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logMessage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event logMessage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logMessage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logMessage generated =
    Comment    ======= Verify ${subSystem}_settingsApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsApplied generated =
    Comment    ======= Verify ${subSystem}_simulationMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_simulationMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event simulationMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_simulationMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event simulationMode generated =
    Comment    ======= Verify ${subSystem}_softwareVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_softwareVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event softwareVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_softwareVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event softwareVersions generated =
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_heartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event heartbeat iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_heartbeat_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event heartbeat generated =
    Comment    ======= Verify ${subSystem}_authList test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_authList
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event authList iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_authList_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event authList generated =

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
    Should Contain X Times    ${pointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingModelTermNames : RO    1
    Should Contain X Times    ${pointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingModelTermValues : RO    1
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
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetName : RO    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}frame : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azDegs : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elDegs : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}planetName : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ephemFile : RO    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}equinox : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raString : RO    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decString : RO    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}epoch : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}difftrackRA : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}difftrackDec : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}properMotionRA : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}properMotionDec : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}parallax : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}radvel : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotPA : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotAngle : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotStartFrame : 1    1
    Should Contain X Times    ${currentTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotTrackFrame : 1    1
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
    Should Contain X Times    ${weatherDataApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemp : 1    1
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
    ${pointingFile_start}=    Get Index From List    ${full_list}    === Event pointingFile received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${pointingFile_start}
    ${pointingFile_end}=    Evaluate    ${end}+${1}
    ${pointingFile_list}=    Get Slice From List    ${full_list}    start=${pointingFile_start}    end=${pointingFile_end}
    Should Contain X Times    ${pointingFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fileIsOpen : 1    1
    Should Contain X Times    ${pointingFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filePath : RO    1
    Should Contain X Times    ${pointingFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${timesOfLimits_start}=    Get Index From List    ${full_list}    === Event timesOfLimits received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${timesOfLimits_start}
    ${timesOfLimits_end}=    Evaluate    ${end}+${1}
    ${timesOfLimits_list}=    Get Slice From List    ${full_list}    start=${timesOfLimits_start}    end=${timesOfLimits_end}
    Should Contain X Times    ${timesOfLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${timesOfLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeAzLim : 1    1
    Should Contain X Times    ${timesOfLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRotLim : 1    1
    Should Contain X Times    ${timesOfLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeElHighLimit : 1    1
    Should Contain X Times    ${timesOfLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeElLowLimit : 1    1
    Should Contain X Times    ${timesOfLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeUnobservable : 1    1
    Should Contain X Times    ${timesOfLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    1
    Should Contain X Times    ${timesOfLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${validatedTarget_start}=    Get Index From List    ${full_list}    === Event validatedTarget received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${validatedTarget_start}
    ${validatedTarget_end}=    Evaluate    ${end}+${1}
    ${validatedTarget_list}=    Get Slice From List    ${full_list}    start=${validatedTarget_start}    end=${validatedTarget_end}
    Should Contain X Times    ${validatedTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}isValid : 1    1
    Should Contain X Times    ${validatedTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}az : 1    1
    Should Contain X Times    ${validatedTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}el : 1    1
    Should Contain X Times    ${validatedTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rot : 1    1
    Should Contain X Times    ${validatedTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    1
    Should Contain X Times    ${validatedTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${offsetSummary_start}=    Get Index From List    ${full_list}    === Event offsetSummary received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${offsetSummary_start}
    ${offsetSummary_end}=    Evaluate    ${end}+${1}
    ${offsetSummary_list}=    Get Slice From List    ${full_list}    start=${offsetSummary_start}    end=${offsetSummary_end}
    Should Contain X Times    ${offsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${offsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}iaa : 1    1
    Should Contain X Times    ${offsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userOffsetRA : 1    1
    Should Contain X Times    ${offsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userOffsetDec : 1    1
    Should Contain X Times    ${offsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}handsetOffsetRA : 1    1
    Should Contain X Times    ${offsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}handsetOffsetDec : 1    1
    Should Contain X Times    ${offsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userCollOffsetCA : 1    1
    Should Contain X Times    ${offsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userCollOffsetCE : 1    1
    Should Contain X Times    ${offsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}handsetCollOffsetCA : 1    1
    Should Contain X Times    ${offsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}handsetCollOffsetCE : 1    1
    Should Contain X Times    ${offsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingOriginX : 1    1
    Should Contain X Times    ${offsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingOriginY : 1    1
    Should Contain X Times    ${offsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingOriginUserDX : 1    1
    Should Contain X Times    ${offsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingOriginUserDY : 1    1
    Should Contain X Times    ${offsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingOriginHandsetDX : 1    1
    Should Contain X Times    ${offsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingOriginHandsetDY : 1    1
    Should Contain X Times    ${offsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${pointData_start}=    Get Index From List    ${full_list}    === Event pointData received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${pointData_start}
    ${pointData_end}=    Evaluate    ${end}+${1}
    ${pointData_list}=    Get Slice From List    ${full_list}    start=${pointData_start}    end=${pointData_end}
    Should Contain X Times    ${pointData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}expectedAzimuth : 1    1
    Should Contain X Times    ${pointData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}expectedElevation : 1    1
    Should Contain X Times    ${pointData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredAzimuth : 1    1
    Should Contain X Times    ${pointData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredElevation : 1    1
    Should Contain X Times    ${pointData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredRotator : 1    1
    Should Contain X Times    ${pointData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filePath : RO    1
    Should Contain X Times    ${pointData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingVersions_start}=    Get Index From List    ${full_list}    === Event settingVersions received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingVersions_start}
    ${settingVersions_end}=    Evaluate    ${end}+${1}
    ${settingVersions_list}=    Get Slice From List    ${full_list}    start=${settingVersions_start}    end=${settingVersions_end}
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsVersion : RO    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsLabels : RO    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settingsUrl : RO    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${errorCode_start}=    Get Index From List    ${full_list}    === Event errorCode received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${errorCode_start}
    ${errorCode_end}=    Evaluate    ${end}+${1}
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end}
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorReport : RO    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${summaryState_start}=    Get Index From List    ${full_list}    === Event summaryState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${summaryState_start}
    ${summaryState_end}=    Evaluate    ${end}+${1}
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end}
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}summaryState : 1    1
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedSettingsMatchStart_start}=    Get Index From List    ${full_list}    === Event appliedSettingsMatchStart received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${appliedSettingsMatchStart_start}
    ${appliedSettingsMatchStart_end}=    Evaluate    ${end}+${1}
    ${appliedSettingsMatchStart_list}=    Get Slice From List    ${full_list}    start=${appliedSettingsMatchStart_start}    end=${appliedSettingsMatchStart_end}
    Should Contain X Times    ${appliedSettingsMatchStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}appliedSettingsMatchStartIsTrue : 1    1
    Should Contain X Times    ${appliedSettingsMatchStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logLevel_start}=    Get Index From List    ${full_list}    === Event logLevel received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${logLevel_start}
    ${logLevel_end}=    Evaluate    ${end}+${1}
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end}
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logMessage_start}=    Get Index From List    ${full_list}    === Event logMessage received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${logMessage_start}
    ${logMessage_end}=    Evaluate    ${end}+${1}
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end}
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}message : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filePath : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}functionName : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lineNumber : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}process : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsApplied_start}=    Get Index From List    ${full_list}    === Event settingsApplied received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingsApplied_start}
    ${settingsApplied_end}=    Evaluate    ${end}+${1}
    ${settingsApplied_list}=    Get Slice From List    ${full_list}    start=${settingsApplied_start}    end=${settingsApplied_end}
    Should Contain X Times    ${settingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settingsVersion : RO    1
    Should Contain X Times    ${settingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otherSettingsEvents : RO    1
    Should Contain X Times    ${settingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${simulationMode_start}=    Get Index From List    ${full_list}    === Event simulationMode received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${simulationMode_start}
    ${simulationMode_end}=    Evaluate    ${end}+${1}
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end}
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === Event softwareVersions received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${softwareVersions_start}
    ${softwareVersions_end}=    Evaluate    ${end}+${1}
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end}
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xmlVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openSpliceVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cscVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystemVersions : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${heartbeat_start}=    Get Index From List    ${full_list}    === Event heartbeat received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${heartbeat_start}
    ${heartbeat_end}=    Evaluate    ${end}+${1}
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end}
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeat : 1    1
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${authList_start}=    Get Index From List    ${full_list}    === Event authList received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${authList_start}
    ${authList_end}=    Evaluate    ${end}+${1}
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${authList_end}
    Should Contain X Times    ${authList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}authorizedUsers : RO    1
    Should Contain X Times    ${authList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nonAuthorizedCSCs : RO    1
    Should Contain X Times    ${authList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
