*** Settings ***
Documentation    M1M3_AppliedActiveOpticForces sender/logger tests.
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 8.9554 0.664255922817 0.506125414461 0.417546363163 0.188109168374 0.93456130273 0.267556159079 0.407512237721 0.105758194814 0.879227948444 0.642277858787 0.11085933559 0.752801197578 0.101618661991 0.346419447276 0.129407898836 0.811550351421 0.12038195364 0.949326731352 0.0915318217547 0.453277789564 0.546852901132 0.310973600015 0.145461664304 0.875936306467 0.275146899232 0.23221274895 0.315197999077 0.193381166504 0.470958608611 0.0806222862713 0.780996140034 0.207165349715 0.274668861419 0.107262301616 0.628187832683 0.200393288498 0.70813113394 0.73853713368 0.650438647208 0.877592786516 0.917036049202 0.135792673964 0.754421227516 0.636684387423 0.885515436059 0.389848579553 0.595604922852 0.558655252135 0.941716899787 0.163650436119 0.481374072512 0.205245780508 0.467149457343 0.666254731161 0.164986967985 0.326403203572 0.219179076534 0.0475715686612 0.370880257864 0.73884779217 0.581002855823 0.0459359903352 0.584516352536 0.896422412214 0.473032649223 0.550559335121 0.525016635203 0.643309593506 0.602190161196 0.827791800252 0.543328907161 0.644297336234 0.869974330378 0.574904620578 0.128133407398 0.398549460142 0.962403452602 0.109936232733 0.709369288229 0.18573423845 0.224870982558 0.203485704312 0.0707706023271 0.792608809921 0.389377365729 0.374384706692 0.6925283717 0.428676495245 0.832441971811 0.31019243952 0.905476532439 0.845790841855 0.835642976873 0.830107161581 0.221803355832 0.960587414214 0.713035142855 0.936511871497 0.196491873095 0.12272165259 0.779834755463 0.616008493582 0.979921190696 0.0429779358425 0.252617238422 0.552806385839 0.714594853716 0.123324818714 0.582909207719 0.00529121230397 0.497094675602 0.862444391788 0.324695736067 0.543710294442 0.386946350677 0.0770311672902 0.319097860164 0.843578860492 0.384407795802 0.643371925776 0.536649739663 0.80575932423 0.599463969432 0.333938909557 0.770155381822 0.288075259181 0.860555403062 0.467506264161 0.526593633203 0.548652429197 0.897957405975 0.990213548758 0.71967383371 0.976575563883 0.916548412129 0.772109653625 0.361827679185 0.108759762526 0.133970847034 0.331145675284 0.7500471477 0.675871972704 0.0446875621971 0.758537549272 0.961801153503 0.410453873006 0.802357279742 0.27772231116 0.679733643987 0.230678443143 0.883094418459 0.602890405687 0.549281646119 0.450030799599 0.12509648901 0.926188870837 0.603510083086 0.474890843888 0.0690697269976 -1637766283
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
