*** Settings ***
Documentation    Camera_takeImages communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    camera
${component}    takeImages
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -402619830 37.7065 0 1 0 0 wHZSilQaGiSqgALMwAQNhWtOMwynyiMmwCLRfyiWQpkHJOWsHBMnMFDnwLmWgATfmfkWWrHcSuLAaByTLkXrUHNmPEjjIeGavGbVfqrWAMQfLsqPdFprHWYkKElUGwqfgiOTMLcwZDbulwXfGWtzYJzyKonQuQQloPiolmrYXNrmKMSvDGQVILuGEhuuYzRvmsawCLQqMBWPsiODpzjJdBcGxiOFbiwQBMSYOCAUqzsDEqzflCiMGbykMWlOmQvT
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -402619830 37.7065 0 1 0 0 wHZSilQaGiSqgALMwAQNhWtOMwynyiMmwCLRfyiWQpkHJOWsHBMnMFDnwLmWgATfmfkWWrHcSuLAaByTLkXrUHNmPEjjIeGavGbVfqrWAMQfLsqPdFprHWYkKElUGwqfgiOTMLcwZDbulwXfGWtzYJzyKonQuQQloPiolmrYXNrmKMSvDGQVILuGEhuuYzRvmsawCLQqMBWPsiODpzjJdBcGxiOFbiwQBMSYOCAUqzsDEqzflCiMGbykMWlOmQvT
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    numImages : -402619830    1
    Should Contain X Times    ${output}    expTime : 37.7065    1
    Should Contain X Times    ${output}    shutter : 0    1
    Should Contain X Times    ${output}    science : 1    1
    Should Contain X Times    ${output}    guide : 0    1
    Should Contain X Times    ${output}    wfs : 0    1
    Should Contain X Times    ${output}    imageSequenceName : wHZSilQaGiSqgALMwAQNhWtOMwynyiMmwCLRfyiWQpkHJOWsHBMnMFDnwLmWgATfmfkWWrHcSuLAaByTLkXrUHNmPEjjIeGavGbVfqrWAMQfLsqPdFprHWYkKElUGwqfgiOTMLcwZDbulwXfGWtzYJzyKonQuQQloPiolmrYXNrmKMSvDGQVILuGEhuuYzRvmsawCLQqMBWPsiODpzjJdBcGxiOFbiwQBMSYOCAUqzsDEqzflCiMGbykMWlOmQvT    1
    Should Contain    ${output}    === command takeImages issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command takeImages received =
    Should Contain    ${output}    device : 
    Should Contain    ${output}    property : 
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    numImages : -402619830    1
    Should Contain X Times    ${output}    expTime : 37.7065    1
    Should Contain X Times    ${output}    shutter : 0    1
    Should Contain X Times    ${output}    science : 1    1
    Should Contain X Times    ${output}    guide : 0    1
    Should Contain X Times    ${output}    wfs : 0    1
    Should Contain X Times    ${output}    imageSequenceName : wHZSilQaGiSqgALMwAQNhWtOMwynyiMmwCLRfyiWQpkHJOWsHBMnMFDnwLmWgATfmfkWWrHcSuLAaByTLkXrUHNmPEjjIeGavGbVfqrWAMQfLsqPdFprHWYkKElUGwqfgiOTMLcwZDbulwXfGWtzYJzyKonQuQQloPiolmrYXNrmKMSvDGQVILuGEhuuYzRvmsawCLQqMBWPsiODpzjJdBcGxiOFbiwQBMSYOCAUqzsDEqzflCiMGbykMWlOmQvT    1
    Should Contain X Times    ${output}    === [ackCommand_takeImages] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
