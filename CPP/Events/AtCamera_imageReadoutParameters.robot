*** Settings ***
Documentation    AtCamera_imageReadoutParameters sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atcamera
${component}    imageReadoutParameters
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send AvWDKGqsVHpAQpYzspRRhbWAytbkHDdtfrcSNonEyHYUDXhsDzsiocnPgkyroSsRnNLxYXAaWAmZysvyWRQMfQUlpBjuDpjhevupVoEjrsWvRhWrAJWhEkGtRnvieFwiCpPZtzcPCFLAaflITODUsGetGnIotfHjelrfrjdynWgYWKYSjZPxOHQZkxlKuFgXvDbuFbpaAwitIakCduJgBYilOCTgQwHbNkCgLnxgIlICTPtKIvQVNgrKYEQvcIjW uSIVjfETrKgYqCWunLEfWFeQjRFavAkezKDNUPGUHNTvgPIGGAweYYRKAptKPXHItNawTJUUpOikvtTcWGVesxeJVvjtFyAqPMHQyKubwYWNryYJVylRhkGXfPLtqrdCNMhJvUtJiQfNkRmdoRHHXaBRkwJaNDICEgpBxoGcZkPvUrQldFfAuHgOcdrfyzBMciiLEspPhAxxYwiRvCmVCsIzNojIBBvPeeTIaNqTqYHDwuSaBxruGJFHYVBxmzaB -1853790796 -1289315362 -940257698 -1551651433 2059913510 888963198 -1119055024 -1805304078 -1646018733 1616045513
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atcamera::logevent_imageReadoutParameters writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event imageReadoutParameters generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1616045513
    Log    ${output}
    Should Contain X Times    ${output}    === Event imageReadoutParameters received =     1
    Should Contain    ${output}    imageName : AvWDKGqsVHpAQpYzspRRhbWAytbkHDdtfrcSNonEyHYUDXhsDzsiocnPgkyroSsRnNLxYXAaWAmZysvyWRQMfQUlpBjuDpjhevupVoEjrsWvRhWrAJWhEkGtRnvieFwiCpPZtzcPCFLAaflITODUsGetGnIotfHjelrfrjdynWgYWKYSjZPxOHQZkxlKuFgXvDbuFbpaAwitIakCduJgBYilOCTgQwHbNkCgLnxgIlICTPtKIvQVNgrKYEQvcIjW
    Should Contain    ${output}    ccdNames : uSIVjfETrKgYqCWunLEfWFeQjRFavAkezKDNUPGUHNTvgPIGGAweYYRKAptKPXHItNawTJUUpOikvtTcWGVesxeJVvjtFyAqPMHQyKubwYWNryYJVylRhkGXfPLtqrdCNMhJvUtJiQfNkRmdoRHHXaBRkwJaNDICEgpBxoGcZkPvUrQldFfAuHgOcdrfyzBMciiLEspPhAxxYwiRvCmVCsIzNojIBBvPeeTIaNqTqYHDwuSaBxruGJFHYVBxmzaB
    Should Contain    ${output}    ccdType : -1853790796
    Should Contain    ${output}    overRows : -1289315362
    Should Contain    ${output}    overCols : -940257698
    Should Contain    ${output}    readRows : -1551651433
    Should Contain    ${output}    readCols : 2059913510
    Should Contain    ${output}    readCols2 : 888963198
    Should Contain    ${output}    preCols : -1119055024
    Should Contain    ${output}    preRows : -1805304078
    Should Contain    ${output}    postCols : -1646018733
    Should Contain    ${output}    priority : 1616045513
