*** Settings ***
Documentation    M1M3_RejectedActiveOpticForces sender/logger tests.
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 92.8614 0.70921928247 0.472483677257 0.652074037409 0.411231606364 0.961690406877 0.0284345813615 0.265465653894 0.535123544426 0.132726888639 0.105475863033 0.0709926599946 0.283235096392 0.0759346369127 0.460779794097 0.992882404177 0.851650456122 0.143702007977 0.937222645239 0.180832770839 0.276444360102 0.688661845056 0.771412425372 0.198830167865 0.212467966366 0.329043522942 0.239074663607 0.902179543286 0.474291597377 0.280137058507 0.784212415734 0.450452517434 0.673577309101 0.695320345146 0.0908302358777 0.803038152023 0.981257267662 0.438927528128 0.720796832973 0.985594491655 0.819247272358 0.712829636742 0.712890500984 0.646659779477 0.533005438989 0.106637887514 0.42581732728 0.431511265699 0.964812365415 0.0621148079586 0.403435443371 0.282791044664 0.373965740276 0.14044809504 0.314711207661 0.441166036655 0.675564245236 0.254061961621 0.0446169067854 0.321639750244 0.812665586194 0.72443926928 0.409623989117 0.529870569471 0.591017094253 0.547205331295 0.236158594425 0.951503604655 0.582657477873 0.818050932753 0.863096211444 0.821053412344 0.503610989593 0.434667137033 0.783530797308 0.906050651969 0.854556283384 0.546195181755 0.870406061489 0.649667811369 0.801393811966 0.0460316414582 0.0313100749976 0.811612091761 0.305059350237 0.730519965577 0.440122923558 0.218420420692 0.561294465386 0.799484109503 0.924131261434 0.488221027189 0.415321016917 0.960967962826 0.594454348569 0.971523133127 0.376288909197 0.379001205234 0.364972223643 0.59592951323 0.125675098609 0.959203967967 0.964139986225 0.0855967604514 0.405180129002 0.876605530925 0.496028983839 0.952274263305 0.266377801358 0.0613951403758 0.0335977895104 0.978104396802 0.821052793381 0.755548707348 0.761129146603 0.934391739527 0.733569878573 0.749779621117 0.21911866288 0.130083824091 0.277637321869 0.0707314133871 0.928837314352 0.417140387489 0.875044617013 0.318568611726 0.978086863759 0.607292950316 0.235555685705 0.601268480211 0.713695226254 0.463177097448 0.177392910358 0.098108473775 0.308842216811 0.779574375102 0.753906595485 0.19809832292 0.707950359682 0.358789035654 0.191491657192 0.68673777259 0.0888747161279 0.175376372547 0.0310200691985 0.867489902545 0.760014343027 0.749010166628 0.955961171663 0.146116850166 0.0343548990808 0.452069886584 0.884512283109 0.579921324512 0.258655533328 0.472443381337 0.191774679358 0.201915408501 0.209498481484 0.191547147158 -1799611894
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
