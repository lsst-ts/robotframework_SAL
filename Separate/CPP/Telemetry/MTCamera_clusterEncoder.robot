*** Settings ***
Documentation    MTCamera ClusterEncoder communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTCamera
${component}    clusterEncoder
${timeout}    30s

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

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_cold test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_clusterEncoder
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTCamera subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSD : 0    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSD : 1    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSD : 2    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSD : 3    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSD : 4    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSD : 5    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSD : 6    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSD : 7    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSD : 8    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSD : 9    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageMean : 0    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageMean : 1    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageMean : 2    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageMean : 3    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageMean : 4    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageMean : 5    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageMean : 6    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageMean : 7    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageMean : 8    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageMean : 9    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanSD : 0    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanSD : 1    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanSD : 2    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanSD : 3    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanSD : 4    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanSD : 5    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanSD : 6    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanSD : 7    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanSD : 8    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanSD : 9    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanMean : 0    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanMean : 1    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanMean : 2    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanMean : 3    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanMean : 4    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanMean : 5    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanMean : 6    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanMean : 7    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanMean : 8    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanMean : 9    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}psf : 0    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}psf : 1    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}psf : 2    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}psf : 3    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}psf : 4    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}psf : 5    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}psf : 6    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}psf : 7    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}psf : 8    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}psf : 9    1
