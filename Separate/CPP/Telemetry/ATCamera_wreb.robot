*** Settings ***
Documentation    ATCamera Wreb communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATCamera
${component}    wreb
${timeout}    15s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_sub

Start Subscriber
    [Tags]    functional
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_sub    alias=Subscriber
    Log    ${output}
    Should Contain    "${output}"   "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    ===== ATCamera subscribers ready =====
    Sleep    6s

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_wrebPower test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_wreb
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== ATCamera subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ckPSH_V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ckPOV : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ogoV : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}atemp0U : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}atemp0L : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdTemp0 : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rtdTemp : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digPS_V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digPS_I : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaPS_V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaPS_I : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHPS_V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHPS_I : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}odPS_V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}odPS_I : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPS_V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPS_I : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sckU_V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sckL_V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rgU_V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rgL_V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cks0V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rg0V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od0V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rd0V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gd0V : 1    10
    Should Contain X Times    ${wreb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od0I : 1    10
