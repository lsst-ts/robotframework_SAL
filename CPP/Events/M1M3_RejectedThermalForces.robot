*** Settings ***
Documentation    M1M3_RejectedThermalForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedThermalForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 29.9167 0.254611 0.175068 0.879715 0.058065 0.291619 0.551197 0.391737 0.5091 0.709204 0.37767 0.189354 0.058914 0.158922 0.040679 0.28081 0.366834 0.410565 0.686621 0.539735 0.458761 0.183616 0.90543 0.280274 0.868084 0.534603 0.931473 0.65482 0.323069 0.711333 0.402669 0.319768 0.105284 0.35142 0.340784 0.072043 0.540166 0.801703 0.380507 0.873366 0.791247 0.083214 0.518484 0.523686 0.425771 0.840801 0.695601 0.695577 0.805486 0.082614 0.923766 0.044894 0.236982 0.33932 0.666133 0.949601 0.794732 0.270539 0.06659 0.449544 0.091753 0.279467 0.351194 0.958828 0.946266 0.583704 0.799543 0.428603 0.324678 0.650868 0.881971 0.470677 0.105789 0.537296 0.239453 0.346701 0.225049 0.602616 0.463591 0.783847 0.237001 0.104673 0.19693 0.831153 0.380876 0.806657 0.732909 0.625347 0.303137 0.249799 0.360202 0.238864 0.818775 0.084666 0.848679 0.062726 0.797491 0.10041 0.223168 0.188139 0.307201 0.732212 0.943302 0.92732 0.636267 0.257785 0.45612 0.940316 0.407759 0.251209 0.116475 0.919343 0.917635 0.802167 0.372247 0.499206 0.855231 0.014125 0.832824 0.046979 0.382157 0.639089 0.210373 0.92338 0.202572 0.980673 0.319435 0.614705 0.199947 0.732667 0.936316 0.455878 0.050458 0.689701 0.025342 0.942132 0.724347 0.041463 0.04785 0.605673 0.891655 0.999835 0.138929 0.097669 0.180734 0.007921 0.937723 0.388742 0.819693 0.38036 0.487841 0.280721 0.837852 0.591167 0.815421 0.851549 0.17132 0.343905 0.961161 0.420574 0.173352 0.756024 0.262468 0.141921 0.359284 0.257363 0.476196 0.062331 0.058249 0.625707 0.293878 0.905235 0.700673 0.498463 0.839194 0.32345 0.044126 0.629262 0.067051 0.714459 0.600473 0.185165 0.916784 0.427476 0.382906 0.663616 0.216171 0.078241 0.065367 0.112407 0.362769 0.73256 0.318672 0.94738 0.212074 0.88755 0.837897 0.978216 0.916278 0.331302 0.771659 0.128909 0.879077 0.560475 0.091751 0.168229 0.417307 0.993387 0.621718 0.022513 0.250116 0.235115 0.337206 0.727856 0.129565 0.030753 0.241828 0.49674 0.610302 0.397565 0.399528 0.65917 0.150218 0.546132 0.931679 0.231531 0.856534 0.568719 0.963686 0.467798 0.597857 0.061014 0.520024 0.351879 0.189574 0.375534 0.177889 0.122509 0.323939 0.468575 0.521609 0.271511 0.577098 0.130076 0.61786 0.724216 0.956585 0.739475 0.404026 0.455859 0.11917 0.759867 0.378734 0.408613 0.869934 0.346091 0.548722 0.30942 0.861827 0.178213 0.87991 0.77744 0.604641 0.619719 0.515563 0.291073 0.317198 0.686175 0.118701 0.838894 0.056035 0.348922 0.481754 0.711728 0.781858 0.89948 251050358
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedThermalForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedThermalForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 251050358
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedThermalForces received =     1
    Should Contain    ${output}    Timestamp : 29.9167
    Should Contain    ${output}    XForces : 0.254611
    Should Contain    ${output}    YForces : 0.175068
    Should Contain    ${output}    ZForces : 0.879715
    Should Contain    ${output}    Fx : 0.058065
    Should Contain    ${output}    Fy : 0.291619
    Should Contain    ${output}    Fz : 0.551197
    Should Contain    ${output}    Mx : 0.391737
    Should Contain    ${output}    My : 0.5091
    Should Contain    ${output}    Mz : 0.709204
    Should Contain    ${output}    ForceMagnitude : 0.37767
    Should Contain    ${output}    priority : 0.189354
