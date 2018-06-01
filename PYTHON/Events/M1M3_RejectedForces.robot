*** Settings ***
Documentation    M1M3_RejectedForces communications tests.
Force Tags    python    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedForces
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp XForces YForces ZForces Fx Fy Fz Mx My Mz ForceMagnitude priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 42.4927 0.235968 0.139395 0.525563 0.947815 0.090817 0.186505 0.103525 0.334082 0.784515 0.043864 0.230162 0.339993 0.978727 0.924753 0.290675 0.583674 0.839847 0.092545 0.488128 0.290041 0.4678 0.485902 0.160009 0.892797 0.197857 0.454802 0.879513 0.2173 0.308229 0.052979 0.537219 0.697774 0.094205 0.696186 0.858383 0.728886 0.003812 0.035129 0.237203 0.17763 0.372481 0.825423 0.665223 0.921184 0.545968 0.612328 0.631922 0.515411 0.012947 0.173626 0.632456 0.758324 0.517452 0.386742 0.2211 0.754989 0.515243 0.716268 0.952427 0.22101 0.629848 0.682804 0.728837 0.940902 0.400567 0.046255 0.718516 0.824517 0.148114 0.172154 0.574795 0.972445 0.830437 0.513576 0.857067 0.318241 0.471188 0.775892 0.631003 0.969784 0.578983 0.425016 0.383793 0.667503 0.027485 0.708445 0.502626 0.220882 0.383625 0.577733 0.594723 0.330275 0.016832 0.606609 0.189776 0.072797 0.479462 0.884856 0.901766 0.261595 0.373793 0.318503 0.295321 0.985381 0.507593 0.269403 0.992608 0.234139 0.426115 0.99993 0.243236 0.891327 0.994891 0.662561 0.148675 0.103034 0.551258 0.401358 0.045437 0.873577 0.582109 0.514819 0.654518 0.877507 0.2514 0.709925 0.551588 0.98396 0.791332 0.24086 0.669996 0.638794 0.810106 0.003023 0.199507 0.621871 0.642644 0.012927 0.485124 0.459485 0.51504 0.65857 0.076709 0.407278 0.043521 0.419186 0.702195 0.151183 0.84731 0.713342 0.180652 0.56739 0.208423 0.665885 0.896659 0.256836 0.868488 0.759579 0.706118 0.869512 0.799276 0.547789 0.118854 0.104675 0.800425 0.664 0.071084 0.669024 0.366419 0.424582 0.28679 0.582268 0.99387 0.251963 0.148312 0.539728 0.525042 0.063573 0.129567 0.349735 0.88204 0.848999 0.435138 0.308179 0.538003 0.866447 0.225591 0.539392 0.147282 0.072011 0.393326 0.440963 0.881615 0.916944 0.37065 0.222806 0.695262 0.007516 0.29715 0.363886 0.336473 0.776759 0.166412 0.744056 0.277835 0.162389 0.321531 0.861181 0.811638 0.864624 0.091265 0.445016 0.110781 0.060166 0.433182 0.110208 0.756908 0.696932 0.811827 0.82831 0.477322 0.797752 0.732136 0.761425 0.650206 0.101123 0.819233 0.097945 0.452678 0.468684 0.265458 0.690853 0.201403 0.556242 0.205951 0.387547 0.383615 0.565545 0.180683 0.028712 0.941578 0.278199 0.383962 0.433636 0.787406 0.320644 0.999216 0.288513 0.709101 0.590138 0.83524 0.752572 0.468249 0.233159 0.09155 0.306969 0.158918 0.536012 0.833356 0.100533 0.714096 0.350745 0.365869 0.181357 0.400554 0.465665 0.32669 0.863042 0.824764 0.204262 0.499272 0.236872 0.999931 0.405388 0.553696 -1444501125
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
