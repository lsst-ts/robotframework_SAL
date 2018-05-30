*** Settings ***
Documentation    M1M3_RejectedAzimuthForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedAzimuthForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 75.7904 0.878435 0.690785 0.879972 0.350775 0.950539 0.258998 0.926184 0.813001 0.136768 0.733908 0.447989 0.202751 0.444532 0.724869 0.84679 0.877788 0.965464 0.482202 0.498231 0.652536 0.454981 0.09402 0.880618 0.657132 0.644005 0.678832 0.722346 0.297263 0.101972 0.950782 0.361967 0.328555 0.078564 0.140507 0.772824 0.117631 0.063981 0.119529 0.109811 0.344962 0.61134 0.017839 0.422833 0.906734 0.249006 0.394169 0.916484 0.091794 0.599511 0.197004 0.125618 0.436949 0.252137 0.454201 0.388642 0.902233 0.709946 0.358077 0.208218 0.953077 0.739075 0.949639 0.357111 0.533099 0.462139 0.380604 0.868311 0.016771 0.835643 0.676131 0.48874 0.528525 0.367811 0.605243 0.390534 0.189212 0.604158 0.615084 0.833175 0.760682 0.950597 0.23495 0.642736 0.264939 0.525699 0.617172 0.70084 0.668104 0.709601 0.757058 0.377659 0.152433 0.863808 0.560831 0.578105 0.879744 0.991109 0.29424 0.301854 0.696574 0.785404 0.935901 0.577057 0.427788 0.14969 0.856435 0.531843 0.575595 0.294444 0.835628 0.157197 0.728806 0.040921 0.680054 0.094656 0.145831 0.916581 0.422612 0.27942 0.690761 0.773908 0.686109 0.0886 0.450868 0.922186 0.337861 0.25296 0.457709 0.90741 0.429415 0.3698 0.91178 0.956187 0.962855 0.581433 0.573604 0.341057 0.150437 0.571796 0.663982 0.586611 0.03288 0.661595 0.035437 0.164542 0.834806 0.214551 0.3045 0.303724 0.147062 0.577614 0.917147 0.535048 0.420774 0.402422 0.320065 0.269983 0.406705 0.883114 0.586245 0.397849 0.924303 0.681956 0.50133 0.643114 0.428233 0.657574 0.788779 0.178273 0.593934 0.02568 0.632212 0.340199 0.536074 0.231164 0.904234 0.162601 0.125272 0.875288 0.437285 0.773749 0.371326 0.245974 0.595155 0.656602 0.966519 0.834839 0.710163 0.949202 0.147748 0.648068 0.274536 0.632318 0.19525 0.003872 0.053536 0.181821 0.750838 0.832577 0.884623 0.626575 0.010603 0.317597 0.818207 0.375431 0.223579 0.72491 0.631974 0.798811 0.508303 0.360797 0.571379 0.149149 0.004787 0.254411 0.81068 0.56501 0.328287 0.513345 0.478796 0.779797 0.450837 0.056437 0.690258 0.521429 0.073279 0.553534 0.39718 0.666385 0.716158 0.675025 0.135445 0.176254 0.81329 0.451548 0.34859 0.613938 0.091937 0.574755 0.027384 0.258105 0.649667 0.125087 0.599758 0.21157 0.155254 0.990294 0.41611 0.976035 0.911646 0.674862 0.841149 0.468926 0.127748 0.279631 0.385896 0.710001 0.607391 0.309768 0.06878 0.758281 0.865425 0.158783 0.705846 0.111168 0.021547 0.700589 0.552972 0.085481 0.394879 0.477869 0.48928 0.587079 0.161083 0.989318 922932106
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedAzimuthForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedAzimuthForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 922932106
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedAzimuthForces received =     1
    Should Contain    ${output}    Timestamp : 75.7904
    Should Contain    ${output}    XForces : 0.878435
    Should Contain    ${output}    YForces : 0.690785
    Should Contain    ${output}    ZForces : 0.879972
    Should Contain    ${output}    Fx : 0.350775
    Should Contain    ${output}    Fy : 0.950539
    Should Contain    ${output}    Fz : 0.258998
    Should Contain    ${output}    Mx : 0.926184
    Should Contain    ${output}    My : 0.813001
    Should Contain    ${output}    Mz : 0.136768
    Should Contain    ${output}    ForceMagnitude : 0.733908
    Should Contain    ${output}    priority : 0.447989
