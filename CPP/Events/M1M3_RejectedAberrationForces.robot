*** Settings ***
Documentation    M1M3_RejectedAberrationForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedAberrationForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 50.6133 0.140347 0.14316 0.060415 0.665327 0.404169 0.050849 0.300077 0.38985 0.818413 0.896203 0.479186 0.252851 0.750058 0.364131 0.36994 0.676039 0.170084 0.464729 0.003191 0.834435 0.532639 0.800562 0.298562 0.692867 0.504824 0.123401 0.739389 0.049689 0.805095 0.516541 0.634747 0.4356 0.063721 0.572617 0.826821 0.102165 0.216791 0.298526 0.868848 0.680934 0.948247 0.466382 0.695962 0.540113 0.993589 0.133347 0.651575 0.442754 0.872197 0.496855 0.68001 0.149246 0.071734 0.254957 0.659244 0.598193 0.709962 0.772046 0.511289 0.529273 0.749167 0.982506 0.129067 0.267647 0.497247 0.381113 0.331721 0.515271 0.848621 0.534805 0.59557 0.67503 0.29396 0.516376 0.005374 0.072283 0.944166 0.701002 0.874077 0.189136 0.142161 0.725097 0.645758 0.558582 0.89977 0.004882 0.184797 0.801743 0.420727 0.073128 0.29426 0.759881 0.524372 0.262032 0.782292 0.952416 0.164063 0.772959 0.05617 0.333203 0.806736 0.030276 0.309246 0.962728 0.473476 0.310703 0.087591 0.140368 0.89292 0.182749 0.129763 0.139753 0.813645 0.194969 0.962276 0.303543 0.766946 0.631909 0.382777 0.021172 0.638191 0.96088 0.44632 0.846858 0.927411 0.918961 0.389823 0.911575 0.026905 0.136162 0.206919 0.340101 0.629583 0.868838 0.721425 0.358851 0.815729 0.039916 0.411978 0.377384 0.807631 0.350361 0.0214 0.488928 0.216466 0.045029 0.036584 0.781926 0.256536 0.233723 0.043941 0.774017 0.99626 0.8625 0.826734 0.92864 0.338652 0.959842 0.279318 253412787
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedAberrationForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 253412787
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedAberrationForces received =     1
    Should Contain    ${output}    Timestamp : 50.6133
    Should Contain    ${output}    ZForces : 0.140347
    Should Contain    ${output}    Fz : 0.14316
    Should Contain    ${output}    Mx : 0.060415
    Should Contain    ${output}    My : 0.665327
    Should Contain    ${output}    priority : 0.404169
