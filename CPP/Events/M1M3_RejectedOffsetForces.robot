*** Settings ***
Documentation    M1M3_RejectedOffsetForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedOffsetForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 41.1331 0.943717 0.200616 0.204254 0.818999 0.807711 0.226057 0.492674 0.636381 0.754262 0.838447 0.277093 0.78411 0.580576 0.3123 0.320996 0.704286 0.643305 0.500602 0.243383 0.819124 0.134364 0.158212 0.755042 0.880014 0.138617 0.424961 0.908667 0.661153 0.552187 0.624054 0.249284 0.181914 0.351075 0.916489 0.438748 0.793905 0.728504 0.480288 0.973249 0.387125 0.719944 0.755027 0.001389 0.198173 0.544149 0.902251 0.829547 0.485381 0.518891 0.654489 0.305751 0.210538 0.150414 0.078512 0.767656 0.613173 0.12988 0.408463 0.216416 0.297842 0.700749 0.25065 0.692104 0.340521 0.992925 0.335835 0.025857 0.651623 0.491653 0.053052 0.373841 0.576968 0.074645 0.863703 0.507199 0.886173 0.806244 0.532825 0.756713 0.842678 0.505577 0.842529 0.587058 0.710543 0.31118 0.755227 0.621137 0.001267 0.081622 0.175428 0.925637 0.245295 0.75075 0.944322 0.491438 0.986003 0.247599 0.212874 0.056919 0.160229 0.332708 0.964773 0.671721 0.317486 0.967471 0.87645 0.818144 0.932694 0.117332 0.588234 0.386779 0.917357 0.714741 0.723467 0.378641 0.829956 0.514654 0.816003 0.396617 0.076233 0.359568 0.682533 0.433333 0.844092 0.6903 0.183471 0.127648 0.86027 0.894334 0.354612 0.013836 0.779824 0.726522 0.692389 0.903249 0.73345 0.212977 0.474989 0.400956 0.61158 0.442055 0.811248 0.412493 0.31759 0.213433 0.877057 0.807379 0.546786 0.514716 0.316595 0.521239 0.991639 0.709011 0.786582 0.71891 0.452292 0.003856 0.533937 0.922016 0.803485 0.208882 0.198584 0.407991 0.884459 0.861614 0.516428 0.852394 0.661572 0.57364 0.014203 0.066824 0.143578 0.255429 0.584116 0.114657 0.44788 0.411778 0.68636 0.473573 0.386151 0.900667 0.156448 0.870558 0.677275 0.142285 0.277777 0.659067 0.194151 0.39357 0.857071 0.177224 0.228543 0.1131 0.535362 0.447895 0.770521 0.268345 0.166347 0.381141 0.36643 0.499724 0.644598 0.641514 0.132066 0.763044 0.039943 0.850022 0.193573 0.667391 0.222873 0.319769 0.147617 0.223315 0.917256 0.661857 0.679711 0.704767 0.272005 0.760829 0.49234 0.29487 0.942263 0.861333 0.424595 0.743132 0.959132 0.430777 0.032742 0.243757 0.261544 0.819215 0.670339 0.437795 0.698685 0.423489 0.823762 0.856466 0.272336 0.444154 0.879131 0.368935 0.541256 0.255632 0.08097 0.357158 0.333668 0.859438 0.163888 0.560857 0.721561 0.251921 0.506645 0.611445 0.833625 0.368436 0.789784 0.027879 0.587984 0.272558 0.35003 0.782277 0.600935 0.891855 0.224314 0.066366 0.510555 0.376017 0.895924 0.279251 0.321268 0.536295 0.055925 0.661258 0.741829 0.4429 373139672
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedOffsetForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedOffsetForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 373139672
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedOffsetForces received =     1
    Should Contain    ${output}    Timestamp : 41.1331
    Should Contain    ${output}    XForces : 0.943717
    Should Contain    ${output}    YForces : 0.200616
    Should Contain    ${output}    ZForces : 0.204254
    Should Contain    ${output}    Fx : 0.818999
    Should Contain    ${output}    Fy : 0.807711
    Should Contain    ${output}    Fz : 0.226057
    Should Contain    ${output}    Mx : 0.492674
    Should Contain    ${output}    My : 0.636381
    Should Contain    ${output}    Mz : 0.754262
    Should Contain    ${output}    ForceMagnitude : 0.838447
    Should Contain    ${output}    priority : 0.277093
