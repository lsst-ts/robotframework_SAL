*** Settings ***
Documentation    DIMM_Events communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    DIMM
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
    Comment    ======= Verify ${subSystem}_detailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_detailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event detailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_detailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event detailedState generated =
    Comment    ======= Verify ${subSystem}_internalCommand test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_internalCommand
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event internalCommand iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_internalCommand_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event internalCommand generated =
    Comment    ======= Verify ${subSystem}_loopTimeOutOfRange test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_loopTimeOutOfRange
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event loopTimeOutOfRange iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_loopTimeOutOfRange_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event loopTimeOutOfRange generated =
    Comment    ======= Verify ${subSystem}_dimmMeasurement test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_dimmMeasurement
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event dimmMeasurement iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_dimmMeasurement_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event dimmMeasurement generated =
    Comment    ======= Verify ${subSystem}_dimmData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_dimmData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event dimmData iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_dimmData_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event dimmData generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${detailedState_start}=    Get Index From List    ${full_list}    === Event detailedState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${detailedState_start}
    ${detailedState_end}=    Evaluate    ${end}+${1}
    ${detailedState_list}=    Get Slice From List    ${full_list}    start=${detailedState_start}    end=${detailedState_end}
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${internalCommand_start}=    Get Index From List    ${full_list}    === Event internalCommand received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${internalCommand_start}
    ${internalCommand_end}=    Evaluate    ${end}+${1}
    ${internalCommand_list}=    Get Slice From List    ${full_list}    start=${internalCommand_start}    end=${internalCommand_end}
    Should Contain X Times    ${internalCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandObject : \x00    1
    Should Contain X Times    ${internalCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${loopTimeOutOfRange_start}=    Get Index From List    ${full_list}    === Event loopTimeOutOfRange received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${loopTimeOutOfRange_start}
    ${loopTimeOutOfRange_end}=    Evaluate    ${end}+${1}
    ${loopTimeOutOfRange_list}=    Get Slice From List    ${full_list}    start=${loopTimeOutOfRange_start}    end=${loopTimeOutOfRange_end}
    Should Contain X Times    ${loopTimeOutOfRange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}loopTimeOutOfRange : 1    1
    Should Contain X Times    ${loopTimeOutOfRange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${dimmMeasurement_start}=    Get Index From List    ${full_list}    === Event dimmMeasurement received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${dimmMeasurement_start}
    ${dimmMeasurement_end}=    Evaluate    ${end}+${1}
    ${dimmMeasurement_list}=    Get Slice From List    ${full_list}    start=${dimmMeasurement_start}    end=${dimmMeasurement_end}
    Should Contain X Times    ${dimmMeasurement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${dimmMeasurement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hrNum : 1    1
    Should Contain X Times    ${dimmMeasurement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}secz : 1    1
    Should Contain X Times    ${dimmMeasurement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fwhm : 1    1
    Should Contain X Times    ${dimmMeasurement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fwhmx : 1    1
    Should Contain X Times    ${dimmMeasurement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fwhmy : 1    1
    Should Contain X Times    ${dimmMeasurement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}r0 : 1    1
    Should Contain X Times    ${dimmMeasurement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nimg : 1    1
    Should Contain X Times    ${dimmMeasurement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dx : 1    1
    Should Contain X Times    ${dimmMeasurement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dy : 1    1
    Should Contain X Times    ${dimmMeasurement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flux : 1    1
    Should Contain X Times    ${dimmMeasurement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fluxL : 1    1
    Should Contain X Times    ${dimmMeasurement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scintL : 1    1
    Should Contain X Times    ${dimmMeasurement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}strehlL : 1    1
    Should Contain X Times    ${dimmMeasurement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fluxR : 1    1
    Should Contain X Times    ${dimmMeasurement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}scintR : 1    1
    Should Contain X Times    ${dimmMeasurement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}strehlR : 1    1
    Should Contain X Times    ${dimmMeasurement_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${dimmData_start}=    Get Index From List    ${full_list}    === Event dimmData received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${dimmData_start}
    ${dimmData_end}=    Evaluate    ${end}+${1}
    ${dimmData_list}=    Get Slice From List    ${full_list}    start=${dimmData_start}    end=${dimmData_end}
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFrames : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}spot1Flux : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}splot2Flux : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}spot1RMSFlux : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}spot2RMSFlux : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}spot1MaxInten : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}spot2MaxInten : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}seperationX : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}seperationY : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}seperationRMSX : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}seperationRMSY : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}covarianceX : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}covarianceY : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}noiseRMSX : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}noiseRMSY : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}averagePositionX : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}averagePositionY : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}averagePositionRMSX : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}averagePositionRMSY : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}averageFWHMspot1 : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}averageFWHMspot2 : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}averageEllipticityspot1 : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}averageEllipticityspot2 : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}averageBackground : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}backgroundRMS : 1    1
    Should Contain X Times    ${dimmData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
