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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send cTJzfjtzsjonHhiFzZEACJqxTOBunGAlHwcasVPuNqbdDGAAPWzgAONTrTolYIHHfXiGTZaLkZFoVnKmvfNtjTHdKYSerlELpPdbIzRkWNODhZbPfcbnuIgwgwmZsdNyReApRTIbKvwoeIlFWNZbrOYNRZUhxLrmdfXGTPtpblqXrBVqHALuwjdwspnKEbsqSNcMNlMoccseOxZQnrbicMTeGmEfLzrGAsoIjlXlOUEbcUaHggxPfBUnDVHgqdfN vvDtgQnFqIgAgEDsWxyUuyXgUckZhEuCohaLtCvjTBeEzvBjRygzxkSgEWngCKeGbXZnPseGXidyanuwuwRlRkUqmkdNNWJEyTHoBSqSwqAsXwORhKvrXMOCpTmxLjhVhuZyzKMUyrEEOJwlgxIIpfyyYzSxUBPqjWTnOgAWNDuSrgdhuZCXKXgQUYnPCgIvRBOEfmLxhiJNkwlSnRyyEMEBAtyXutSfEzGyRAcIeFScDcpTihpczwvrhEtHWxXa -758677905 460921010 687175469 -2061323954 -704540838 270163767 -1218370348 534744641 1090027437 931686264
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atcamera::logevent_imageReadoutParameters writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event imageReadoutParameters generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 931686264
    Log    ${output}
    Should Contain X Times    ${output}    === Event imageReadoutParameters received =     1
    Should Contain    ${output}    imageName : cTJzfjtzsjonHhiFzZEACJqxTOBunGAlHwcasVPuNqbdDGAAPWzgAONTrTolYIHHfXiGTZaLkZFoVnKmvfNtjTHdKYSerlELpPdbIzRkWNODhZbPfcbnuIgwgwmZsdNyReApRTIbKvwoeIlFWNZbrOYNRZUhxLrmdfXGTPtpblqXrBVqHALuwjdwspnKEbsqSNcMNlMoccseOxZQnrbicMTeGmEfLzrGAsoIjlXlOUEbcUaHggxPfBUnDVHgqdfN
    Should Contain    ${output}    ccdNames : vvDtgQnFqIgAgEDsWxyUuyXgUckZhEuCohaLtCvjTBeEzvBjRygzxkSgEWngCKeGbXZnPseGXidyanuwuwRlRkUqmkdNNWJEyTHoBSqSwqAsXwORhKvrXMOCpTmxLjhVhuZyzKMUyrEEOJwlgxIIpfyyYzSxUBPqjWTnOgAWNDuSrgdhuZCXKXgQUYnPCgIvRBOEfmLxhiJNkwlSnRyyEMEBAtyXutSfEzGyRAcIeFScDcpTihpczwvrhEtHWxXa
    Should Contain    ${output}    ccdType : -758677905
    Should Contain    ${output}    overRows : 460921010
    Should Contain    ${output}    overCols : 687175469
    Should Contain    ${output}    readRows : -2061323954
    Should Contain    ${output}    readCols : -704540838
    Should Contain    ${output}    readCols2 : 270163767
    Should Contain    ${output}    preCols : -1218370348
    Should Contain    ${output}    preRows : 534744641
    Should Contain    ${output}    postCols : 1090027437
    Should Contain    ${output}    priority : 931686264
