*** Settings ***
Documentation    M1M3_AppliedStaticForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedStaticForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 79.3433 0.048441 0.750265 0.489769 0.223431 0.086293 0.6073 0.590443 0.617884 0.756397 0.527068 0.193052 0.693663 0.683874 0.434744 0.399651 0.786966 0.237703 0.556061 0.368553 0.105945 0.089773 0.937399 0.430316 0.103144 0.572188 0.771739 0.562912 0.377129 0.358832 0.678439 0.989883 0.062161 0.165701 0.962095 0.376049 0.412204 0.494384 0.132401 0.02863 0.132566 0.023424 0.960774 0.724435 0.664438 0.066964 0.792597 0.504513 0.970873 0.775164 0.112005 0.615889 0.493225 0.044205 0.101356 0.781524 0.850403 0.52934 0.562856 0.873578 0.381262 0.974554 0.799049 0.963177 0.642479 0.922354 0.716927 0.00746 0.526708 0.870363 0.464167 0.37788 0.653157 0.176647 0.437378 0.701031 0.630443 0.804872 0.041847 0.838044 0.904234 0.215475 0.582764 0.842784 0.952973 0.959259 0.345186 0.531187 0.581802 0.830178 0.899183 0.05553 0.025117 0.591106 0.888802 0.622453 0.242071 0.149697 0.613965 0.086109 0.047606 0.797388 0.132511 0.419584 0.841774 0.185285 0.564239 0.924848 0.630502 0.619412 0.476214 0.3092 0.862194 0.822536 0.305564 0.375109 0.266562 0.677999 0.417023 0.119181 0.43421 0.187709 0.658084 0.726514 0.786901 0.204971 0.93425 0.54707 0.723152 0.146923 0.628665 0.158875 0.582442 0.003443 0.910954 0.242056 0.435275 0.802075 0.656532 0.881755 0.764599 0.971719 0.961072 0.009426 0.988727 0.174276 0.280557 0.613649 0.640982 0.333719 0.321613 0.809749 0.40496 0.830864 0.267945 0.275746 0.54977 0.394546 0.923597 0.663504 0.471842 0.208839 0.403059 0.051259 0.821556 0.841351 0.795978 0.085197 0.486986 0.005038 0.117695 0.893445 0.346966 0.566893 0.14934 0.478752 0.336507 0.701845 0.252297 0.989918 0.473459 0.3861 0.683026 0.592377 0.633209 0.166433 0.538905 0.502327 0.372512 0.336222 0.238562 0.90045 0.943694 0.709911 0.875881 0.421216 0.158269 0.930798 0.096743 0.76965 0.753351 0.948216 0.758977 0.431774 0.765729 0.629098 0.581738 0.223448 0.32091 0.043811 0.500467 0.739686 0.087234 0.934747 0.109611 0.722004 0.323072 0.52578 0.873655 0.033348 0.580487 0.504264 0.711052 0.824523 0.648163 0.916146 0.41521 0.771572 0.297613 0.043073 0.44323 0.688396 0.596136 0.652036 0.725617 0.788658 0.212034 0.504551 0.523943 0.158529 0.754519 0.020749 0.33684 0.919008 0.610989 0.950683 0.298136 0.546731 0.137332 0.12689 0.609464 0.614683 0.032029 0.902769 0.906418 0.35524 0.184267 0.308922 0.223774 0.550401 0.174635 0.160464 0.521473 0.880932 0.633764 0.925234 0.12088 0.573704 0.041957 0.374684 0.060474 0.379275 0.965866 0.216112 0.928266 0.50804 897929085
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedStaticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedStaticForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 897929085
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedStaticForces received =     1
    Should Contain    ${output}    Timestamp : 79.3433
    Should Contain    ${output}    XForces : 0.048441
    Should Contain    ${output}    YForces : 0.750265
    Should Contain    ${output}    ZForces : 0.489769
    Should Contain    ${output}    Fx : 0.223431
    Should Contain    ${output}    Fy : 0.086293
    Should Contain    ${output}    Fz : 0.6073
    Should Contain    ${output}    Mx : 0.590443
    Should Contain    ${output}    My : 0.617884
    Should Contain    ${output}    Mz : 0.756397
    Should Contain    ${output}    ForceMagnitude : 0.527068
    Should Contain    ${output}    priority : 0.193052
