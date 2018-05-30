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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 0.367445 0.192305 0.236803 0.878884 0.132808 0.93889 0.054945 0.239407 0.521717 0.396745 0.549373 0.031552 0.265289 0.115444 0.766406 0.684452 0.530318 0.829573 0.81386 0.001043 0.173415 0.796079 0.260834 0.046774 0.017552 0.005477 0.152791 0.80226 0.115928 0.005568 0.542189 0.341928 0.319252 0.336085 0.398186 0.101562 0.098474 0.210705 0.728421 0.835978 0.276648 0.105085 0.503411 0.304175 0.777874 0.612189 0.782907 0.395543 0.152597 0.631529 0.655924 0.170242 0.074215 0.041311 0.526632 0.821245 0.004894 0.11186 0.139209 0.331239 0.007181 0.447344 0.417202 0.418489 0.32538 0.531882 0.86645 0.044597 0.42021 0.901539 0.534812 0.52526 0.918922 0.033735 0.330541 0.112544 0.317077 0.470078 0.472615 0.883705 0.29916 0.404336 0.650771 0.395526 0.137014 0.359762 0.742836 0.739038 0.07271 0.867218 0.958627 0.956154 0.171891 0.147883 0.442411 0.812436 0.799327 0.625236 0.404275 0.51426 0.735879 0.863348 0.716499 0.283225 0.895424 0.99447 0.704844 0.106841 0.818099 0.863435 0.819232 0.580775 0.776679 0.962435 0.292826 0.357856 0.678701 0.875576 0.103634 0.531435 0.855396 0.360168 0.11991 0.370593 0.620398 0.058758 0.798611 0.738124 0.732791 0.379729 0.057298 0.381858 0.221636 0.646089 0.898106 0.214218 0.445955 0.783031 0.205108 0.814726 0.905584 0.226866 0.450441 0.200783 0.199326 0.92823 0.714997 0.315021 0.858256 0.820561 0.161559 0.428922 0.950463 0.836928 0.348866 0.991963 0.111105 0.589417 0.956226 0.209422 0.027303 0.533572 0.49646 0.49078 0.759614 0.375158 0.936336 0.626356 0.44204 0.896997 0.988942 0.524452 0.593165 0.468592 0.412017 0.66725 0.92437 0.005485 0.162674 0.811274 0.556399 0.457641 0.587553 0.656137 0.209278 0.947203 0.686055 0.825145 0.27077 0.442617 0.834943 0.401693 0.047937 0.778265 0.614497 0.283763 0.335788 0.5761 0.606734 0.564744 0.155608 0.915495 0.978547 0.367083 0.98761 0.932353 0.049199 0.161141 0.870113 0.831756 0.725269 0.856674 0.994807 0.842039 0.990741 0.790298 0.293833 0.728721 0.353081 0.992388 0.127665 0.782488 0.015588 0.724412 0.152675 0.963995 0.816645 0.950236 0.636806 0.273558 0.709213 0.769159 0.250974 0.954911 0.54613 0.892997 0.991407 0.574509 0.188109 0.872731 0.744315 0.447867 0.095772 0.446415 0.876134 0.102645 0.570195 0.674477 0.763605 0.649506 0.826137 0.732317 0.037806 0.329515 0.756646 0.230119 0.95485 0.477999 0.131199 0.170483 0.091103 0.667576 0.909925 0.884857 0.424346 0.399842 0.165192 0.45524
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 0.367445 0.192305 0.236803 0.878884 0.132808 0.93889 0.054945 0.239407 0.521717 0.396745 0.549373 0.031552 0.265289 0.115444 0.766406 0.684452 0.530318 0.829573 0.81386 0.001043 0.173415 0.796079 0.260834 0.046774 0.017552 0.005477 0.152791 0.80226 0.115928 0.005568 0.542189 0.341928 0.319252 0.336085 0.398186 0.101562 0.098474 0.210705 0.728421 0.835978 0.276648 0.105085 0.503411 0.304175 0.777874 0.612189 0.782907 0.395543 0.152597 0.631529 0.655924 0.170242 0.074215 0.041311 0.526632 0.821245 0.004894 0.11186 0.139209 0.331239 0.007181 0.447344 0.417202 0.418489 0.32538 0.531882 0.86645 0.044597 0.42021 0.901539 0.534812 0.52526 0.918922 0.033735 0.330541 0.112544 0.317077 0.470078 0.472615 0.883705 0.29916 0.404336 0.650771 0.395526 0.137014 0.359762 0.742836 0.739038 0.07271 0.867218 0.958627 0.956154 0.171891 0.147883 0.442411 0.812436 0.799327 0.625236 0.404275 0.51426 0.735879 0.863348 0.716499 0.283225 0.895424 0.99447 0.704844 0.106841 0.818099 0.863435 0.819232 0.580775 0.776679 0.962435 0.292826 0.357856 0.678701 0.875576 0.103634 0.531435 0.855396 0.360168 0.11991 0.370593 0.620398 0.058758 0.798611 0.738124 0.732791 0.379729 0.057298 0.381858 0.221636 0.646089 0.898106 0.214218 0.445955 0.783031 0.205108 0.814726 0.905584 0.226866 0.450441 0.200783 0.199326 0.92823 0.714997 0.315021 0.858256 0.820561 0.161559 0.428922 0.950463 0.836928 0.348866 0.991963 0.111105 0.589417 0.956226 0.209422 0.027303 0.533572 0.49646 0.49078 0.759614 0.375158 0.936336 0.626356 0.44204 0.896997 0.988942 0.524452 0.593165 0.468592 0.412017 0.66725 0.92437 0.005485 0.162674 0.811274 0.556399 0.457641 0.587553 0.656137 0.209278 0.947203 0.686055 0.825145 0.27077 0.442617 0.834943 0.401693 0.047937 0.778265 0.614497 0.283763 0.335788 0.5761 0.606734 0.564744 0.155608 0.915495 0.978547 0.367083 0.98761 0.932353 0.049199 0.161141 0.870113 0.831756 0.725269 0.856674 0.994807 0.842039 0.990741 0.790298 0.293833 0.728721 0.353081 0.992388 0.127665 0.782488 0.015588 0.724412 0.152675 0.963995 0.816645 0.950236 0.636806 0.273558 0.709213 0.769159 0.250974 0.954911 0.54613 0.892997 0.991407 0.574509 0.188109 0.872731 0.744315 0.447867 0.095772 0.446415 0.876134 0.102645 0.570195 0.674477 0.763605 0.649506 0.826137 0.732317 0.037806 0.329515 0.756646 0.230119 0.95485 0.477999 0.131199 0.170483 0.091103 0.667576 0.909925 0.884857 0.424346 0.399842 0.165192 0.45524
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    XForces : 0.367445    1
    Should Contain X Times    ${output}    YForces : 0.265289    1
    Should Contain X Times    ${output}    ZForces : 0.155608    1
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
    Should Contain X Times    ${output}    XForces : 0.367445    1
    Should Contain X Times    ${output}    YForces : 0.265289    1
    Should Contain X Times    ${output}    ZForces : 0.155608    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyOffsetForces] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
