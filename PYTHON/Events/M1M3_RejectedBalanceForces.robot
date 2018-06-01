*** Settings ***
Documentation    M1M3_RejectedBalanceForces communications tests.
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
${component}    RejectedBalanceForces
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp XForces YForces ZForces Fx Fy Fz Mx My Mz ForceMagnitude priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 74.455 0.317298 0.516294 0.586042 0.189293 0.025042 0.414681 0.786221 0.228385 0.807658 0.681145 0.536482 0.402091 0.645875 0.423808 0.466529 0.753862 0.274105 0.339957 0.715256 0.932786 0.78485 0.332963 0.37569 0.45098 0.782777 0.902587 0.348416 0.451703 0.564577 0.043342 0.931025 0.798489 0.431995 0.765548 0.903791 0.030328 0.649585 0.787212 0.545298 0.169206 0.254378 0.284346 0.838363 0.163866 0.768619 0.68826 0.091784 0.123839 0.414731 0.323449 0.74866 0.706365 0.543559 0.50017 0.710363 0.272711 0.755583 0.754807 0.876378 0.177655 0.199458 0.350228 0.36024 0.608369 0.326826 0.034614 0.589287 0.617581 0.441686 0.221476 0.886469 0.720464 0.432387 0.28357 0.253376 0.695696 0.732715 0.907016 0.398071 0.20621 0.431395 0.828995 0.559575 0.541546 0.524321 0.749914 0.325412 0.310861 0.934156 0.555489 0.881152 0.52688 0.252944 0.053856 0.020697 0.344406 0.757628 0.746088 0.942313 0.22297 0.652847 0.166485 0.820633 0.361801 0.404729 0.552248 0.244923 0.369397 0.22523 0.856943 0.504789 0.663996 0.168136 0.588369 0.790364 0.237724 0.441626 0.800619 0.498692 0.649149 0.580706 0.365075 0.576162 0.228048 0.649772 0.792882 0.793628 0.907815 0.07549 0.422231 0.663708 0.465191 0.990966 0.118194 0.187253 0.766449 0.094261 0.292783 0.11169 0.907213 0.819259 0.613456 0.595724 0.912312 0.947777 0.539459 0.3483 0.884477 0.364701 0.295023 0.579853 0.722615 0.050119 0.318126 0.034384 0.252607 0.33444 0.318587 0.689118 0.390503 0.431427 0.532266 0.072053 0.308753 0.652042 0.951288 0.577677 0.6492 0.693753 0.940467 0.22976 0.746873 0.276372 0.308744 0.024532 0.72342 0.051203 0.781563 0.218246 0.303663 0.519529 0.07907 0.905155 0.70378 0.25488 0.67444 0.91298 0.555486 0.240333 0.984732 0.581151 0.528607 0.886749 0.211029 0.591108 0.753547 0.896758 0.496391 0.256327 0.290564 0.165198 0.108391 0.247288 0.735373 0.409832 0.880637 0.628232 0.168062 0.602828 0.757688 0.630669 0.255036 0.001432 0.835569 0.759753 0.427851 0.525526 0.690599 0.045764 0.921144 0.862109 0.983059 0.429415 0.885277 0.930712 0.574897 0.314684 0.364719 0.537926 0.048996 0.102412 0.637614 0.950838 0.895463 0.683712 0.377967 0.390666 0.668914 0.859031 0.910837 0.047484 0.293373 0.698558 0.055616 0.595536 0.523 0.990654 0.755108 0.61666 0.761452 0.769377 0.755743 0.822864 0.541456 0.953645 0.249324 0.447479 0.502462 0.358346 0.074398 0.445322 0.299279 0.598551 0.993365 0.743937 0.947476 0.53872 0.505503 0.405864 0.034487 0.165577 0.748984 0.150272 0.847555 0.991787 -696489992
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedBalanceForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
