*** Settings ***
Documentation    HVAC Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    HVAC
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
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=Subscriber    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    Comment    Sleep for 6s to allow DDS time to register all the topics.
    Sleep    6s
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    ===== HVAC subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas end of topic ===
    Comment    ======= Verify ${subSystem}_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir end of topic ===
    Comment    ======= Verify ${subSystem}_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex end of topic ===
    Comment    ======= Verify ${subSystem}_lsstBarraoblPiso01BarraoblChiller01 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_lsstBarraoblPiso01BarraoblChiller01
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_lsstBarraoblPiso01BarraoblChiller01 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::lsstBarraoblPiso01BarraoblChiller01_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_lsstBarraoblPiso01BarraoblChiller01 end of topic ===
    Comment    ======= Verify ${subSystem}_lsstBarraoblPiso02BarraoblCrack01 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_lsstBarraoblPiso02BarraoblCrack01
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_lsstBarraoblPiso02BarraoblCrack01 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::lsstBarraoblPiso02BarraoblCrack01_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_lsstBarraoblPiso02BarraoblCrack01 end of topic ===
    Comment    ======= Verify ${subSystem}_lsstBarraoblPiso02BarraoblFancoil01 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_lsstBarraoblPiso02BarraoblFancoil01
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_lsstBarraoblPiso02BarraoblFancoil01 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::lsstBarraoblPiso02BarraoblFancoil01_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_lsstBarraoblPiso02BarraoblFancoil01 end of topic ===
    Comment    ======= Verify ${subSystem}_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01 end of topic ===
    Comment    ======= Verify ${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca end of topic ===
    Comment    ======= Verify ${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== HVAC subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_start}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas start of topic ===
    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_end}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas end of topic ===
    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}=    Get Slice From List    ${full_list}    start=${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_start}    end=${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_end}
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblVin_01BarraoblEstadoFuncionamiento : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblVec_01BarraoblEstadoFuncionamiento : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblBombaAguaFriaBarraoblEstadoFuncionamiento : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblVea_01BarraoblEstadoSelector : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblVin_01BarraoblEstadoSelector : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblVec_01BarraoblEstadoSelector : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblVea_01BarraoblComandoEncendido : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblVin_01BarraoblComandoEncendido : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblVec_01BarraoblComandoEncendido : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblValvulaBarraoblEstadoValvula_1Amper_2 : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblBombaAguaFriaBarraoblComandoEncendido : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblTemperaturaAmbiente : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblValvulaBarraoblEstadoValvula_03 : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblValvulaBarraoblEstadoValvula_04 : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblValvulaBarraoblEstadoValvula_05 : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblValvulaBarraoblEstadoValvula_06 : 1    10
    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_start}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir start of topic ===
    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_end}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir end of topic ===
    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}=    Get Slice From List    ${full_list}    start=${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_start}    end=${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_end}
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_08BarraoblEstadoFuncionamiento : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_09BarraoblEstadoFuncionamiento : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_10BarraoblEstadoFuncionamiento : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_11BarraoblEstadoFuncionamiento : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_12BarraoblEstadoFuncionamiento : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_13BarraoblEstadoFuncionamiento : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_14BarraoblEstadoFuncionamiento : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_15BarraoblEstadoFuncionamiento : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_16BarraoblEstadoFuncionamiento : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_17BarraoblEstadoFuncionamiento : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_01BarraoblFallaTermica : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_08BarraoblFallaTermica : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_09BarraoblFallaTermica : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_10BarraoblFallaTermica : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_11BarraoblFallaTermica : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_12BarraoblFallaTermica : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_13BarraoblFallaTermica : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_14BarraoblFallaTermica : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_15BarraoblFallaTermica : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_16BarraoblFallaTermica : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_17BarraoblFallaTermica : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_01BarraoblComandoEncendido : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_08BarraoblComandoEncendido : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_09BarraoblComandoEncendido : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_10BarraoblComandoEncendido : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_11BarraoblComandoEncendido : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_12BarraoblComandoEncendido : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_13BarraoblComandoEncendido : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_14BarraoblComandoEncendido : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_15BarraoblComandoEncendido : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_16BarraoblComandoEncendido : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso05BarraoblVea_17BarraoblComandoEncendido : 1    10
    ${lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_start}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex start of topic ===
    ${lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_end}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex end of topic ===
    ${lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_list}=    Get Slice From List    ${full_list}    start=${lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_start}    end=${lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_end}
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso04BarraoblVea_04BarraoblEstadoFuncionamiento : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso04BarraoblVex_03BarraoblFallaTermica : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso04BarraoblVex_04BarraoblFallaTermica : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso04BarraoblVex_03BarraoblComandoEncendido : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso04BarraoblVex_04BarraoblComandoEncendido : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso04BarraoblDamperLowerBarraoblComando : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso04BarraoblZonaCargacomandoEncendido : 1    10
    ${lsstBarraoblPiso01BarraoblChiller01_start}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso01BarraoblChiller01 start of topic ===
    ${lsstBarraoblPiso01BarraoblChiller01_end}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso01BarraoblChiller01 end of topic ===
    ${lsstBarraoblPiso01BarraoblChiller01_list}=    Get Slice From List    ${full_list}    start=${lsstBarraoblPiso01BarraoblChiller01_start}    end=${lsstBarraoblPiso01BarraoblChiller01_end}
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblTemperaturaAguaRetornoEvaporador : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblTemperaturaAguaImpulsionEvaporador : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblPresionBajaCto1 : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblPresionBajaCto2 : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblComandoEncendido : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblPotenciaDisponibleChiller : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01Barraobl_PctoPotenciaTrabajo : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblEstadoFuncionamiento : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblModoOperacion : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblEstadoUnidad : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblHorasCompresorPromedio : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblHorasCompresor_01 : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblHorasCompresor_02 : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblHorasCompresor_03 : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblHorasCompresor_04 : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblCompresor_01Funcionando : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblCompresor_02Funcionando : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblCompresor_03Funcionando : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblCompresor_04Funcionando : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblCompresor_01Alarmado : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblCompresor_02Alarmado : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblCompresor_03Alarmado : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblCompresor_04Alarmado : 1    10
    Should Contain X Times    ${lsstBarraoblPiso01BarraoblChiller01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso01BarraoblChiller_01BarraoblAlarmaGeneral : 1    10
    ${lsstBarraoblPiso02BarraoblCrack01_start}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso02BarraoblCrack01 start of topic ===
    ${lsstBarraoblPiso02BarraoblCrack01_end}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso02BarraoblCrack01 end of topic ===
    ${lsstBarraoblPiso02BarraoblCrack01_list}=    Get Slice From List    ${full_list}    start=${lsstBarraoblPiso02BarraoblCrack01_start}    end=${lsstBarraoblPiso02BarraoblCrack01_end}
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblCrack01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaRetorno : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblCrack01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pctoHumedadSala : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblCrack01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointHumidificador : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblCrack01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointDeshumidificador : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblCrack01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setPointCooling : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblCrack01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setPointHeating : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblCrack01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pctoAperturaValvula : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblCrack01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}requerimientoHumificador : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblCrack01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblCrack01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoEspacioDeEspacioUnidad : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblCrack01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}modoOperacionUnidad : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblCrack01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoPresenciaAlarma : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblCrack01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numeroCircuitos : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblCrack01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${lsstBarraoblPiso02BarraoblFancoil01_start}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso02BarraoblFancoil01 start of topic ===
    ${lsstBarraoblPiso02BarraoblFancoil01_end}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso02BarraoblFancoil01 end of topic ===
    ${lsstBarraoblPiso02BarraoblFancoil01_list}=    Get Slice From List    ${full_list}    start=${lsstBarraoblPiso02BarraoblFancoil01_start}    end=${lsstBarraoblPiso02BarraoblFancoil01_end}
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblFancoil01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoOperacion : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblFancoil01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoCalefactor : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblFancoil01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoVentilador : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblFancoil01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pcto_AperturaValvulaFrio : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblFancoil01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointCoolingDay : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblFancoil01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointHeatingDay : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblFancoil01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointCoolingNight : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblFancoil01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointHeatingNight : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblFancoil01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTrabajo : 1    10
    Should Contain X Times    ${lsstBarraoblPiso02BarraoblFancoil01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_start}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01 start of topic ===
    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_end}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01 end of topic ===
    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}=    Get Slice From List    ${full_list}    start=${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_start}    end=${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_end}
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTrabajo : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointVentiladorMin : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointVentiladorMax : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setPointVentImpulsion : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaAnticongelante : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaInyeccion : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaRetorno : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}alarmaGeneral : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}alarmaFiltro : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoDamper : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resetAlarma : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaAmbienteAmperExterior : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoValvula : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}caudalVentiladorImpulsion : 1    10
    Should Contain X Times    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_start}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca start of topic ===
    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_end}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca end of topic ===
    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}=    Get Slice From List    ${full_list}    start=${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_start}    end=${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_end}
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso04BarraoblManejadraBarraoblSblancaBarraoblEstadoTemperaturaAmbiente : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoTemperaturaExterior : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoTemperaturaAnticongelante : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valorConsigna : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTrabajo : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaInyeccion : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaRetorno : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}    ${SPACE}${SPACE}${SPACE}${SPACE}alarmaGeneral : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}    ${SPACE}${SPACE}${SPACE}${SPACE}alarmaFiltro : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resetAlarma : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoValvula : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calefaccionEtapa_01 : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calefaccionEtapa_02 : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}    ${SPACE}${SPACE}${SPACE}${SPACE}caudalVentiladorImpulsion : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointVentiladorMin : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointVentiladorMax : 1    10
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia_start}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia start of topic ===
    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia_end}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia end of topic ===
    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia_list}=    Get Slice From List    ${full_list}    start=${lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia_start}    end=${lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia_end}
    Should Contain X Times    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lsstBarraoblPiso04BarraoblManejadoraBarraoblSblancaBarraoblTemperaturaSala : 1    10
