*** Settings ***
Documentation    M1M3_RejectedStaticForces communications tests.
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
${component}    RejectedStaticForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 84.5726 0.001991 0.761716 0.258864 0.16504 0.349161 0.563328 0.878552 0.664437 0.223401 0.482605 0.588419 0.039403 0.3982 0.585524 0.749553 0.792139 0.250674 0.932658 0.780867 0.523969 0.128191 0.802151 0.94891 0.60655 0.950765 0.813631 0.508613 0.041887 0.651233 0.727614 0.551997 0.117603 0.516213 0.457804 0.498179 0.644665 0.504092 0.568757 0.849162 0.374394 0.544409 0.475163 0.33926 0.686829 0.184793 0.653689 0.376529 0.31027 0.701194 0.616369 0.574775 0.378492 0.258074 0.580844 0.213031 0.745518 0.811775 0.39495 0.216711 0.047818 0.838206 0.956723 0.056776 0.261247 0.289639 0.025038 0.614455 0.178603 0.206625 0.430288 0.052683 0.288802 0.310661 0.73848 0.146461 0.116344 0.838006 0.914277 0.503458 0.088864 0.958362 0.507381 0.96927 0.256648 0.45644 0.439613 0.043362 0.061681 0.482343 0.535792 0.793503 0.855753 0.951095 0.166721 0.281392 0.055537 0.21493 0.064432 0.363641 0.687018 0.17785 0.458664 0.626057 0.419704 0.494975 0.211422 0.321408 0.140245 0.20764 0.948229 0.292812 0.176192 0.281987 0.218175 0.259016 0.90419 0.079588 0.579974 0.09574 0.415997 0.717548 0.146607 0.662402 0.766519 0.01497 0.264167 0.857466 0.771716 0.18697 0.872341 0.405649 0.747434 0.757098 0.684955 0.351875 0.881374 0.755548 0.575734 0.510012 0.998731 0.724732 0.495795 0.479417 0.834426 0.656689 0.503427 0.624972 0.534972 0.712267 0.342973 0.610001 0.923698 0.439894 0.692152 0.274814 0.952199 0.66642 0.399252 0.31505 0.386925 0.672216 0.825235 0.575431 0.104566 0.883083 0.062575 0.518505 0.201348 0.507724 0.700976 0.477123 0.310069 0.151501 0.947413 0.99247 0.631318 0.935917 0.822431 0.208589 0.31669 0.234994 0.636308 0.01194 0.299267 0.083051 0.409801 0.791277 0.06564 0.626651 0.476424 0.938479 0.827679 0.182834 0.38586 0.372855 0.53128 0.332881 0.737226 0.30833 0.331004 0.550592 0.59848 0.774599 0.975829 0.64695 0.010577 0.257616 0.350469 0.43017 0.012383 0.293214 0.943848 0.000815 0.483445 0.29998 0.889409 0.399979 0.447264 0.416759 0.74465 0.398552 0.29882 0.540442 0.993965 0.08645 0.074717 0.982944 0.338704 0.382841 0.674478 0.063307 0.383152 0.868335 0.246444 0.642905 0.860733 0.449902 0.572239 0.409418 0.868629 0.444345 0.800445 0.820305 0.988591 0.992966 0.891468 0.612467 0.423266 0.574727 0.597033 0.942756 0.439856 0.978303 0.899682 0.542071 0.982738 0.293802 0.457688 0.658105 0.606945 0.782639 0.513194 0.425095 0.529643 0.039699 0.215093 0.443812 0.344318 0.661934 0.572431 0.811831 0.151677 0.993204 0.000642 0.833406 -2068878344
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedStaticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
