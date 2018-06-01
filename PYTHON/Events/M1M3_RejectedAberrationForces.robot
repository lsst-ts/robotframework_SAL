*** Settings ***
Documentation    M1M3_RejectedAberrationForces communications tests.
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 20.9506 0.224279 0.891343 0.997004 0.631401 0.946576 0.425704 0.880536 0.812848 0.869201 0.587929 0.541248 0.402193 0.041393 0.4402 0.798026 0.397681 0.173062 0.180861 0.855494 0.679955 0.536385 0.932288 0.810499 0.82954 0.531605 0.735634 0.999524 0.375115 0.194018 0.929258 0.56695 0.931294 0.199559 0.958778 0.828632 0.276852 0.635227 0.689261 0.536105 0.48331 0.540702 0.864724 0.567086 0.866715 0.542875 0.764879 0.134246 0.733884 0.344912 0.887918 0.974749 0.887531 0.033203 0.079229 0.107574 0.821536 0.041965 0.959978 0.798579 0.66944 0.797927 0.946946 0.342907 0.785416 0.559857 0.199352 0.87421 0.483076 0.233424 0.54456 0.072303 0.915627 0.507525 0.714354 0.064181 0.691713 0.060014 0.506794 0.896905 0.723456 0.124776 0.394635 0.767233 0.690043 0.777815 0.539717 0.185517 0.2274 0.434942 0.901696 0.391802 0.797493 0.281474 0.077197 0.411875 0.559377 0.763138 0.135117 0.970967 0.398506 0.712722 0.868327 0.59228 0.739478 0.160794 0.69601 0.444504 0.697374 0.551352 0.036972 0.136806 0.72635 0.257015 0.735713 0.012647 0.86822 0.726606 0.081161 0.482276 0.478157 0.748039 0.261501 0.237162 0.921935 0.927375 0.428126 0.88219 0.705908 0.913978 0.998419 0.531311 0.03394 0.40009 0.611531 0.674068 0.425108 0.847004 0.533709 0.363344 0.412783 0.338499 0.912319 0.831056 0.129903 0.418467 0.611778 0.612183 0.702925 0.940257 0.208405 0.374062 0.133182 0.718674 0.020039 0.550298 0.427948 0.269296 0.073394 0.428005 -1299915202
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
