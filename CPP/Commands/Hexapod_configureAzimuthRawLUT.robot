*** Settings ***
Documentation    Hexapod_configureAzimuthRawLUT communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    hexapod
${component}    configureAzimuthRawLUT
${timeout}    30s

*** Test Cases ***
Verify Component Commander and Controller
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_controller

Start Commander - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage : \ input parameters...

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -25795 27499 -2508 4713 2897 24679 18662 21824 -31893 1263 -30188 25622 28320 -17535 14284 -9310 -14859 -20139 4783 -331 -26177 -28096 -31752 12282 17625 25452 6258 -2045 -8377 30349 -27099 28947 -24649 12679 -5983 6692 13662 0.811789 0.600228 0.247915 0.720804 0.829765 0.958186 0.306534 0.695498 0.767265 0.307859 0.757375 0.313411 0.384819 0.548688 0.319392 0.353819 0.954226 0.097741 0.510172 0.393042 0.501521 0.529812 0.801582 0.832137 0.545132 0.718766 0.661952 0.218433 0.385385 0.525995 0.761314 0.242437 0.308185 0.063382 0.932682 0.683461 0.482876 0.001429 0.997695 0.626433 0.837226 0.326832 0.315327 0.127108 0.986726 0.636573 0.620938 0.342426 0.453491 0.184506 0.007593 0.650084 0.029742 0.675009 0.733595 0.691521 0.846878 0.703664 0.070499 0.169687 0.96298 0.923595 0.386553 0.38166 0.894085 0.902389 0.900221 0.825258 0.818405 0.602819 0.437145 0.14255 0.202314 0.76354 0.104701 0.550869 0.367723 0.916575 0.839545 0.012735 0.360014 0.035506 0.584183 0.299226 0.509919 0.271635 0.34105 0.286379 0.803062 0.70518 0.235766 0.331586 0.80347 0.287406 0.7539 0.532273 0.429339 0.998572 0.966254 0.135927 0.813107 0.76453 0.816282 0.654142 0.822822 0.250786 0.751349 0.417236 0.11971 0.376965 0.268987 0.261451 0.503495 0.056873 0.266512 0.232528 0.430721 0.290977 0.548665 0.7291 0.305769 0.204876 0.69886 0.888568 0.484357 0.797137 0.093039 0.67013 0.839573 0.443285 0.04458 0.633962 0.070758 0.676848 0.212817 0.978905 0.665765 0.449351 0.853812 0.143207 0.178759 0.18858 0.490789 0.940724 0.349 0.366477 0.97978 0.333037 0.546254 0.446946 0.539905 0.926507 0.478728 0.130986 0.288575 0.546481 0.866242 0.313995 0.984023 0.932917 0.72422 0.615497 0.962376 0.717118 0.438578 0.125427 0.352614 0.088625 0.726438 0.923593 0.656396 0.387198 0.025253 0.430706 0.54005 0.249076 0.783181 0.225023 0.594862 0.145168 0.603991 0.445661 0.664049 0.073824 0.089135 0.785528 0.954094 0.848233 0.140792 0.739431 0.79175 0.885653 0.422165 0.711307 0.307811 0.90487 0.166829 0.533081 0.949042 0.284397 0.489912 0.072809 0.927666 0.260535 0.760615 0.306611 0.976333 0.72603 0.495968 0.8451 0.18318 0.85275 0.987218 0.702222 0.832736 0.933033 0.029008 0.050238 0.375085 0.941019 0.854245 0.794038
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Controller.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_controller
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander -25795 27499 -2508 4713 2897 24679 18662 21824 -31893 1263 -30188 25622 28320 -17535 14284 -9310 -14859 -20139 4783 -331 -26177 -28096 -31752 12282 17625 25452 6258 -2045 -8377 30349 -27099 28947 -24649 12679 -5983 6692 13662 0.811789 0.600228 0.247915 0.720804 0.829765 0.958186 0.306534 0.695498 0.767265 0.307859 0.757375 0.313411 0.384819 0.548688 0.319392 0.353819 0.954226 0.097741 0.510172 0.393042 0.501521 0.529812 0.801582 0.832137 0.545132 0.718766 0.661952 0.218433 0.385385 0.525995 0.761314 0.242437 0.308185 0.063382 0.932682 0.683461 0.482876 0.001429 0.997695 0.626433 0.837226 0.326832 0.315327 0.127108 0.986726 0.636573 0.620938 0.342426 0.453491 0.184506 0.007593 0.650084 0.029742 0.675009 0.733595 0.691521 0.846878 0.703664 0.070499 0.169687 0.96298 0.923595 0.386553 0.38166 0.894085 0.902389 0.900221 0.825258 0.818405 0.602819 0.437145 0.14255 0.202314 0.76354 0.104701 0.550869 0.367723 0.916575 0.839545 0.012735 0.360014 0.035506 0.584183 0.299226 0.509919 0.271635 0.34105 0.286379 0.803062 0.70518 0.235766 0.331586 0.80347 0.287406 0.7539 0.532273 0.429339 0.998572 0.966254 0.135927 0.813107 0.76453 0.816282 0.654142 0.822822 0.250786 0.751349 0.417236 0.11971 0.376965 0.268987 0.261451 0.503495 0.056873 0.266512 0.232528 0.430721 0.290977 0.548665 0.7291 0.305769 0.204876 0.69886 0.888568 0.484357 0.797137 0.093039 0.67013 0.839573 0.443285 0.04458 0.633962 0.070758 0.676848 0.212817 0.978905 0.665765 0.449351 0.853812 0.143207 0.178759 0.18858 0.490789 0.940724 0.349 0.366477 0.97978 0.333037 0.546254 0.446946 0.539905 0.926507 0.478728 0.130986 0.288575 0.546481 0.866242 0.313995 0.984023 0.932917 0.72422 0.615497 0.962376 0.717118 0.438578 0.125427 0.352614 0.088625 0.726438 0.923593 0.656396 0.387198 0.025253 0.430706 0.54005 0.249076 0.783181 0.225023 0.594862 0.145168 0.603991 0.445661 0.664049 0.073824 0.089135 0.785528 0.954094 0.848233 0.140792 0.739431 0.79175 0.885653 0.422165 0.711307 0.307811 0.90487 0.166829 0.533081 0.949042 0.284397 0.489912 0.072809 0.927666 0.260535 0.760615 0.306611 0.976333 0.72603 0.495968 0.8451 0.18318 0.85275 0.987218 0.702222 0.832736 0.933033 0.029008 0.050238 0.375085 0.941019 0.854245 0.794038
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :     1
    Should Contain X Times    ${output}    property :     1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    azIndex : -25795    1
    Should Contain X Times    ${output}    fz1 : 0.811789    1
    Should Contain X Times    ${output}    fz2 : 0.001429    1
    Should Contain X Times    ${output}    fz3 : 0.104701    1
    Should Contain X Times    ${output}    fz4 : 0.261451    1
    Should Contain X Times    ${output}    fz5 : 0.546254    1
    Should Contain X Times    ${output}    fz6 : 0.785528    1
    Should Contain    ${output}    === command configureAzimuthRawLUT issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command configureAzimuthRawLUT received =
    Should Contain    ${output}    device : 
    Should Contain    ${output}    property : 
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    azIndex : -25795    1
    Should Contain X Times    ${output}    fz1 : 0.811789    1
    Should Contain X Times    ${output}    fz2 : 0.001429    1
    Should Contain X Times    ${output}    fz3 : 0.104701    1
    Should Contain X Times    ${output}    fz4 : 0.261451    1
    Should Contain X Times    ${output}    fz5 : 0.546254    1
    Should Contain X Times    ${output}    fz6 : 0.785528    1
    Should Contain X Times    ${output}    === [ackCommand_configureAzimuthRawLUT] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
