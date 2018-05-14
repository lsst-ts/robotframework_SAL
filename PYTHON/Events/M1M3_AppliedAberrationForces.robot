*** Settings ***
Documentation    M1M3_AppliedAberrationForces sender/logger tests.
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
${component}    AppliedAberrationForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 63.5705 0.301697571839 0.968416337758 0.805942163148 0.311861918599 0.75363519252 0.498894323623 0.809477766291 0.545079307603 0.610478726905 0.940405663619 0.380982302963 0.271196017348 0.291903815815 0.784544926678 0.155648721866 0.705706409796 0.801923959409 0.912981785493 0.978114354599 0.538316513192 0.102198128439 0.845248997015 0.30131277243 0.584315931832 0.146760377442 0.884556207837 0.350254491024 0.431572457687 0.75706165507 0.78446826805 0.195606889703 0.422871909108 0.259135004221 0.445827047531 0.395760432743 0.978281932337 0.183433900596 0.196810223097 0.715625860763 0.721049416675 0.857514921149 0.362985118856 0.335150228236 0.891360402696 0.328898078672 0.0614470627253 0.948716038635 0.562714195902 0.350637609908 0.00869403136328 0.459354511553 0.554575664853 0.111767794458 0.046855429362 0.12862726072 0.165089407489 0.912312621458 0.869307280886 0.634088330872 0.0555323217763 0.463864281692 0.428625295065 0.119102596067 0.715162753168 0.881111352496 0.786294005381 0.645212311955 0.51825241834 0.179849032261 0.677048810672 0.476073735322 0.927342195592 0.276013152905 0.439510626989 0.393626341375 0.243366748736 0.824482791183 0.743219388644 0.962128219955 0.337386687548 0.985096110914 0.228126801481 0.441202164859 0.743952619133 0.043507225774 0.460180866568 0.684565798825 0.821192245349 0.91445404177 0.752271628401 0.824385013917 0.61731820712 0.770838675795 0.00418930225858 0.871418607581 0.604738828891 0.114462795713 0.809344865693 0.955460351768 0.092024480459 0.927769690685 0.228059872333 0.662441664606 0.637504043424 0.871747717876 0.947790298784 0.795969392428 0.781588525051 0.360472907981 0.530689546063 0.847800634089 0.544964255202 0.243073958931 0.117991976875 0.769726673399 0.854850962461 0.17786582558 0.932806849459 0.068885020744 0.0122563016536 0.935367259463 0.666935984699 0.59067544814 0.588543171764 0.761940926325 0.157198274655 0.444611218865 0.480142035389 0.156543353894 0.031924832793 0.657886439263 0.671433050903 0.321103269887 0.884096376991 0.784785607671 0.851142110856 0.844853925872 0.177692409646 0.729058432114 0.598048246157 0.640079174744 0.133232307604 0.270817900011 0.321313322379 0.993057669114 0.639266569173 0.0517809225862 0.998339561305 0.143878958695 0.0403139927905 0.453129805071 0.890715647618 0.712473077644 0.0560738835221 0.874472848512 0.436059119276 0.130283166208 0.0647170119974 0.977697743066 -235296304
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
