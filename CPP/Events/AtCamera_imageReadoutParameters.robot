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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send LkZtndthxgejIVPZBUfFpfgTXpxaVABixRikSCGkgSIBkZoVbqWJZabesqNCTbfaoEETmjIHGvJmAnqZNDhONIpwUQyFmiNxWTTTUqLtMLLDpprevBcJJIGXyATbeKyzXmULuZblBQLFJVHfNNYODztXzsAQYRtDFSRKTkvVLGvLDMYCgwVnVcLQkmsdgfbTNeUTDEdRIGAVQJHOOnJxFPYMKFdaKwJwXkUUVmEMpyNkbgQftMOxFecMQULeTsvY qwRLhRrCtBNMmiBLpaDSqbLerMQGonBLrwBwMHVHoQQTMkJGjDhIMGlZbpKVGsfGZlqSngoYqJlEgeajqNikELcHYGjwylRbgGHNKWwbCssyfnoPinnUmeIdINjDEquYdOsHqWzbymRvJGPavHhmwrcOJypGmWUiECGDNdCyIOrTIpfENzHewklqfeVcXPFOQWIOsNNqqXlbGrbAwkmTfgtRwvkQytXJYcbSljHRcoswDjJMxxKrumAZRQrurGmv -149743762 1117305579 -274233685 -1987161038 369248717 1572762271 69634380 357616521 798839920 -78062212
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atcamera::logevent_imageReadoutParameters writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event imageReadoutParameters generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -78062212
    Log    ${output}
    Should Contain X Times    ${output}    === Event imageReadoutParameters received =     1
    Should Contain    ${output}    imageName : LkZtndthxgejIVPZBUfFpfgTXpxaVABixRikSCGkgSIBkZoVbqWJZabesqNCTbfaoEETmjIHGvJmAnqZNDhONIpwUQyFmiNxWTTTUqLtMLLDpprevBcJJIGXyATbeKyzXmULuZblBQLFJVHfNNYODztXzsAQYRtDFSRKTkvVLGvLDMYCgwVnVcLQkmsdgfbTNeUTDEdRIGAVQJHOOnJxFPYMKFdaKwJwXkUUVmEMpyNkbgQftMOxFecMQULeTsvY
    Should Contain    ${output}    ccdNames : qwRLhRrCtBNMmiBLpaDSqbLerMQGonBLrwBwMHVHoQQTMkJGjDhIMGlZbpKVGsfGZlqSngoYqJlEgeajqNikELcHYGjwylRbgGHNKWwbCssyfnoPinnUmeIdINjDEquYdOsHqWzbymRvJGPavHhmwrcOJypGmWUiECGDNdCyIOrTIpfENzHewklqfeVcXPFOQWIOsNNqqXlbGrbAwkmTfgtRwvkQytXJYcbSljHRcoswDjJMxxKrumAZRQrurGmv
    Should Contain    ${output}    ccdType : -149743762
    Should Contain    ${output}    overRows : 1117305579
    Should Contain    ${output}    overCols : -274233685
    Should Contain    ${output}    readRows : -1987161038
    Should Contain    ${output}    readCols : 369248717
    Should Contain    ${output}    readCols2 : 1572762271
    Should Contain    ${output}    preCols : 69634380
    Should Contain    ${output}    preRows : 357616521
    Should Contain    ${output}    postCols : 798839920
    Should Contain    ${output}    priority : -78062212
