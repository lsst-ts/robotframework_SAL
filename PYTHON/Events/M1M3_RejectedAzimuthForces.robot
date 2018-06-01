*** Settings ***
Documentation    M1M3_RejectedAzimuthForces communications tests.
Force Tags    python    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedAzimuthForces
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp XForces YForces ZForces Fx Fy Fz Mx My Mz ForceMagnitude priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 86.07 0.694171 0.171017 0.308984 0.681636 0.809627 0.384006 0.155575 0.550116 0.879197 0.144323 0.109624 0.932867 0.222052 0.610122 0.399195 0.793886 0.437966 0.718956 0.414049 0.602269 0.197235 0.656831 0.012835 0.171213 0.349716 0.334749 0.249002 0.409269 0.43379 0.556653 0.467847 0.971656 0.480605 0.887623 0.404788 0.62499 0.253275 0.20214 0.796689 0.449207 0.022468 0.587285 0.585912 0.693571 0.697451 0.826566 0.695515 0.125436 0.587958 0.425943 0.642209 0.967874 0.026376 0.071643 0.099914 0.19551 0.774389 0.096245 0.514718 0.091092 0.046242 0.40701 0.556861 0.057193 0.575083 0.948363 0.336254 0.571593 0.617351 0.286867 0.825016 0.337441 0.609133 0.400848 0.950348 0.837788 0.902364 0.982116 0.394964 0.555892 0.526181 0.81649 0.986699 0.987604 0.143433 0.803139 0.910103 0.11598 0.348611 0.425047 0.838977 0.706345 0.328484 0.88072 0.130531 0.747421 0.674647 0.77842 0.270126 0.723484 0.284536 0.9357 0.407767 0.594128 0.601784 0.498947 0.377052 0.536355 0.395256 0.394358 0.767111 0.716813 0.944117 0.060328 0.88574 0.663266 0.120772 0.430528 0.153006 0.728885 0.765741 0.073347 0.663667 0.040879 0.798912 0.343821 0.819023 0.675986 0.064068 0.561887 0.805164 0.738737 0.217085 0.951947 0.808523 0.048494 0.606585 0.2678 0.606316 0.130594 0.222721 0.118184 0.359439 0.94374 0.562024 0.351403 0.162617 0.763435 0.927248 0.892948 0.79661 0.611603 0.683168 0.524901 0.229628 0.982541 0.759482 0.977791 0.537666 0.358265 0.489687 0.033385 0.383852 0.738613 0.044699 0.887952 0.291063 0.481738 0.022195 0.691817 0.574255 0.796119 0.426686 0.637349 0.350892 0.142217 0.798397 0.212165 0.40299 0.628898 0.845961 0.962486 0.491735 0.371863 0.559288 0.739384 0.73926 0.0424 0.138192 0.928469 0.156894 0.959669 0.946214 0.012924 0.594814 0.801152 0.0132 0.111314 0.28637 0.262862 0.783378 0.851729 0.9341 0.017686 0.969004 0.516187 0.253037 0.897725 0.350593 0.421619 0.764664 0.683834 0.963878 0.391959 0.233829 0.320503 0.898975 0.646521 0.209047 0.834668 0.851073 0.534089 0.859116 0.826835 0.903938 0.72297 0.950967 0.02269 0.718236 0.904116 0.619476 0.671544 0.36607 0.415441 0.346933 0.166619 0.521259 0.57295 0.047534 0.972502 0.232409 0.539461 0.313561 0.445447 0.178382 0.925805 0.199033 0.645093 0.397108 0.293522 0.797268 0.118918 0.856321 0.066702 0.507648 0.084653 0.206052 0.812624 0.612814 0.868285 0.441616 0.04915 0.23975 0.729394 0.794349 0.856939 0.104273 0.704206 0.674826 0.535818 0.400413 0.738351 0.599309 0.556414 0.835508 -1642660719
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedAzimuthForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
