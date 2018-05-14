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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 32199 21048 -3250 -14266 5669 -6882 -1326 17856 -22366 -15111 1111 -29354 18846 23720 12774 7921 -9833 7256 -23774 0.44157145433 0.491105301211 0.615583996654 0.909184686135 0.401723103812 0.348720281473 0.0911822715581 0.873978501602 0.326990176362 0.254150811572 0.891377826719 0.7469404671 0.228469622905 0.118182189055 0.937549787082 0.296575151844 0.499868417702 0.389389747236 0.914503269818 0.0507091147649 0.814731978765 0.394286722191 0.149677970506 0.498725168452 0.294832331348 0.95570482801 0.637122192222 0.42981832243 0.0262511553682 0.248690421748 0.87858309069 0.245594575398 0.682742678446 0.953182273795 0.479786948585 0.379657707604 0.573056113418 0.43832340892 0.301736068968 0.871175027143 0.196735718933 0.995255725798 0.855979527253 0.793759360964 0.920814414638 0.321962683256 0.0802385407968 0.788702946428 0.444777450294 0.208484177774 0.658645121041 0.107056729697 0.490682995592 0.416551407613 0.668098027387 0.39332607013 0.275818255981 0.357832830272 0.775500562411 0.543719496384 0.901855266313 0.440433533819 0.466899787374 0.386770608305 0.129254807844 0.468528164732 0.556388782611 0.867592196544 0.796404411888 0.612050560894 0.647377997718 0.683202717837 0.342733772341 0.588943268131 0.647750500806 0.259973450759 0.760698381708 0.597513936657 0.740486553541 0.975774086043 0.78768456222 0.318358631027 0.591861480087 0.835071305829 0.385052128498 0.638879091201 0.0954488975728 0.8334244656 0.174331745158 0.355454281167 0.283320683862 0.114823986602 0.930290872411 0.552057672623 0.292080494467 0.0029903333319 0.162642685079 0.0310175530151 0.762442214176 0.555791088564 0.737888376222 0.0290332743442 0.842528212958 0.960970710538 0.688678961729 0.876050861691 0.428757337649 0.478770555497 0.726927829415 0.469558217689 0.562395787469 0.724580508388 0.810842512712 0.246515522212
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 32199 21048 -3250 -14266 5669 -6882 -1326 17856 -22366 -15111 1111 -29354 18846 23720 12774 7921 -9833 7256 -23774 0.44157145433 0.491105301211 0.615583996654 0.909184686135 0.401723103812 0.348720281473 0.0911822715581 0.873978501602 0.326990176362 0.254150811572 0.891377826719 0.7469404671 0.228469622905 0.118182189055 0.937549787082 0.296575151844 0.499868417702 0.389389747236 0.914503269818 0.0507091147649 0.814731978765 0.394286722191 0.149677970506 0.498725168452 0.294832331348 0.95570482801 0.637122192222 0.42981832243 0.0262511553682 0.248690421748 0.87858309069 0.245594575398 0.682742678446 0.953182273795 0.479786948585 0.379657707604 0.573056113418 0.43832340892 0.301736068968 0.871175027143 0.196735718933 0.995255725798 0.855979527253 0.793759360964 0.920814414638 0.321962683256 0.0802385407968 0.788702946428 0.444777450294 0.208484177774 0.658645121041 0.107056729697 0.490682995592 0.416551407613 0.668098027387 0.39332607013 0.275818255981 0.357832830272 0.775500562411 0.543719496384 0.901855266313 0.440433533819 0.466899787374 0.386770608305 0.129254807844 0.468528164732 0.556388782611 0.867592196544 0.796404411888 0.612050560894 0.647377997718 0.683202717837 0.342733772341 0.588943268131 0.647750500806 0.259973450759 0.760698381708 0.597513936657 0.740486553541 0.975774086043 0.78768456222 0.318358631027 0.591861480087 0.835071305829 0.385052128498 0.638879091201 0.0954488975728 0.8334244656 0.174331745158 0.355454281167 0.283320683862 0.114823986602 0.930290872411 0.552057672623 0.292080494467 0.0029903333319 0.162642685079 0.0310175530151 0.762442214176 0.555791088564 0.737888376222 0.0290332743442 0.842528212958 0.960970710538 0.688678961729 0.876050861691 0.428757337649 0.478770555497 0.726927829415 0.469558217689 0.562395787469 0.724580508388 0.810842512712 0.246515522212
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    elevIndex : 32199    1
    Should Contain X Times    ${output}    fz1 : 0.44157145433    1
    Should Contain X Times    ${output}    fz2 : 0.0507091147649    1
    Should Contain X Times    ${output}    fz3 : 0.301736068968    1
    Should Contain X Times    ${output}    fz4 : 0.357832830272    1
    Should Contain X Times    ${output}    fz5 : 0.760698381708    1
    Should Contain X Times    ${output}    fz6 : 0.0029903333319    1
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
    Should Contain X Times    ${output}    elevIndex : 32199    1
    Should Contain X Times    ${output}    fz1 : 0.44157145433    1
    Should Contain X Times    ${output}    fz2 : 0.0507091147649    1
    Should Contain X Times    ${output}    fz3 : 0.301736068968    1
    Should Contain X Times    ${output}    fz4 : 0.357832830272    1
    Should Contain X Times    ${output}    fz5 : 0.760698381708    1
    Should Contain X Times    ${output}    fz6 : 0.0029903333319    1
    Should Contain X Times    ${output}    === [ackCommand_configureElevationRawLUT] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
