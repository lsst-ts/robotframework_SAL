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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send caKJcCUjnTjsBiawUqNErfJeKuYFyIhCcibWFTvfiHouuukqFrNmkTHKTlERHGyuuxdRAfDkSsLFJCWBLzcRuSDxwWpJifZlVouuSjzqSDhzAqEcSAzgmyNJyalVDZlhqxNJYzypvhBsvuwBVwBgZtHsSnsVAvepFsuYGtCVViGLwybJhsIjVjPqwAfahpotIukKqnKLcnNdFpreuZEKhydyMBTDHtGuPjZdrFQHKHLgvETiEDFIroneKpriBllL UBhaazdlGCqTjeyTjxlcXAPgNrHUcduiaftUuHPSvAOuDUdkCAfPMRJsCOksKdVwRCiTBdEOTdRzqPmCFhXevHunAsfCrLMaqEYsOXgXZZsvaTbShWTKwpvNkahHIfVqXaKYagwsUfQlfmhVGKsDoaROWNIoTDqoBXpMPlPNSxDoshPjMSnRnLhKNLkelAHMmyvxqDBcExNJhbatcKblskpFiHOARiAfKqnqKTVQgIwzeIQDoLQdDmSeUkCUvSXn 1363119701 -1707664874 -1749176897 -1216582831 1234538615 972340260 -936225018 -911589328 1936473400 -187399181
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atcamera::logevent_imageReadoutParameters writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event imageReadoutParameters generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -187399181
    Log    ${output}
    Should Contain X Times    ${output}    === Event imageReadoutParameters received =     1
    Should Contain    ${output}    imageName : caKJcCUjnTjsBiawUqNErfJeKuYFyIhCcibWFTvfiHouuukqFrNmkTHKTlERHGyuuxdRAfDkSsLFJCWBLzcRuSDxwWpJifZlVouuSjzqSDhzAqEcSAzgmyNJyalVDZlhqxNJYzypvhBsvuwBVwBgZtHsSnsVAvepFsuYGtCVViGLwybJhsIjVjPqwAfahpotIukKqnKLcnNdFpreuZEKhydyMBTDHtGuPjZdrFQHKHLgvETiEDFIroneKpriBllL
    Should Contain    ${output}    ccdNames : UBhaazdlGCqTjeyTjxlcXAPgNrHUcduiaftUuHPSvAOuDUdkCAfPMRJsCOksKdVwRCiTBdEOTdRzqPmCFhXevHunAsfCrLMaqEYsOXgXZZsvaTbShWTKwpvNkahHIfVqXaKYagwsUfQlfmhVGKsDoaROWNIoTDqoBXpMPlPNSxDoshPjMSnRnLhKNLkelAHMmyvxqDBcExNJhbatcKblskpFiHOARiAfKqnqKTVQgIwzeIQDoLQdDmSeUkCUvSXn
    Should Contain    ${output}    ccdType : 1363119701
    Should Contain    ${output}    overRows : -1707664874
    Should Contain    ${output}    overCols : -1749176897
    Should Contain    ${output}    readRows : -1216582831
    Should Contain    ${output}    readCols : 1234538615
    Should Contain    ${output}    readCols2 : 972340260
    Should Contain    ${output}    preCols : -936225018
    Should Contain    ${output}    preRows : -911589328
    Should Contain    ${output}    postCols : 1936473400
    Should Contain    ${output}    priority : -187399181
