*** Settings ***
Documentation    M1M3_ApplyOffsetForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    ApplyOffsetForces
${timeout}    30s

*** Test Cases ***
Verify Component Commander and Controller
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_controller

Start Commander - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage : \ input parameters...

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 0.251761 0.438395 0.259596 0.493272 0.623762 0.681677 0.718218 0.905555 0.327334 0.616663 0.29223 0.987107 0.233843 0.354779 0.793482 0.476767 0.188157 0.784073 0.39317 0.835697 0.921976 0.03288 0.511298 0.88887 0.717947 0.942286 0.525058 0.684344 0.565014 0.496572 0.462584 0.962521 0.43272 0.175891 0.217305 0.922792 0.323343 0.633352 0.025967 0.389823 0.281338 0.923204 0.586725 0.259361 0.072904 0.342239 0.937948 0.934885 0.595025 0.744613 0.980759 0.660345 0.374148 0.111215 0.135768 0.948881 0.50216 0.020168 0.521871 0.290978 0.668453 0.162938 0.052576 0.314054 0.968205 0.916302 0.458019 0.766478 0.403252 0.185129 0.308476 0.691677 0.750088 0.260278 0.870961 0.072998 0.022917 0.494891 0.829343 0.213475 0.956219 0.898427 0.017139 0.468035 0.348929 0.778455 0.85946 0.575543 0.429146 0.817726 0.846429 0.945864 0.749326 0.759291 0.367683 0.644616 0.637834 0.615145 0.089598 0.17795 0.808875 0.158465 0.563397 0.051415 0.054475 0.126366 0.997894 0.82073 0.304554 0.482483 0.193396 0.064601 0.200631 0.830334 0.489296 0.808193 0.254365 0.572287 0.367294 0.304379 0.702396 0.483619 0.342269 0.353062 0.381427 0.051804 0.535211 0.048165 0.881655 0.906317 0.383479 0.118457 0.149312 0.123857 0.154619 0.182369 0.556077 0.326967 0.181275 0.121597 0.470723 0.446152 0.264543 0.154992 0.019164 0.087582 0.751782 0.115214 0.660155 0.814113 0.144793 0.93496 0.379281 0.105683 0.332853 0.603411 0.807028 0.609962 0.012439 0.18792 0.685471 0.353867 0.217962 0.453812 0.709362 0.872516 0.861306 0.819195 0.940765 0.909876 0.578099 0.914947 0.332908 0.430843 0.905101 0.781116 0.861955 0.803175 0.855487 0.319556 0.653683 0.62767 0.856853 0.263855 0.118767 0.940101 0.807484 0.433665 0.22828 0.372434 0.537019 0.448885 0.082526 0.190349 0.036377 0.549935 0.258601 0.790757 0.79166 0.833245 0.793779 0.32823 0.1355 0.170678 0.044335 0.125768 0.918763 0.6159 0.899151 0.907211 0.320423 0.693923 0.02107 0.505151 0.160517 0.065999 0.715372 0.814342 0.310893 0.815798 0.138539 0.701537 0.167816 0.600975 0.600703 0.108622 0.733004 0.718397 0.117361 0.556908 0.00655 0.035305 0.862271 0.239495 0.406089 0.345322 0.502409 0.106198 0.671634 0.692545 0.710849 0.465505 0.443029 0.415088 0.332098 0.109091 0.309977 0.564205 0.923732 0.821234 0.704211 0.030621 0.150069 0.697059 0.431163 0.373478 0.040083 0.881128 0.886484 0.691885 0.693556 0.457453 0.209678 0.044938 0.548199 0.786156 0.16632 0.086266
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Controller.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_controller
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 0.251761 0.438395 0.259596 0.493272 0.623762 0.681677 0.718218 0.905555 0.327334 0.616663 0.29223 0.987107 0.233843 0.354779 0.793482 0.476767 0.188157 0.784073 0.39317 0.835697 0.921976 0.03288 0.511298 0.88887 0.717947 0.942286 0.525058 0.684344 0.565014 0.496572 0.462584 0.962521 0.43272 0.175891 0.217305 0.922792 0.323343 0.633352 0.025967 0.389823 0.281338 0.923204 0.586725 0.259361 0.072904 0.342239 0.937948 0.934885 0.595025 0.744613 0.980759 0.660345 0.374148 0.111215 0.135768 0.948881 0.50216 0.020168 0.521871 0.290978 0.668453 0.162938 0.052576 0.314054 0.968205 0.916302 0.458019 0.766478 0.403252 0.185129 0.308476 0.691677 0.750088 0.260278 0.870961 0.072998 0.022917 0.494891 0.829343 0.213475 0.956219 0.898427 0.017139 0.468035 0.348929 0.778455 0.85946 0.575543 0.429146 0.817726 0.846429 0.945864 0.749326 0.759291 0.367683 0.644616 0.637834 0.615145 0.089598 0.17795 0.808875 0.158465 0.563397 0.051415 0.054475 0.126366 0.997894 0.82073 0.304554 0.482483 0.193396 0.064601 0.200631 0.830334 0.489296 0.808193 0.254365 0.572287 0.367294 0.304379 0.702396 0.483619 0.342269 0.353062 0.381427 0.051804 0.535211 0.048165 0.881655 0.906317 0.383479 0.118457 0.149312 0.123857 0.154619 0.182369 0.556077 0.326967 0.181275 0.121597 0.470723 0.446152 0.264543 0.154992 0.019164 0.087582 0.751782 0.115214 0.660155 0.814113 0.144793 0.93496 0.379281 0.105683 0.332853 0.603411 0.807028 0.609962 0.012439 0.18792 0.685471 0.353867 0.217962 0.453812 0.709362 0.872516 0.861306 0.819195 0.940765 0.909876 0.578099 0.914947 0.332908 0.430843 0.905101 0.781116 0.861955 0.803175 0.855487 0.319556 0.653683 0.62767 0.856853 0.263855 0.118767 0.940101 0.807484 0.433665 0.22828 0.372434 0.537019 0.448885 0.082526 0.190349 0.036377 0.549935 0.258601 0.790757 0.79166 0.833245 0.793779 0.32823 0.1355 0.170678 0.044335 0.125768 0.918763 0.6159 0.899151 0.907211 0.320423 0.693923 0.02107 0.505151 0.160517 0.065999 0.715372 0.814342 0.310893 0.815798 0.138539 0.701537 0.167816 0.600975 0.600703 0.108622 0.733004 0.718397 0.117361 0.556908 0.00655 0.035305 0.862271 0.239495 0.406089 0.345322 0.502409 0.106198 0.671634 0.692545 0.710849 0.465505 0.443029 0.415088 0.332098 0.109091 0.309977 0.564205 0.923732 0.821234 0.704211 0.030621 0.150069 0.697059 0.431163 0.373478 0.040083 0.881128 0.886484 0.691885 0.693556 0.457453 0.209678 0.044938 0.548199 0.786156 0.16632 0.086266
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    XForces : 0.251761    1
    Should Contain X Times    ${output}    YForces : 0.233843    1
    Should Contain X Times    ${output}    ZForces : 0.793779    1
    Should Contain    ${output}    === command ApplyOffsetForces issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command ApplyOffsetForces received =
    Should Contain    ${output}    device : 
    Should Contain    ${output}    property : 
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    XForces : 0.251761    1
    Should Contain X Times    ${output}    YForces : 0.233843    1
    Should Contain X Times    ${output}    ZForces : 0.793779    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyOffsetForces] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
