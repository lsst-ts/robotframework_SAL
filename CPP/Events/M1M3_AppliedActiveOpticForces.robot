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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 35.5414 0.784988745079 0.228938116121 0.832735421199 0.668310817512 0.4008961707 0.078914982079 0.344228007294 0.83451783495 0.206110023575 0.788174934714 0.116461591287 0.141127513096 0.733108543302 0.851365453436 0.866839066846 0.396987448713 0.992784953211 0.083201154066 0.707834222902 0.343533529429 0.0452064688648 0.169364511853 0.66723675093 0.4472522154 0.571758437458 0.824932114512 0.754163913838 0.789743139815 0.899630349628 0.082462803231 0.0381048491974 0.530285549486 0.484993672273 0.497465771913 0.207089616322 0.837974678477 0.694676453734 0.399481343262 0.64390404147 0.348865370494 0.991985881711 0.281061718651 0.67645460052 0.907168493329 0.872323551469 0.784983429642 0.199747913224 0.987257355568 0.694069693924 0.760814505688 0.233386733393 0.605460865695 0.147170367631 0.160741365586 0.733927084948 0.527816212007 0.735419621677 0.339338931018 0.556427381882 0.374111769717 0.984942181377 0.560041650331 0.367106304986 0.732203065956 0.784898711677 0.555799792135 0.89765337036 0.523497691865 0.211980983868 0.539699310631 0.355625669331 0.0760195980649 0.291039590379 0.598903543553 0.456977528836 0.0235211582617 0.244484613858 0.0761828447031 0.450921976807 0.224606222745 0.103556264226 0.729531746288 0.757250715741 0.073470662476 0.794834164646 0.493480665015 0.991824042145 0.469148347645 0.243773327994 0.829012220597 0.512238369104 0.877334307924 0.809619369621 0.325469812456 0.907861183874 0.170745709354 0.144305955748 0.137822489792 0.945462168658 0.527848159238 0.214228714333 0.0224951710789 0.18700419204 0.148835778791 0.386983199424 0.985019944384 0.88037734388 0.857882818669 0.168088166717 0.579252607883 0.210934584935 0.259860646415 0.35480583157 0.339828095565 0.567772887174 0.804583984439 0.877042058816 0.90928774605 0.134036183161 0.80282979126 0.174098019568 0.97364165406 0.832860943049 0.0842562272068 0.111137768233 0.701533029691 0.248409140747 0.386300793615 0.400548359994 0.809604977562 0.109798265515 0.70869833862 0.737066387395 0.0202107396852 0.167654472815 0.898165602757 0.576121066648 0.892882822016 0.732774390705 0.555536152072 0.172916717291 0.664819545695 0.122428217757 0.874978481517 0.404072725217 0.358435749716 0.176093876455 0.1688528163 0.184561363112 0.0955777343936 0.518959064636 0.859375506375 0.889692303001 0.972336992612 0.696195880032 0.37231503503 0.929970988755 0.0870668084787 0.975826230265 -165631905
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedActiveOpticForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -165631905
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedActiveOpticForces received =     1
    Should Contain    ${output}    Timestamp : 35.5414
    Should Contain    ${output}    ZForces : 0.784988745079
    Should Contain    ${output}    Fz : 0.228938116121
    Should Contain    ${output}    Mx : 0.832735421199
    Should Contain    ${output}    My : 0.668310817512
    Should Contain    ${output}    priority : 0.4008961707
