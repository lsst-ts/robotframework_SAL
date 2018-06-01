*** Settings ***
Documentation    M1M3_ApplyActiveOpticForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    ApplyActiveOpticForces
${timeout}    30s

*** Test Cases ***
Verify Component Commander and Controller
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_controller

Start Commander - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage : \ input parameters...

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 0.698178 0.37269 0.677733 0.431757 0.535009 0.562943 0.351326 0.83864 0.189206 0.502482 0.107295 0.688938 0.505906 0.987671 0.393013 0.479554 0.497904 0.529673 0.271527 0.753956 0.055414 0.983856 0.39947 0.550395 0.306739 0.499176 0.197605 0.861337 0.621494 0.536291 0.052165 0.911518 0.253785 0.99212 0.905691 0.425093 0.368462 0.098071 0.216631 0.284515 0.368583 0.601162 0.282288 0.813048 0.260287 0.476717 0.768572 0.189756 0.268885 0.185221 0.077482 0.329577 0.137407 0.419057 0.673946 0.045472 0.767604 0.296315 0.200212 0.15553 0.301482 0.056658 0.738591 0.585707 0.994449 0.499766 0.906298 0.762891 0.638947 0.088014 0.126407 0.405845 0.50731 0.970715 0.074453 0.2905 0.920549 0.255779 0.266049 0.286564 0.050416 0.856116 0.346766 0.986693 0.698182 0.294621 0.269893 0.755539 0.3606 0.281552 0.826332 0.672547 0.203543 0.434031 0.693086 0.086721 0.00929 0.777162 0.585612 0.23434 0.758018 0.845284 0.177356 0.5591 0.660608 0.089191 0.201755 0.724847 0.127982 0.588468 0.278817 0.03001 0.757123 0.390313 0.601349 0.741545 0.364653 0.926683 0.214011 0.323304 0.1106 0.730899 0.573688 0.685796 0.977768 0.332045 0.386048 0.801125 0.827044 0.735674 0.804831 0.330854 0.945282 0.98141 0.061974 0.261155 0.793716 0.999085 0.860028 0.026343 0.21728 0.678717 0.34316 0.260992 0.856027 0.713192 0.490625 0.883704 0.298826 0.627747 0.635846 0.803691 0.207711 0.550563 0.981728 0.171766
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Controller.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_controller
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 0.698178 0.37269 0.677733 0.431757 0.535009 0.562943 0.351326 0.83864 0.189206 0.502482 0.107295 0.688938 0.505906 0.987671 0.393013 0.479554 0.497904 0.529673 0.271527 0.753956 0.055414 0.983856 0.39947 0.550395 0.306739 0.499176 0.197605 0.861337 0.621494 0.536291 0.052165 0.911518 0.253785 0.99212 0.905691 0.425093 0.368462 0.098071 0.216631 0.284515 0.368583 0.601162 0.282288 0.813048 0.260287 0.476717 0.768572 0.189756 0.268885 0.185221 0.077482 0.329577 0.137407 0.419057 0.673946 0.045472 0.767604 0.296315 0.200212 0.15553 0.301482 0.056658 0.738591 0.585707 0.994449 0.499766 0.906298 0.762891 0.638947 0.088014 0.126407 0.405845 0.50731 0.970715 0.074453 0.2905 0.920549 0.255779 0.266049 0.286564 0.050416 0.856116 0.346766 0.986693 0.698182 0.294621 0.269893 0.755539 0.3606 0.281552 0.826332 0.672547 0.203543 0.434031 0.693086 0.086721 0.00929 0.777162 0.585612 0.23434 0.758018 0.845284 0.177356 0.5591 0.660608 0.089191 0.201755 0.724847 0.127982 0.588468 0.278817 0.03001 0.757123 0.390313 0.601349 0.741545 0.364653 0.926683 0.214011 0.323304 0.1106 0.730899 0.573688 0.685796 0.977768 0.332045 0.386048 0.801125 0.827044 0.735674 0.804831 0.330854 0.945282 0.98141 0.061974 0.261155 0.793716 0.999085 0.860028 0.026343 0.21728 0.678717 0.34316 0.260992 0.856027 0.713192 0.490625 0.883704 0.298826 0.627747 0.635846 0.803691 0.207711 0.550563 0.981728 0.171766
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    ZForces : 0.698178    1
    Should Contain    ${output}    === command ApplyActiveOpticForces issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command ApplyActiveOpticForces received =
    Should Contain    ${output}    device : 
    Should Contain    ${output}    property : 
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    ZForces : 0.698178    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyActiveOpticForces] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
