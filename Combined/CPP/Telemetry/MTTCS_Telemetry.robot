*** Settings ***
Documentation    MTTCS Telemetry communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTTCS
${component}    all
${timeout}    30s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber

Start Subscriber
    [Tags]    functional
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=Subscriber
    Log    ${output}
    Should Contain    "${output}"   "1"

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_kernelPointingModel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_kernelPointingModel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTTCS_kernelPointingModel start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::kernelPointingModel_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTTCS_kernelPointingModel end of topic ===
    Comment    ======= Verify ${subSystem}_aOCS test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_aOCS
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTTCS_aOCS start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::aOCS_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTTCS_aOCS end of topic ===
    Comment    ======= Verify ${subSystem}_kernelTimeKeeper test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_kernelTimeKeeper
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTTCS_kernelTimeKeeper start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::kernelTimeKeeper_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTTCS_kernelTimeKeeper end of topic ===
    Comment    ======= Verify ${subSystem}_kernelSite test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_kernelSite
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTTCS_kernelSite start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::kernelSite_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTTCS_kernelSite end of topic ===
    Comment    ======= Verify ${subSystem}_kernelTarget test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_kernelTarget
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTTCS_kernelTarget start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::kernelTarget_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTTCS_kernelTarget end of topic ===
    Comment    ======= Verify ${subSystem}_kernelPointingControl test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_kernelPointingControl
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTTCS_kernelPointingControl start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::kernelPointingControl_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTTCS_kernelPointingControl end of topic ===
    Comment    ======= Verify ${subSystem}_kernelTrackRefSys test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_kernelTrackRefSys
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTTCS_kernelTrackRefSys start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::kernelTrackRefSys_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTTCS_kernelTrackRefSys end of topic ===
    Comment    ======= Verify ${subSystem}_zEMAX test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_zEMAX
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTTCS_zEMAX start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::zEMAX_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTTCS_zEMAX end of topic ===
    Comment    ======= Verify ${subSystem}_kernelPointingLog test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_kernelPointingLog
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTTCS_kernelPointingLog start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::kernelPointingLog_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTTCS_kernelPointingLog end of topic ===
    Comment    ======= Verify ${subSystem}_kernelDawdleFilter test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_kernelDawdleFilter
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTTCS_kernelDawdleFilter start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::kernelDawdleFilter_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTTCS_kernelDawdleFilter end of topic ===
    Comment    ======= Verify ${subSystem}_kernelOpticsVt test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_kernelOpticsVt
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTTCS_kernelOpticsVt start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::kernelOpticsVt_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTTCS_kernelOpticsVt end of topic ===
    Comment    ======= Verify ${subSystem}_wEP test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_wEP
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTTCS_wEP start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::wEP_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTTCS_wEP end of topic ===
    Comment    ======= Verify ${subSystem}_kernelTrackingTarget test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_kernelTrackingTarget
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTTCS_kernelTrackingTarget start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::kernelTrackingTarget_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTTCS_kernelTrackingTarget end of topic ===
    Comment    ======= Verify ${subSystem}_kernelFK5Target test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_kernelFK5Target
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTTCS_kernelFK5Target start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::kernelFK5Target_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTTCS_kernelFK5Target end of topic ===
    Comment    ======= Verify ${subSystem}_loopTime test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_loopTime
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTTCS_loopTime start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::loopTime_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTTCS_loopTime end of topic ===
    Comment    ======= Verify ${subSystem}_timestamp test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_timestamp
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTTCS_timestamp start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::timestamp_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTTCS_timestamp end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTTCS subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${kernelPointingModel_start}=    Get Index From List    ${full_list}    === MTTCS_kernelPointingModel start of topic ===
    ${kernelPointingModel_end}=    Get Index From List    ${full_list}    === MTTCS_kernelPointingModel end of topic ===
    ${kernelPointingModel_list}=    Get Slice From List    ${full_list}    start=${kernelPointingModel_start}    end=${kernelPointingModel_end}
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coeffv : 0    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coeffv : 1    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coeffv : 2    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coeffv : 3    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coeffv : 4    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coeffv : 5    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coeffv : 6    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coeffv : 7    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coeffv : 8    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coeffv : 9    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}model : 0    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}model : 1    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}model : 2    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}model : 3    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}model : 4    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}model : 5    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}model : 6    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}model : 7    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}model : 8    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}model : 9    1
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nTerml : 1    10
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nTerms : 1    10
    Should Contain X Times    ${kernelPointingModel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nTermx : 1    10
    ${aOCS_start}=    Get Index From List    ${full_list}    === MTTCS_aOCS start of topic ===
    ${aOCS_end}=    Get Index From List    ${full_list}    === MTTCS_aOCS end of topic ===
    ${aOCS_list}=    Get Slice From List    ${full_list}    start=${aOCS_start}    end=${aOCS_end}
    Should Contain X Times    ${aOCS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}result : LSST    10
    ${kernelTimeKeeper_start}=    Get Index From List    ${full_list}    === MTTCS_kernelTimeKeeper start of topic ===
    ${kernelTimeKeeper_end}=    Get Index From List    ${full_list}    === MTTCS_kernelTimeKeeper end of topic ===
    ${kernelTimeKeeper_list}=    Get Slice From List    ${full_list}    start=${kernelTimeKeeper_start}    end=${kernelTimeKeeper_end}
    Should Contain X Times    ${kernelTimeKeeper_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cst : 1    10
    Should Contain X Times    ${kernelTimeKeeper_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dcst : 1    10
    Should Contain X Times    ${kernelTimeKeeper_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dsst : 1    10
    Should Contain X Times    ${kernelTimeKeeper_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sst : 1    10
    Should Contain X Times    ${kernelTimeKeeper_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tai : 1    10
    Should Contain X Times    ${kernelTimeKeeper_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tt : 1    10
    ${kernelSite_start}=    Get Index From List    ${full_list}    === MTTCS_kernelSite start of topic ===
    ${kernelSite_end}=    Get Index From List    ${full_list}    === MTTCS_kernelSite end of topic ===
    ${kernelSite_list}=    Get Slice From List    ${full_list}    start=${kernelSite_start}    end=${kernelSite_end}
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 0    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 1    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 2    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 3    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 4    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 5    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 6    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 7    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 8    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 9    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aoprms : 0    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aoprms : 1    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aoprms : 2    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aoprms : 3    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aoprms : 4    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aoprms : 5    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aoprms : 6    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aoprms : 7    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aoprms : 8    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aoprms : 9    1
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}daz : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}diurab : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elong : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lat : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refa : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refb : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}st0 : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}t0 : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tt0 : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ttj : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ttmtai : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}uau : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ukm : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vau : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vkm : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}delat : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}delut : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elongm : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hm : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}latm : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tai : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ttmtat : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xpm : 1    10
    Should Contain X Times    ${kernelSite_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ypm : 1    10
    ${kernelTarget_start}=    Get Index From List    ${full_list}    === MTTCS_kernelTarget start of topic ===
    ${kernelTarget_end}=    Get Index From List    ${full_list}    === MTTCS_kernelTarget end of topic ===
    ${kernelTarget_list}=    Get Slice From List    ${full_list}    start=${kernelTarget_start}    end=${kernelTarget_end}
    Should Contain X Times    ${kernelTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}humid : 1    10
    Should Contain X Times    ${kernelTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}press : 1    10
    Should Contain X Times    ${kernelTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tLR : 1    10
    Should Contain X Times    ${kernelTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tai : 1    10
    Should Contain X Times    ${kernelTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 1    10
    Should Contain X Times    ${kernelTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wavel : 1    10
    Should Contain X Times    ${kernelTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xOffset : 1    10
    Should Contain X Times    ${kernelTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yOffset : 1    10
    Should Contain X Times    ${kernelTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}az : 1    10
    Should Contain X Times    ${kernelTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azdot : 1    10
    Should Contain X Times    ${kernelTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}el : 1    10
    Should Contain X Times    ${kernelTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}eldot : 1    10
    Should Contain X Times    ${kernelTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}focalPlaneX : 1    10
    Should Contain X Times    ${kernelTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}focalPlaneY : 1    10
    Should Contain X Times    ${kernelTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}t0 : 1    10
    ${kernelPointingControl_start}=    Get Index From List    ${full_list}    === MTTCS_kernelPointingControl start of topic ===
    ${kernelPointingControl_end}=    Get Index From List    ${full_list}    === MTTCS_kernelPointingControl end of topic ===
    ${kernelPointingControl_list}=    Get Slice From List    ${full_list}    start=${kernelPointingControl_start}    end=${kernelPointingControl_end}
    Should Contain X Times    ${kernelPointingControl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aGuide : 1    10
    Should Contain X Times    ${kernelPointingControl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aLocal : 1    10
    Should Contain X Times    ${kernelPointingControl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bGuide : 1    10
    Should Contain X Times    ${kernelPointingControl_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bLocal : 1    10
    ${kernelTrackRefSys_start}=    Get Index From List    ${full_list}    === MTTCS_kernelTrackRefSys start of topic ===
    ${kernelTrackRefSys_end}=    Get Index From List    ${full_list}    === MTTCS_kernelTrackRefSys end of topic ===
    ${kernelTrackRefSys_list}=    Get Slice From List    ${full_list}    start=${kernelTrackRefSys_start}    end=${kernelTrackRefSys_end}
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ae2mt : 0    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ae2mt : 1    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ae2mt : 2    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ae2mt : 3    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ae2mt : 4    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ae2mt : 5    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ae2mt : 6    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ae2mt : 7    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ae2mt : 8    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ae2mt : 9    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 0    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 1    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 2    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 3    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 4    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 5    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 6    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 7    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 8    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}amprms : 9    1
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cst : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}diurab : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hm : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}humid : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}press : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refa : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refb : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sst : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tdbj : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tlat : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tlr : 1    10
    Should Contain X Times    ${kernelTrackRefSys_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wavel : 1    10
    ${zEMAX_start}=    Get Index From List    ${full_list}    === MTTCS_zEMAX start of topic ===
    ${zEMAX_end}=    Get Index From List    ${full_list}    === MTTCS_zEMAX end of topic ===
    ${zEMAX_list}=    Get Slice From List    ${full_list}    start=${zEMAX_start}    end=${zEMAX_end}
    Should Contain X Times    ${zEMAX_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bgAlgorithm : LSST    10
    Should Contain X Times    ${zEMAX_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposure : 1    10
    Should Contain X Times    ${zEMAX_list}    ${SPACE}${SPACE}${SPACE}${SPACE}iterations : 1    10
    ${kernelPointingLog_start}=    Get Index From List    ${full_list}    === MTTCS_kernelPointingLog start of topic ===
    ${kernelPointingLog_end}=    Get Index From List    ${full_list}    === MTTCS_kernelPointingLog end of topic ===
    ${kernelPointingLog_list}=    Get Slice From List    ${full_list}    start=${kernelPointingLog_start}    end=${kernelPointingLog_end}
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aux : 0    1
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aux : 1    1
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aux : 2    1
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aux : 3    1
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aux : 4    1
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aux : 5    1
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aux : 6    1
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aux : 7    1
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aux : 8    1
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aux : 9    1
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}casspa : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decl : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fl : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}humid : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}marked : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pitch : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}press : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rcorr : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}roll : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tlr : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wavel : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xr : 1    10
    Should Contain X Times    ${kernelPointingLog_list}    ${SPACE}${SPACE}${SPACE}${SPACE}yr : 1    10
    ${kernelDawdleFilter_start}=    Get Index From List    ${full_list}    === MTTCS_kernelDawdleFilter start of topic ===
    ${kernelDawdleFilter_end}=    Get Index From List    ${full_list}    === MTTCS_kernelDawdleFilter end of topic ===
    ${kernelDawdleFilter_list}=    Get Slice From List    ${full_list}    start=${kernelDawdleFilter_start}    end=${kernelDawdleFilter_end}
    Should Contain X Times    ${kernelDawdleFilter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bypass : 1    10
    Should Contain X Times    ${kernelDawdleFilter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}t : 1    10
    ${kernelOpticsVt_start}=    Get Index From List    ${full_list}    === MTTCS_kernelOpticsVt start of topic ===
    ${kernelOpticsVt_end}=    Get Index From List    ${full_list}    === MTTCS_kernelOpticsVt end of topic ===
    ${kernelOpticsVt_list}=    Get Slice From List    ${full_list}    start=${kernelOpticsVt_start}    end=${kernelOpticsVt_end}
    Should Contain X Times    ${kernelOpticsVt_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tilt : 1    10
    Should Contain X Times    ${kernelOpticsVt_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tip : 1    10
    ${wEP_start}=    Get Index From List    ${full_list}    === MTTCS_wEP start of topic ===
    ${wEP_end}=    Get Index From List    ${full_list}    === MTTCS_wEP end of topic ===
    ${wEP_list}=    Get Slice From List    ${full_list}    start=${wEP_start}    end=${wEP_end}
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}basisSetName : LSST    10
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numberOfTerms : 1    10
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr1 : 0    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr1 : 1    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr1 : 2    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr1 : 3    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr1 : 4    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr1 : 5    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr1 : 6    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr1 : 7    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr1 : 8    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr1 : 9    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr2 : 0    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr2 : 1    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr2 : 2    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr2 : 3    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr2 : 4    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr2 : 5    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr2 : 6    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr2 : 7    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr2 : 8    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr2 : 9    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr3 : 0    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr3 : 1    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr3 : 2    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr3 : 3    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr3 : 4    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr3 : 5    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr3 : 6    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr3 : 7    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr3 : 8    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr3 : 9    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr4 : 0    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr4 : 1    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr4 : 2    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr4 : 3    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr4 : 4    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr4 : 5    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr4 : 6    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr4 : 7    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr4 : 8    1
    Should Contain X Times    ${wEP_list}    ${SPACE}${SPACE}${SPACE}${SPACE}zArr4 : 9    1
    ${kernelTrackingTarget_start}=    Get Index From List    ${full_list}    === MTTCS_kernelTrackingTarget start of topic ===
    ${kernelTrackingTarget_end}=    Get Index From List    ${full_list}    === MTTCS_kernelTrackingTarget end of topic ===
    ${kernelTrackingTarget_list}=    Get Slice From List    ${full_list}    start=${kernelTrackingTarget_start}    end=${kernelTrackingTarget_end}
    Should Contain X Times    ${kernelTrackingTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionX : 1    10
    Should Contain X Times    ${kernelTrackingTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionY : 1    10
    Should Contain X Times    ${kernelTrackingTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}t0 : 1    10
    Should Contain X Times    ${kernelTrackingTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocityX : 1    10
    Should Contain X Times    ${kernelTrackingTarget_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocityY : 1    10
    ${kernelFK5Target_start}=    Get Index From List    ${full_list}    === MTTCS_kernelFK5Target start of topic ===
    ${kernelFK5Target_end}=    Get Index From List    ${full_list}    === MTTCS_kernelFK5Target end of topic ===
    ${kernelFK5Target_list}=    Get Slice From List    ${full_list}    start=${kernelFK5Target_start}    end=${kernelFK5Target_end}
    Should Contain X Times    ${kernelFK5Target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decl : 1    10
    Should Contain X Times    ${kernelFK5Target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}epoc : 1    10
    Should Contain X Times    ${kernelFK5Target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}equinox : 1    10
    Should Contain X Times    ${kernelFK5Target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}parallax : 1    10
    Should Contain X Times    ${kernelFK5Target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pmDec : 1    10
    Should Contain X Times    ${kernelFK5Target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pmRA : 1    10
    Should Contain X Times    ${kernelFK5Target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ra : 1    10
    Should Contain X Times    ${kernelFK5Target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rv : 1    10
    ${loopTime_start}=    Get Index From List    ${full_list}    === MTTCS_loopTime start of topic ===
    ${loopTime_end}=    Get Index From List    ${full_list}    === MTTCS_loopTime end of topic ===
    ${loopTime_list}=    Get Slice From List    ${full_list}    start=${loopTime_start}    end=${loopTime_end}
    Should Contain X Times    ${loopTime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}loopTime : 1    10
    ${timestamp_start}=    Get Index From List    ${full_list}    === MTTCS_timestamp start of topic ===
    ${timestamp_end}=    Get Index From List    ${full_list}    === MTTCS_timestamp end of topic ===
    ${timestamp_list}=    Get Slice From List    ${full_list}    start=${timestamp_start}    end=${timestamp_end}
    Should Contain X Times    ${timestamp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
