*** Settings ***
Documentation    M1M3_AppliedElevationForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedElevationForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 92.3029 0.375642 0.63082 0.216654 0.724074 0.415212 0.461691 0.825498 0.597704 0.222581 0.771021 0.887548 0.069924 0.668427 0.607742 0.054545 0.404563 0.80882 0.751846 0.075467 0.429955 0.022346 0.147694 0.06068 0.216016 0.74229 0.205669 0.953608 0.017566 0.939723 0.775914 0.746956 0.584809 0.60141 0.623289 0.659398 0.328198 0.33401 0.355609 0.626471 0.562836 0.071873 0.639564 0.210349 0.087044 0.610849 0.443178 0.341384 0.765579 0.752264 0.638177 0.955254 0.491156 0.167729 0.613229 0.933944 0.453278 0.512834 0.271684 0.981976 0.76745 0.280415 0.008099 0.861945 0.313729 0.417313 0.666572 0.159678 0.194616 0.632086 0.269857 0.489567 0.648394 0.41646 0.424953 0.485882 0.81652 0.837709 0.234223 0.61222 0.244629 0.468092 0.66611 0.681073 0.729937 0.0137 0.949762 0.411413 0.352249 0.572666 0.055247 0.508674 0.226152 0.427406 0.873388 0.027922 0.645537 0.372873 0.227154 0.166735 0.565045 0.344603 0.906857 0.914267 0.171445 0.853592 0.958604 0.671999 0.49817 0.837844 0.573909 0.346567 0.141424 0.903108 0.51338 0.15273 0.541256 0.083594 0.581388 0.00226 0.540481 0.720761 0.360082 0.805805 0.165114 0.211314 0.72061 0.59009 0.992615 0.028387 0.912041 0.492666 0.577331 0.917714 0.46305 0.125642 0.790742 0.547615 0.642333 0.212814 0.484813 0.429944 0.589628 0.610608 0.314208 0.718393 0.016291 0.322092 0.14372 0.386085 0.172128 0.178443 0.671908 0.701808 0.231626 0.028906 0.142348 0.382843 0.119404 0.734618 0.768223 0.133616 0.130461 0.905812 0.930966 0.527112 0.181823 0.370441 0.76338 0.223019 0.364591 0.632632 0.163831 0.739557 0.523607 0.587855 0.300207 0.640487 0.399649 0.334127 0.400738 0.56504 0.923111 0.011076 0.585205 0.706619 0.759036 0.963041 0.830273 0.412734 0.514342 0.736648 0.733133 0.333407 0.530222 0.624459 0.020808 0.548752 0.391544 0.897593 0.992078 0.210804 0.311162 0.219967 0.134697 0.923483 0.4057 0.507721 0.891007 0.243237 0.634037 0.104073 0.204829 0.344108 0.33635 0.699456 0.867141 0.231984 0.327856 0.907663 0.335083 0.294368 0.616683 0.974929 0.789339 0.292063 0.581899 0.48688 0.08307 0.424561 0.345344 0.342548 0.065084 0.558292 0.325662 0.666834 0.8709 0.685844 0.933885 0.522306 0.015961 0.927195 0.328518 0.174726 0.190418 0.969558 0.239839 0.352147 0.339297 0.395373 0.119562 0.261481 0.849651 0.141517 0.575473 0.89399 0.409272 0.57106 0.95586 0.689484 0.408435 0.864393 0.566397 0.981548 0.059834 0.99218 0.619029 0.356858 0.10294 0.356693 0.695952 0.092386 0.836698 0.441139 0.976026 0.430868 -2099307700
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedElevationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedElevationForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -2099307700
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedElevationForces received =     1
    Should Contain    ${output}    Timestamp : 92.3029
    Should Contain    ${output}    XForces : 0.375642
    Should Contain    ${output}    YForces : 0.63082
    Should Contain    ${output}    ZForces : 0.216654
    Should Contain    ${output}    Fx : 0.724074
    Should Contain    ${output}    Fy : 0.415212
    Should Contain    ${output}    Fz : 0.461691
    Should Contain    ${output}    Mx : 0.825498
    Should Contain    ${output}    My : 0.597704
    Should Contain    ${output}    Mz : 0.222581
    Should Contain    ${output}    ForceMagnitude : 0.771021
    Should Contain    ${output}    priority : 0.887548
