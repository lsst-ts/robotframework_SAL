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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 13.3834 0.399783 0.087266 0.328286 0.599912 0.638216 0.504529 0.674789 0.352734 0.205928 0.060126 0.39895 0.039189 0.013386 0.206026 0.523371 0.332354 0.160327 0.23897 0.321733 0.412817 0.395376 0.733406 0.431781 0.965632 0.652753 0.207564 0.284315 0.339906 0.473883 0.640598 0.000168 0.081735 0.946023 0.970908 0.811585 0.141381 0.161449 0.054882 0.210492 0.624435 0.146739 0.81982 0.022932 0.101296 0.799262 0.277386 0.279994 0.955926 0.694405 0.369307 0.464003 0.022484 0.233529 0.610469 0.161761 0.758058 0.91022 0.312343 0.913068 0.532356 0.259485 0.891336 0.504095 0.0888 0.072171 0.010551 0.560813 0.930284 0.968196 0.636702 0.957758 0.566766 0.56187 0.682602 0.99524 0.14616 0.571424 0.756504 0.351828 0.982777 0.176996 0.941825 0.322404 0.401504 0.283868 0.493889 0.446301 0.462036 0.10838 0.82842 0.99831 0.833175 0.526686 0.990194 0.799612 0.962758 0.509987 0.495557 0.86908 0.996929 0.311209 0.285234 0.546209 0.004961 0.150828 0.362851 0.721776 0.454051 0.805208 0.534211 0.561801 0.970504 0.044928 0.455435 0.403167 0.603089 0.354185 0.829154 0.230016 0.26169 0.320666 0.297891 0.350879 0.388707 0.631695 0.934776 0.066906 0.226966 0.117624 0.54172 0.999193 0.054759 0.430519 0.590487 0.436443 0.100191 0.672801 0.544274 0.65035 0.491804 0.599125 0.192254 0.361282 0.06398 0.468201 0.014543 0.921231 0.811882 0.181251 0.636223 0.886467 0.932398 0.735476 0.544779 0.432027 0.047641 0.143295 0.580167 0.833517 -1154448707
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedActiveOpticForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1154448707
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedActiveOpticForces received =     1
    Should Contain    ${output}    Timestamp : 13.3834
    Should Contain    ${output}    ZForces : 0.399783
    Should Contain    ${output}    Fz : 0.087266
    Should Contain    ${output}    Mx : 0.328286
    Should Contain    ${output}    My : 0.599912
    Should Contain    ${output}    priority : 0.638216
