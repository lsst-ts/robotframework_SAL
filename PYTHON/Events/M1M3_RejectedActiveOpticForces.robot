*** Settings ***
Documentation    M1M3_RejectedActiveOpticForces sender/logger tests.
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
${component}    RejectedActiveOpticForces
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp ZForces Fz Mx My priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 84.6028 0.371934096085 0.41514087623 0.125738765294 0.773142867545 0.647888999399 0.253852289975 0.950941918757 0.484390681351 0.129941206743 0.517048111156 0.847401927426 0.404216399023 0.22664125454 0.378213240427 0.208898665608 0.54371124676 0.448339532102 0.781328788332 0.746634550907 0.477555812095 0.44880077337 0.703629018857 0.316011089075 0.318409665066 0.812129326005 0.189494264489 0.536723886198 0.593361684364 0.904646416879 0.181734995062 0.80726987183 0.905853322915 0.379813224249 0.552773854144 0.167958585808 0.964717962276 0.638807316809 0.272960536832 0.974807604449 0.12832160453 0.32966686015 0.543785984185 0.907674944433 0.937519563254 0.628060249587 0.166339494275 0.495620499082 0.749930463058 0.685276074331 0.100796801568 0.545932143733 0.98253238486 0.707906155982 0.0482556294532 0.355263842818 0.976707155928 0.758407761145 0.521379040268 0.8439026086 0.0548256575045 0.858867920423 0.280209547976 0.0177166888213 0.65982855207 0.820098157882 0.215899461384 0.0748712246875 0.630211979956 0.298220580549 0.504521613112 0.70229191372 0.476079230711 0.265266573186 0.519773617296 0.356175418463 0.413034721475 0.0258326183901 0.325400831216 0.0121668791435 0.486035838503 0.206510976749 0.744480128017 0.0882467167837 0.585671636227 0.201274556112 0.690026425142 0.674452438017 0.19700397663 0.0529593259457 0.19480644823 0.836301934478 0.997811453988 0.00287700528645 0.505661614421 0.365790994576 0.0942245380506 0.2011356776 0.684045604569 0.917812565901 0.618755501564 0.59308424548 0.583768344483 0.392741073565 0.866991690143 0.925737539746 0.430562191906 0.982285248152 0.0532877590142 0.244396600984 0.222209884279 0.698311392531 0.0636337025097 0.797876407638 0.433633285568 0.638623760283 0.543364441087 0.181807856689 0.427397165477 0.452856462029 0.908214679434 0.843231717316 0.700836706829 0.395077806008 0.0856714095417 0.846988428621 0.38400037323 0.324767164099 0.50301576237 0.0304203650076 0.279899052296 0.969324807868 0.549828128109 0.196855559412 0.101355794997 0.0942032355675 0.715964335996 0.876188337708 0.481616406325 0.338648554022 0.954023787278 0.261420426128 0.0214369631934 0.247105666721 0.602226609342 0.497100841794 0.317752490642 0.819989183373 0.225272070118 0.450893772742 0.368007904793 0.318512157122 0.661687043403 0.758175324395 0.959211292149 0.37300131454 0.289225599331 0.482320809503 0.258173534055 0.788943314734 -525254910
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
