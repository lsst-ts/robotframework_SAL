*** Settings ***
Documentation    M1M3_AppliedVelocityForces communications tests.
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
${component}    AppliedVelocityForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 48.9379 0.156564 0.040208 0.914951 0.054172 0.262878 0.595208 0.755701 0.433042 0.182878 0.083232 0.099323 0.397638 0.332756 0.872455 0.896017 0.480246 0.471225 0.272692 0.810859 0.885853 0.6286 0.790401 0.428747 0.874607 0.523158 0.146391 0.860056 0.621613 0.192755 0.757524 0.52072 0.228465 0.50259 0.870233 0.559734 0.199733 0.74808 0.020579 0.072155 0.693954 0.042045 0.338936 0.849159 0.796304 0.055422 0.70743 0.89103 0.194556 0.459659 0.893412 0.735117 0.400393 0.347122 0.148139 0.459117 0.658973 0.987901 0.564356 0.972929 0.309404 0.147764 0.322514 0.302824 0.269158 0.309915 0.137736 0.187249 0.320425 0.51748 0.111447 0.710155 0.780803 0.049124 0.16735 0.934755 0.498993 0.001977 0.841077 0.051681 0.491092 0.113231 0.613432 0.565473 0.352414 0.176822 0.381413 0.275924 0.966534 0.330532 0.506638 0.253109 0.250867 0.465648 0.579145 0.723809 0.095677 0.208162 0.394578 0.72093 0.037084 0.063141 0.937708 0.879763 0.917761 0.277002 0.83783 0.138314 0.301739 0.889045 0.963892 0.965226 0.142324 0.759678 0.569877 0.241527 0.158313 0.957709 0.386295 0.486072 0.445694 0.804795 0.188997 0.752581 0.3164 0.729518 0.736552 0.321185 0.945934 0.977072 0.758391 0.028941 0.349601 0.980384 0.164397 0.488696 0.878971 0.271544 0.967349 0.121636 0.811392 0.945124 0.703771 0.608812 0.215186 0.379936 0.304459 0.807055 0.522582 0.248003 0.960093 0.645034 0.939981 0.284449 0.292918 0.101166 0.269069 0.45048 0.677442 0.435363 0.346679 0.36811 0.645614 0.005832 0.631257 0.336466 0.061706 0.869917 0.693907 0.155855 0.627239 0.740522 0.019999 0.457885 0.934703 0.790492 0.792543 0.23694 0.361417 0.964428 0.062086 0.782683 0.957065 0.129318 0.00111 0.84376 0.370305 0.33211 0.441765 0.415388 0.424577 0.946468 0.581279 0.019599 0.718091 0.594553 0.492866 0.379481 0.993253 0.420491 0.012911 0.53182 0.292085 0.447052 0.683735 0.984476 0.740645 0.743357 0.1602 0.90215 0.865047 0.105721 0.409082 0.693401 0.578051 0.155402 0.066647 0.234642 0.576844 0.341716 0.097738 0.029821 0.757874 0.953174 0.54444 0.875083 0.442968 0.268251 0.329627 0.447161 0.94199 0.201393 0.420555 0.460278 0.836402 0.91489 0.576856 0.408753 0.276578 0.187579 0.811303 0.144793 0.688008 0.246426 0.020369 0.443998 0.756127 0.415839 0.743964 0.045238 0.219357 0.67014 0.738992 0.81246 0.941676 0.33359 0.486366 0.866792 0.828687 0.738379 0.785497 0.396989 0.640405 0.115684 0.463526 0.7859 0.153863 0.810487 0.799238 0.282057 0.312535 0.174109 0.381883 0.652248 0.944081 0.471407 -1909968292
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedVelocityForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
