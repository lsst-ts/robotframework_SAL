*** Settings ***
Documentation    M1M3_RejectedActiveOpticForces sender/logger tests.
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 7.9547 0.923205415877 0.600896198155 0.85188300489 0.0264024980986 0.059654330443 0.685710639203 0.0207847956746 0.995006726032 0.850066489111 0.108291281146 0.502008500482 0.748608077057 0.451212657434 0.309419880146 0.62760210005 0.731688558732 0.334261358717 0.934877735359 0.639360072334 0.0617456732443 0.21901438389 0.402192310948 0.395575684231 0.465980823029 0.773811178536 0.968311627376 0.225538346149 0.470435634509 0.242849585657 0.405310830354 0.330964209122 0.675162203162 0.661849003545 0.362098582042 0.893073531803 0.632354498471 0.542692736061 0.817277481566 0.469824272393 0.107364684283 0.204645449743 0.625918525025 0.726583895553 0.514650950035 0.204719724246 0.38551238142 0.584751830733 0.997534999641 0.250106107784 0.867601528583 0.734252979368 0.722643915308 0.640481902144 0.575773264849 0.503756128683 0.133366330813 0.269298023497 0.320827226851 0.690959307829 0.390384092607 0.00576383137412 0.927004041908 0.489410863341 0.0882332780043 0.846320347927 0.715101201673 0.661260283366 0.799675347054 0.551871555515 0.0612893196421 0.634807117594 0.862595212821 0.0563487228792 0.285736280439 0.485200587424 0.780955605056 0.0250220973902 0.266402343827 0.238186355116 0.946618175645 0.535939094313 0.566846054535 0.826542384834 0.115972171494 0.388076904403 0.642834622195 0.516215211654 0.112768344575 0.718327106625 0.708722657975 0.918857975524 0.913349435476 0.399472713923 0.590210878742 0.749766785243 0.591687357972 0.0469445183936 0.84837202261 0.893668944663 0.824058187884 0.854968369414 0.597790228945 0.931506268933 0.199614558664 0.240974841794 0.290366686317 0.17805552792 0.905014468003 0.415563695745 0.0270215195869 0.17285950399 0.81550975027 0.529799220339 0.48036733652 0.563473333475 0.560200280588 0.515394522272 0.31747027875 0.582239266682 0.952198713654 0.140420800002 0.0588701369035 0.435819158664 0.103690211564 0.969838343672 0.14394902311 0.166241459932 0.0469779205114 0.845025251756 0.0944891653942 0.541444239944 0.646467307046 0.907377490992 0.365603949004 0.67906863216 0.573774312142 0.479369701226 0.891850725484 0.370460083367 0.731972597587 0.361596805019 0.0691430366918 0.716724766245 0.676806037324 0.505253796968 0.313471010425 0.965433905404 0.833931012593 0.365231107142 0.602848391194 0.411427447824 0.92097152145 0.63208003826 0.313814293417 0.619390714719 0.446332932384 0.31251138838 0.213280872074 0.676426723784 -1158471936
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedActiveOpticForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1158471936
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedActiveOpticForces received =     1
    Should Contain    ${output}    Timestamp : 7.9547
    Should Contain    ${output}    ZForces : 0.923205415877
    Should Contain    ${output}    Fz : 0.600896198155
    Should Contain    ${output}    Mx : 0.85188300489
    Should Contain    ${output}    My : 0.0264024980986
    Should Contain    ${output}    priority : 0.059654330443
