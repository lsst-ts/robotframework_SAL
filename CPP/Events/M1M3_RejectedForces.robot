*** Settings ***
Documentation    M1M3_RejectedForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 67.1667 0.655689 0.734339 0.851982 0.511654 0.407565 0.333938 0.20754 0.603897 0.948308 0.142303 0.733696 0.820389 0.007197 0.992509 0.068019 0.819241 0.214704 0.725251 0.841828 0.536976 0.415911 0.08584 0.799474 0.976532 0.771728 0.785145 0.672119 0.009089 0.730001 0.08949 0.52938 0.705514 0.062987 0.844067 0.764563 0.294068 0.760969 0.50192 0.085493 0.569139 0.053493 0.713871 0.790294 0.107691 0.538019 0.573128 0.561214 0.468581 0.892056 0.079248 0.965146 0.31978 0.698269 0.523362 0.020889 0.426778 0.559138 0.818289 0.2214 0.976805 0.408544 0.20773 0.457761 0.370055 0.308751 0.36478 0.626004 0.795408 0.277529 0.273449 0.888201 0.797115 0.904573 0.564217 0.254962 0.571242 0.396934 0.141576 0.591722 0.961126 0.329229 0.112182 0.553479 0.374982 0.32314 0.516785 0.269885 0.606319 0.222914 0.489477 0.962389 0.921855 0.150192 0.374392 0.760628 0.766049 0.453554 0.604507 0.922444 0.440211 0.318877 0.652062 0.633505 0.244582 0.675705 0.177729 0.830206 0.861116 0.830465 0.36046 0.028579 0.0566 0.315512 0.465752 0.561799 0.35725 0.125027 0.830106 0.346337 0.011212 0.114048 0.165632 0.144085 0.681395 0.399753 0.002215 0.145925 0.062859 0.195467 0.820291 0.927665 0.998394 0.555342 0.714001 0.014491 0.676993 0.497189 0.308668 0.682772 0.823253 0.788633 0.545164 0.167362 0.822046 0.372112 0.543145 0.534431 0.997778 0.076321 0.153295 0.096503 0.992795 0.528829 0.390683 0.467485 0.26361 0.624356 0.401173 0.647126 0.105909 0.499012 0.509275 0.805723 0.168689 0.195906 0.19298 0.758145 0.049676 0.022872 0.6203 0.706087 0.789799 0.753272 0.562046 0.072864 0.162653 0.355873 0.836448 0.624287 0.15208 0.020308 0.734321 0.965084 0.326121 0.737821 0.647058 0.631844 0.901337 0.366734 0.292966 0.434921 0.635593 0.404446 0.217041 0.560191 0.090534 0.623352 0.824332 0.413173 0.50506 0.347049 0.249693 0.285277 0.649643 0.074565 0.941222 0.91625 0.043862 0.859892 0.617943 0.250527 0.915338 0.96979 0.292092 0.220774 0.880107 0.351243 0.319802 0.819786 0.025442 0.206622 0.486558 0.953886 0.580137 0.015049 0.518339 0.856409 0.699488 0.495086 0.897937 0.306825 0.691347 0.411749 0.345658 0.7315 0.813949 0.691617 0.770858 0.416481 0.286511 0.719251 0.810663 0.531917 0.409955 0.254784 0.387935 0.10159 0.503353 0.436477 0.088499 0.078452 0.652295 0.447653 0.886044 0.998736 0.335428 0.794987 0.42187 0.369319 0.159584 0.586621 0.115542 0.564734 0.024044 0.197777 0.267639 0.437309 0.689748 0.354259 0.13264 0.514441 0.096747 0.447218 0.918317 0.193103 738572633
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 738572633
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedForces received =     1
    Should Contain    ${output}    Timestamp : 67.1667
    Should Contain    ${output}    XForces : 0.655689
    Should Contain    ${output}    YForces : 0.734339
    Should Contain    ${output}    ZForces : 0.851982
    Should Contain    ${output}    Fx : 0.511654
    Should Contain    ${output}    Fy : 0.407565
    Should Contain    ${output}    Fz : 0.333938
    Should Contain    ${output}    Mx : 0.20754
    Should Contain    ${output}    My : 0.603897
    Should Contain    ${output}    Mz : 0.948308
    Should Contain    ${output}    ForceMagnitude : 0.142303
    Should Contain    ${output}    priority : 0.733696
