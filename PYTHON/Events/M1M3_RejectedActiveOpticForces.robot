*** Settings ***
Documentation    M1M3_RejectedActiveOpticForces communications tests.
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 10.218 0.661409 0.729335 0.218512 0.760114 0.512729 0.857925 0.256226 0.362622 0.079466 0.809157 0.242936 0.706236 0.140836 0.328539 0.728894 0.336389 0.985195 0.316548 0.352315 0.857514 0.906028 0.0973 0.187689 0.484051 0.474312 0.232484 0.292592 0.712264 0.085716 0.135595 0.992516 0.1208 0.458671 0.585585 0.832907 0.784277 0.762252 0.466119 0.409089 0.787257 0.725328 0.680577 0.498651 0.643153 0.081232 0.052023 0.659587 0.571504 0.141836 0.042413 0.85503 0.424998 0.555429 0.381413 0.816193 0.487026 0.529642 0.403118 0.648097 0.515962 0.891391 0.093089 0.161897 0.819636 0.011004 0.958922 0.218214 0.528653 0.026587 0.396494 0.011325 0.322393 0.506895 0.437946 0.355483 0.05146 0.19129 0.594696 0.533823 0.503949 0.175914 0.199942 0.616286 0.690888 0.090932 0.849843 0.314856 0.849129 0.393117 0.475422 0.171823 0.678623 0.719465 0.175986 0.139669 0.666636 0.011288 0.645984 0.923711 0.063179 0.623377 0.634624 0.960522 0.749466 0.263796 0.642898 0.744349 0.800656 0.909453 0.807949 0.558968 0.795098 0.933948 0.558805 0.701832 0.066324 0.594695 0.40387 0.980788 0.004381 0.463498 0.088141 0.45225 0.866133 0.280273 0.006592 0.34102 0.616881 0.624415 0.262107 0.88894 0.618983 0.261831 0.964763 0.171738 0.673871 0.163801 0.696174 0.558981 0.661742 0.703296 0.725425 0.444255 0.936206 0.622843 0.40041 0.169274 0.262829 0.901397 0.179206 0.917244 0.660045 0.087197 0.249332 0.317451 0.123889 0.156746 0.988575 0.19133 308206937
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
