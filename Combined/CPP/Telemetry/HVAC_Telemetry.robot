*** Settings ***
Documentation    HVAC Telemetry communications tests.
Force Tags    messaging    cpp    
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
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdout.txt
    Comment    Sleep for 6s to allow DDS time to register all the topics.
    Sleep    6s
    ${output}=    Get File    ${EXECDIR}${/}${subSystem}_stdout.txt
    Should Contain    ${output}    ===== HVAC subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_vea01P01 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vea01P01
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_vea01P01 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vea01P01_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_vea01P01 end of topic ===
    Comment    ======= Verify ${subSystem}_vin01P01 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vin01P01
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_vin01P01 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vin01P01_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_vin01P01 end of topic ===
    Comment    ======= Verify ${subSystem}_vec01P01 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vec01P01
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_vec01P01 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vec01P01_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_vec01P01 end of topic ===
    Comment    ======= Verify ${subSystem}_bombaAguaFriaP01 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_bombaAguaFriaP01
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_bombaAguaFriaP01 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::bombaAguaFriaP01_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_bombaAguaFriaP01 end of topic ===
    Comment    ======= Verify ${subSystem}_valvulaP01 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_valvulaP01
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_valvulaP01 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::valvulaP01_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_valvulaP01 end of topic ===
    Comment    ======= Verify ${subSystem}_temperatuaAmbienteP01 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_temperatuaAmbienteP01
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_temperatuaAmbienteP01 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::temperatuaAmbienteP01_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_temperatuaAmbienteP01 end of topic ===
    Comment    ======= Verify ${subSystem}_vea01P05 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vea01P05
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_vea01P05 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vea01P05_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_vea01P05 end of topic ===
    Comment    ======= Verify ${subSystem}_vea08P05 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vea08P05
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_vea08P05 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vea08P05_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_vea08P05 end of topic ===
    Comment    ======= Verify ${subSystem}_vea09P05 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vea09P05
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_vea09P05 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vea09P05_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_vea09P05 end of topic ===
    Comment    ======= Verify ${subSystem}_vea10P05 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vea10P05
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_vea10P05 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vea10P05_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_vea10P05 end of topic ===
    Comment    ======= Verify ${subSystem}_vea11P05 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vea11P05
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_vea11P05 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vea11P05_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_vea11P05 end of topic ===
    Comment    ======= Verify ${subSystem}_vea12P05 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vea12P05
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_vea12P05 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vea12P05_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_vea12P05 end of topic ===
    Comment    ======= Verify ${subSystem}_vea13P05 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vea13P05
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_vea13P05 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vea13P05_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_vea13P05 end of topic ===
    Comment    ======= Verify ${subSystem}_vea14P05 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vea14P05
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_vea14P05 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vea14P05_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_vea14P05 end of topic ===
    Comment    ======= Verify ${subSystem}_vea15P05 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vea15P05
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_vea15P05 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vea15P05_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_vea15P05 end of topic ===
    Comment    ======= Verify ${subSystem}_vea16P05 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vea16P05
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_vea16P05 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vea16P05_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_vea16P05 end of topic ===
    Comment    ======= Verify ${subSystem}_vea17P05 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vea17P05
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_vea17P05 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vea17P05_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_vea17P05 end of topic ===
    Comment    ======= Verify ${subSystem}_vea03P04 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vea03P04
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_vea03P04 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vea03P04_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_vea03P04 end of topic ===
    Comment    ======= Verify ${subSystem}_vea04P04 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vea04P04
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_vea04P04 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vea04P04_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_vea04P04 end of topic ===
    Comment    ======= Verify ${subSystem}_vex03P04 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vex03P04
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_vex03P04 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vex03P04_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_vex03P04 end of topic ===
    Comment    ======= Verify ${subSystem}_vex04P04 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vex04P04
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_vex04P04 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vex04P04_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_vex04P04 end of topic ===
    Comment    ======= Verify ${subSystem}_damperLowerP04 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_damperLowerP04
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_damperLowerP04 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::damperLowerP04_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_damperLowerP04 end of topic ===
    Comment    ======= Verify ${subSystem}_zonaCargaP04 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_zonaCargaP04
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_zonaCargaP04 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::zonaCargaP04_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_zonaCargaP04 end of topic ===
    Comment    ======= Verify ${subSystem}_chiller01P01 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_chiller01P01
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_chiller01P01 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::chiller01P01_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_chiller01P01 end of topic ===
    Comment    ======= Verify ${subSystem}_crack01P02 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_crack01P02
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_crack01P02 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::crack01P02_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_crack01P02 end of topic ===
    Comment    ======= Verify ${subSystem}_fancoil01P02 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_fancoil01P02
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_fancoil01P02 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::fancoil01P02_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_fancoil01P02 end of topic ===
    Comment    ======= Verify ${subSystem}_manejadoraLower01P05 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_manejadoraLower01P05
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_manejadoraLower01P05 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::manejadoraLower01P05_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_manejadoraLower01P05 end of topic ===
    Comment    ======= Verify ${subSystem}_manejadoraSblancaP04 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_manejadoraSblancaP04
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_manejadoraSblancaP04 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::manejadoraSblancaP04_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_manejadoraSblancaP04 end of topic ===
    Comment    ======= Verify ${subSystem}_manejadraSblancaP04 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_manejadraSblancaP04
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_manejadraSblancaP04 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::manejadraSblancaP04_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_manejadraSblancaP04 end of topic ===
    Comment    ======= Verify ${subSystem}_manejadoraSlimpiaP04 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_manejadoraSlimpiaP04
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_manejadoraSlimpiaP04 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::manejadoraSlimpiaP04_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_manejadoraSlimpiaP04 end of topic ===
    Comment    ======= Verify ${subSystem}_manejadoraZzzP04 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_manejadoraZzzP04
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === HVAC_manejadoraZzzP04 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::manejadoraZzzP04_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === HVAC_manejadoraZzzP04 end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== HVAC subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${vea01P01_start}=    Get Index From List    ${full_list}    === HVAC_vea01P01 start of topic ===
    ${vea01P01_end}=    Get Index From List    ${full_list}    === HVAC_vea01P01 end of topic ===
    ${vea01P01_list}=    Get Slice From List    ${full_list}    start=${vea01P01_start}    end=${vea01P01_end}
    Should Contain X Times    ${vea01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${vea01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoSelector : 1    10
    Should Contain X Times    ${vea01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${vin01P01_start}=    Get Index From List    ${full_list}    === HVAC_vin01P01 start of topic ===
    ${vin01P01_end}=    Get Index From List    ${full_list}    === HVAC_vin01P01 end of topic ===
    ${vin01P01_list}=    Get Slice From List    ${full_list}    start=${vin01P01_start}    end=${vin01P01_end}
    Should Contain X Times    ${vin01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${vin01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoSelector : 1    10
    Should Contain X Times    ${vin01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${vec01P01_start}=    Get Index From List    ${full_list}    === HVAC_vec01P01 start of topic ===
    ${vec01P01_end}=    Get Index From List    ${full_list}    === HVAC_vec01P01 end of topic ===
    ${vec01P01_list}=    Get Slice From List    ${full_list}    start=${vec01P01_start}    end=${vec01P01_end}
    Should Contain X Times    ${vec01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${vec01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoSelector : 1    10
    Should Contain X Times    ${vec01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${bombaAguaFriaP01_start}=    Get Index From List    ${full_list}    === HVAC_bombaAguaFriaP01 start of topic ===
    ${bombaAguaFriaP01_end}=    Get Index From List    ${full_list}    === HVAC_bombaAguaFriaP01 end of topic ===
    ${bombaAguaFriaP01_list}=    Get Slice From List    ${full_list}    start=${bombaAguaFriaP01_start}    end=${bombaAguaFriaP01_end}
    Should Contain X Times    ${bombaAguaFriaP01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${bombaAguaFriaP01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${valvulaP01_start}=    Get Index From List    ${full_list}    === HVAC_valvulaP01 start of topic ===
    ${valvulaP01_end}=    Get Index From List    ${full_list}    === HVAC_valvulaP01 end of topic ===
    ${valvulaP01_list}=    Get Slice From List    ${full_list}    start=${valvulaP01_start}    end=${valvulaP01_end}
    Should Contain X Times    ${valvulaP01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoValvula12 : 1    10
    Should Contain X Times    ${valvulaP01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoValvula03 : 1    10
    Should Contain X Times    ${valvulaP01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoValvula04 : 1    10
    Should Contain X Times    ${valvulaP01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoValvula05 : 1    10
    Should Contain X Times    ${valvulaP01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoValvula06 : 1    10
    ${temperatuaAmbienteP01_start}=    Get Index From List    ${full_list}    === HVAC_temperatuaAmbienteP01 start of topic ===
    ${temperatuaAmbienteP01_end}=    Get Index From List    ${full_list}    === HVAC_temperatuaAmbienteP01 end of topic ===
    ${temperatuaAmbienteP01_list}=    Get Slice From List    ${full_list}    start=${temperatuaAmbienteP01_start}    end=${temperatuaAmbienteP01_end}
    Should Contain X Times    ${temperatuaAmbienteP01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaAmbiente : 1    10
    ${vea01P05_start}=    Get Index From List    ${full_list}    === HVAC_vea01P05 start of topic ===
    ${vea01P05_end}=    Get Index From List    ${full_list}    === HVAC_vea01P05 end of topic ===
    ${vea01P05_list}=    Get Slice From List    ${full_list}    start=${vea01P05_start}    end=${vea01P05_end}
    Should Contain X Times    ${vea01P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${vea01P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fallaTermica : 1    10
    Should Contain X Times    ${vea01P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${vea08P05_start}=    Get Index From List    ${full_list}    === HVAC_vea08P05 start of topic ===
    ${vea08P05_end}=    Get Index From List    ${full_list}    === HVAC_vea08P05 end of topic ===
    ${vea08P05_list}=    Get Slice From List    ${full_list}    start=${vea08P05_start}    end=${vea08P05_end}
    Should Contain X Times    ${vea08P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${vea08P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fallaTermica : 1    10
    Should Contain X Times    ${vea08P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${vea09P05_start}=    Get Index From List    ${full_list}    === HVAC_vea09P05 start of topic ===
    ${vea09P05_end}=    Get Index From List    ${full_list}    === HVAC_vea09P05 end of topic ===
    ${vea09P05_list}=    Get Slice From List    ${full_list}    start=${vea09P05_start}    end=${vea09P05_end}
    Should Contain X Times    ${vea09P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${vea09P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fallaTermica : 1    10
    Should Contain X Times    ${vea09P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${vea10P05_start}=    Get Index From List    ${full_list}    === HVAC_vea10P05 start of topic ===
    ${vea10P05_end}=    Get Index From List    ${full_list}    === HVAC_vea10P05 end of topic ===
    ${vea10P05_list}=    Get Slice From List    ${full_list}    start=${vea10P05_start}    end=${vea10P05_end}
    Should Contain X Times    ${vea10P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${vea10P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fallaTermica : 1    10
    Should Contain X Times    ${vea10P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${vea11P05_start}=    Get Index From List    ${full_list}    === HVAC_vea11P05 start of topic ===
    ${vea11P05_end}=    Get Index From List    ${full_list}    === HVAC_vea11P05 end of topic ===
    ${vea11P05_list}=    Get Slice From List    ${full_list}    start=${vea11P05_start}    end=${vea11P05_end}
    Should Contain X Times    ${vea11P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${vea11P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fallaTermica : 1    10
    Should Contain X Times    ${vea11P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${vea12P05_start}=    Get Index From List    ${full_list}    === HVAC_vea12P05 start of topic ===
    ${vea12P05_end}=    Get Index From List    ${full_list}    === HVAC_vea12P05 end of topic ===
    ${vea12P05_list}=    Get Slice From List    ${full_list}    start=${vea12P05_start}    end=${vea12P05_end}
    Should Contain X Times    ${vea12P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${vea12P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fallaTermica : 1    10
    Should Contain X Times    ${vea12P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${vea13P05_start}=    Get Index From List    ${full_list}    === HVAC_vea13P05 start of topic ===
    ${vea13P05_end}=    Get Index From List    ${full_list}    === HVAC_vea13P05 end of topic ===
    ${vea13P05_list}=    Get Slice From List    ${full_list}    start=${vea13P05_start}    end=${vea13P05_end}
    Should Contain X Times    ${vea13P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${vea13P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fallaTermica : 1    10
    Should Contain X Times    ${vea13P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${vea14P05_start}=    Get Index From List    ${full_list}    === HVAC_vea14P05 start of topic ===
    ${vea14P05_end}=    Get Index From List    ${full_list}    === HVAC_vea14P05 end of topic ===
    ${vea14P05_list}=    Get Slice From List    ${full_list}    start=${vea14P05_start}    end=${vea14P05_end}
    Should Contain X Times    ${vea14P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${vea14P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fallaTermica : 1    10
    Should Contain X Times    ${vea14P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${vea15P05_start}=    Get Index From List    ${full_list}    === HVAC_vea15P05 start of topic ===
    ${vea15P05_end}=    Get Index From List    ${full_list}    === HVAC_vea15P05 end of topic ===
    ${vea15P05_list}=    Get Slice From List    ${full_list}    start=${vea15P05_start}    end=${vea15P05_end}
    Should Contain X Times    ${vea15P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${vea15P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fallaTermica : 1    10
    Should Contain X Times    ${vea15P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${vea16P05_start}=    Get Index From List    ${full_list}    === HVAC_vea16P05 start of topic ===
    ${vea16P05_end}=    Get Index From List    ${full_list}    === HVAC_vea16P05 end of topic ===
    ${vea16P05_list}=    Get Slice From List    ${full_list}    start=${vea16P05_start}    end=${vea16P05_end}
    Should Contain X Times    ${vea16P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${vea16P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fallaTermica : 1    10
    Should Contain X Times    ${vea16P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${vea17P05_start}=    Get Index From List    ${full_list}    === HVAC_vea17P05 start of topic ===
    ${vea17P05_end}=    Get Index From List    ${full_list}    === HVAC_vea17P05 end of topic ===
    ${vea17P05_list}=    Get Slice From List    ${full_list}    start=${vea17P05_start}    end=${vea17P05_end}
    Should Contain X Times    ${vea17P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${vea17P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fallaTermica : 1    10
    Should Contain X Times    ${vea17P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${vea03P04_start}=    Get Index From List    ${full_list}    === HVAC_vea03P04 start of topic ===
    ${vea03P04_end}=    Get Index From List    ${full_list}    === HVAC_vea03P04 end of topic ===
    ${vea03P04_list}=    Get Slice From List    ${full_list}    start=${vea03P04_start}    end=${vea03P04_end}
    Should Contain X Times    ${vea03P04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    ${vea04P04_start}=    Get Index From List    ${full_list}    === HVAC_vea04P04 start of topic ===
    ${vea04P04_end}=    Get Index From List    ${full_list}    === HVAC_vea04P04 end of topic ===
    ${vea04P04_list}=    Get Slice From List    ${full_list}    start=${vea04P04_start}    end=${vea04P04_end}
    Should Contain X Times    ${vea04P04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    ${vex03P04_start}=    Get Index From List    ${full_list}    === HVAC_vex03P04 start of topic ===
    ${vex03P04_end}=    Get Index From List    ${full_list}    === HVAC_vex03P04 end of topic ===
    ${vex03P04_list}=    Get Slice From List    ${full_list}    start=${vex03P04_start}    end=${vex03P04_end}
    Should Contain X Times    ${vex03P04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fallaTermica : 1    10
    Should Contain X Times    ${vex03P04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${vex04P04_start}=    Get Index From List    ${full_list}    === HVAC_vex04P04 start of topic ===
    ${vex04P04_end}=    Get Index From List    ${full_list}    === HVAC_vex04P04 end of topic ===
    ${vex04P04_list}=    Get Slice From List    ${full_list}    start=${vex04P04_start}    end=${vex04P04_end}
    Should Contain X Times    ${vex04P04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fallaTermica : 1    10
    Should Contain X Times    ${vex04P04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${damperLowerP04_start}=    Get Index From List    ${full_list}    === HVAC_damperLowerP04 start of topic ===
    ${damperLowerP04_end}=    Get Index From List    ${full_list}    === HVAC_damperLowerP04 end of topic ===
    ${damperLowerP04_list}=    Get Slice From List    ${full_list}    start=${damperLowerP04_start}    end=${damperLowerP04_end}
    Should Contain X Times    ${damperLowerP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comando : 1    10
    ${zonaCargaP04_start}=    Get Index From List    ${full_list}    === HVAC_zonaCargaP04 start of topic ===
    ${zonaCargaP04_end}=    Get Index From List    ${full_list}    === HVAC_zonaCargaP04 end of topic ===
    ${zonaCargaP04_list}=    Get Slice From List    ${full_list}    start=${zonaCargaP04_start}    end=${zonaCargaP04_end}
    Should Contain X Times    ${zonaCargaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${chiller01P01_start}=    Get Index From List    ${full_list}    === HVAC_chiller01P01 start of topic ===
    ${chiller01P01_end}=    Get Index From List    ${full_list}    === HVAC_chiller01P01 end of topic ===
    ${chiller01P01_list}=    Get Slice From List    ${full_list}    start=${chiller01P01_start}    end=${chiller01P01_end}
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointActivo : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaAguaRetornoEvaporador : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaAguaImpulsionEvaporador : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}presionBajaCto1 : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}presionBajaCto2 : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}potenciaDisponibleChiller : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}potenciaTrabajo : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}modoOperacion : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoUnidad : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}horasCompresorPromedio : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}horasCompresor01 : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}horasCompresor02 : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}horasCompresor03 : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}horasCompresor04 : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compresor01Funcionando : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compresor02Funcionando : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compresor03Funcionando : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compresor04Funcionando : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compresor01Alarmado : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compresor02Alarmado : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compresor03Alarmado : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compresor04Alarmado : 1    10
    Should Contain X Times    ${chiller01P01_list}    ${SPACE}${SPACE}${SPACE}${SPACE}alarmaGeneral : 1    10
    ${crack01P02_start}=    Get Index From List    ${full_list}    === HVAC_crack01P02 start of topic ===
    ${crack01P02_end}=    Get Index From List    ${full_list}    === HVAC_crack01P02 end of topic ===
    ${crack01P02_list}=    Get Slice From List    ${full_list}    start=${crack01P02_start}    end=${crack01P02_end}
    Should Contain X Times    ${crack01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaInyeccion : 1    10
    Should Contain X Times    ${crack01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaRetorno : 1    10
    Should Contain X Times    ${crack01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}humedadSala : 1    10
    Should Contain X Times    ${crack01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointHumidificador : 1    10
    Should Contain X Times    ${crack01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointDeshumidificador : 1    10
    Should Contain X Times    ${crack01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setPointCooling : 1    10
    Should Contain X Times    ${crack01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setPointHeating : 1    10
    Should Contain X Times    ${crack01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aperturaValvula : 1    10
    Should Contain X Times    ${crack01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}requerimientoHumificador : 1    10
    Should Contain X Times    ${crack01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${crack01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoDeUnidad : 1    10
    Should Contain X Times    ${crack01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}modoOperacionUnidad : 1    10
    Should Contain X Times    ${crack01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoPresenciaAlarma : 1    10
    Should Contain X Times    ${crack01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numeroCircuitos : 1    10
    Should Contain X Times    ${crack01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${fancoil01P02_start}=    Get Index From List    ${full_list}    === HVAC_fancoil01P02 start of topic ===
    ${fancoil01P02_end}=    Get Index From List    ${full_list}    === HVAC_fancoil01P02 end of topic ===
    ${fancoil01P02_list}=    Get Slice From List    ${full_list}    start=${fancoil01P02_start}    end=${fancoil01P02_end}
    Should Contain X Times    ${fancoil01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaSala : 1    10
    Should Contain X Times    ${fancoil01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoOperacion : 1    10
    Should Contain X Times    ${fancoil01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoCalefactor : 1    10
    Should Contain X Times    ${fancoil01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoVentilador : 1    10
    Should Contain X Times    ${fancoil01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aperturaValvulaFrio : 1    10
    Should Contain X Times    ${fancoil01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointCoolingDay : 1    10
    Should Contain X Times    ${fancoil01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointHeatingDay : 1    10
    Should Contain X Times    ${fancoil01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointCoolingNight : 1    10
    Should Contain X Times    ${fancoil01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointHeatingNight : 1    10
    Should Contain X Times    ${fancoil01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTrabajo : 1    10
    Should Contain X Times    ${fancoil01P02_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${manejadoraLower01P05_start}=    Get Index From List    ${full_list}    === HVAC_manejadoraLower01P05 start of topic ===
    ${manejadoraLower01P05_end}=    Get Index From List    ${full_list}    === HVAC_manejadoraLower01P05 end of topic ===
    ${manejadoraLower01P05_list}=    Get Slice From List    ${full_list}    start=${manejadoraLower01P05_start}    end=${manejadoraLower01P05_end}
    Should Contain X Times    ${manejadoraLower01P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valorConsigna : 1    10
    Should Contain X Times    ${manejadoraLower01P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTrabajo : 1    10
    Should Contain X Times    ${manejadoraLower01P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointVentiladorMin : 1    10
    Should Contain X Times    ${manejadoraLower01P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointVentiladorMax : 1    10
    Should Contain X Times    ${manejadoraLower01P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setPointVentImpulsion : 1    10
    Should Contain X Times    ${manejadoraLower01P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaAnticongelante : 1    10
    Should Contain X Times    ${manejadoraLower01P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaInyeccion : 1    10
    Should Contain X Times    ${manejadoraLower01P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaRetorno : 1    10
    Should Contain X Times    ${manejadoraLower01P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}alarmaGeneral : 1    10
    Should Contain X Times    ${manejadoraLower01P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}alarmaFiltro : 1    10
    Should Contain X Times    ${manejadoraLower01P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${manejadoraLower01P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoDamper : 1    10
    Should Contain X Times    ${manejadoraLower01P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resetAlarma : 1    10
    Should Contain X Times    ${manejadoraLower01P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaAmbienteExterior : 1    10
    Should Contain X Times    ${manejadoraLower01P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoValvula : 1    10
    Should Contain X Times    ${manejadoraLower01P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}caudalVentiladorImpulsion : 1    10
    Should Contain X Times    ${manejadoraLower01P05_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    ${manejadoraSblancaP04_start}=    Get Index From List    ${full_list}    === HVAC_manejadoraSblancaP04 start of topic ===
    ${manejadoraSblancaP04_end}=    Get Index From List    ${full_list}    === HVAC_manejadoraSblancaP04 end of topic ===
    ${manejadoraSblancaP04_list}=    Get Slice From List    ${full_list}    start=${manejadoraSblancaP04_start}    end=${manejadoraSblancaP04_end}
    Should Contain X Times    ${manejadoraSblancaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valorConsigna : 1    10
    Should Contain X Times    ${manejadoraSblancaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoFuncionamiento : 1    10
    Should Contain X Times    ${manejadoraSblancaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoTemperaturaExterior : 1    10
    Should Contain X Times    ${manejadoraSblancaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoTemperaturaAnticongelante : 1    10
    Should Contain X Times    ${manejadoraSblancaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointTrabajo : 1    10
    Should Contain X Times    ${manejadoraSblancaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaInyeccion : 1    10
    Should Contain X Times    ${manejadoraSblancaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaRetorno : 1    10
    Should Contain X Times    ${manejadoraSblancaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}alarmaGeneral : 1    10
    Should Contain X Times    ${manejadoraSblancaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}alarmaFiltro : 1    10
    Should Contain X Times    ${manejadoraSblancaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}resetAlarma : 1    10
    Should Contain X Times    ${manejadoraSblancaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoValvula : 1    10
    Should Contain X Times    ${manejadoraSblancaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calefaccionEtapa01 : 1    10
    Should Contain X Times    ${manejadoraSblancaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}calefaccionEtapa02 : 1    10
    Should Contain X Times    ${manejadoraSblancaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}caudalVentiladorImpulsion : 1    10
    Should Contain X Times    ${manejadoraSblancaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointVentiladorMin : 1    10
    Should Contain X Times    ${manejadoraSblancaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}setpointVentiladorMax : 1    10
    Should Contain X Times    ${manejadoraSblancaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}comandoEncendido : 1    10
    Should Contain X Times    ${manejadoraSblancaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaSala : 1    10
    ${manejadraSblancaP04_start}=    Get Index From List    ${full_list}    === HVAC_manejadraSblancaP04 start of topic ===
    ${manejadraSblancaP04_end}=    Get Index From List    ${full_list}    === HVAC_manejadraSblancaP04 end of topic ===
    ${manejadraSblancaP04_list}=    Get Slice From List    ${full_list}    start=${manejadraSblancaP04_start}    end=${manejadraSblancaP04_end}
    Should Contain X Times    ${manejadraSblancaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}estadoTemperaturaAmbiente : 1    10
    ${manejadoraSlimpiaP04_start}=    Get Index From List    ${full_list}    === HVAC_manejadoraSlimpiaP04 start of topic ===
    ${manejadoraSlimpiaP04_end}=    Get Index From List    ${full_list}    === HVAC_manejadoraSlimpiaP04 end of topic ===
    ${manejadoraSlimpiaP04_list}=    Get Slice From List    ${full_list}    start=${manejadoraSlimpiaP04_start}    end=${manejadoraSlimpiaP04_end}
    Should Contain X Times    ${manejadoraSlimpiaP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperaturaSala : 1    10
    ${manejadoraZzzP04_start}=    Get Index From List    ${full_list}    === HVAC_manejadoraZzzP04 start of topic ===
    ${manejadoraZzzP04_end}=    Get Index From List    ${full_list}    === HVAC_manejadoraZzzP04 end of topic ===
    ${manejadoraZzzP04_list}=    Get Slice From List    ${full_list}    start=${manejadoraZzzP04_start}    end=${manejadoraZzzP04_end}
    Should Contain X Times    ${manejadoraZzzP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ai4 : 1    10
    Should Contain X Times    ${manejadoraZzzP04_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ai5 : 1    10
