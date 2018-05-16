*** Settings ***
Documentation    AtCamera_imageReadoutParameters sender/logger tests.
Force Tags    cpp    TSS-2675
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send DteSoIekhkkBYxkSRAMBOqRnIlPEKZzEDZrWXeZiyyktwpLvKTpgFBojIcoYJLPHhyDDgcqtGIjnbbsBHtUFlAKayqEGwbiJbwINUVXLkxHxKXhNdLFszgdSGqXfrHBFAHAFKoFpGToBxjVNvLzdcViUrxExlpDccOneSVHpYKrsNybYiJlvqdXoymjMjEXuOEpuaDFyFcGHDOCakOmhvaifPRdJJnzELGEjXgVySdMtLlKtpHnyNXIRYrXlXbjA IiaMSyIvqekPZslcmXZzPHkPqeKNgTklmmyyiGwVvmVGFnTmucZQiFTTqdBLZqLJKTnKxuFbAlsZKDUJEpThIHFAScdIloGiXIwLgdiSDpNRlgDATkoiCENsPDangsyRHjyWHoJdpdrRdmbPXDPewkQHrBmMicCxltLHGUjBRbliHeBImXmBBRdWkQgkkwTXCrimfElOUyxFbGhLBAnykRmmUBMhadpztzYKnMthhDPqeZXiaeEumydHiPEMsReC -1655090498 1878607500 2075229384 -1560537022 854678148 -1202413944 -164790963 1473184044 1507341431 2009485790
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atcamera::logevent_imageReadoutParameters writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event imageReadoutParameters generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 2009485790
    Log    ${output}
    Should Contain X Times    ${output}    === Event imageReadoutParameters received =     1
    Should Contain    ${output}    imageName : DteSoIekhkkBYxkSRAMBOqRnIlPEKZzEDZrWXeZiyyktwpLvKTpgFBojIcoYJLPHhyDDgcqtGIjnbbsBHtUFlAKayqEGwbiJbwINUVXLkxHxKXhNdLFszgdSGqXfrHBFAHAFKoFpGToBxjVNvLzdcViUrxExlpDccOneSVHpYKrsNybYiJlvqdXoymjMjEXuOEpuaDFyFcGHDOCakOmhvaifPRdJJnzELGEjXgVySdMtLlKtpHnyNXIRYrXlXbjA
    Should Contain    ${output}    ccdNames : IiaMSyIvqekPZslcmXZzPHkPqeKNgTklmmyyiGwVvmVGFnTmucZQiFTTqdBLZqLJKTnKxuFbAlsZKDUJEpThIHFAScdIloGiXIwLgdiSDpNRlgDATkoiCENsPDangsyRHjyWHoJdpdrRdmbPXDPewkQHrBmMicCxltLHGUjBRbliHeBImXmBBRdWkQgkkwTXCrimfElOUyxFbGhLBAnykRmmUBMhadpztzYKnMthhDPqeZXiaeEumydHiPEMsReC
    Should Contain    ${output}    ccdType : -1655090498
    Should Contain    ${output}    overRows : 1878607500
    Should Contain    ${output}    overCols : 2075229384
    Should Contain    ${output}    readRows : -1560537022
    Should Contain    ${output}    readCols : 854678148
    Should Contain    ${output}    readCols2 : -1202413944
    Should Contain    ${output}    preCols : -164790963
    Should Contain    ${output}    preRows : 1473184044
    Should Contain    ${output}    postCols : 1507341431
    Should Contain    ${output}    priority : 2009485790
