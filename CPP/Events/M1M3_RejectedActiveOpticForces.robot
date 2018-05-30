*** Settings ***
Documentation    M1M3_RejectedActiveOpticForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedActiveOpticForces
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_log

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage :  input parameters...

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Logger.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_log
    ${output}=    Read Until    logger ready =
    Log    ${output}
    Should Contain    ${output}    Event ${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 94.4086 0.248705 0.036561 0.119683 0.091939 0.638339 0.615264 0.366209 0.28228 0.493891 0.419361 0.398342 0.417671 0.411035 0.358164 0.533304 0.927736 0.817861 0.737402 0.694121 0.59839 0.237311 0.749791 0.103353 0.495939 0.615271 0.186972 0.738197 0.58983 0.616361 0.289089 0.438317 0.547418 0.129766 0.559931 0.492202 0.547174 0.527459 0.632888 0.551176 0.512381 0.803306 0.439088 0.427143 0.668092 0.643204 0.041944 0.412263 0.9108 0.165162 0.966675 0.781271 0.228256 0.801745 0.847591 0.225223 0.090483 0.824978 0.347592 0.863106 0.52512 0.072578 0.852912 0.70639 0.206006 0.613758 0.065741 0.948101 0.958079 0.055933 0.094013 0.96618 0.413594 0.657999 0.298357 0.739766 0.232343 0.731617 0.607841 0.852145 0.169656 0.332886 0.758387 0.858594 0.396503 0.920261 0.863654 0.032211 0.831841 0.507123 0.778387 0.710079 0.808044 0.28363 0.613813 0.324602 0.790998 0.568753 0.710067 0.557933 0.464296 0.489032 0.544907 0.964906 0.804515 0.612573 0.136396 0.554009 0.930147 0.463133 0.803431 0.764666 0.97667 0.144051 0.488455 0.766027 0.382859 0.517068 0.59151 0.499061 0.38588 0.659307 0.568053 0.829028 0.962597 0.977293 0.818236 0.75423 0.517182 0.61468 0.161102 0.001453 0.406057 0.140725 0.078991 0.422891 0.369165 0.097602 0.05886 0.118469 0.508356 0.47143 0.597471 0.10667 0.433878 0.768937 0.0657 0.784712 0.643512 0.179019 0.373303 0.570041 0.823845 0.980084 0.250728 0.044109 0.76876 0.596034 0.470378 0.102113 1390587880
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedActiveOpticForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1390587880
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedActiveOpticForces received =     1
    Should Contain    ${output}    Timestamp : 94.4086
    Should Contain    ${output}    ZForces : 0.248705
    Should Contain    ${output}    Fz : 0.036561
    Should Contain    ${output}    Mx : 0.119683
    Should Contain    ${output}    My : 0.091939
    Should Contain    ${output}    priority : 0.638339
