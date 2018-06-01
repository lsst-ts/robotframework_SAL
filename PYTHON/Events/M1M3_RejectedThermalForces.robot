*** Settings ***
Documentation    M1M3_RejectedThermalForces communications tests.
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
${component}    RejectedThermalForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 56.0538 0.511389 0.203185 0.996738 0.766218 0.288357 0.279108 0.189407 0.796789 0.160701 0.040363 0.146161 0.365536 0.053249 0.681275 0.533371 0.364192 0.147218 0.178977 0.244784 0.769004 0.474168 0.678954 0.59316 0.788224 0.833639 0.74756 0.697339 0.260844 0.72713 0.037119 0.285211 0.979855 0.4603 0.648524 0.045084 0.935507 0.62109 0.288029 0.47704 0.187289 0.298863 0.974033 0.936425 0.551348 0.675865 0.473314 0.85708 0.603263 0.625635 0.545066 0.237386 0.289149 0.809296 0.82619 0.750672 0.969717 0.252361 0.451215 0.794093 0.055039 0.914353 0.68894 0.496807 0.802234 0.466885 0.100069 0.063194 0.223748 0.421511 0.345044 0.051881 0.786192 0.426546 0.940485 0.841186 0.307157 0.634355 0.00631 0.531698 0.555617 0.26085 0.568113 0.56711 0.277649 0.371202 0.297813 0.722744 0.164275 0.683692 0.216953 0.496562 0.899343 0.216829 0.991531 0.215325 0.435799 0.720852 0.263098 0.956432 0.791605 0.920555 0.719144 0.99278 0.897806 0.500289 0.408289 0.598134 0.869464 0.099287 0.755399 0.403108 0.381936 0.0158 0.717929 0.583783 0.663375 0.161845 0.061326 0.620719 0.811251 0.443102 0.628356 0.88085 0.451062 0.46849 0.781216 0.278799 0.280712 0.402865 0.979327 0.807694 0.141756 0.048824 0.763854 0.341892 0.160549 0.027007 0.028805 0.275568 0.308126 0.14369 0.55267 0.826798 0.499751 0.615226 0.645678 0.827119 0.897035 0.7894 0.907229 0.758182 0.535659 0.442635 0.736274 0.608095 0.851763 0.492778 0.850499 0.170762 0.554889 0.862057 0.444339 0.568736 0.696937 0.964737 0.624019 0.429683 0.293745 0.638526 0.532581 0.963436 0.84912 0.995619 0.702734 0.438431 0.512851 0.429449 0.460651 0.549471 0.688183 0.983164 0.081406 0.517044 0.153688 0.374445 0.06886 0.522559 0.676303 0.606864 0.989643 0.025811 0.478881 0.109434 0.182218 0.090089 0.974206 0.375775 0.711346 0.147586 0.793453 0.568565 0.590316 0.532402 0.142735 0.876755 0.781302 0.739749 0.707352 0.548763 0.680605 0.194753 0.799477 0.348174 0.28448 0.381881 0.555742 0.474958 0.449227 0.290339 0.132013 0.330085 0.627417 0.308495 0.627102 0.97857 0.104739 0.250593 0.694305 0.553141 0.723437 0.738873 0.315574 0.147003 0.490271 0.324777 0.500413 0.693368 0.565548 0.5318 0.378571 0.759039 0.312681 0.578722 0.119847 0.520083 0.443319 0.162374 0.585129 0.054883 0.358788 0.546143 0.903771 0.949872 0.774865 0.549651 0.661125 0.753141 0.326396 0.543753 0.214876 0.681028 0.528905 0.779669 0.243232 0.3048 0.917948 0.750519 0.966193 0.909349 0.444185 0.968865 0.260146 0.449286 0.492662 0.897614 -1116586115
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedThermalForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
