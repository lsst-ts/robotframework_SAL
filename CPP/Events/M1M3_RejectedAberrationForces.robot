*** Settings ***
Documentation    M1M3_RejectedAberrationForces sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedAberrationForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 5.4837 0.876387712125 0.851510867296 0.80060840053 0.728409186256 0.39099668237 0.466486085421 0.76416476232 0.166832635103 0.116025885442 0.951999393153 0.762704475166 0.968250979971 0.599965343401 0.75161500385 0.467434484605 0.232529113285 0.434140701603 0.100512616122 0.417786388017 0.73334083034 0.700848596887 0.416681045989 0.821181874723 0.287394149243 0.925815261806 0.720602772785 0.931955097469 0.224581582145 0.909149974686 0.755047846923 0.377869127178 0.4487338709 0.584495615059 0.58241821963 0.651190684363 0.821593076366 0.941252901763 0.154037762166 0.362893074279 0.940965156239 0.905098136541 0.507950657278 0.0415691273405 0.369913136357 0.0915643808481 0.794248722115 0.48745895049 0.00363797658245 0.85056210663 0.390847801068 0.416748644869 0.190414044929 0.597756559314 0.75810377815 0.589548702652 0.849977024462 0.735704661998 0.650479436281 0.0289295338042 0.412421435958 0.0572642222522 0.290671116751 0.625121182841 0.572354469214 0.630619532674 0.662150746723 0.132954806905 0.345277563591 0.987968973133 0.133080870646 0.0491293631312 0.0689468965314 0.313395586552 0.176336671248 0.284392065362 0.601612647689 0.610167845917 0.840669575824 0.933603127505 0.893446741758 0.333327263874 0.210835610519 0.250139617251 0.585589469337 0.822772660096 0.20260130196 0.443514714244 0.711347544318 0.495315198787 0.0266483487612 0.47850713652 0.363838041029 0.0341131519222 0.858458339196 0.812617018618 0.102525578912 0.660696143903 0.0355764560007 0.894438813308 0.815728459777 0.565797450899 0.275399127438 0.87724884628 0.689935961952 0.39584701577 0.672814584519 0.274243601179 0.910603964297 0.951426456005 0.479340300189 0.959061057832 0.0359889037481 0.17673555204 0.911171605888 0.384106146544 0.918840156076 0.37836443375 0.0364520154888 0.490634548574 0.418843045457 0.908760903498 0.952805578433 0.529702794166 0.388893035389 0.65827168595 0.709655235655 0.792734030426 0.0714502166092 0.376309356614 0.423326451191 0.266859993031 0.596695593387 0.123441601209 0.7398274881 0.95950511823 0.168006776016 0.92482229063 0.100593917506 0.9444022841 0.979624119151 0.587612089422 0.155733917106 0.572248415319 0.632851311635 0.0581633841945 0.580274577385 0.265461983274 0.798620030419 0.885671668213 0.758564901199 0.805689391968 0.966848546435 0.172749172326 0.37374218412 0.63405645096 0.42209649516 0.458317941789 0.360291114415 0.322606166277 -11105566
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedAberrationForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -11105566
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedAberrationForces received =     1
    Should Contain    ${output}    Timestamp : 5.4837
    Should Contain    ${output}    ZForces : 0.876387712125
    Should Contain    ${output}    Fz : 0.851510867296
    Should Contain    ${output}    Mx : 0.80060840053
    Should Contain    ${output}    My : 0.728409186256
    Should Contain    ${output}    priority : 0.39099668237
