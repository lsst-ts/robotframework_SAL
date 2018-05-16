*** Settings ***
Documentation    Hexapod_configureElevationRawLUT commander/controller tests.
Force Tags    cpp    
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 32666 17923 -30667 9718 13976 -17420 23148 -30905 32346 6330 -20498 -31952 -15058 -32198 -1453 29658 -19112 -15038 -8214 0.389587336913 0.737134053267 0.890419730297 0.295038519326 0.385991662452 0.135019875371 0.535547832287 0.273311267542 0.213058638153 0.186297985624 0.993677155106 0.123261222438 0.396384643618 0.434756418388 0.670248492612 0.822877133712 0.844480118603 0.285496050554 0.339686008694 0.0476686905148 0.616255256869 0.895591248996 0.459533161252 0.709708203345 0.130935403056 0.805180194398 0.634627541481 0.70850442777 0.443070355296 0.817010055563 0.877877502852 0.471036936842 0.294981268721 0.776423724327 0.348783845895 0.355503681946 0.137477715552 0.789331180146 0.634580551027 0.283832467867 0.255433261912 0.567124225323 0.809383512117 0.021489422554 0.635098673004 0.219254023404 0.00768106499694 0.502362728525 0.49659020108 0.623274871782 0.161662214606 0.926971351162 0.928361759153 0.63303519562 0.670533886971 0.465759361206 0.821074829271 0.20692720672 0.474192011571 0.312036632464 0.105687992947 0.557029939121 0.743322773257 0.111521412379 0.561120660383 0.539753082051 0.0650098997147 0.451742623671 0.438790295655 0.0714069528014 0.834614388097 0.297304487851 0.330548662598 0.982367510609 0.604521363584 0.915655255044 0.351300139422 0.850085626254 0.0779921288555 0.49015160854 0.275611895387 0.205315911917 0.1759983456 0.832307076554 0.405973924372 0.620335826821 0.121616893089 0.546720205788 0.356093924045 0.191404521102 0.638977798411 0.532827224924 0.604963633653 0.358829443922 0.269441226254 0.901736546611 0.86679657231 0.651134753702 0.672801132241 0.864967763346 0.046526961828 0.750429751956 0.394618095568 0.527055512451 0.221783165103 0.705904719799 0.19790337511 0.0472687125598 0.811302027346 0.496454327968 0.114903225734 0.0711595365928 0.40101908475 0.734932823691
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 32666 17923 -30667 9718 13976 -17420 23148 -30905 32346 6330 -20498 -31952 -15058 -32198 -1453 29658 -19112 -15038 -8214 0.389587336913 0.737134053267 0.890419730297 0.295038519326 0.385991662452 0.135019875371 0.535547832287 0.273311267542 0.213058638153 0.186297985624 0.993677155106 0.123261222438 0.396384643618 0.434756418388 0.670248492612 0.822877133712 0.844480118603 0.285496050554 0.339686008694 0.0476686905148 0.616255256869 0.895591248996 0.459533161252 0.709708203345 0.130935403056 0.805180194398 0.634627541481 0.70850442777 0.443070355296 0.817010055563 0.877877502852 0.471036936842 0.294981268721 0.776423724327 0.348783845895 0.355503681946 0.137477715552 0.789331180146 0.634580551027 0.283832467867 0.255433261912 0.567124225323 0.809383512117 0.021489422554 0.635098673004 0.219254023404 0.00768106499694 0.502362728525 0.49659020108 0.623274871782 0.161662214606 0.926971351162 0.928361759153 0.63303519562 0.670533886971 0.465759361206 0.821074829271 0.20692720672 0.474192011571 0.312036632464 0.105687992947 0.557029939121 0.743322773257 0.111521412379 0.561120660383 0.539753082051 0.0650098997147 0.451742623671 0.438790295655 0.0714069528014 0.834614388097 0.297304487851 0.330548662598 0.982367510609 0.604521363584 0.915655255044 0.351300139422 0.850085626254 0.0779921288555 0.49015160854 0.275611895387 0.205315911917 0.1759983456 0.832307076554 0.405973924372 0.620335826821 0.121616893089 0.546720205788 0.356093924045 0.191404521102 0.638977798411 0.532827224924 0.604963633653 0.358829443922 0.269441226254 0.901736546611 0.86679657231 0.651134753702 0.672801132241 0.864967763346 0.046526961828 0.750429751956 0.394618095568 0.527055512451 0.221783165103 0.705904719799 0.19790337511 0.0472687125598 0.811302027346 0.496454327968 0.114903225734 0.0711595365928 0.40101908475 0.734932823691
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    elevIndex : 32666    1
    Should Contain X Times    ${output}    fz1 : 0.389587336913    1
    Should Contain X Times    ${output}    fz2 : 0.0476686905148    1
    Should Contain X Times    ${output}    fz3 : 0.634580551027    1
    Should Contain X Times    ${output}    fz4 : 0.20692720672    1
    Should Contain X Times    ${output}    fz5 : 0.351300139422    1
    Should Contain X Times    ${output}    fz6 : 0.901736546611    1
    Should Contain    ${output}    === command configureElevationRawLUT issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command configureElevationRawLUT received =
    Should Contain    ${output}    device : 
    Should Contain    ${output}    property : 
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    elevIndex : 32666    1
    Should Contain X Times    ${output}    fz1 : 0.389587336913    1
    Should Contain X Times    ${output}    fz2 : 0.0476686905148    1
    Should Contain X Times    ${output}    fz3 : 0.634580551027    1
    Should Contain X Times    ${output}    fz4 : 0.20692720672    1
    Should Contain X Times    ${output}    fz5 : 0.351300139422    1
    Should Contain X Times    ${output}    fz6 : 0.901736546611    1
    Should Contain X Times    ${output}    === [ackCommand_configureElevationRawLUT] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
