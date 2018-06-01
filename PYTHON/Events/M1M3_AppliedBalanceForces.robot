*** Settings ***
Documentation    M1M3_AppliedBalanceForces communications tests.
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
${component}    AppliedBalanceForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 76.4419 0.413086 0.917072 0.819472 0.790141 0.9719 0.152972 0.005099 0.501689 0.26814 0.063441 0.644978 0.570107 0.79126 0.272746 0.308713 0.756466 0.484747 0.067231 0.011163 0.790331 0.176347 0.282232 0.760362 0.006392 0.228851 0.804228 0.712593 0.665563 0.924969 0.810503 0.420957 0.950647 0.748395 0.492264 0.260478 0.856086 0.741336 0.006826 0.043093 0.389351 0.146367 0.161869 0.159803 0.051071 0.238957 0.657487 0.254328 0.062612 0.51136 0.194605 0.375477 0.299853 0.6177 0.198067 0.116134 0.030217 0.514196 0.687664 0.643036 0.669701 0.502402 0.864988 0.506905 0.900277 0.359942 0.982733 0.957109 0.895906 0.7033 0.641377 0.004293 0.842292 0.908069 0.595614 0.125978 0.338971 0.140045 0.139653 0.847274 0.384264 0.155777 0.314142 0.099522 0.688425 0.374265 0.007793 0.496998 0.832914 0.990747 0.529796 0.559133 0.581072 0.784393 0.522482 0.524555 0.73197 0.360837 0.415401 0.772373 0.891595 0.575913 0.765717 0.66172 0.96261 0.695963 0.636397 0.46473 0.349902 0.928483 0.557956 0.457831 0.28906 0.92683 0.840168 0.575923 0.150469 0.389148 0.228639 0.284925 0.25076 0.89161 0.711731 0.414781 0.292289 0.774131 0.173009 0.896172 0.957904 0.1272 0.764153 0.231891 0.095018 0.708353 0.849343 0.46744 0.154161 0.767141 0.766937 0.293425 0.664114 0.687193 0.922701 0.652868 0.950462 0.00776 0.556708 0.864948 0.606894 0.428733 0.854202 0.914281 0.360205 0.706429 0.44639 0.563915 0.667696 0.203726 0.077902 0.916501 0.817953 0.671538 0.341579 0.128499 0.0983 0.390721 0.756184 0.258734 0.711923 0.014452 0.565453 0.442511 0.096906 0.604601 0.570516 0.946107 0.093564 0.203998 0.759458 0.619441 0.713714 0.934477 0.375826 0.468967 0.308074 0.085596 0.716922 0.835535 0.867857 0.773448 0.970318 0.207063 0.680454 0.979557 0.636783 0.581098 0.83983 0.660994 0.968104 0.317055 0.440368 0.245313 0.763966 0.253344 0.874674 0.416382 0.173626 0.0519 0.412035 0.246022 0.903539 0.775882 0.389526 0.802698 0.552002 0.242988 0.485024 0.433253 0.232044 0.289244 0.178107 0.204093 0.704715 0.99272 0.643781 0.691001 0.700436 0.916867 0.366028 0.450899 0.621154 0.430739 0.717531 0.713653 0.941817 0.209769 0.828771 0.539396 0.432802 0.839646 0.013995 0.816092 0.854373 0.254418 0.043594 0.109343 0.736709 0.174244 0.074404 0.592766 0.336998 0.457503 0.085521 0.971423 0.596116 0.170828 0.20671 0.135108 0.497465 0.59908 0.731875 0.311678 0.972549 0.605499 0.795631 0.393806 0.784781 0.386657 0.224605 0.682278 0.706978 0.714745 0.822395 0.01991 0.093583 0.926994 1693711371
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedBalanceForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
