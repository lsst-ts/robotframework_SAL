*** Settings ***
Documentation    Hexapod_configureElevationRawLUT communications tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    hexapod
${component}    configureElevationRawLUT
${timeout}    30s

*** Test Cases ***
Verify Component Commander and Controller
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_${component}.py

Start Commander - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments :

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -19831 10494 -31293 -5477 -9084 29867 30278 -31608 20791 11905 -22873 -20413 9627 -10705 -12173 13283 -23798 -32666 25204 0.540059 0.871881 0.406026 0.155242 0.917049 0.272103 0.478055 0.898947 0.768612 0.31137 0.768625 0.747309 0.947242 0.4494 0.15123 0.958152 0.154938 0.276915 0.640694 0.470373 0.174086 0.592936 0.042926 0.365671 0.304914 0.789134 0.120348 0.103656 0.715041 0.425055 0.629099 0.006559 0.19691 0.209043 0.953667 0.841501 0.794888 0.672745 0.476626 0.862397 0.37423 0.716338 0.321471 0.472095 0.070466 0.799669 0.327952 0.689248 0.340858 0.893732 0.02045 0.839242 0.279413 0.079978 0.413189 0.529997 0.123008 0.984692 0.055177 0.338242 0.563269 0.445793 0.443485 0.435364 0.73118 0.25231 0.673373 0.018808 0.291145 0.198925 0.587044 0.301401 0.463088 0.569992 0.079838 0.00104 0.69186 0.036064 0.560633 0.630123 0.178021 0.933519 0.555696 0.102387 0.663893 0.272774 0.171133 0.033246 0.018412 0.759085 0.135312 0.469956 0.422415 0.751814 0.26168 0.78408 0.511726 0.711404 0.149655 0.708465 0.273508 0.814844 0.245082 0.580821 0.541531 0.794913 0.22468 0.333008 0.084347 0.281846 0.49065 0.628331 0.836761 0.602259
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Controller.
    ${input}=    Write    python ${subSystem}_Controller_${component}.py
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -19831 10494 -31293 -5477 -9084 29867 30278 -31608 20791 11905 -22873 -20413 9627 -10705 -12173 13283 -23798 -32666 25204 0.540059 0.871881 0.406026 0.155242 0.917049 0.272103 0.478055 0.898947 0.768612 0.31137 0.768625 0.747309 0.947242 0.4494 0.15123 0.958152 0.154938 0.276915 0.640694 0.470373 0.174086 0.592936 0.042926 0.365671 0.304914 0.789134 0.120348 0.103656 0.715041 0.425055 0.629099 0.006559 0.19691 0.209043 0.953667 0.841501 0.794888 0.672745 0.476626 0.862397 0.37423 0.716338 0.321471 0.472095 0.070466 0.799669 0.327952 0.689248 0.340858 0.893732 0.02045 0.839242 0.279413 0.079978 0.413189 0.529997 0.123008 0.984692 0.055177 0.338242 0.563269 0.445793 0.443485 0.435364 0.73118 0.25231 0.673373 0.018808 0.291145 0.198925 0.587044 0.301401 0.463088 0.569992 0.079838 0.00104 0.69186 0.036064 0.560633 0.630123 0.178021 0.933519 0.555696 0.102387 0.663893 0.272774 0.171133 0.033246 0.018412 0.759085 0.135312 0.469956 0.422415 0.751814 0.26168 0.78408 0.511726 0.711404 0.149655 0.708465 0.273508 0.814844 0.245082 0.580821 0.541531 0.794913 0.22468 0.333008 0.084347 0.281846 0.49065 0.628331 0.836761 0.602259
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    elevIndex : -19831    1
    Should Contain X Times    ${output}    fz1 : 0.540059    1
    Should Contain X Times    ${output}    fz2 : 0.470373    1
    Should Contain X Times    ${output}    fz3 : 0.476626    1
    Should Contain X Times    ${output}    fz4 : 0.984692    1
    Should Contain X Times    ${output}    fz5 : 0.69186    1
    Should Contain X Times    ${output}    fz6 : 0.78408    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    elevIndex(19) = [-19831, 10494, -31293, -5477, -9084, 29867, 30278, -31608, 20791, 11905, -22873, -20413, 9627, -10705, -12173, 13283, -23798, -32666, 25204]    1
    Should Contain X Times    ${output}    fz1(19) = [0.540059, 0.871881, 0.406026, 0.155242, 0.917049, 0.272103, 0.478055, 0.898947, 0.768612, 0.31137, 0.768625, 0.747309, 0.947242, 0.4494, 0.15123, 0.958152, 0.154938, 0.276915, 0.640694]    1
    Should Contain X Times    ${output}    fz2(19) = [0.470373, 0.174086, 0.592936, 0.042926, 0.365671, 0.304914, 0.789134, 0.120348, 0.103656, 0.715041, 0.425055, 0.629099, 0.006559, 0.19691, 0.209043, 0.953667, 0.841501, 0.794888, 0.672745]    1
    Should Contain X Times    ${output}    fz3(19) = [0.476626, 0.862397, 0.37423, 0.716338, 0.321471, 0.472095, 0.070466, 0.799669, 0.327952, 0.689248, 0.340858, 0.893732, 0.02045, 0.839242, 0.279413, 0.079978, 0.413189, 0.529997, 0.123008]    1
    Should Contain X Times    ${output}    fz4(19) = [0.984692, 0.055177, 0.338242, 0.563269, 0.445793, 0.443485, 0.435364, 0.73118, 0.25231, 0.673373, 0.018808, 0.291145, 0.198925, 0.587044, 0.301401, 0.463088, 0.569992, 0.079838, 0.00104]    1
    Should Contain X Times    ${output}    fz5(19) = [0.69186, 0.036064, 0.560633, 0.630123, 0.178021, 0.933519, 0.555696, 0.102387, 0.663893, 0.272774, 0.171133, 0.033246, 0.018412, 0.759085, 0.135312, 0.469956, 0.422415, 0.751814, 0.26168]    1
    Should Contain X Times    ${output}    fz6(19) = [0.78408, 0.511726, 0.711404, 0.149655, 0.708465, 0.273508, 0.814844, 0.245082, 0.580821, 0.541531, 0.794913, 0.22468, 0.333008, 0.084347, 0.281846, 0.49065, 0.628331, 0.836761, 0.602259]    1
    Should Contain X Times    ${output}    === [ackCommand_configureElevationRawLUT] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
