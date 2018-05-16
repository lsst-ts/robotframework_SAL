*** Settings ***
Documentation    M1M3_AppliedActiveOpticForces sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedActiveOpticForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 24.9941 0.0312640356405 0.417057890454 0.950747465934 0.0939149583662 0.134681251723 0.460636914024 0.0639719475002 0.934671090922 0.370035903772 0.374167945834 0.15487209838 0.84719540341 0.502221031041 0.983182270179 0.909862946532 0.611741709392 0.651498211507 0.167072529834 0.0908659893729 0.471576211926 0.321760819098 0.450213005391 0.757005386996 0.495223758657 0.371242834136 0.976801003408 0.491101667398 0.157408619764 0.222951393805 0.983674968201 0.598872364545 0.476168709584 0.672652675856 0.91568989901 0.61701509715 0.204970085681 0.897582649219 0.945435473777 0.610554365592 0.787694585931 0.561259245367 0.268930645194 0.212565815993 0.0942832172549 0.869474862379 0.339474776082 0.157260005819 0.15081621005 0.162470839399 0.939140049626 0.146431192071 0.300103776075 0.961259151921 0.498510827719 0.11207324286 0.199854175165 0.296737606878 0.198038628063 0.358881887985 0.0443717728267 0.670852602816 0.687283192531 0.479052280774 0.0423240072938 0.804362276672 0.683538863544 0.443389380345 0.553176298751 0.800732009986 0.214865602953 0.372052741955 0.456403616791 0.751248098847 0.0847375080342 0.789235212129 0.638058138239 0.91577506985 0.808765310156 0.592099382794 0.718249687438 0.881779558409 0.73572676477 0.142018602689 0.00471308388157 0.794640772659 0.912470512994 0.984656251702 0.585951616828 0.596344135925 0.348457501252 0.172069008574 0.185716610407 0.470821880455 0.39695739252 0.460268951626 0.0239941036708 0.00468367736434 0.366755167911 0.91815933019 0.636441828744 0.0187288280615 0.713696414177 0.867249883569 0.640699808687 0.239766916695 0.777722615985 0.282177660997 0.849542236775 0.422752385431 0.242858444941 0.00926460846321 0.202946480636 0.992578041615 0.590224902679 0.633150856567 0.482843096113 0.728567048436 0.463077325854 0.454816797716 0.457558774154 0.907047179686 0.383338396854 0.917584469085 0.648818859182 0.00280749816272 0.746615539676 0.177274228027 0.729193080826 0.677932448479 0.448258999726 0.72459392988 0.787006310361 0.101260512013 0.973192842706 0.568375873203 0.973844047621 0.937307830772 0.133326632824 0.529251362869 0.820285539595 0.879128835637 0.55475784434 0.975054117044 0.415017380201 0.449617175518 0.946362601596 0.508081861474 0.896405673642 0.0193996797627 0.332705505826 0.51681143849 0.638273940707 0.39702111974 0.420373825184 0.29058233846 0.402023998869 0.592217618491 0.77588824584 0.21809898024 743863227
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedActiveOpticForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 743863227
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedActiveOpticForces received =     1
    Should Contain    ${output}    Timestamp : 24.9941
    Should Contain    ${output}    ZForces : 0.0312640356405
    Should Contain    ${output}    Fz : 0.417057890454
    Should Contain    ${output}    Mx : 0.950747465934
    Should Contain    ${output}    My : 0.0939149583662
    Should Contain    ${output}    priority : 0.134681251723
