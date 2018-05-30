*** Settings ***
Documentation    M1M3_RejectedStaticForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedStaticForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 31.3369 0.894257 0.136306 0.892189 0.901607 0.630752 0.87744 0.6886 0.157393 0.662212 0.230224 0.824943 0.754465 0.371321 0.139258 0.321557 0.365542 0.168961 0.129661 0.169654 0.92056 0.672655 0.917088 0.003245 0.243145 0.626051 0.951878 0.435057 0.317741 0.232408 0.8952 0.119196 0.50171 0.177425 0.354841 0.104124 0.423181 0.657858 0.294681 0.616464 0.335443 0.772153 0.128976 0.908662 0.919871 0.579152 0.557119 0.289658 0.293355 0.513679 0.53839 0.17805 0.773929 0.22094 0.669636 0.39942 0.629847 0.81389 0.014044 0.803973 0.479981 0.467592 0.034941 0.208109 0.599666 0.78198 0.947361 0.772189 0.766033 0.369496 0.896073 0.564667 0.66331 0.700801 0.480642 0.99175 0.286655 0.330723 0.186921 0.483236 0.952811 0.225062 0.57436 0.754346 0.346238 0.189525 0.199406 0.274723 0.100092 0.597831 0.785477 0.452381 0.678963 0.121639 0.534907 0.605011 0.13063 0.616212 0.723545 0.604664 0.325106 0.862253 0.817904 0.347151 0.750261 0.195422 0.085521 0.543556 0.468018 0.003295 0.753638 0.191222 0.142977 0.993984 0.68112 0.06834 0.380654 0.261497 0.427783 0.149758 0.580416 0.218763 0.98472 0.224466 0.489498 0.484809 0.809242 0.104763 0.640078 0.811494 0.89693 0.146818 0.601665 0.946723 0.282436 0.243676 0.140897 0.351898 0.713347 0.072764 0.706343 0.929992 0.908337 0.854563 0.590657 0.432926 0.194473 0.133269 0.031517 0.408218 0.94005 0.663382 0.564276 0.996455 0.618314 0.490217 0.935269 0.763652 0.105374 0.083505 0.628524 0.453996 0.851895 0.850387 0.627921 0.004411 0.500513 0.604275 0.347573 0.71064 0.721006 0.313699 0.507972 0.133778 0.953131 0.776019 0.89976 0.198302 0.356028 0.000062 0.77154 0.25968 0.888916 0.391876 0.168144 0.290484 0.422479 0.419818 0.060986 0.538844 0.0574 0.724777 0.489368 0.335956 0.123432 0.756654 0.205772 0.522134 0.711826 0.867083 0.096994 0.758472 0.639373 0.709617 0.608208 0.639582 0.443997 0.456075 0.199551 0.069438 0.323547 0.108347 0.615566 0.869107 0.133181 0.793114 0.642467 0.666559 0.425859 0.749208 0.291446 0.956919 0.522006 0.216872 0.924554 0.377511 0.761874 0.689641 0.020451 0.459983 0.893144 0.177319 0.734381 0.50429 0.615186 0.049196 0.083655 0.267876 0.487451 0.907178 0.889986 0.297421 0.743484 0.241512 0.049449 0.479565 0.547421 0.306125 0.054425 0.67429 0.561073 0.534949 0.533659 0.99352 0.451969 0.391524 0.155377 0.584292 0.506698 0.986187 0.005064 0.771308 0.945462 0.868039 0.250859 0.027791 0.133271 0.133938 0.830823 0.479717 0.790847 0.610304 0.968272 0.507949 0.266107 0.706016 884812403
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedStaticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedStaticForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 884812403
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedStaticForces received =     1
    Should Contain    ${output}    Timestamp : 31.3369
    Should Contain    ${output}    XForces : 0.894257
    Should Contain    ${output}    YForces : 0.136306
    Should Contain    ${output}    ZForces : 0.892189
    Should Contain    ${output}    Fx : 0.901607
    Should Contain    ${output}    Fy : 0.630752
    Should Contain    ${output}    Fz : 0.87744
    Should Contain    ${output}    Mx : 0.6886
    Should Contain    ${output}    My : 0.157393
    Should Contain    ${output}    Mz : 0.662212
    Should Contain    ${output}    ForceMagnitude : 0.230224
    Should Contain    ${output}    priority : 0.824943
