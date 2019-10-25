*** Settings ***
Documentation    MTPtg_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTPtg
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
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger    alias=Logger     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"    "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
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
    Comment    ======= Verify ${subSystem}_settingsApplied test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsApplied
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsApplied_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsApplied generated =
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
    Comment    ======= Verify ${subSystem}_nextTarget test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_nextTarget
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event nextTarget iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_nextTarget_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event nextTarget generated =
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
    Comment    ======= Verify ${subSystem}_prospectiveTarget test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_prospectiveTarget
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event prospectiveTarget iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_prospectiveTarget_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event prospectiveTarget generated =
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
    Comment    ======= Verify ${subSystem}_settingVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingVersions generated =
    Comment    ======= Verify ${subSystem}_errorCode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_errorCode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event errorCode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_errorCode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event errorCode generated =
    Comment    ======= Verify ${subSystem}_summaryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_summaryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event summaryState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_summaryState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event summaryState generated =
    Comment    ======= Verify ${subSystem}_appliedSettingsMatchStart test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedSettingsMatchStart
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedSettingsMatchStart iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedSettingsMatchStart_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedSettingsMatchStart generated =
    Comment    ======= Verify ${subSystem}_logLevel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logLevel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event logLevel iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logLevel_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logLevel generated =
    Comment    ======= Verify ${subSystem}_logMessage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logMessage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event logMessage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logMessage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logMessage generated =
    Comment    ======= Verify ${subSystem}_simulationMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_simulationMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event simulationMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_simulationMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event simulationMode generated =
    Comment    ======= Verify ${subSystem}_softwareVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_softwareVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event softwareVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_softwareVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event softwareVersions generated =
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_heartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event heartbeat iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_heartbeat_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event heartbeat generated =

Read Logger
    [Tags]    functional
    Switch Process    Logger
    ${output}=    Wait For Process    handle=Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain    ${output.stdout}    ===== ${subSystem} loggers ready
    ${focusNameSelected_start}=    Get Index From List    ${full_list}    === ${subSystem}_focusNameSelected start of topic ===
    ${focusNameSelected_end}=    Get Index From List    ${full_list}    === ${subSystem}_focusNameSelected end of topic ===
    ${focusNameSelected_list}=    Get Slice From List    ${full_list}    start=${focusNameSelected_start}    end=${focusNameSelected_end}
    Should Contain X Times    ${focusNameSelected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}focus : 1    1
    Should Contain X Times    ${focusNameSelected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsApplied_start}=    Get Index From List    ${full_list}    === ${subSystem}_settingsApplied start of topic ===
    ${settingsApplied_end}=    Get Index From List    ${full_list}    === ${subSystem}_settingsApplied end of topic ===
    ${settingsApplied_list}=    Get Slice From List    ${full_list}    start=${settingsApplied_start}    end=${settingsApplied_end}
    Should Contain X Times    ${settingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settings : 1    1
    Should Contain X Times    ${settingsApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${sunProximityWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_sunProximityWarning start of topic ===
    ${sunProximityWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_sunProximityWarning end of topic ===
    ${sunProximityWarning_list}=    Get Slice From List    ${full_list}    start=${sunProximityWarning_start}    end=${sunProximityWarning_end}
    Should Contain X Times    ${sunProximityWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${sunProximityWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${detailedState_start}=    Get Index From List    ${full_list}    === ${subSystem}_detailedState start of topic ===
    ${detailedState_end}=    Get Index From List    ${full_list}    === ${subSystem}_detailedState end of topic ===
    ${detailedState_list}=    Get Slice From List    ${full_list}    start=${detailedState_start}    end=${detailedState_end}
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${mountGuideMode_start}=    Get Index From List    ${full_list}    === ${subSystem}_mountGuideMode start of topic ===
    ${mountGuideMode_end}=    Get Index From List    ${full_list}    === ${subSystem}_mountGuideMode end of topic ===
    ${mountGuideMode_list}=    Get Slice From List    ${full_list}    start=${mountGuideMode_start}    end=${mountGuideMode_end}
    Should Contain X Times    ${mountGuideMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    Should Contain X Times    ${mountGuideMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${azWrapWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_azWrapWarning start of topic ===
    ${azWrapWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_azWrapWarning end of topic ===
    ${azWrapWarning_list}=    Get Slice From List    ${full_list}    start=${azWrapWarning_start}    end=${azWrapWarning_end}
    Should Contain X Times    ${azWrapWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${azWrapWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${wavelength_start}=    Get Index From List    ${full_list}    === ${subSystem}_wavelength start of topic ===
    ${wavelength_end}=    Get Index From List    ${full_list}    === ${subSystem}_wavelength end of topic ===
    ${wavelength_list}=    Get Slice From List    ${full_list}    start=${wavelength_start}    end=${wavelength_end}
    Should Contain X Times    ${wavelength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wavelength : 1    1
    Should Contain X Times    ${wavelength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${inPositionEl_start}=    Get Index From List    ${full_list}    === ${subSystem}_inPositionEl start of topic ===
    ${inPositionEl_end}=    Get Index From List    ${full_list}    === ${subSystem}_inPositionEl end of topic ===
    ${inPositionEl_list}=    Get Slice From List    ${full_list}    start=${inPositionEl_start}    end=${inPositionEl_end}
    Should Contain X Times    ${inPositionEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    Should Contain X Times    ${inPositionEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${inBlindSpot_start}=    Get Index From List    ${full_list}    === ${subSystem}_inBlindSpot start of topic ===
    ${inBlindSpot_end}=    Get Index From List    ${full_list}    === ${subSystem}_inBlindSpot end of topic ===
    ${inBlindSpot_list}=    Get Slice From List    ${full_list}    start=${inBlindSpot_start}    end=${inBlindSpot_end}
    Should Contain X Times    ${inBlindSpot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    Should Contain X Times    ${inBlindSpot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${blindSpotWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_blindSpotWarning start of topic ===
    ${blindSpotWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_blindSpotWarning end of topic ===
    ${blindSpotWarning_list}=    Get Slice From List    ${full_list}    start=${blindSpotWarning_start}    end=${blindSpotWarning_end}
    Should Contain X Times    ${blindSpotWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${blindSpotWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${axesTrackMode_start}=    Get Index From List    ${full_list}    === ${subSystem}_axesTrackMode start of topic ===
    ${axesTrackMode_end}=    Get Index From List    ${full_list}    === ${subSystem}_axesTrackMode end of topic ===
    ${axesTrackMode_list}=    Get Slice From List    ${full_list}    start=${axesTrackMode_start}    end=${axesTrackMode_end}
    Should Contain X Times    ${axesTrackMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${axesTrackMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${axesTrackMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${objectSetWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_objectSetWarning start of topic ===
    ${objectSetWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_objectSetWarning end of topic ===
    ${objectSetWarning_list}=    Get Slice From List    ${full_list}    start=${objectSetWarning_start}    end=${objectSetWarning_end}
    Should Contain X Times    ${objectSetWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${objectSetWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${pointingModel_start}=    Get Index From List    ${full_list}    === ${subSystem}_pointingModel start of topic ===
    ${pointingModel_end}=    Get Index From List    ${full_list}    === ${subSystem}_pointingModel end of topic ===
    ${pointingModel_list}=    Get Slice From List    ${full_list}    start=${pointingModel_start}    end=${pointingModel_end}
    Should Contain X Times    ${pointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${pointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingModelTermNames : LSST    1
    Should Contain X Times    ${pointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingModelTermValues : LSST    1
    Should Contain X Times    ${pointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${airmassWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_airmassWarning start of topic ===
    ${airmassWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_airmassWarning end of topic ===
    ${airmassWarning_list}=    Get Slice From List    ${full_list}    start=${airmassWarning_start}    end=${airmassWarning_end}
    Should Contain X Times    ${airmassWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${airmassWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${weatherDataInvalid_start}=    Get Index From List    ${full_list}    === ${subSystem}_weatherDataInvalid start of topic ===
    ${weatherDataInvalid_end}=    Get Index From List    ${full_list}    === ${subSystem}_weatherDataInvalid end of topic ===
    ${weatherDataInvalid_list}=    Get Slice From List    ${full_list}    start=${weatherDataInvalid_start}    end=${weatherDataInvalid_end}
    Should Contain X Times    ${weatherDataInvalid_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    Should Contain X Times    ${weatherDataInvalid_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${focusNameInconsistentWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_focusNameInconsistentWarning start of topic ===
    ${focusNameInconsistentWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_focusNameInconsistentWarning end of topic ===
    ${focusNameInconsistentWarning_list}=    Get Slice From List    ${full_list}    start=${focusNameInconsistentWarning_start}    end=${focusNameInconsistentWarning_end}
    Should Contain X Times    ${focusNameInconsistentWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    Should Contain X Times    ${focusNameInconsistentWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${currentTarget_start}=    Get Index From List    ${full_list}    === ${subSystem}_currentTarget start of topic ===
    ${currentTarget_end}=    Get Index From List    ${full_list}    === ${subSystem}_currentTarget end of topic ===
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
    ${iersOutOfDate_start}=    Get Index From List    ${full_list}    === ${subSystem}_iersOutOfDate start of topic ===
    ${iersOutOfDate_end}=    Get Index From List    ${full_list}    === ${subSystem}_iersOutOfDate end of topic ===
    ${iersOutOfDate_list}=    Get Slice From List    ${full_list}    start=${iersOutOfDate_start}    end=${iersOutOfDate_end}
    Should Contain X Times    ${iersOutOfDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    Should Contain X Times    ${iersOutOfDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${weatherDataApplied_start}=    Get Index From List    ${full_list}    === ${subSystem}_weatherDataApplied start of topic ===
    ${weatherDataApplied_end}=    Get Index From List    ${full_list}    === ${subSystem}_weatherDataApplied end of topic ===
    ${weatherDataApplied_list}=    Get Slice From List    ${full_list}    start=${weatherDataApplied_start}    end=${weatherDataApplied_end}
    Should Contain X Times    ${weatherDataApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambient_temp : 1    1
    Should Contain X Times    ${weatherDataApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure : 1    1
    Should Contain X Times    ${weatherDataApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}humidity : 1    1
    Should Contain X Times    ${weatherDataApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${currentDebugLevel_start}=    Get Index From List    ${full_list}    === ${subSystem}_currentDebugLevel start of topic ===
    ${currentDebugLevel_end}=    Get Index From List    ${full_list}    === ${subSystem}_currentDebugLevel end of topic ===
    ${currentDebugLevel_list}=    Get Slice From List    ${full_list}    start=${currentDebugLevel_start}    end=${currentDebugLevel_end}
    Should Contain X Times    ${currentDebugLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentLevel : 1    1
    Should Contain X Times    ${currentDebugLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${nextTarget_start}=    Get Index From List    ${full_list}    === ${subSystem}_nextTarget start of topic ===
    ${nextTarget_end}=    Get Index From List    ${full_list}    === ${subSystem}_nextTarget end of topic ===
    ${nextTarget_list}=    Get Slice From List    ${full_list}    start=${nextTarget_start}    end=${nextTarget_end}
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetType : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetName : LSST    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}frame : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azDegs : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elDegs : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}planetName : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ephemFile : LSST    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}equinox : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raString : LSST    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decString : LSST    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}epoch : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}difftrackRA : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}difftrackDec : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}properMotionRA : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}properMotionDec : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}parallax : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}radvel : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotPA : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotFrame : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotMode : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raHours : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decDegs : 1    1
    Should Contain X Times    ${nextTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${mountDataWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_mountDataWarning start of topic ===
    ${mountDataWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_mountDataWarning end of topic ===
    ${mountDataWarning_list}=    Get Slice From List    ${full_list}    start=${mountDataWarning_start}    end=${mountDataWarning_end}
    Should Contain X Times    ${mountDataWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${mountDataWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${accessMode_start}=    Get Index From List    ${full_list}    === ${subSystem}_accessMode start of topic ===
    ${accessMode_end}=    Get Index From List    ${full_list}    === ${subSystem}_accessMode end of topic ===
    ${accessMode_list}=    Get Slice From List    ${full_list}    start=${accessMode_start}    end=${accessMode_end}
    Should Contain X Times    ${accessMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    Should Contain X Times    ${accessMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rotWrapWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_rotWrapWarning start of topic ===
    ${rotWrapWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_rotWrapWarning end of topic ===
    ${rotWrapWarning_list}=    Get Slice From List    ${full_list}    start=${rotWrapWarning_start}    end=${rotWrapWarning_end}
    Should Contain X Times    ${rotWrapWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${rotWrapWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${inPosition_start}=    Get Index From List    ${full_list}    === ${subSystem}_inPosition start of topic ===
    ${inPosition_end}=    Get Index From List    ${full_list}    === ${subSystem}_inPosition end of topic ===
    ${inPosition_list}=    Get Slice From List    ${full_list}    start=${inPosition_start}    end=${inPosition_end}
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${inPositionRot_start}=    Get Index From List    ${full_list}    === ${subSystem}_inPositionRot start of topic ===
    ${inPositionRot_end}=    Get Index From List    ${full_list}    === ${subSystem}_inPositionRot end of topic ===
    ${inPositionRot_list}=    Get Slice From List    ${full_list}    start=${inPositionRot_start}    end=${inPositionRot_end}
    Should Contain X Times    ${inPositionRot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    Should Contain X Times    ${inPositionRot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${inPositionAz_start}=    Get Index From List    ${full_list}    === ${subSystem}_inPositionAz start of topic ===
    ${inPositionAz_end}=    Get Index From List    ${full_list}    === ${subSystem}_inPositionAz end of topic ===
    ${inPositionAz_list}=    Get Slice From List    ${full_list}    start=${inPositionAz_start}    end=${inPositionAz_end}
    Should Contain X Times    ${inPositionAz_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    Should Contain X Times    ${inPositionAz_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${iers_start}=    Get Index From List    ${full_list}    === ${subSystem}_iers start of topic ===
    ${iers_end}=    Get Index From List    ${full_list}    === ${subSystem}_iers end of topic ===
    ${iers_list}=    Get Slice From List    ${full_list}    start=${iers_start}    end=${iers_end}
    Should Contain X Times    ${iers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${iers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dut1 : 1    1
    Should Contain X Times    ${iers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}poleX : 1    1
    Should Contain X Times    ${iers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}poleY : 1    1
    Should Contain X Times    ${iers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${prospectiveTarget_start}=    Get Index From List    ${full_list}    === ${subSystem}_prospectiveTarget start of topic ===
    ${prospectiveTarget_end}=    Get Index From List    ${full_list}    === ${subSystem}_prospectiveTarget end of topic ===
    ${prospectiveTarget_list}=    Get Slice From List    ${full_list}    start=${prospectiveTarget_start}    end=${prospectiveTarget_end}
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetType : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetName : LSST    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}frame : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azDegs : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elDegs : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}planetName : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ephemFile : LSST    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}equinox : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raString : LSST    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decString : LSST    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}epoch : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}difftrackRA : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}difftrackDec : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}properMotionRA : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}properMotionDec : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}parallax : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}radvel : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotPA : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotFrame : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotMode : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}raHours : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decDegs : 1    1
    Should Contain X Times    ${prospectiveTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${moonProximityWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_moonProximityWarning start of topic ===
    ${moonProximityWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_moonProximityWarning end of topic ===
    ${moonProximityWarning_list}=    Get Slice From List    ${full_list}    start=${moonProximityWarning_start}    end=${moonProximityWarning_end}
    Should Contain X Times    ${moonProximityWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${moonProximityWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${trackPosting_start}=    Get Index From List    ${full_list}    === ${subSystem}_trackPosting start of topic ===
    ${trackPosting_end}=    Get Index From List    ${full_list}    === ${subSystem}_trackPosting end of topic ===
    ${trackPosting_list}=    Get Slice From List    ${full_list}    start=${trackPosting_start}    end=${trackPosting_end}
    Should Contain X Times    ${trackPosting_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 1    1
    Should Contain X Times    ${trackPosting_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${ptgAzCurrentWrap_start}=    Get Index From List    ${full_list}    === ${subSystem}_ptgAzCurrentWrap start of topic ===
    ${ptgAzCurrentWrap_end}=    Get Index From List    ${full_list}    === ${subSystem}_ptgAzCurrentWrap end of topic ===
    ${ptgAzCurrentWrap_list}=    Get Slice From List    ${full_list}    start=${ptgAzCurrentWrap_start}    end=${ptgAzCurrentWrap_end}
    Should Contain X Times    ${ptgAzCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentWrap : 1    1
    Should Contain X Times    ${ptgAzCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${ptgRotCurrentWrap_start}=    Get Index From List    ${full_list}    === ${subSystem}_ptgRotCurrentWrap start of topic ===
    ${ptgRotCurrentWrap_end}=    Get Index From List    ${full_list}    === ${subSystem}_ptgRotCurrentWrap end of topic ===
    ${ptgRotCurrentWrap_list}=    Get Slice From List    ${full_list}    start=${ptgRotCurrentWrap_start}    end=${ptgRotCurrentWrap_end}
    Should Contain X Times    ${ptgRotCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentWrap : 1    1
    Should Contain X Times    ${ptgRotCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${elLimitWarning_start}=    Get Index From List    ${full_list}    === ${subSystem}_elLimitWarning start of topic ===
    ${elLimitWarning_end}=    Get Index From List    ${full_list}    === ${subSystem}_elLimitWarning end of topic ===
    ${elLimitWarning_list}=    Get Slice From List    ${full_list}    start=${elLimitWarning_start}    end=${elLimitWarning_end}
    Should Contain X Times    ${elLimitWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${elLimitWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingVersions_start}=    Get Index From List    ${full_list}    === ${subSystem}_settingVersions start of topic ===
    ${settingVersions_end}=    Get Index From List    ${full_list}    === ${subSystem}_settingVersions end of topic ===
    ${settingVersions_list}=    Get Slice From List    ${full_list}    start=${settingVersions_start}    end=${settingVersions_end}
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsVersion : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsLabels : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settingsUrl : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${errorCode_start}=    Get Index From List    ${full_list}    === ${subSystem}_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === ${subSystem}_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end}
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorReport : LSST    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : LSST    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${summaryState_start}=    Get Index From List    ${full_list}    === ${subSystem}_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === ${subSystem}_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end}
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}summaryState : 1    1
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedSettingsMatchStart_start}=    Get Index From List    ${full_list}    === ${subSystem}_appliedSettingsMatchStart start of topic ===
    ${appliedSettingsMatchStart_end}=    Get Index From List    ${full_list}    === ${subSystem}_appliedSettingsMatchStart end of topic ===
    ${appliedSettingsMatchStart_list}=    Get Slice From List    ${full_list}    start=${appliedSettingsMatchStart_start}    end=${appliedSettingsMatchStart_end}
    Should Contain X Times    ${appliedSettingsMatchStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}appliedSettingsMatchStartIsTrue : 1    1
    Should Contain X Times    ${appliedSettingsMatchStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logLevel_start}=    Get Index From List    ${full_list}    === ${subSystem}_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === ${subSystem}_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end}
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logMessage_start}=    Get Index From List    ${full_list}    === ${subSystem}_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === ${subSystem}_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end}
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}message : LSST    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : LSST    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${simulationMode_start}=    Get Index From List    ${full_list}    === ${subSystem}_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === ${subSystem}_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end}
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === ${subSystem}_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === ${subSystem}_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end}
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xmlVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openSpliceVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cscVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystemVersions : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${heartbeat_start}=    Get Index From List    ${full_list}    === ${subSystem}_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === ${subSystem}_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end}
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeat : 1    1
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
