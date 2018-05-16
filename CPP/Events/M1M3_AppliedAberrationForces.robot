*** Settings ***
Documentation    M1M3_AppliedAberrationForces sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedAberrationForces
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_log

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage :  input parameters...

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Logger.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_log
    ${output}=    Read Until    logger ready =
    Log    ${output}
    Should Contain    ${output}    Event ${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 47.0601 0.837589086062 0.531636431666 0.733828070233 0.925105868437 0.659924331053 0.837824111482 0.246456757986 0.878051342512 0.591452422787 0.813251050653 0.328765931809 0.315017730302 0.562896540695 0.343407332232 0.161936043387 0.883074150472 0.514719851846 0.834521151539 0.223519175403 0.434298500783 0.556515670084 0.0985147487738 0.125701607029 0.244134067056 0.23786361374 0.365057170947 0.693737959312 0.0647356558317 0.369838045015 0.184682903775 0.344120468542 0.440382796153 0.889549171817 0.379080282643 0.785190859707 0.822371937602 0.72828070474 0.281957998118 0.345978529745 0.76474707679 0.298292148975 0.378810625285 0.0448833848546 0.459465075748 0.992876539122 0.928346591216 0.729974269732 0.919220140378 0.151216013183 0.261269758464 0.172086617551 0.0233276329849 0.461609838475 0.329102717218 0.673504680939 0.718471490995 0.897607983573 0.924156106291 0.813045776918 0.6827416408 0.795293999101 0.400714853462 0.316386306855 0.624267496805 0.929120186394 0.0681797944915 0.854015310339 0.397115700439 0.581439551433 0.899927165404 0.264081940281 0.818617840879 0.613475795591 0.501968957026 0.241596575673 0.908352016301 0.0527444804272 0.217886004124 0.504792521906 0.614092873066 0.469376318812 0.815738174785 0.561270379662 0.850561948042 0.0646238924006 0.437148744672 0.567649228423 0.765832689073 0.0127475075628 0.0521697703899 0.865022324205 0.280124621475 0.571508333392 0.13006298244 0.1706403504 0.370769924933 0.338868866738 0.919666450883 0.350379024026 0.634831517161 0.333964572326 0.892914049065 0.849801240218 0.438279892681 0.842300766027 0.0515287725612 0.121946372581 0.717702296683 0.0939133769787 0.521437364571 0.949352711046 0.149140439974 0.528720990083 0.974898298672 0.181782709313 0.792011546666 0.207864473712 0.605476792972 0.543401128203 0.495764595386 0.207442383176 0.0765909448977 0.473980782531 0.315804691352 0.0256310573075 0.714651684377 0.589890318251 0.570227668619 0.903937362331 0.0988910523772 0.762262117999 0.371617722917 0.467325092085 0.142294790169 0.598635231997 0.588982003009 0.820987741542 0.494479042343 0.723991523501 0.795247312996 0.425272026132 0.85935793449 0.316847998737 0.408903378437 0.090087156445 0.27866810986 0.0911853521543 0.472204478219 0.301344880286 0.367234327493 0.481217482601 0.0760238503314 0.60513489997 0.550741526554 0.354445331728 0.523210898616 0.770768525075 0.951542377747 0.295540668502 1033322259
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedAberrationForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1033322259
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedAberrationForces received =     1
    Should Contain    ${output}    Timestamp : 47.0601
    Should Contain    ${output}    ZForces : 0.837589086062
    Should Contain    ${output}    Fz : 0.531636431666
    Should Contain    ${output}    Mx : 0.733828070233
    Should Contain    ${output}    My : 0.925105868437
    Should Contain    ${output}    priority : 0.659924331053
