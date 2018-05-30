*** Settings ***
Documentation    M1M3_RejectedVelocityForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedVelocityForces
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_log

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage :  input parameters...

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Logger.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_log
    ${output}=    Read Until    logger ready =
    Log    ${output}
    Should Contain    ${output}    Event ${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 55.7883 0.112344 0.370125 0.191604 0.600862 0.418138 0.341671 0.772594 0.906132 0.712095 0.294098 0.177151 0.003984 0.712409 0.457842 0.935867 0.877233 0.877583 0.874106 0.97395 0.550465 0.315056 0.848808 0.870533 0.383695 0.72285 0.345847 0.975416 0.337407 0.965449 0.00976 0.788995 0.879842 0.389922 0.67597 0.437534 0.308368 0.449929 0.415367 0.490916 0.455845 0.001344 0.166968 0.224883 0.646976 0.181682 0.378035 0.931756 0.207482 0.126196 0.937259 0.85349 0.320469 0.669746 0.999978 0.242619 0.17451 0.082577 0.600636 0.41005 0.598908 0.610102 0.188096 0.577464 0.619451 0.210766 0.960044 0.037453 0.479528 0.873831 0.998523 0.124711 0.994079 0.591407 0.970269 0.281112 0.752009 0.768047 0.884878 0.710689 0.74659 0.110805 0.984152 0.315612 0.251557 0.482888 0.729785 0.317907 0.556907 0.444719 0.21776 0.87397 0.704941 0.367717 0.20323 0.029191 0.134983 0.724643 0.401302 0.037284 0.075811 0.759614 0.487378 0.520367 0.159131 0.774096 0.329186 0.245299 0.483055 0.021589 0.158194 0.546842 0.509245 0.199356 0.723885 0.117738 0.570413 0.073547 0.819768 0.471183 0.694908 0.170582 0.494783 0.764757 0.471072 0.359135 0.567371 0.412849 0.995734 0.698973 0.447369 0.710662 0.509093 0.636508 0.852675 0.18116 0.493547 0.123253 0.17472 0.084337 0.65816 0.638514 0.295869 0.50684 0.812206 0.741223 0.028983 0.721275 0.157499 0.381433 0.139179 0.60987 0.266941 0.07267 0.818665 0.356564 0.836586 0.788954 0.327438 0.531612 0.421317 0.060924 0.922322 0.877459 0.392792 0.688646 0.091938 0.946649 0.968097 0.007622 0.712041 0.78989 0.768937 0.385574 0.116273 0.65501 0.415485 0.14279 0.151721 0.535934 0.615472 0.21053 0.315832 0.283984 0.408 0.404026 0.196807 0.388635 0.556838 0.045167 0.294073 0.060954 0.979285 0.329686 0.553864 0.494773 0.062924 0.742014 0.149188 0.145387 0.798664 0.771529 0.034292 0.925228 0.258521 0.331339 0.139811 0.473447 0.268469 0.467142 0.885529 0.906734 0.748997 0.513844 0.404621 0.984939 0.945802 0.30784 0.018643 0.295809 0.617393 0.647362 0.327015 0.125602 0.234148 0.176864 0.355628 0.370065 0.029798 0.773863 0.929848 0.92683 0.715352 0.571784 0.731345 0.006729 0.112885 0.73002 0.737403 0.80898 0.20832 0.043345 0.539487 0.921907 0.905904 0.459685 0.062442 0.236738 0.40204 0.69116 0.29445 0.134185 0.899053 0.579407 0.990021 0.547373 0.356111 0.363838 0.96713 0.632309 0.437568 0.691627 0.605468 0.193551 0.798469 0.154479 0.920829 0.675258 0.949136 0.918053 0.898921 0.567724 0.236421 0.411648 0.079165 0.05188 1766369427
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedVelocityForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedVelocityForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1766369427
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedVelocityForces received =     1
    Should Contain    ${output}    Timestamp : 55.7883
    Should Contain    ${output}    XForces : 0.112344
    Should Contain    ${output}    YForces : 0.370125
    Should Contain    ${output}    ZForces : 0.191604
    Should Contain    ${output}    Fx : 0.600862
    Should Contain    ${output}    Fy : 0.418138
    Should Contain    ${output}    Fz : 0.341671
    Should Contain    ${output}    Mx : 0.772594
    Should Contain    ${output}    My : 0.906132
    Should Contain    ${output}    Mz : 0.712095
    Should Contain    ${output}    ForceMagnitude : 0.294098
    Should Contain    ${output}    priority : 0.177151
