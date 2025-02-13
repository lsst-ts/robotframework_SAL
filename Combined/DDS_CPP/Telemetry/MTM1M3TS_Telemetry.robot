*** Settings ***
Documentation    MTM1M3TS Telemetry communications tests.
Force Tags    messaging    cpp    mtm1m3ts    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTM1M3TS
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
    Should Contain    ${output}    ===== MTM1M3TS subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_thermalData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_thermalData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTM1M3TS_thermalData start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::thermalData_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3TS_thermalData end of topic ===
    Comment    ======= Verify ${subSystem}_mixingValve test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_mixingValve
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTM1M3TS_mixingValve start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::mixingValve_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3TS_mixingValve end of topic ===
    Comment    ======= Verify ${subSystem}_glycolLoopTemperature test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_glycolLoopTemperature
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTM1M3TS_glycolLoopTemperature start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::glycolLoopTemperature_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3TS_glycolLoopTemperature end of topic ===
    Comment    ======= Verify ${subSystem}_flowMeter test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_flowMeter
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTM1M3TS_flowMeter start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::flowMeter_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3TS_flowMeter end of topic ===
    Comment    ======= Verify ${subSystem}_glycolPump test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_glycolPump
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTM1M3TS_glycolPump start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::glycolPump_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTM1M3TS_glycolPump end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTM1M3TS subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${thermalData_start}=    Get Index From List    ${full_list}    === MTM1M3TS_thermalData start of topic ===
    ${thermalData_end}=    Get Index From List    ${full_list}    === MTM1M3TS_thermalData end of topic ===
    ${thermalData_list}=    Get Slice From List    ${full_list}    start=${thermalData_start}    end=${thermalData_end}
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcFault : 0    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcFault : 1    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcFault : 2    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcFault : 3    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcFault : 4    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcFault : 5    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcFault : 6    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcFault : 7    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcFault : 8    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ilcFault : 9    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterDisabled : 0    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterDisabled : 1    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterDisabled : 2    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterDisabled : 3    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterDisabled : 4    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterDisabled : 5    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterDisabled : 6    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterDisabled : 7    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterDisabled : 8    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterDisabled : 9    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterBreaker : 0    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterBreaker : 1    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterBreaker : 2    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterBreaker : 3    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterBreaker : 4    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterBreaker : 5    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterBreaker : 6    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterBreaker : 7    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterBreaker : 8    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterBreaker : 9    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanBreaker : 0    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanBreaker : 1    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanBreaker : 2    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanBreaker : 3    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanBreaker : 4    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanBreaker : 5    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanBreaker : 6    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanBreaker : 7    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanBreaker : 8    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanBreaker : 9    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}differentialTemperature : 0    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}differentialTemperature : 1    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}differentialTemperature : 2    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}differentialTemperature : 3    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}differentialTemperature : 4    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}differentialTemperature : 5    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}differentialTemperature : 6    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}differentialTemperature : 7    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}differentialTemperature : 8    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}differentialTemperature : 9    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanRPM : 0    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanRPM : 1    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanRPM : 2    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanRPM : 3    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanRPM : 4    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanRPM : 5    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanRPM : 6    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanRPM : 7    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanRPM : 8    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanRPM : 9    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}absoluteTemperature : 0    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}absoluteTemperature : 1    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}absoluteTemperature : 2    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}absoluteTemperature : 3    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}absoluteTemperature : 4    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}absoluteTemperature : 5    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}absoluteTemperature : 6    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}absoluteTemperature : 7    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}absoluteTemperature : 8    1
    Should Contain X Times    ${thermalData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}absoluteTemperature : 9    1
    ${mixingValve_start}=    Get Index From List    ${full_list}    === MTM1M3TS_mixingValve start of topic ===
    ${mixingValve_end}=    Get Index From List    ${full_list}    === MTM1M3TS_mixingValve end of topic ===
    ${mixingValve_list}=    Get Slice From List    ${full_list}    start=${mixingValve_start}    end=${mixingValve_end}
    Should Contain X Times    ${mixingValve_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawValvePosition : 1    10
    Should Contain X Times    ${mixingValve_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valvePosition : 1    10
    ${glycolLoopTemperature_start}=    Get Index From List    ${full_list}    === MTM1M3TS_glycolLoopTemperature start of topic ===
    ${glycolLoopTemperature_end}=    Get Index From List    ${full_list}    === MTM1M3TS_glycolLoopTemperature end of topic ===
    ${glycolLoopTemperature_list}=    Get Slice From List    ${full_list}    start=${glycolLoopTemperature_start}    end=${glycolLoopTemperature_end}
    Should Contain X Times    ${glycolLoopTemperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aboveMirrorTemperature : 1    10
    Should Contain X Times    ${glycolLoopTemperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}insideCellTemperature1 : 1    10
    Should Contain X Times    ${glycolLoopTemperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}insideCellTemperature2 : 1    10
    Should Contain X Times    ${glycolLoopTemperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}insideCellTemperature3 : 1    10
    Should Contain X Times    ${glycolLoopTemperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telescopeCoolantSupplyTemperature : 1    10
    Should Contain X Times    ${glycolLoopTemperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}telescopeCoolantReturnTemperature : 1    10
    Should Contain X Times    ${glycolLoopTemperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mirrorCoolantSupplyTemperature : 1    10
    Should Contain X Times    ${glycolLoopTemperature_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mirrorCoolantReturnTemperature : 1    10
    ${flowMeter_start}=    Get Index From List    ${full_list}    === MTM1M3TS_flowMeter start of topic ===
    ${flowMeter_end}=    Get Index From List    ${full_list}    === MTM1M3TS_flowMeter end of topic ===
    ${flowMeter_list}=    Get Slice From List    ${full_list}    start=${flowMeter_start}    end=${flowMeter_end}
    Should Contain X Times    ${flowMeter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}signalStrength : 1    10
    Should Contain X Times    ${flowMeter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowRate : 1    10
    Should Contain X Times    ${flowMeter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}netTotalizer : 1    10
    Should Contain X Times    ${flowMeter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positiveTotalizer : 1    10
    Should Contain X Times    ${flowMeter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}negativeTotalizer : 1    10
    ${glycolPump_start}=    Get Index From List    ${full_list}    === MTM1M3TS_glycolPump start of topic ===
    ${glycolPump_end}=    Get Index From List    ${full_list}    === MTM1M3TS_glycolPump end of topic ===
    ${glycolPump_list}=    Get Slice From List    ${full_list}    start=${glycolPump_start}    end=${glycolPump_end}
    Should Contain X Times    ${glycolPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandedFrequency : 1    10
    Should Contain X Times    ${glycolPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}targetFrequency : 1    10
    Should Contain X Times    ${glycolPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputFrequency : 1    10
    Should Contain X Times    ${glycolPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputCurrent : 1    10
    Should Contain X Times    ${glycolPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}busVoltage : 1    10
    Should Contain X Times    ${glycolPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}outputVoltage : 1    10
