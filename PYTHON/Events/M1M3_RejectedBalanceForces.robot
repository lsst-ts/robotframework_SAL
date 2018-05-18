*** Settings ***
Documentation    M1M3_RejectedBalanceForces sender/logger tests.
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
${component}    RejectedBalanceForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 94.8451 0.278924921193 0.105133234293 0.0274686468563 0.591979307973 0.613923488283 0.709262358875 0.0835850766553 0.55291900394 0.903296554512 0.470692420804 0.219770573476 0.959490231192 0.646118369326 0.285437141159 0.301909279137 0.636305043003 0.835252252715 0.103877145323 0.144267127874 0.712430032093 0.280095780372 0.787353472082 0.761590731394 0.548211323027 0.785050524673 0.610665884498 0.959293017298 0.807433558776 0.612904825352 0.26721718427 0.629169075268 0.663936560474 0.351093217776 0.638947652278 0.907077838836 0.520561770589 0.297152071763 0.314158631667 0.247027341793 0.334883099961 0.254648234048 0.806291628672 0.355078279793 0.614815507655 0.476944989353 0.389290619489 0.889151002055 0.0290047100057 0.66431908608 0.827482093636 0.0882653128718 0.663048913588 0.13607270836 0.304404064978 0.135412347936 0.449607096544 0.272608319007 0.849589842463 0.0404120681144 0.855569726218 0.670122799183 0.442038912656 0.573057475138 0.14361959747 0.67547120625 0.767277735663 0.238161710277 0.999908429854 0.270715522646 0.861350851651 0.512897444037 0.230362422142 0.566952259588 0.977571706313 0.846579064143 0.970981752265 0.394203352142 0.182782844596 0.501514511489 0.281723053703 0.563842608856 0.0935225634582 0.73705741547 0.104958836522 0.1923710344 0.254950172138 0.36114010495 0.185760210095 0.0978567611003 0.838951109817 0.962033054702 0.00475115940204 0.216575851403 0.506378045939 0.913938751471 0.0631668390148 0.0848000345703 0.727978301086 0.878825925704 0.115445520917 0.554303735176 0.29444407919 0.961477604283 0.0245575595361 0.107579929998 0.262204644269 0.626010307394 0.875915521598 0.907321046928 0.634024571709 0.650176786567 0.926871477867 0.595332152834 0.884014000615 0.659995443231 0.409889437155 0.017021692831 0.234785912764 0.49176992944 0.258709406478 0.158064288655 0.206774260839 0.633334297568 0.120008443526 0.0057238852492 0.499708144149 0.809487997865 0.574235250529 0.306080180789 0.724924072093 0.755670816141 0.443813161963 0.0256643086727 0.107976124064 0.806677291146 0.459996131977 0.704464443588 0.731079930772 0.531048269938 0.389854131931 0.207299973771 0.73378333317 0.520243960153 0.698760736208 0.469813609875 0.316694696243 0.722198815421 0.535286759942 0.624264712137 0.934490392755 0.438908482354 0.867616099298 0.455271193634 0.750121535707 0.78993897031 0.265114633833 0.310853969392 0.442585277725 0.366962578978 0.117535412787 0.514714839648 0.378366284949 0.357637967721 0.385246766238 0.124411864129 0.339032207968 0.827885853317 0.383995682445 0.912925416558 0.13435033245 0.483148559961 0.938424730943 0.706857873738 0.276721184036 0.263954937592 0.725572550314 0.0497043986024 0.450748224009 0.568680447048 0.0421136152235 0.536176337483 0.221380835634 0.367774864023 0.467283991766 0.12593765757 0.145540806261 0.109647551111 0.734042881404 0.727583302169 0.225207471403 0.6356380782 0.906860157535 0.225942573777 0.796735073826 0.541597724654 0.266632856562 0.0300355937423 0.717235280926 0.953585502489 0.221062730268 0.340464868589 0.740389938817 0.191996269843 0.987264569366 0.19628792492 0.568848197893 0.659384588364 0.679325559092 0.512205705609 0.291244111477 0.165185866605 0.173741087425 0.260810200847 0.419560813958 0.118405867955 0.514985012474 0.0442152240528 0.344374474038 0.107757663253 0.473546208692 0.307611320434 0.717040453163 0.987220079166 0.896838351807 0.254281603775 0.626928768708 0.478075538105 0.237919903809 0.736830100845 0.716448268024 0.705877894828 0.936002831698 0.104969112968 0.139240044834 0.18132012062 0.099782804159 0.0480986533649 0.318163607718 0.839145596075 0.33218003641 0.280695889242 0.290043998343 0.203611361477 0.000734932622721 0.931212717558 0.288405499382 0.554078684528 0.113968479487 0.954853157696 0.463174086667 0.464991042687 0.381429706496 0.428276435736 0.169532270923 0.172795902402 0.185751442784 0.633694790531 0.90424295004 0.0886875487028 0.835233744429 0.93062405783 0.567084781007 0.482554955686 0.944290001741 0.931446209524 0.960370113622 0.704542147722 0.88068859102 0.5414171877 0.441257179228 0.595491059101 0.73563629488 0.551746316144 0.333263541424 0.307245815255 -1281631422
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedBalanceForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
