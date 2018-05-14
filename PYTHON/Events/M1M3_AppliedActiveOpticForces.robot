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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 66.1437 0.283034492784 0.304871714007 0.962363022945 0.577041700238 0.61755269456 0.649591068988 0.97865201293 0.686662628517 0.378666771147 0.403881419306 0.562969877198 0.0349108878461 0.739027582183 0.891157201863 0.631209502178 0.719161964551 0.0127437257112 0.845999888451 0.91555588529 0.946062285438 0.724123879793 0.649590129928 0.374209338296 0.855558378259 0.181689703302 0.490598506488 0.153547153649 0.856757787478 0.283652543253 0.656552969081 0.271937128054 0.839550949259 0.533464484668 0.566246514672 0.713123760693 0.876963559128 0.72682726801 0.058773651264 0.366163580201 0.849050363074 0.234578987054 0.286127227614 0.78248406891 0.813687919863 0.636315331253 0.00286529828132 0.395798025578 0.45881232328 0.894259137713 0.704044876941 0.801749739931 0.754504876156 0.708388515867 0.927337024411 0.338582960014 0.095577135282 0.979630759152 0.362690112465 0.892113647921 0.0493787695062 0.72760921753 0.225936711042 0.109327969237 0.985854385624 0.511285160251 0.375499923359 0.0851984909738 0.544511766207 0.760662525223 0.337140823354 0.0247468622389 0.639904287346 0.951800042835 0.006085416616 0.148402318137 0.171905913014 0.258427590798 0.665907643703 0.0203707989841 0.752506532067 0.993029084545 0.14862808276 0.628050916159 0.898999877059 0.786928951143 0.903002065382 0.808877814793 0.270702928691 0.891650905407 0.880073357056 0.39586599927 0.203181353007 0.1939944941 0.341055945376 0.476666585494 0.259019555064 0.748628838887 0.640003327738 0.670036073486 0.273568272286 0.94471749779 0.964218816058 0.814208509926 0.287669735871 0.225358784356 0.263533877072 0.778710438824 0.663251504216 0.149964247583 0.339364633617 0.922628655486 0.673939203292 0.481450805029 0.62813939848 0.27119594244 0.709255060285 0.709856307295 0.688672525335 0.773211145728 0.681977652508 0.617516488201 0.586911948234 0.569203056707 0.54774630101 0.494491409894 0.0287433036773 0.21435994346 0.451457389193 0.853591031213 0.495475189507 0.00968257166396 0.750470498487 0.00938831060651 0.0459632040757 0.302223175697 0.823627384922 0.0665113424972 0.0367345388524 0.430706157051 0.600179576012 0.799277313565 0.307304918699 0.242475466887 0.85906675896 0.844132699242 0.208821096119 0.969997956573 0.105730291861 0.880636170635 0.0466333554995 0.296116293906 0.16307015882 0.224041606643 0.120900855184 0.376577514123 0.187781405655 0.947339823427 0.438931548168 0.400809220309 -120174430
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
