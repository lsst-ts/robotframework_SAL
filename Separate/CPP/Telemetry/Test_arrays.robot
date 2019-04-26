*** Settings ***
Documentation    Test Arrays communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Test
${component}    arrays
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
    Should Contain    ${output}    ===== Test subscribers ready =====
    Sleep    6s

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_arrays test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_arrays
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Test subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 1    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 2    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 3    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 4    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 5    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 6    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 7    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 8    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boolean0 : 9    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x00    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x01    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x02    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x03    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x04    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x05    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x06    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x07    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x08    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byte0 : \x09    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}char0 : LSST    10
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 1    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 2    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 3    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 4    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 5    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 6    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 7    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 8    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}short0 : 9    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 1    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 2    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 3    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 4    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 5    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 6    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 7    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 8    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}int0 : 9    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 1    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 2    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 3    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 4    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 5    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 6    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 7    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 8    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}long0 : 9    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 1    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 2    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 3    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 4    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 5    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 6    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 7    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 8    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}longLong0 : 9    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}octet0 : \x00    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}octet0 : \x01    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}octet0 : \x02    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}octet0 : \x03    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}octet0 : \x04    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}octet0 : \x05    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}octet0 : \x06    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}octet0 : \x07    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}octet0 : \x08    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}octet0 : \x09    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 1    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 2    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 3    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 4    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 5    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 6    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 7    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 8    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedShort0 : 9    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 1    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 2    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 3    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 4    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 5    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 6    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 7    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 8    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedInt0 : 9    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedLong0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedLong0 : 1    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedLong0 : 2    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedLong0 : 3    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedLong0 : 4    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedLong0 : 5    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedLong0 : 6    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedLong0 : 7    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedLong0 : 8    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unsignedLong0 : 9    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 1    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 2    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 3    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 4    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 5    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 6    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 7    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 8    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}float0 : 9    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 0    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 1    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 2    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 3    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 4    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 5    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 6    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 7    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 8    1
    Should Contain X Times    ${arrays_list}    ${SPACE}${SPACE}${SPACE}${SPACE}double0 : 9    1
