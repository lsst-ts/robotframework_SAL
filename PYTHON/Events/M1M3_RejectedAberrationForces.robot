*** Settings ***
Documentation    M1M3_RejectedAberrationForces sender/logger tests.
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
${component}    RejectedAberrationForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 9.0202 0.856069491145 0.630619255108 0.94853882002 0.635974005521 0.289715211316 0.823144525414 0.836365406487 0.703910623277 0.574791657807 0.551624057901 0.0226895682157 0.303097582548 0.453430793857 0.166587452693 0.29480962561 0.976406069312 0.57917256574 0.0653471313968 0.773283221399 0.397210538096 0.523694737903 0.396893144535 0.158339090881 0.349354860707 0.879954866588 0.761348916962 0.326888331545 0.624009312693 0.562494233446 0.776156831772 0.653836111846 0.290647309697 0.730746280605 0.738656336746 0.598424990849 0.756215994099 0.275984435462 0.13356595979 0.457782607048 0.991873709164 0.216632958524 0.712583407495 0.302721479707 0.136042546478 0.793853441943 0.831953038614 0.222041665208 0.0635571965451 0.339379496171 0.167472602616 0.595985793347 0.30058162401 0.278432446064 0.146815059513 0.503963356318 0.165565838226 0.293965486198 0.041600538928 0.284572570898 0.00661257938196 0.144070695118 0.217026983605 0.711967649911 0.275154148033 0.194014465359 0.827947233397 0.0747944340257 0.644669391968 0.430487199695 0.337744530124 0.448080760978 0.71293698801 0.706740361418 0.129843951211 0.820656329083 0.561458407594 0.724630947936 0.692255163606 0.235401186122 0.322325410378 0.986559307688 0.508924174571 0.0451542021577 0.814541525497 0.928357911272 0.95017951807 0.172797618613 0.544893313622 0.568991439036 0.768300797983 0.619376122035 0.713952972685 0.681613241598 0.644244653806 0.275874228299 0.0757263547027 0.966451783877 0.924097332574 0.0467005159209 0.751212808181 0.71663559782 0.303076398033 0.193794935889 0.306490816484 0.299094338264 0.523134763856 0.605287112135 0.490814480096 0.374786014349 0.0737450125653 0.560983281216 0.969743856037 0.204795914209 0.679659656508 0.708388488152 0.950921260599 0.629650253244 0.0193747255637 0.222124155632 0.327197845562 0.571367520908 0.170013011592 0.587924480565 0.0450845316239 0.574064200834 0.491781961257 0.78300613289 0.759845053329 0.19524692746 0.25359225994 0.919562087563 0.476780052225 0.682362622464 0.868273998268 0.984933702871 0.914517296696 0.797799085096 0.572239680424 0.960698728517 0.0960705306843 0.4330363879 0.0799170396726 0.493312386423 0.598521574932 0.330928501522 0.933912815123 0.488739883051 0.963983913685 0.828969749346 0.235910308992 0.789069807426 0.280417169347 0.95221860697 0.418264089981 0.668643293202 0.885368835793 0.766775061608 0.619550143913 0.187825800027 -392522752
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
