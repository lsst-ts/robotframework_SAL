*** Settings ***
Documentation    MTM1M3 AccelerometerData communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTM1M3
${component}    accelerometerData
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
    Comment    ======= Verify ${subSystem}_powerData test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_accelerometerData
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTM1M3 subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    10
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAccelerometers : 0    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAccelerometers : 1    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAccelerometers : 2    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAccelerometers : 3    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAccelerometers : 4    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAccelerometers : 5    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAccelerometers : 6    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAccelerometers : 7    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAccelerometers : 8    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rawAccelerometers : 9    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometers : 0    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometers : 1    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometers : 2    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometers : 3    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometers : 4    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometers : 5    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometers : 6    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometers : 7    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometers : 8    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometers : 9    1
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}angularAccelerationX : 1    10
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}angularAccelerationY : 1    10
    Should Contain X Times    ${accelerometerData_list}    ${SPACE}${SPACE}${SPACE}${SPACE}angularAccelerationZ : 1    10
