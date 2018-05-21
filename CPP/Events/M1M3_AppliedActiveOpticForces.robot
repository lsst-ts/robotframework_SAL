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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 64.51 0.91657792238 0.848406522154 0.682898999466 0.784487399123 0.628861075269 0.502077691065 0.223007289403 0.597319128454 0.064704983636 0.74508793042 0.179372365147 0.520302647182 0.195099798376 0.432607037649 0.083191204269 0.903093508761 0.398333060259 0.621365610632 0.643459532679 0.504503855468 0.525198044566 0.342191372128 0.66407222284 0.1322392557 0.959387939232 0.0189485333282 0.0556261639039 0.0842134111341 0.490926162873 0.457115426743 0.223000603399 0.0777945178138 0.157023000186 0.604786266966 0.228299537997 0.720242681522 0.842965371296 0.917672304437 0.971764629349 0.110830616193 0.498629551543 0.606490133482 0.160180821166 0.649592328012 0.331630847119 0.794834437547 0.428391120888 0.849728184691 0.889002565628 0.805233126248 0.88475690254 0.988360636052 0.968039119598 0.5076746651 0.0660167323067 0.606914720035 0.691124312072 0.623480393473 0.300240556072 0.104260816336 0.834971327115 0.396549482798 0.981945923132 0.586802399662 0.0391868163022 0.514625609502 0.711011761954 0.895579745224 0.0766182354966 0.491770708702 0.0769896244944 0.632182476762 0.962801346316 0.327905684419 0.019699158776 0.338681604772 0.693401852542 0.500022678336 0.359779124304 0.54565754691 0.969203094069 0.678534237842 0.57728981578 0.183728135852 0.406317804655 0.317658796376 0.602280510869 0.00475781561786 0.578058658112 0.639583529221 0.923427596537 0.870957322574 0.167734764406 0.186428846648 0.172255648234 0.448239835483 0.0811449541977 0.459505782929 0.884853427417 0.527799362932 0.625624581999 0.295322519518 0.582607760968 0.927888802592 0.205273262711 0.241634855527 0.467430671018 0.975214560792 0.625884970941 0.281205512662 0.952767822404 0.259980719317 0.718542780067 0.965984496841 0.603917921322 0.458260175311 0.102494730775 0.476814211725 0.589965306589 0.171741506729 0.146763053648 0.763248907749 0.66125872872 0.762748810165 0.831121241314 0.775126044631 0.514659868357 0.687854982793 0.571867934624 0.227514015225 0.0635500065496 0.961775423271 0.136492945956 0.583271922538 0.527117042625 0.274417748788 0.279258502277 0.570212579684 0.676076300512 0.767646253895 0.111278267415 0.526880054149 0.610198546767 0.851089183231 0.29452751379 0.314007311001 0.702389968482 0.639593269766 0.0239969238214 0.848720435592 0.115435290395 0.966555563544 0.147192106446 0.579562916294 0.0973709287276 0.0160849409826 0.0461968627572 0.260217836824 0.864121867909 -2001574568
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedActiveOpticForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -2001574568
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedActiveOpticForces received =     1
    Should Contain    ${output}    Timestamp : 64.51
    Should Contain    ${output}    ZForces : 0.91657792238
    Should Contain    ${output}    Fz : 0.848406522154
    Should Contain    ${output}    Mx : 0.682898999466
    Should Contain    ${output}    My : 0.784487399123
    Should Contain    ${output}    priority : 0.628861075269
