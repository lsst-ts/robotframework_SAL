*** Settings ***
Documentation    M1M3_RejectedActiveOpticForces sender/logger tests.
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
${component}    RejectedActiveOpticForces
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp ZForces Fz Mx My priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 42.9453 0.195138120556 0.961936012779 0.0516659311725 0.234711939505 0.482691376164 0.612000881571 0.894416085496 0.886610220754 0.278100133145 0.402141264149 0.910406199608 0.0288259761954 0.404797361313 0.834127226466 0.160141387132 0.289551370594 0.487892707057 0.637753351412 0.213753411122 0.68989082385 0.830302280326 0.148500034447 0.35305715228 0.0602279883543 0.196958350014 0.190428938841 0.431263675797 0.161323150963 0.677421606057 0.100136423764 0.0200818006653 0.74509091235 0.786620552428 0.258304384887 0.804011527835 0.454983632744 0.540519259425 0.441081752708 0.535195253298 0.293538162385 0.854431590628 0.258043007445 0.742607492456 0.433676322831 0.643513857085 0.482140664328 0.956734929269 0.327740702876 0.312391232215 0.594964969674 0.285837486337 0.756131851213 0.298278122809 0.808963501881 0.401458327282 0.23793610601 0.935764427213 0.775647333254 0.633510425183 0.490848134251 0.809503380977 0.0874190583318 0.949623613022 0.422046637271 0.725641701411 0.433317668712 0.0469026793229 0.44157255203 0.873303227366 0.0799845409581 0.756362219141 0.190029814493 0.184034930645 0.610025400201 0.424506760472 0.0543376887957 0.125584296759 0.760279212147 0.532807422965 0.73004231344 0.753860333443 0.00918884173456 0.107259877122 0.364090052963 0.868070938253 0.939262720289 0.156704691219 0.394173954383 0.486453850527 0.163338377441 0.255831938239 0.441629527448 0.362630892961 0.273388607912 0.92208965969 0.00956389690859 0.563820781194 0.707251029058 0.181792699315 0.976411343011 0.745571074722 0.262381654882 0.696949627238 0.938029349079 0.201942662915 0.60444788734 0.0356325588841 0.904266089798 0.817289957081 0.205636876708 0.718649546017 0.234888230831 0.172867521067 0.0956888177482 0.127498083487 0.961352426941 0.354754533625 0.288167666665 0.362935420385 0.776370960214 0.0623032948141 0.347702470647 0.775281203414 0.891965724585 0.639799651331 0.0458760960289 0.539443914402 0.247617066679 0.674703558108 0.444993976507 0.000171735320861 0.283648587349 0.845506784942 0.76226516173 0.753553492028 0.372643535224 0.313322187801 0.701307923516 0.975026481079 0.893588904574 0.556312496719 0.0843585289618 0.714751609753 0.136406399336 0.462760546277 0.621248576019 0.40957401989 0.802540072452 0.476010144026 0.0369660041882 0.676962808677 0.485378191594 0.0476038061416 0.302852063151 0.111260835388 0.079131998336 0.318296203953 0.20752996597 0.0305397593476 1673079912
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
