*** Settings ***
Documentation    M1M3_ApplyAberrationForces communications tests.
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
${component}    ApplyAberrationForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 0.192064 0.656914 0.937113 0.042305 0.252938 0.33735 0.923577 0.826492 0.486774 0.63704 0.009202 0.597782 0.303152 0.505742 0.126498 0.405729 0.932733 0.178645 0.979364 0.73261 0.491435 0.419927 0.4324 0.104225 0.130471 0.874051 0.954643 0.915459 0.635263 0.568485 0.80321 0.231558 0.640385 0.045181 0.323123 0.494269 0.983071 0.063065 0.21657 0.121312 0.369728 0.634604 0.370306 0.352729 0.327022 0.38767 0.835711 0.252211 0.180019 0.407894 0.108471 0.100293 0.39748 0.141439 0.930529 0.792906 0.115381 0.887651 0.088352 0.693911 0.352417 0.052082 0.687256 0.982718 0.520971 0.976393 0.828772 0.601918 0.310353 0.877991 0.584538 0.908666 0.018236 0.483803 0.782145 0.723605 0.984318 0.84151 0.259103 0.28797 0.502276 0.913705 0.502758 0.735868 0.936861 0.491197 0.544065 0.447106 0.296456 0.435786 0.563471 0.834628 0.164285 0.431929 0.40143 0.178263 0.621507 0.608047 0.138423 0.205263 0.930821 0.193634 0.763127 0.121307 0.553199 0.270961 0.605546 0.987673 0.355579 0.132648 0.918297 0.406183 0.091804 0.161453 0.708306 0.862301 0.274661 0.681911 0.466177 0.466767 0.848541 0.021898 0.358707 0.622196 0.194192 0.509495 0.306981 0.559209 0.665182 0.246504 0.775599 0.089669 0.741912 0.593722 0.857381 0.130206 0.521549 0.494344 0.004585 0.870817 0.466089 0.507588 0.953461 0.308649 0.35946 0.544151 0.991303 0.024174 0.85066 0.257949 0.449664 0.281804 0.493412 0.247063 0.020936 0.753186
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 0.192064 0.656914 0.937113 0.042305 0.252938 0.33735 0.923577 0.826492 0.486774 0.63704 0.009202 0.597782 0.303152 0.505742 0.126498 0.405729 0.932733 0.178645 0.979364 0.73261 0.491435 0.419927 0.4324 0.104225 0.130471 0.874051 0.954643 0.915459 0.635263 0.568485 0.80321 0.231558 0.640385 0.045181 0.323123 0.494269 0.983071 0.063065 0.21657 0.121312 0.369728 0.634604 0.370306 0.352729 0.327022 0.38767 0.835711 0.252211 0.180019 0.407894 0.108471 0.100293 0.39748 0.141439 0.930529 0.792906 0.115381 0.887651 0.088352 0.693911 0.352417 0.052082 0.687256 0.982718 0.520971 0.976393 0.828772 0.601918 0.310353 0.877991 0.584538 0.908666 0.018236 0.483803 0.782145 0.723605 0.984318 0.84151 0.259103 0.28797 0.502276 0.913705 0.502758 0.735868 0.936861 0.491197 0.544065 0.447106 0.296456 0.435786 0.563471 0.834628 0.164285 0.431929 0.40143 0.178263 0.621507 0.608047 0.138423 0.205263 0.930821 0.193634 0.763127 0.121307 0.553199 0.270961 0.605546 0.987673 0.355579 0.132648 0.918297 0.406183 0.091804 0.161453 0.708306 0.862301 0.274661 0.681911 0.466177 0.466767 0.848541 0.021898 0.358707 0.622196 0.194192 0.509495 0.306981 0.559209 0.665182 0.246504 0.775599 0.089669 0.741912 0.593722 0.857381 0.130206 0.521549 0.494344 0.004585 0.870817 0.466089 0.507588 0.953461 0.308649 0.35946 0.544151 0.991303 0.024174 0.85066 0.257949 0.449664 0.281804 0.493412 0.247063 0.020936 0.753186
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    ZForces : 0.192064    1
    Should Contain    ${output}    === command ApplyAberrationForces issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command ApplyAberrationForces received =
    Should Contain    ${output}    device : 
    Should Contain    ${output}    property : 
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    ZForces : 0.192064    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyAberrationForces] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
