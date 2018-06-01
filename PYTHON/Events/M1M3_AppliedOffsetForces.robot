*** Settings ***
Documentation    M1M3_AppliedOffsetForces communications tests.
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
${component}    AppliedOffsetForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 72.3747 0.521147 0.852216 0.987437 0.870089 0.420329 0.900028 0.776818 0.72119 0.800479 0.883846 0.481032 0.003545 0.246345 0.080549 0.334287 0.708167 0.364703 0.391621 0.084909 0.697905 0.606783 0.810804 0.237639 0.052448 0.827253 0.780465 0.243671 0.106357 0.653546 0.158934 0.970189 0.768991 0.979429 0.1672 0.400553 0.908067 0.392374 0.562943 0.691003 0.620213 0.898728 0.401077 0.41795 0.219996 0.224604 0.673872 0.037268 0.822461 0.437356 0.130684 0.99879 0.992665 0.752785 0.796962 0.06187 0.031766 0.472725 0.40039 0.014046 0.707895 0.813331 0.456298 0.985174 0.101167 0.652774 0.514549 0.657492 0.262454 0.843433 0.924456 0.447447 0.489194 0.226225 0.739499 0.455394 0.622538 0.241085 0.061044 0.36734 0.295234 0.00766 0.321304 0.332663 0.416517 0.066504 0.87809 0.196921 0.145799 0.915618 0.591328 0.855563 0.629875 0.341766 0.281792 0.365682 0.185253 0.190786 0.647536 0.316112 0.670681 0.445614 0.636764 0.213493 0.442451 0.347508 0.202228 0.534303 0.810952 0.74539 0.580228 0.269708 0.342879 0.671511 0.146884 0.571202 0.829236 0.674785 0.425436 0.970343 0.154469 0.489505 0.46135 0.198474 0.136383 0.303333 0.277537 0.608063 0.495738 0.809584 0.928502 0.801993 0.681909 0.835898 0.418218 0.903311 0.350633 0.042082 0.268633 0.952992 0.274588 0.544945 0.876522 0.419114 0.219047 0.238001 0.549878 0.636244 0.656853 0.573622 0.820798 0.01097 0.42509 0.791612 0.314804 0.565042 0.91118 0.466199 0.108241 0.272237 0.833689 0.650539 0.587522 0.469887 0.072468 0.406183 0.048642 0.195557 0.726994 0.950315 0.154606 0.553275 0.651296 0.308653 0.436289 0.547937 0.747865 0.031694 0.894081 0.031024 0.086902 0.078683 0.361348 0.747928 0.120999 0.477861 0.924883 0.090024 0.69891 0.443124 0.640209 0.314354 0.507275 0.805897 0.91446 0.297569 0.871119 0.331475 0.799478 0.651993 0.691381 0.02384 0.121889 0.820041 0.033493 0.103997 0.45352 0.548057 0.774242 0.657378 0.790474 0.826576 0.611717 0.966042 0.092193 0.736614 0.243836 0.98498 0.483507 0.545931 0.81669 0.963782 0.573264 0.430539 0.832868 0.68822 0.168729 0.825443 0.637359 0.811805 0.84769 0.306513 0.464864 0.394874 0.139208 0.253721 0.417532 0.235752 0.038576 0.452009 0.198581 0.348287 0.518637 0.322075 0.15181 0.496407 0.557439 0.689402 0.355255 0.742743 0.579584 0.571368 0.916254 0.302238 0.592277 0.979954 0.905348 0.971851 0.951979 0.562627 0.569639 0.628518 0.976387 0.453498 0.063014 0.988328 0.307713 0.033228 0.227141 0.291057 0.720346 0.640529 0.809498 0.298119 0.899265 0.781139 807691936
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedOffsetForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
