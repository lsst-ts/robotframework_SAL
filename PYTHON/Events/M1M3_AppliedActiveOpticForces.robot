*** Settings ***
Documentation    M1M3_AppliedActiveOpticForces communications tests.
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 58.879 0.866682 0.62526 0.462021 0.454707 0.719107 0.026892 0.840549 0.284378 0.10821 0.974046 0.6585 0.353943 0.525284 0.050981 0.244114 0.389219 0.465711 0.192132 0.058103 0.173232 0.506004 0.734327 0.095139 0.578585 0.764854 0.220941 0.109117 0.255099 0.069031 0.923729 0.202531 0.49636 0.190079 0.774211 0.340304 0.42336 0.03955 0.099314 0.057936 0.435363 0.324287 0.337607 0.904218 0.863518 0.715804 0.323301 0.927808 0.775464 0.534716 0.057036 0.048487 0.77967 0.597546 0.260553 0.495265 0.255303 0.562358 0.871521 0.983732 0.542829 0.201363 0.031085 0.851152 0.119781 0.14125 0.56374 0.007683 0.409626 0.838198 0.79923 0.809408 0.259559 0.166759 0.606464 0.955164 0.401518 0.91341 0.849493 0.689566 0.960826 0.724003 0.731059 0.17228 0.836529 0.704132 0.071629 0.601984 0.880454 0.798276 0.840887 0.699319 0.152803 0.304291 0.463335 0.754604 0.22285 0.358408 0.950801 0.489902 0.207242 0.570786 0.208035 0.051477 0.07586 0.698745 0.188491 0.322153 0.453794 0.038808 0.36231 0.936878 0.934376 0.981904 0.979153 0.481306 0.013722 0.606957 0.457015 0.56399 0.269619 0.937202 0.227283 0.509995 0.316088 0.216571 0.569246 0.916132 0.770212 0.624594 0.53785 0.340796 0.052988 0.954593 0.339793 0.589696 0.937479 0.364512 0.440995 0.805213 0.754514 0.365087 0.127851 0.135019 0.258007 0.78918 0.175508 0.308863 0.172851 0.190413 0.165449 0.048913 0.609204 0.52636 0.835664 0.239094 0.413989 0.482667 0.923175 0.060929 -2071847340
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
