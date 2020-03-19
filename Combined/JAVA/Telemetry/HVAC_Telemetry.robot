*** Settings ***
Documentation    HVAC_Telemetry communications tests.
Force Tags    java    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
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
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}Publisher_all.java
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/src/test/java/${subSystem}Subscriber_all.java

Start Subscriber
    [Tags]    functional
    Comment    Executing Combined Java Subscriber Program.
    ${subscriberOutput}=    Start Process    mvn    -Dtest\=${subSystem}Subscriber_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${SALVersion}/    alias=Subscriber    stdout=${EXECDIR}${/}stdoutSubscriber.txt    stderr=${EXECDIR}${/}stderrSubscriber.txt
    Log    ${subscriberOutput}
    Should Contain    "${subscriberOutput}"   "1"
    Wait Until Keyword Succeeds    30    1s    File Should Not Be Empty    ${EXECDIR}${/}stdoutSubscriber.txt
    Comment    Wait for Subscriber program to be ready.
    ${subscriberOutput}=    Get File    ${EXECDIR}${/}stdoutSubscriber.txt
    :FOR    ${i}    IN RANGE    30
    \    Exit For Loop If     '${subSystem} all subscribers ready' in $subscriberOutput
    \    ${subscriberOutput}=    Get File    ${EXECDIR}${/}stdoutSubscriber.txt
    \    Sleep    3s
    Log    ${subscriberOutput}
    Should Contain    ${subscriberOutput}    ===== ${subSystem} all subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Executing Combined Java Publisher Program.
    ${publisherOutput}=    Run Process    mvn    -Dtest\=${subSystem}Publisher_all.java    test    cwd=${SALWorkDir}/maven/${subSystem}_${SALVersion}/    alias=Publisher    stdout=${EXECDIR}${/}stdoutPublisher.txt    stderr=${EXECDIR}${/}stderrPublisher.txt
    Log    ${publisherOutput.stdout}
    Should Contain    ${publisherOutput.stdout}    ===== ${subSystem} all publishers ready =====
    Should Contain    ${publisherOutput.stdout}    [INFO] BUILD SUCCESS

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== HVAC all subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=29
    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_start}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas start of topic ===
    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_end}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas end of topic ===
    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}=    Get Slice From List    ${full_list}    start=${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_start}    end=${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_end + 1}
    Log Many    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}
    Should Contain    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}    === HVAC_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas start of topic ===
    Should Contain    ${lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_list}    === HVAC_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas end of topic ===
    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_start}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir start of topic ===
    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_end}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir end of topic ===
    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}=    Get Slice From List    ${full_list}    start=${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_start}    end=${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_end + 1}
    Log Many    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}
    Should Contain    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    === HVAC_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir start of topic ===
    Should Contain    ${lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_list}    === HVAC_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir end of topic ===
    ${lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_start}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex start of topic ===
    ${lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_end}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex end of topic ===
    ${lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_list}=    Get Slice From List    ${full_list}    start=${lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_start}    end=${lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_end + 1}
    Log Many    ${lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_list}
    Should Contain    ${lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_list}    === HVAC_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex start of topic ===
    Should Contain    ${lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_list}    === HVAC_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex end of topic ===
    ${lsstBarraoblPiso01BarraoblChiller01_start}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso01BarraoblChiller01 start of topic ===
    ${lsstBarraoblPiso01BarraoblChiller01_end}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso01BarraoblChiller01 end of topic ===
    ${lsstBarraoblPiso01BarraoblChiller01_list}=    Get Slice From List    ${full_list}    start=${lsstBarraoblPiso01BarraoblChiller01_start}    end=${lsstBarraoblPiso01BarraoblChiller01_end + 1}
    Log Many    ${lsstBarraoblPiso01BarraoblChiller01_list}
    Should Contain    ${lsstBarraoblPiso01BarraoblChiller01_list}    === HVAC_lsstBarraoblPiso01BarraoblChiller01 start of topic ===
    Should Contain    ${lsstBarraoblPiso01BarraoblChiller01_list}    === HVAC_lsstBarraoblPiso01BarraoblChiller01 end of topic ===
    ${lsstBarraoblPiso02BarraoblCrack01_start}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso02BarraoblCrack01 start of topic ===
    ${lsstBarraoblPiso02BarraoblCrack01_end}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso02BarraoblCrack01 end of topic ===
    ${lsstBarraoblPiso02BarraoblCrack01_list}=    Get Slice From List    ${full_list}    start=${lsstBarraoblPiso02BarraoblCrack01_start}    end=${lsstBarraoblPiso02BarraoblCrack01_end + 1}
    Log Many    ${lsstBarraoblPiso02BarraoblCrack01_list}
    Should Contain    ${lsstBarraoblPiso02BarraoblCrack01_list}    === HVAC_lsstBarraoblPiso02BarraoblCrack01 start of topic ===
    Should Contain    ${lsstBarraoblPiso02BarraoblCrack01_list}    === HVAC_lsstBarraoblPiso02BarraoblCrack01 end of topic ===
    ${lsstBarraoblPiso02BarraoblFancoil01_start}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso02BarraoblFancoil01 start of topic ===
    ${lsstBarraoblPiso02BarraoblFancoil01_end}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso02BarraoblFancoil01 end of topic ===
    ${lsstBarraoblPiso02BarraoblFancoil01_list}=    Get Slice From List    ${full_list}    start=${lsstBarraoblPiso02BarraoblFancoil01_start}    end=${lsstBarraoblPiso02BarraoblFancoil01_end + 1}
    Log Many    ${lsstBarraoblPiso02BarraoblFancoil01_list}
    Should Contain    ${lsstBarraoblPiso02BarraoblFancoil01_list}    === HVAC_lsstBarraoblPiso02BarraoblFancoil01 start of topic ===
    Should Contain    ${lsstBarraoblPiso02BarraoblFancoil01_list}    === HVAC_lsstBarraoblPiso02BarraoblFancoil01 end of topic ===
    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_start}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01 start of topic ===
    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_end}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01 end of topic ===
    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}=    Get Slice From List    ${full_list}    start=${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_start}    end=${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_end + 1}
    Log Many    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}
    Should Contain    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}    === HVAC_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01 start of topic ===
    Should Contain    ${lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01_list}    === HVAC_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower01 end of topic ===
    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_start}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca start of topic ===
    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_end}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca end of topic ===
    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}=    Get Slice From List    ${full_list}    start=${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_start}    end=${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_end + 1}
    Log Many    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}
    Should Contain    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}    === HVAC_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca start of topic ===
    Should Contain    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_list}    === HVAC_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca end of topic ===
    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia_start}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia start of topic ===
    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia_end}=    Get Index From List    ${full_list}    === HVAC_lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia end of topic ===
    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia_list}=    Get Slice From List    ${full_list}    start=${lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia_start}    end=${lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia_end + 1}
    Log Many    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia_list}
    Should Contain    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia_list}    === HVAC_lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia start of topic ===
    Should Contain    ${lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia_list}    === HVAC_lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia end of topic ===
