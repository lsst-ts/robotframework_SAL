*** Settings ***
Documentation    MTPtg_Events communications tests.
Force Tags    messaging    cpp    mtptg    
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
    Should Be Equal    ${output.returncode}   ${NONE}
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
    Comment    ======= Verify ${subSystem}_rotWrapWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rotWrapWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event rotWrapWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rotWrapWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rotWrapWarning generated =
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
    Comment    ======= Verify ${subSystem}_observatoryLocation test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_observatoryLocation
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event observatoryLocation iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_observatoryLocation_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event observatoryLocation generated =
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_heartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event heartbeat iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_heartbeat_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event heartbeat generated =
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
    Comment    ======= Verify ${subSystem}_softwareVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_softwareVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event softwareVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_softwareVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event softwareVersions generated =
    Comment    ======= Verify ${subSystem}_authList test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_authList
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event authList iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_authList_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event authList generated =
    Comment    ======= Verify ${subSystem}_errorCode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_errorCode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event errorCode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_errorCode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event errorCode generated =
    Comment    ======= Verify ${subSystem}_simulationMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_simulationMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event simulationMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_simulationMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event simulationMode generated =
    Comment    ======= Verify ${subSystem}_summaryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_summaryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event summaryState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_summaryState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event summaryState generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${focusNameSelected_start}=    Get Index From List    ${full_list}    === Event focusNameSelected received =${SPACE}
    ${end}=    Evaluate    ${focusNameSelected_start}+${2}
    ${focusNameSelected_list}=    Get Slice From List    ${full_list}    start=${focusNameSelected_start}    end=${end}
    Should Contain X Times    ${focusNameSelected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}focus : 1    1
    ${sunProximityWarning_start}=    Get Index From List    ${full_list}    === Event sunProximityWarning received =${SPACE}
    ${end}=    Evaluate    ${sunProximityWarning_start}+${2}
    ${sunProximityWarning_list}=    Get Slice From List    ${full_list}    start=${sunProximityWarning_start}    end=${end}
    Should Contain X Times    ${sunProximityWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    ${detailedState_start}=    Get Index From List    ${full_list}    === Event detailedState received =${SPACE}
    ${end}=    Evaluate    ${detailedState_start}+${2}
    ${detailedState_list}=    Get Slice From List    ${full_list}    start=${detailedState_start}    end=${end}
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    ${azWrapWarning_start}=    Get Index From List    ${full_list}    === Event azWrapWarning received =${SPACE}
    ${end}=    Evaluate    ${azWrapWarning_start}+${2}
    ${azWrapWarning_list}=    Get Slice From List    ${full_list}    start=${azWrapWarning_start}    end=${end}
    Should Contain X Times    ${azWrapWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    ${wavelength_start}=    Get Index From List    ${full_list}    === Event wavelength received =${SPACE}
    ${end}=    Evaluate    ${wavelength_start}+${2}
    ${wavelength_list}=    Get Slice From List    ${full_list}    start=${wavelength_start}    end=${end}
    Should Contain X Times    ${wavelength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wavelength : 1    1
    ${objectSetWarning_start}=    Get Index From List    ${full_list}    === Event objectSetWarning received =${SPACE}
    ${end}=    Evaluate    ${objectSetWarning_start}+${2}
    ${objectSetWarning_list}=    Get Slice From List    ${full_list}    start=${objectSetWarning_start}    end=${end}
    Should Contain X Times    ${objectSetWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    ${pointingModel_start}=    Get Index From List    ${full_list}    === Event pointingModel received =${SPACE}
    ${end}=    Evaluate    ${pointingModel_start}+${4}
    ${pointingModel_list}=    Get Slice From List    ${full_list}    start=${pointingModel_start}    end=${end}
    Should Contain X Times    ${pointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${pointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingModelTermNames : RO    1
    Should Contain X Times    ${pointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingModelTermValues : RO    1
    ${airmassWarning_start}=    Get Index From List    ${full_list}    === Event airmassWarning received =${SPACE}
    ${end}=    Evaluate    ${airmassWarning_start}+${2}
    ${airmassWarning_list}=    Get Slice From List    ${full_list}    start=${airmassWarning_start}    end=${end}
    Should Contain X Times    ${airmassWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    ${weatherDataInvalid_start}=    Get Index From List    ${full_list}    === Event weatherDataInvalid received =${SPACE}
    ${end}=    Evaluate    ${weatherDataInvalid_start}+${2}
    ${weatherDataInvalid_list}=    Get Slice From List    ${full_list}    start=${weatherDataInvalid_start}    end=${end}
    Should Contain X Times    ${weatherDataInvalid_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    ${focusNameInconsistentWarning_start}=    Get Index From List    ${full_list}    === Event focusNameInconsistentWarning received =${SPACE}
    ${end}=    Evaluate    ${focusNameInconsistentWarning_start}+${2}
    ${focusNameInconsistentWarning_list}=    Get Slice From List    ${full_list}    start=${focusNameInconsistentWarning_start}    end=${end}
    Should Contain X Times    ${focusNameInconsistentWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    ${currentTarget_start}=    Get Index From List    ${full_list}    === Event currentTarget received =${SPACE}
    ${end}=    Evaluate    ${currentTarget_start}+${28}
    ${currentTarget_list}=    Get Slice From List    ${full_list}    start=${currentTarget_start}    end=${end}
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
    ${iersOutOfDate_start}=    Get Index From List    ${full_list}    === Event iersOutOfDate received =${SPACE}
    ${end}=    Evaluate    ${iersOutOfDate_start}+${2}
    ${iersOutOfDate_list}=    Get Slice From List    ${full_list}    start=${iersOutOfDate_start}    end=${end}
    Should Contain X Times    ${iersOutOfDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eventState : 1    1
    ${weatherDataApplied_start}=    Get Index From List    ${full_list}    === Event weatherDataApplied received =${SPACE}
    ${end}=    Evaluate    ${weatherDataApplied_start}+${4}
    ${weatherDataApplied_list}=    Get Slice From List    ${full_list}    start=${weatherDataApplied_start}    end=${end}
    Should Contain X Times    ${weatherDataApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTemp : 1    1
    Should Contain X Times    ${weatherDataApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure : 1    1
    Should Contain X Times    ${weatherDataApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}humidity : 1    1
    ${currentDebugLevel_start}=    Get Index From List    ${full_list}    === Event currentDebugLevel received =${SPACE}
    ${end}=    Evaluate    ${currentDebugLevel_start}+${2}
    ${currentDebugLevel_list}=    Get Slice From List    ${full_list}    start=${currentDebugLevel_start}    end=${end}
    Should Contain X Times    ${currentDebugLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentLevel : 1    1
    ${mountDataWarning_start}=    Get Index From List    ${full_list}    === Event mountDataWarning received =${SPACE}
    ${end}=    Evaluate    ${mountDataWarning_start}+${2}
    ${mountDataWarning_list}=    Get Slice From List    ${full_list}    start=${mountDataWarning_start}    end=${end}
    Should Contain X Times    ${mountDataWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    ${rotWrapWarning_start}=    Get Index From List    ${full_list}    === Event rotWrapWarning received =${SPACE}
    ${end}=    Evaluate    ${rotWrapWarning_start}+${2}
    ${rotWrapWarning_list}=    Get Slice From List    ${full_list}    start=${rotWrapWarning_start}    end=${end}
    Should Contain X Times    ${rotWrapWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    ${iers_start}=    Get Index From List    ${full_list}    === Event iers received =${SPACE}
    ${end}=    Evaluate    ${iers_start}+${5}
    ${iers_list}=    Get Slice From List    ${full_list}    start=${iers_start}    end=${end}
    Should Contain X Times    ${iers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${iers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dut1 : 1    1
    Should Contain X Times    ${iers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}poleX : 1    1
    Should Contain X Times    ${iers_list}    ${SPACE}${SPACE}${SPACE}${SPACE}poleY : 1    1
    ${moonProximityWarning_start}=    Get Index From List    ${full_list}    === Event moonProximityWarning received =${SPACE}
    ${end}=    Evaluate    ${moonProximityWarning_start}+${2}
    ${moonProximityWarning_list}=    Get Slice From List    ${full_list}    start=${moonProximityWarning_start}    end=${end}
    Should Contain X Times    ${moonProximityWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    ${trackPosting_start}=    Get Index From List    ${full_list}    === Event trackPosting received =${SPACE}
    ${end}=    Evaluate    ${trackPosting_start}+${2}
    ${trackPosting_list}=    Get Slice From List    ${full_list}    start=${trackPosting_start}    end=${end}
    Should Contain X Times    ${trackPosting_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 1    1
    ${ptgAzCurrentWrap_start}=    Get Index From List    ${full_list}    === Event ptgAzCurrentWrap received =${SPACE}
    ${end}=    Evaluate    ${ptgAzCurrentWrap_start}+${2}
    ${ptgAzCurrentWrap_list}=    Get Slice From List    ${full_list}    start=${ptgAzCurrentWrap_start}    end=${end}
    Should Contain X Times    ${ptgAzCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentWrap : 1    1
    ${ptgRotCurrentWrap_start}=    Get Index From List    ${full_list}    === Event ptgRotCurrentWrap received =${SPACE}
    ${end}=    Evaluate    ${ptgRotCurrentWrap_start}+${2}
    ${ptgRotCurrentWrap_list}=    Get Slice From List    ${full_list}    start=${ptgRotCurrentWrap_start}    end=${end}
    Should Contain X Times    ${ptgRotCurrentWrap_list}    ${SPACE}${SPACE}${SPACE}${SPACE}currentWrap : 1    1
    ${elLimitWarning_start}=    Get Index From List    ${full_list}    === Event elLimitWarning received =${SPACE}
    ${end}=    Evaluate    ${elLimitWarning_start}+${2}
    ${elLimitWarning_list}=    Get Slice From List    ${full_list}    start=${elLimitWarning_start}    end=${end}
    Should Contain X Times    ${elLimitWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    ${pointingFile_start}=    Get Index From List    ${full_list}    === Event pointingFile received =${SPACE}
    ${end}=    Evaluate    ${pointingFile_start}+${3}
    ${pointingFile_list}=    Get Slice From List    ${full_list}    start=${pointingFile_start}    end=${end}
    Should Contain X Times    ${pointingFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fileIsOpen : 1    1
    Should Contain X Times    ${pointingFile_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filePath : RO    1
    ${timesOfLimits_start}=    Get Index From List    ${full_list}    === Event timesOfLimits received =${SPACE}
    ${end}=    Evaluate    ${timesOfLimits_start}+${8}
    ${timesOfLimits_list}=    Get Slice From List    ${full_list}    start=${timesOfLimits_start}    end=${end}
    Should Contain X Times    ${timesOfLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${timesOfLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeAzLim : 1    1
    Should Contain X Times    ${timesOfLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRotLim : 1    1
    Should Contain X Times    ${timesOfLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeElHighLimit : 1    1
    Should Contain X Times    ${timesOfLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeElLowLimit : 1    1
    Should Contain X Times    ${timesOfLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeUnobservable : 1    1
    Should Contain X Times    ${timesOfLimits_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    1
    ${validatedTarget_start}=    Get Index From List    ${full_list}    === Event validatedTarget received =${SPACE}
    ${end}=    Evaluate    ${validatedTarget_start}+${6}
    ${validatedTarget_list}=    Get Slice From List    ${full_list}    start=${validatedTarget_start}    end=${end}
    Should Contain X Times    ${validatedTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}isValid : 1    1
    Should Contain X Times    ${validatedTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}az : 1    1
    Should Contain X Times    ${validatedTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}el : 1    1
    Should Contain X Times    ${validatedTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rot : 1    1
    Should Contain X Times    ${validatedTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackId : 1    1
    ${offsetSummary_start}=    Get Index From List    ${full_list}    === Event offsetSummary received =${SPACE}
    ${end}=    Evaluate    ${offsetSummary_start}+${17}
    ${offsetSummary_list}=    Get Slice From List    ${full_list}    start=${offsetSummary_start}    end=${end}
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
    ${pointData_start}=    Get Index From List    ${full_list}    === Event pointData received =${SPACE}
    ${end}=    Evaluate    ${pointData_start}+${7}
    ${pointData_list}=    Get Slice From List    ${full_list}    start=${pointData_start}    end=${end}
    Should Contain X Times    ${pointData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}expectedAzimuth : 1    1
    Should Contain X Times    ${pointData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}expectedElevation : 1    1
    Should Contain X Times    ${pointData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredAzimuth : 1    1
    Should Contain X Times    ${pointData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredElevation : 1    1
    Should Contain X Times    ${pointData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}measuredRotator : 1    1
    Should Contain X Times    ${pointData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filePath : RO    1
    ${observatoryLocation_start}=    Get Index From List    ${full_list}    === Event observatoryLocation received =${SPACE}
    ${end}=    Evaluate    ${observatoryLocation_start}+${5}
    ${observatoryLocation_list}=    Get Slice From List    ${full_list}    start=${observatoryLocation_start}    end=${end}
    Should Contain X Times    ${observatoryLocation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longitude : 1    1
    Should Contain X Times    ${observatoryLocation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}latitude : 1    1
    Should Contain X Times    ${observatoryLocation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}height : 1    1
    Should Contain X Times    ${observatoryLocation_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeZone : 1    1
    ${heartbeat_start}=    Get Index From List    ${full_list}    === Event heartbeat received =${SPACE}
    ${end}=    Evaluate    ${heartbeat_start}+${1}
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${end}
    ${logLevel_start}=    Get Index From List    ${full_list}    === Event logLevel received =${SPACE}
    ${end}=    Evaluate    ${logLevel_start}+${3}
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${end}
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystem : RO    1
    ${logMessage_start}=    Get Index From List    ${full_list}    === Event logMessage received =${SPACE}
    ${end}=    Evaluate    ${logMessage_start}+${10}
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${end}
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}message : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filePath : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}functionName : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lineNumber : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}process : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === Event softwareVersions received =${SPACE}
    ${end}=    Evaluate    ${softwareVersions_start}+${6}
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${end}
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xmlVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openSpliceVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cscVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystemVersions : RO    1
    ${authList_start}=    Get Index From List    ${full_list}    === Event authList received =${SPACE}
    ${end}=    Evaluate    ${authList_start}+${1}
    ${authList_list}=    Get Slice From List    ${full_list}    start=${authList_start}    end=${end}
    ${errorCode_start}=    Get Index From List    ${full_list}    === Event errorCode received =${SPACE}
    ${end}=    Evaluate    ${errorCode_start}+${4}
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${end}
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorReport : RO    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    ${simulationMode_start}=    Get Index From List    ${full_list}    === Event simulationMode received =${SPACE}
    ${end}=    Evaluate    ${simulationMode_start}+${2}
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${end}
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    ${summaryState_start}=    Get Index From List    ${full_list}    === Event summaryState received =${SPACE}
    ${end}=    Evaluate    ${summaryState_start}+${2}
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${end}
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}summaryState : 1    1
