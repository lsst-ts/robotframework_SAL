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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 25930 20100 -2517 11808 -24014 -2424 -21342 6832 -6244 27019 -8699 2747 -24975 -19147 1435 13615 -17989 6311 -3604 0.957601120526 0.536877259252 0.399057678562 0.15215266669 0.786817821112 0.14064545213 0.893312577666 0.47127091455 0.358557506898 0.391598251565 0.00754815378758 0.627483590651 0.723719941939 0.819601928315 0.0245601650449 0.975748355223 0.0361159831994 0.495813530299 0.833254384754 0.208671573137 0.827788902088 0.0249419516812 0.517490110691 0.626266760378 0.955133320999 0.184610424972 0.758494399812 0.420383512995 0.620034637504 0.055149816362 0.163477949268 0.525903430627 0.935505482558 0.911636674629 0.823682515532 0.158967305462 0.637065994171 0.24582021856 0.00859895547975 0.734311562541 0.314988638867 0.280456318288 0.905590345208 0.762046464504 0.55831521302 0.460112842644 0.86251336066 0.879532623382 0.285025554865 0.229570767969 0.278683914882 0.0995243470355 0.38097697023 0.141914009816 0.846052524596 0.913419111827 0.268273536137 0.871180539224 0.850162690878 0.821583522751 0.685967601967 0.868272212542 0.422237244539 0.211550415861 0.762574278584 0.0717009570545 0.354967780409 0.877190907256 0.833136847115 0.724630141703 0.33685102208 0.344356431228 0.183011978828 0.579341705754 0.718601484985 0.222246280554 0.016318760894 0.098994554654 0.135763855755 0.386043225811 0.788060471733 0.277179685126 0.242784011339 0.941943833572 0.117400447088 0.613334960342 0.119603944733 0.99362759591 0.21367441187 0.0980354134464 0.392558706004 0.636323654896 0.175161597035 0.851235409943 0.89676786443 0.653981059672 0.363377992353 0.517852678512 0.623607616407 0.682803414833 0.267390426216 0.656043130123 0.595638962532 0.524582650109 0.390527268318 0.221621399121 0.455647330263 0.556844464532 0.876475191836 0.235835100218 0.487525624456 0.13060184029 0.407489038935 0.0628189937748
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 25930 20100 -2517 11808 -24014 -2424 -21342 6832 -6244 27019 -8699 2747 -24975 -19147 1435 13615 -17989 6311 -3604 0.957601120526 0.536877259252 0.399057678562 0.15215266669 0.786817821112 0.14064545213 0.893312577666 0.47127091455 0.358557506898 0.391598251565 0.00754815378758 0.627483590651 0.723719941939 0.819601928315 0.0245601650449 0.975748355223 0.0361159831994 0.495813530299 0.833254384754 0.208671573137 0.827788902088 0.0249419516812 0.517490110691 0.626266760378 0.955133320999 0.184610424972 0.758494399812 0.420383512995 0.620034637504 0.055149816362 0.163477949268 0.525903430627 0.935505482558 0.911636674629 0.823682515532 0.158967305462 0.637065994171 0.24582021856 0.00859895547975 0.734311562541 0.314988638867 0.280456318288 0.905590345208 0.762046464504 0.55831521302 0.460112842644 0.86251336066 0.879532623382 0.285025554865 0.229570767969 0.278683914882 0.0995243470355 0.38097697023 0.141914009816 0.846052524596 0.913419111827 0.268273536137 0.871180539224 0.850162690878 0.821583522751 0.685967601967 0.868272212542 0.422237244539 0.211550415861 0.762574278584 0.0717009570545 0.354967780409 0.877190907256 0.833136847115 0.724630141703 0.33685102208 0.344356431228 0.183011978828 0.579341705754 0.718601484985 0.222246280554 0.016318760894 0.098994554654 0.135763855755 0.386043225811 0.788060471733 0.277179685126 0.242784011339 0.941943833572 0.117400447088 0.613334960342 0.119603944733 0.99362759591 0.21367441187 0.0980354134464 0.392558706004 0.636323654896 0.175161597035 0.851235409943 0.89676786443 0.653981059672 0.363377992353 0.517852678512 0.623607616407 0.682803414833 0.267390426216 0.656043130123 0.595638962532 0.524582650109 0.390527268318 0.221621399121 0.455647330263 0.556844464532 0.876475191836 0.235835100218 0.487525624456 0.13060184029 0.407489038935 0.0628189937748
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    elevIndex : 25930    1
    Should Contain X Times    ${output}    fz1 : 0.957601120526    1
    Should Contain X Times    ${output}    fz2 : 0.208671573137    1
    Should Contain X Times    ${output}    fz3 : 0.00859895547975    1
    Should Contain X Times    ${output}    fz4 : 0.871180539224    1
    Should Contain X Times    ${output}    fz5 : 0.016318760894    1
    Should Contain X Times    ${output}    fz6 : 0.653981059672    1
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
    Should Contain X Times    ${output}    elevIndex : 25930    1
    Should Contain X Times    ${output}    fz1 : 0.957601120526    1
    Should Contain X Times    ${output}    fz2 : 0.208671573137    1
    Should Contain X Times    ${output}    fz3 : 0.00859895547975    1
    Should Contain X Times    ${output}    fz4 : 0.871180539224    1
    Should Contain X Times    ${output}    fz5 : 0.016318760894    1
    Should Contain X Times    ${output}    fz6 : 0.653981059672    1
    Should Contain X Times    ${output}    === [ackCommand_configureElevationRawLUT] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
