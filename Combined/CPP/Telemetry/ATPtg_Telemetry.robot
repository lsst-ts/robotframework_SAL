*** Settings ***
Documentation    ATPtg Telemetry communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATPtg
${component}    all
${timeout}    15s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber

Start Subscriber
    [Tags]    functional
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Should Be Equal    ${output.returncode}   ${NONE}
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdout.txt
    Comment    Sleep for 6s to allow DDS time to register all the topics.
    Sleep    6s
    ${output}=    Get File    ${EXECDIR}${/}${subSystem}_stdout.txt
    Should Contain    ${output}    ===== ATPtg subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_currentTargetStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_currentTargetStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ATPtg_currentTargetStatus start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::currentTargetStatus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATPtg_currentTargetStatus end of topic ===
    Comment    ======= Verify ${subSystem}_guiding test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_guiding
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ATPtg_guiding start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::guiding_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATPtg_guiding end of topic ===
    Comment    ======= Verify ${subSystem}_timeAndDate test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_timeAndDate
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ATPtg_timeAndDate start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::timeAndDate_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATPtg_timeAndDate end of topic ===
    Comment    ======= Verify ${subSystem}_mountStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_mountStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ATPtg_mountStatus start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::mountStatus_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATPtg_mountStatus end of topic ===
    Comment    ======= Verify ${subSystem}_skyEnvironment test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_skyEnvironment
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ATPtg_skyEnvironment start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::skyEnvironment_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATPtg_skyEnvironment end of topic ===
    Comment    ======= Verify ${subSystem}_namedAzEl test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_namedAzEl
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ATPtg_namedAzEl start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::namedAzEl_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATPtg_namedAzEl end of topic ===
    Comment    ======= Verify ${subSystem}_mountPositions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_mountPositions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === ATPtg_mountPositions start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::mountPositions_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ATPtg_mountPositions end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ATPtg subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${currentTargetStatus_start}=    Get Index From List    ${full_list}    === ATPtg_currentTargetStatus start of topic ===
    ${currentTargetStatus_end}=    Get Index From List    ${full_list}    === ATPtg_currentTargetStatus end of topic ===
    ${currentTargetStatus_list}=    Get Slice From List    ${full_list}    start=${currentTargetStatus_start}    end=${currentTargetStatus_end}
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandAz : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandEl : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRot : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandAzVelocity : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandElVelocity : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRotVelocity : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ha : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}parAngle : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airmass : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandRa : 1    10
    Should Contain X Times    ${currentTargetStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}demandDec : 1    10
    ${guiding_start}=    Get Index From List    ${full_list}    === ATPtg_guiding start of topic ===
    ${guiding_end}=    Get Index From List    ${full_list}    === ATPtg_guiding end of topic ===
    ${guiding_list}=    Get Slice From List    ${full_list}    start=${guiding_start}    end=${guiding_end}
    Should Contain X Times    ${guiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${guiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}guideControlState : 1    10
    Should Contain X Times    ${guiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}guideAutoClearState : 1    10
    Should Contain X Times    ${guiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}guideGA : 1    10
    Should Contain X Times    ${guiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}guideGB : 1    10
    Should Contain X Times    ${guiding_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotation : 1    10
    ${timeAndDate_start}=    Get Index From List    ${full_list}    === ATPtg_timeAndDate start of topic ===
    ${timeAndDate_end}=    Get Index From List    ${full_list}    === ATPtg_timeAndDate end of topic ===
    ${timeAndDate_list}=    Get Slice From List    ${full_list}    start=${timeAndDate_start}    end=${timeAndDate_end}
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}utc : 1    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lst : 1    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mjd : 1    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}localTime : 1    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}localTimeString : RO    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}leapSecs : 1    10
    Should Contain X Times    ${timeAndDate_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timezone : 1    10
    ${mountStatus_start}=    Get Index From List    ${full_list}    === ATPtg_mountStatus start of topic ===
    ${mountStatus_end}=    Get Index From List    ${full_list}    === ATPtg_mountStatus end of topic ===
    ${mountStatus_list}=    Get Slice From List    ${full_list}    start=${mountStatus_start}    end=${mountStatus_end}
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountRA : 1    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountDec : 1    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountAz : 1    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountEl : 1    10
    Should Contain X Times    ${mountStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mountRot : 1    10
    ${skyEnvironment_start}=    Get Index From List    ${full_list}    === ATPtg_skyEnvironment start of topic ===
    ${skyEnvironment_end}=    Get Index From List    ${full_list}    === ATPtg_skyEnvironment end of topic ===
    ${skyEnvironment_list}=    Get Slice From List    ${full_list}    start=${skyEnvironment_start}    end=${skyEnvironment_end}
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunsetTime : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}twilightEndTime : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}twilightBeginTime : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunriseTime : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonriseTime : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonsetTime : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonPhase : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunAltitude : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonAltitude : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sunTargetDistance : 1    10
    Should Contain X Times    ${skyEnvironment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moonTargetDistance : 1    10
    ${namedAzEl_start}=    Get Index From List    ${full_list}    === ATPtg_namedAzEl start of topic ===
    ${namedAzEl_end}=    Get Index From List    ${full_list}    === ATPtg_namedAzEl end of topic ===
    ${namedAzEl_list}=    Get Slice From List    ${full_list}    start=${namedAzEl_start}    end=${namedAzEl_end}
    Should Contain X Times    ${namedAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}names : RO    10
    Should Contain X Times    ${namedAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azPositions : RO    10
    Should Contain X Times    ${namedAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elPositions : RO    10
    Should Contain X Times    ${namedAzEl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rotPositions : RO    10
    ${mountPositions_start}=    Get Index From List    ${full_list}    === ATPtg_mountPositions start of topic ===
    ${mountPositions_end}=    Get Index From List    ${full_list}    === ATPtg_mountPositions end of topic ===
    ${mountPositions_list}=    Get Slice From List    ${full_list}    start=${mountPositions_start}    end=${mountPositions_end}
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cRioTimestamp : 1    10
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 0    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 1    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 2    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 3    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 4    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 5    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 6    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 7    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 8    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuthCalculatedAngle : 9    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 0    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 1    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 2    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 3    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 4    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 5    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 6    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 7    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 8    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevationCalculatedAngle : 9    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmythCalculatedAngle : 0    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmythCalculatedAngle : 1    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmythCalculatedAngle : 2    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmythCalculatedAngle : 3    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmythCalculatedAngle : 4    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmythCalculatedAngle : 5    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmythCalculatedAngle : 6    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmythCalculatedAngle : 7    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmythCalculatedAngle : 8    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nasmythCalculatedAngle : 9    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 0    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 1    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 2    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 3    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 4    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 5    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 6    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 7    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 8    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 9    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 0    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 1    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 2    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 3    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 4    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 5    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 6    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 7    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 8    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}declination : 9    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyAngle : 0    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyAngle : 1    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyAngle : 2    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyAngle : 3    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyAngle : 4    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyAngle : 5    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyAngle : 6    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyAngle : 7    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyAngle : 8    1
    Should Contain X Times    ${mountPositions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}skyAngle : 9    1
