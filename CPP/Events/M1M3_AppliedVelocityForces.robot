*** Settings ***
Documentation    M1M3_AppliedVelocityForces communications tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedVelocityForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 47.6989 0.774821 0.001138 0.668438 0.266037 0.202972 0.965358 0.381599 0.834416 0.289757 0.701691 0.805913 0.569617 0.650395 0.606569 0.919247 0.852036 0.721703 0.164476 0.521002 0.138705 0.27897 0.498745 0.949081 0.798066 0.106551 0.174783 0.79971 0.113915 0.584388 0.541591 0.813855 0.723868 0.092179 0.409915 0.711136 0.063488 0.87789 0.717816 0.765852 0.089066 0.225055 0.881496 0.615219 0.456656 0.444343 0.612473 0.78673 0.067213 0.833881 0.771463 0.751514 0.454193 0.951559 0.410788 0.900978 0.947822 0.683117 0.294297 0.240458 0.322561 0.813332 0.295751 0.709133 0.201412 0.510744 0.224285 0.636419 0.754182 0.117857 0.227256 0.109814 0.094188 0.378922 0.895113 0.941945 0.605433 0.485367 0.303822 0.300238 0.766102 0.514278 0.182102 0.421566 0.916935 0.044973 0.383928 0.035477 0.983856 0.264284 0.934091 0.52151 0.392821 0.572003 0.692256 0.355764 0.075842 0.293667 0.064155 0.430306 0.936102 0.153322 0.363435 0.900204 0.197069 0.216255 0.410235 0.422434 0.686709 0.954031 0.946956 0.273654 0.324851 0.706079 0.304602 0.577289 0.023992 0.095001 0.256213 0.384227 0.763892 0.174491 0.068004 0.367197 0.575039 0.697236 0.134125 0.057795 0.735939 0.420711 0.131625 0.772548 0.782175 0.612105 0.979693 0.627945 0.754 0.598573 0.959676 0.349083 0.000818 0.468713 0.414351 0.778717 0.57367 0.411943 0.567142 0.341257 0.137897 0.399717 0.998261 0.660527 0.51322 0.024726 0.915943 0.03373 0.587662 0.363067 0.152859 0.475972 0.571612 0.511203 0.00601 0.895133 0.598214 0.18804 0.607555 0.832631 0.19233 0.545249 0.017445 0.235461 0.280193 0.521803 0.385236 0.533591 0.832651 0.301248 0.181928 0.802777 0.472202 0.803743 0.396327 0.953457 0.036846 0.955057 0.275948 0.45271 0.097679 0.808913 0.310774 0.955459 0.77936 0.864993 0.686935 0.707289 0.649102 0.643632 0.96535 0.173573 0.458977 0.186249 0.204653 0.152866 0.612518 0.682191 0.49601 0.574147 0.739984 0.407361 0.622377 0.454309 0.554467 0.132502 0.459992 0.003867 0.629996 0.643509 0.669037 0.485655 0.061243 0.601219 0.095866 0.149201 0.817153 0.146674 0.468367 0.087545 0.410723 0.588245 0.847338 0.242103 0.183118 0.017571 0.234129 0.873561 0.196457 0.538821 0.437883 0.18784 0.036389 0.370034 0.941119 0.338291 0.533696 0.303728 0.476964 0.564973 0.94587 0.818883 0.119127 0.715104 0.940025 0.797205 0.176228 0.205984 0.130071 0.577805 0.207194 0.134467 0.419952 0.590567 0.821026 0.366681 0.764008 0.76622 0.34383 0.686364 0.058718 0.438184 0.081427 0.456504 0.892459 0.720066 0.803711 0.317281 196560271
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedVelocityForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedVelocityForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 196560271
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedVelocityForces received =     1
    Should Contain    ${output}    Timestamp : 47.6989
    Should Contain    ${output}    XForces : 0.774821
    Should Contain    ${output}    YForces : 0.001138
    Should Contain    ${output}    ZForces : 0.668438
    Should Contain    ${output}    Fx : 0.266037
    Should Contain    ${output}    Fy : 0.202972
    Should Contain    ${output}    Fz : 0.965358
    Should Contain    ${output}    Mx : 0.381599
    Should Contain    ${output}    My : 0.834416
    Should Contain    ${output}    Mz : 0.289757
    Should Contain    ${output}    ForceMagnitude : 0.701691
    Should Contain    ${output}    priority : 0.805913
