*** Settings ***
Documentation    HVAC_Telemetry communications tests.
Force Tags    messaging    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${Build_Number}    ${MavenVersion}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    HVAC
${component}    all
${timeout}    600s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/src/test/java/${subSystem}Publisher_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/src/test/java/${subSystem}Subscriber_all.java

Start Subscriber
    [Tags]    functional
    Comment    Executing Combined Java Subscriber Program.
    ${output}=    Start Process    mvn    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/    alias=${subSystem}_Subscriber    stdout=${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt    stderr=${EXECDIR}${/}${subSystem}_stderrSubscriber.txt
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    30    1s    File Should Not Be Empty    ${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt
    Comment    Wait for Subscriber program to be ready.
    ${subscriberOutput}=    Get File    ${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt
    :FOR    ${i}    IN RANGE    30
    \    Exit For Loop If     '${subSystem} all subscribers ready' in $subscriberOutput
    \    ${subscriberOutput}=    Get File    ${EXECDIR}${/}${subSystem}_stdoutSubscriber.txt
    \    Sleep    3s
    Log    ${subscriberOutput}
    Should Contain    ${subscriberOutput}    ===== ${subSystem} all subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Executing Combined Java Publisher Program.
    ${output}=    Run Process    mvn    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/    alias=${subSystem}_Publisher    stdout=${EXECDIR}${/}${subSystem}_stdoutPublisher.txt    stderr=${EXECDIR}${/}${subSystem}_stderrPublisher.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ${subSystem} all publishers ready =====
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== HVAC all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${vea01P01_start}=    Get Index From List    ${full_list}    === HVAC_vea01P01 start of topic ===
    ${vea01P01_end}=    Get Index From List    ${full_list}    === HVAC_vea01P01 end of topic ===
    ${vea01P01_list}=    Get Slice From List    ${full_list}    start=${vea01P01_start}    end=${vea01P01_end + 1}
    Log Many    ${vea01P01_list}
    Should Contain    ${vea01P01_list}    === HVAC_vea01P01 start of topic ===
    Should Contain    ${vea01P01_list}    === HVAC_vea01P01 end of topic ===
    ${vin01P01_start}=    Get Index From List    ${full_list}    === HVAC_vin01P01 start of topic ===
    ${vin01P01_end}=    Get Index From List    ${full_list}    === HVAC_vin01P01 end of topic ===
    ${vin01P01_list}=    Get Slice From List    ${full_list}    start=${vin01P01_start}    end=${vin01P01_end + 1}
    Log Many    ${vin01P01_list}
    Should Contain    ${vin01P01_list}    === HVAC_vin01P01 start of topic ===
    Should Contain    ${vin01P01_list}    === HVAC_vin01P01 end of topic ===
    ${vec01P01_start}=    Get Index From List    ${full_list}    === HVAC_vec01P01 start of topic ===
    ${vec01P01_end}=    Get Index From List    ${full_list}    === HVAC_vec01P01 end of topic ===
    ${vec01P01_list}=    Get Slice From List    ${full_list}    start=${vec01P01_start}    end=${vec01P01_end + 1}
    Log Many    ${vec01P01_list}
    Should Contain    ${vec01P01_list}    === HVAC_vec01P01 start of topic ===
    Should Contain    ${vec01P01_list}    === HVAC_vec01P01 end of topic ===
    ${bombaAguaFriaP01_start}=    Get Index From List    ${full_list}    === HVAC_bombaAguaFriaP01 start of topic ===
    ${bombaAguaFriaP01_end}=    Get Index From List    ${full_list}    === HVAC_bombaAguaFriaP01 end of topic ===
    ${bombaAguaFriaP01_list}=    Get Slice From List    ${full_list}    start=${bombaAguaFriaP01_start}    end=${bombaAguaFriaP01_end + 1}
    Log Many    ${bombaAguaFriaP01_list}
    Should Contain    ${bombaAguaFriaP01_list}    === HVAC_bombaAguaFriaP01 start of topic ===
    Should Contain    ${bombaAguaFriaP01_list}    === HVAC_bombaAguaFriaP01 end of topic ===
    ${valvulaP01_start}=    Get Index From List    ${full_list}    === HVAC_valvulaP01 start of topic ===
    ${valvulaP01_end}=    Get Index From List    ${full_list}    === HVAC_valvulaP01 end of topic ===
    ${valvulaP01_list}=    Get Slice From List    ${full_list}    start=${valvulaP01_start}    end=${valvulaP01_end + 1}
    Log Many    ${valvulaP01_list}
    Should Contain    ${valvulaP01_list}    === HVAC_valvulaP01 start of topic ===
    Should Contain    ${valvulaP01_list}    === HVAC_valvulaP01 end of topic ===
    ${temperatuaAmbienteP01_start}=    Get Index From List    ${full_list}    === HVAC_temperatuaAmbienteP01 start of topic ===
    ${temperatuaAmbienteP01_end}=    Get Index From List    ${full_list}    === HVAC_temperatuaAmbienteP01 end of topic ===
    ${temperatuaAmbienteP01_list}=    Get Slice From List    ${full_list}    start=${temperatuaAmbienteP01_start}    end=${temperatuaAmbienteP01_end + 1}
    Log Many    ${temperatuaAmbienteP01_list}
    Should Contain    ${temperatuaAmbienteP01_list}    === HVAC_temperatuaAmbienteP01 start of topic ===
    Should Contain    ${temperatuaAmbienteP01_list}    === HVAC_temperatuaAmbienteP01 end of topic ===
    ${vea01P05_start}=    Get Index From List    ${full_list}    === HVAC_vea01P05 start of topic ===
    ${vea01P05_end}=    Get Index From List    ${full_list}    === HVAC_vea01P05 end of topic ===
    ${vea01P05_list}=    Get Slice From List    ${full_list}    start=${vea01P05_start}    end=${vea01P05_end + 1}
    Log Many    ${vea01P05_list}
    Should Contain    ${vea01P05_list}    === HVAC_vea01P05 start of topic ===
    Should Contain    ${vea01P05_list}    === HVAC_vea01P05 end of topic ===
    ${vea08P05_start}=    Get Index From List    ${full_list}    === HVAC_vea08P05 start of topic ===
    ${vea08P05_end}=    Get Index From List    ${full_list}    === HVAC_vea08P05 end of topic ===
    ${vea08P05_list}=    Get Slice From List    ${full_list}    start=${vea08P05_start}    end=${vea08P05_end + 1}
    Log Many    ${vea08P05_list}
    Should Contain    ${vea08P05_list}    === HVAC_vea08P05 start of topic ===
    Should Contain    ${vea08P05_list}    === HVAC_vea08P05 end of topic ===
    ${vea09P05_start}=    Get Index From List    ${full_list}    === HVAC_vea09P05 start of topic ===
    ${vea09P05_end}=    Get Index From List    ${full_list}    === HVAC_vea09P05 end of topic ===
    ${vea09P05_list}=    Get Slice From List    ${full_list}    start=${vea09P05_start}    end=${vea09P05_end + 1}
    Log Many    ${vea09P05_list}
    Should Contain    ${vea09P05_list}    === HVAC_vea09P05 start of topic ===
    Should Contain    ${vea09P05_list}    === HVAC_vea09P05 end of topic ===
    ${vea10P05_start}=    Get Index From List    ${full_list}    === HVAC_vea10P05 start of topic ===
    ${vea10P05_end}=    Get Index From List    ${full_list}    === HVAC_vea10P05 end of topic ===
    ${vea10P05_list}=    Get Slice From List    ${full_list}    start=${vea10P05_start}    end=${vea10P05_end + 1}
    Log Many    ${vea10P05_list}
    Should Contain    ${vea10P05_list}    === HVAC_vea10P05 start of topic ===
    Should Contain    ${vea10P05_list}    === HVAC_vea10P05 end of topic ===
    ${vea11P05_start}=    Get Index From List    ${full_list}    === HVAC_vea11P05 start of topic ===
    ${vea11P05_end}=    Get Index From List    ${full_list}    === HVAC_vea11P05 end of topic ===
    ${vea11P05_list}=    Get Slice From List    ${full_list}    start=${vea11P05_start}    end=${vea11P05_end + 1}
    Log Many    ${vea11P05_list}
    Should Contain    ${vea11P05_list}    === HVAC_vea11P05 start of topic ===
    Should Contain    ${vea11P05_list}    === HVAC_vea11P05 end of topic ===
    ${vea12P05_start}=    Get Index From List    ${full_list}    === HVAC_vea12P05 start of topic ===
    ${vea12P05_end}=    Get Index From List    ${full_list}    === HVAC_vea12P05 end of topic ===
    ${vea12P05_list}=    Get Slice From List    ${full_list}    start=${vea12P05_start}    end=${vea12P05_end + 1}
    Log Many    ${vea12P05_list}
    Should Contain    ${vea12P05_list}    === HVAC_vea12P05 start of topic ===
    Should Contain    ${vea12P05_list}    === HVAC_vea12P05 end of topic ===
    ${vea13P05_start}=    Get Index From List    ${full_list}    === HVAC_vea13P05 start of topic ===
    ${vea13P05_end}=    Get Index From List    ${full_list}    === HVAC_vea13P05 end of topic ===
    ${vea13P05_list}=    Get Slice From List    ${full_list}    start=${vea13P05_start}    end=${vea13P05_end + 1}
    Log Many    ${vea13P05_list}
    Should Contain    ${vea13P05_list}    === HVAC_vea13P05 start of topic ===
    Should Contain    ${vea13P05_list}    === HVAC_vea13P05 end of topic ===
    ${vea14P05_start}=    Get Index From List    ${full_list}    === HVAC_vea14P05 start of topic ===
    ${vea14P05_end}=    Get Index From List    ${full_list}    === HVAC_vea14P05 end of topic ===
    ${vea14P05_list}=    Get Slice From List    ${full_list}    start=${vea14P05_start}    end=${vea14P05_end + 1}
    Log Many    ${vea14P05_list}
    Should Contain    ${vea14P05_list}    === HVAC_vea14P05 start of topic ===
    Should Contain    ${vea14P05_list}    === HVAC_vea14P05 end of topic ===
    ${vea15P05_start}=    Get Index From List    ${full_list}    === HVAC_vea15P05 start of topic ===
    ${vea15P05_end}=    Get Index From List    ${full_list}    === HVAC_vea15P05 end of topic ===
    ${vea15P05_list}=    Get Slice From List    ${full_list}    start=${vea15P05_start}    end=${vea15P05_end + 1}
    Log Many    ${vea15P05_list}
    Should Contain    ${vea15P05_list}    === HVAC_vea15P05 start of topic ===
    Should Contain    ${vea15P05_list}    === HVAC_vea15P05 end of topic ===
    ${vea16P05_start}=    Get Index From List    ${full_list}    === HVAC_vea16P05 start of topic ===
    ${vea16P05_end}=    Get Index From List    ${full_list}    === HVAC_vea16P05 end of topic ===
    ${vea16P05_list}=    Get Slice From List    ${full_list}    start=${vea16P05_start}    end=${vea16P05_end + 1}
    Log Many    ${vea16P05_list}
    Should Contain    ${vea16P05_list}    === HVAC_vea16P05 start of topic ===
    Should Contain    ${vea16P05_list}    === HVAC_vea16P05 end of topic ===
    ${vea17P05_start}=    Get Index From List    ${full_list}    === HVAC_vea17P05 start of topic ===
    ${vea17P05_end}=    Get Index From List    ${full_list}    === HVAC_vea17P05 end of topic ===
    ${vea17P05_list}=    Get Slice From List    ${full_list}    start=${vea17P05_start}    end=${vea17P05_end + 1}
    Log Many    ${vea17P05_list}
    Should Contain    ${vea17P05_list}    === HVAC_vea17P05 start of topic ===
    Should Contain    ${vea17P05_list}    === HVAC_vea17P05 end of topic ===
    ${vea03P04_start}=    Get Index From List    ${full_list}    === HVAC_vea03P04 start of topic ===
    ${vea03P04_end}=    Get Index From List    ${full_list}    === HVAC_vea03P04 end of topic ===
    ${vea03P04_list}=    Get Slice From List    ${full_list}    start=${vea03P04_start}    end=${vea03P04_end + 1}
    Log Many    ${vea03P04_list}
    Should Contain    ${vea03P04_list}    === HVAC_vea03P04 start of topic ===
    Should Contain    ${vea03P04_list}    === HVAC_vea03P04 end of topic ===
    ${vea04P04_start}=    Get Index From List    ${full_list}    === HVAC_vea04P04 start of topic ===
    ${vea04P04_end}=    Get Index From List    ${full_list}    === HVAC_vea04P04 end of topic ===
    ${vea04P04_list}=    Get Slice From List    ${full_list}    start=${vea04P04_start}    end=${vea04P04_end + 1}
    Log Many    ${vea04P04_list}
    Should Contain    ${vea04P04_list}    === HVAC_vea04P04 start of topic ===
    Should Contain    ${vea04P04_list}    === HVAC_vea04P04 end of topic ===
    ${vex03P04_start}=    Get Index From List    ${full_list}    === HVAC_vex03P04 start of topic ===
    ${vex03P04_end}=    Get Index From List    ${full_list}    === HVAC_vex03P04 end of topic ===
    ${vex03P04_list}=    Get Slice From List    ${full_list}    start=${vex03P04_start}    end=${vex03P04_end + 1}
    Log Many    ${vex03P04_list}
    Should Contain    ${vex03P04_list}    === HVAC_vex03P04 start of topic ===
    Should Contain    ${vex03P04_list}    === HVAC_vex03P04 end of topic ===
    ${vex04P04_start}=    Get Index From List    ${full_list}    === HVAC_vex04P04 start of topic ===
    ${vex04P04_end}=    Get Index From List    ${full_list}    === HVAC_vex04P04 end of topic ===
    ${vex04P04_list}=    Get Slice From List    ${full_list}    start=${vex04P04_start}    end=${vex04P04_end + 1}
    Log Many    ${vex04P04_list}
    Should Contain    ${vex04P04_list}    === HVAC_vex04P04 start of topic ===
    Should Contain    ${vex04P04_list}    === HVAC_vex04P04 end of topic ===
    ${damperLowerP04_start}=    Get Index From List    ${full_list}    === HVAC_damperLowerP04 start of topic ===
    ${damperLowerP04_end}=    Get Index From List    ${full_list}    === HVAC_damperLowerP04 end of topic ===
    ${damperLowerP04_list}=    Get Slice From List    ${full_list}    start=${damperLowerP04_start}    end=${damperLowerP04_end + 1}
    Log Many    ${damperLowerP04_list}
    Should Contain    ${damperLowerP04_list}    === HVAC_damperLowerP04 start of topic ===
    Should Contain    ${damperLowerP04_list}    === HVAC_damperLowerP04 end of topic ===
    ${zonaCargaP04_start}=    Get Index From List    ${full_list}    === HVAC_zonaCargaP04 start of topic ===
    ${zonaCargaP04_end}=    Get Index From List    ${full_list}    === HVAC_zonaCargaP04 end of topic ===
    ${zonaCargaP04_list}=    Get Slice From List    ${full_list}    start=${zonaCargaP04_start}    end=${zonaCargaP04_end + 1}
    Log Many    ${zonaCargaP04_list}
    Should Contain    ${zonaCargaP04_list}    === HVAC_zonaCargaP04 start of topic ===
    Should Contain    ${zonaCargaP04_list}    === HVAC_zonaCargaP04 end of topic ===
    ${chiller01P01_start}=    Get Index From List    ${full_list}    === HVAC_chiller01P01 start of topic ===
    ${chiller01P01_end}=    Get Index From List    ${full_list}    === HVAC_chiller01P01 end of topic ===
    ${chiller01P01_list}=    Get Slice From List    ${full_list}    start=${chiller01P01_start}    end=${chiller01P01_end + 1}
    Log Many    ${chiller01P01_list}
    Should Contain    ${chiller01P01_list}    === HVAC_chiller01P01 start of topic ===
    Should Contain    ${chiller01P01_list}    === HVAC_chiller01P01 end of topic ===
    ${crack01P02_start}=    Get Index From List    ${full_list}    === HVAC_crack01P02 start of topic ===
    ${crack01P02_end}=    Get Index From List    ${full_list}    === HVAC_crack01P02 end of topic ===
    ${crack01P02_list}=    Get Slice From List    ${full_list}    start=${crack01P02_start}    end=${crack01P02_end + 1}
    Log Many    ${crack01P02_list}
    Should Contain    ${crack01P02_list}    === HVAC_crack01P02 start of topic ===
    Should Contain    ${crack01P02_list}    === HVAC_crack01P02 end of topic ===
    ${fancoil01P02_start}=    Get Index From List    ${full_list}    === HVAC_fancoil01P02 start of topic ===
    ${fancoil01P02_end}=    Get Index From List    ${full_list}    === HVAC_fancoil01P02 end of topic ===
    ${fancoil01P02_list}=    Get Slice From List    ${full_list}    start=${fancoil01P02_start}    end=${fancoil01P02_end + 1}
    Log Many    ${fancoil01P02_list}
    Should Contain    ${fancoil01P02_list}    === HVAC_fancoil01P02 start of topic ===
    Should Contain    ${fancoil01P02_list}    === HVAC_fancoil01P02 end of topic ===
    ${manejadoraLower01P05_start}=    Get Index From List    ${full_list}    === HVAC_manejadoraLower01P05 start of topic ===
    ${manejadoraLower01P05_end}=    Get Index From List    ${full_list}    === HVAC_manejadoraLower01P05 end of topic ===
    ${manejadoraLower01P05_list}=    Get Slice From List    ${full_list}    start=${manejadoraLower01P05_start}    end=${manejadoraLower01P05_end + 1}
    Log Many    ${manejadoraLower01P05_list}
    Should Contain    ${manejadoraLower01P05_list}    === HVAC_manejadoraLower01P05 start of topic ===
    Should Contain    ${manejadoraLower01P05_list}    === HVAC_manejadoraLower01P05 end of topic ===
    ${manejadoraSblancaP04_start}=    Get Index From List    ${full_list}    === HVAC_manejadoraSblancaP04 start of topic ===
    ${manejadoraSblancaP04_end}=    Get Index From List    ${full_list}    === HVAC_manejadoraSblancaP04 end of topic ===
    ${manejadoraSblancaP04_list}=    Get Slice From List    ${full_list}    start=${manejadoraSblancaP04_start}    end=${manejadoraSblancaP04_end + 1}
    Log Many    ${manejadoraSblancaP04_list}
    Should Contain    ${manejadoraSblancaP04_list}    === HVAC_manejadoraSblancaP04 start of topic ===
    Should Contain    ${manejadoraSblancaP04_list}    === HVAC_manejadoraSblancaP04 end of topic ===
    ${manejadraSblancaP04_start}=    Get Index From List    ${full_list}    === HVAC_manejadraSblancaP04 start of topic ===
    ${manejadraSblancaP04_end}=    Get Index From List    ${full_list}    === HVAC_manejadraSblancaP04 end of topic ===
    ${manejadraSblancaP04_list}=    Get Slice From List    ${full_list}    start=${manejadraSblancaP04_start}    end=${manejadraSblancaP04_end + 1}
    Log Many    ${manejadraSblancaP04_list}
    Should Contain    ${manejadraSblancaP04_list}    === HVAC_manejadraSblancaP04 start of topic ===
    Should Contain    ${manejadraSblancaP04_list}    === HVAC_manejadraSblancaP04 end of topic ===
    ${manejadoraSlimpiaP04_start}=    Get Index From List    ${full_list}    === HVAC_manejadoraSlimpiaP04 start of topic ===
    ${manejadoraSlimpiaP04_end}=    Get Index From List    ${full_list}    === HVAC_manejadoraSlimpiaP04 end of topic ===
    ${manejadoraSlimpiaP04_list}=    Get Slice From List    ${full_list}    start=${manejadoraSlimpiaP04_start}    end=${manejadoraSlimpiaP04_end + 1}
    Log Many    ${manejadoraSlimpiaP04_list}
    Should Contain    ${manejadoraSlimpiaP04_list}    === HVAC_manejadoraSlimpiaP04 start of topic ===
    Should Contain    ${manejadoraSlimpiaP04_list}    === HVAC_manejadoraSlimpiaP04 end of topic ===
    ${manejadoraZzzP04_start}=    Get Index From List    ${full_list}    === HVAC_manejadoraZzzP04 start of topic ===
    ${manejadoraZzzP04_end}=    Get Index From List    ${full_list}    === HVAC_manejadoraZzzP04 end of topic ===
    ${manejadoraZzzP04_list}=    Get Slice From List    ${full_list}    start=${manejadoraZzzP04_start}    end=${manejadoraZzzP04_end + 1}
    Log Many    ${manejadoraZzzP04_list}
    Should Contain    ${manejadoraZzzP04_list}    === HVAC_manejadoraZzzP04 start of topic ===
    Should Contain    ${manejadoraZzzP04_list}    === HVAC_manejadoraZzzP04 end of topic ===
