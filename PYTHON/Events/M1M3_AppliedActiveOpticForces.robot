*** Settings ***
Documentation    M1M3_AppliedActiveOpticForces sender/logger tests.
Force Tags    python    Checking if skipped: m1m3
TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedActiveOpticForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 91.7332 0.563324951511 0.734861281886 0.59112258614 0.452620974623 0.419433155851 0.157252394648 0.686207844726 0.322501013108 0.223821379584 0.64337051664 0.316797772767 0.354547534137 0.394312016078 0.696242889807 0.462376308231 0.177107134443 0.968312350204 0.774530557212 0.652445440531 0.355821121532 0.148294602368 0.774501713493 0.779341681892 0.35670474753 0.583271833669 0.528624017063 0.591676453005 0.469122021983 0.544011707959 0.266537433884 0.289108786575 0.246699674984 0.371764993877 0.266182015603 0.206444543006 0.561263758015 0.91478850655 0.943594804077 0.997038017489 0.697869448009 0.344823069903 0.771474495068 0.740897518666 0.876097067268 0.229195928237 0.455238934983 0.00701719623616 0.403845778576 0.897807859622 0.984219079221 0.830002565594 0.785278280903 0.171766096136 0.369199125453 0.331008008035 0.259804827564 0.816526865805 0.608732288406 0.429703002956 0.475580927399 0.736804244024 0.444367997247 0.568772777368 0.840272272249 0.674431623294 0.446113954787 0.896488965779 0.995027651529 0.608762040879 0.827581205257 0.239696652817 0.870840501328 0.645644581564 0.364811785419 0.557936025154 0.295280512171 0.556377779961 0.722854952947 0.864852381108 0.761217998534 0.854596069032 0.00397829610243 0.51738383473 0.322479654163 0.414216742886 0.842552158746 0.675241939498 0.525991123683 0.389246228221 0.803419007613 0.199594679041 0.0442596531426 0.894056942402 0.336352573663 0.778092157627 0.0796216336739 0.595543461407 0.755597431607 0.726044897506 0.95504251924 0.445591172142 0.980948853028 0.375262929827 0.105900425994 0.684417150571 0.492627683076 0.445437582021 0.914927258075 0.376653653041 0.26848693362 0.524102270083 0.599716643088 0.466685719046 0.202013561291 0.452159859938 0.262260240684 0.404815566555 0.663459211703 0.552976617974 0.26065952677 0.852549868068 0.208509501986 0.333462440614 0.408814481793 0.199258339938 0.847036515312 0.660050095367 0.544092413461 0.112320629611 0.00903543413351 0.0429841842729 0.796877033522 0.833378401904 0.678524526805 0.369107660663 0.366906454507 0.226171183498 0.67777474618 0.220419943466 0.799630241818 0.0776688475018 0.150491312922 0.605954831666 0.513080507105 0.890336373295 0.176069786868 0.668618113217 0.360522315273 0.489980882123 0.0516000543244 0.399056507807 0.112106585558 0.379911526122 0.128981641378 0.479410023126 0.486130254991 0.0165331397888 0.293297753346 0.356429069519 893907786
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
