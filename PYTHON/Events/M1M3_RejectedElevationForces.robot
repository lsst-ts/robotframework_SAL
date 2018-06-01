*** Settings ***
Documentation    M1M3_RejectedElevationForces communications tests.
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
${component}    RejectedElevationForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 42.9568 0.657845 0.947968 0.81687 0.179618 0.50908 0.102987 0.436907 0.167604 0.518939 0.245076 0.75551 0.132736 0.444314 0.374125 0.872785 0.275044 0.305128 0.967225 0.763829 0.249605 0.079373 0.11592 0.95702 0.598678 0.984772 0.081918 0.95669 0.517768 0.478948 0.046051 0.897225 0.099874 0.48787 0.498316 0.895051 0.299607 0.642359 0.211072 0.606101 0.75532 0.53942 0.789708 0.684121 0.525076 0.972149 0.708781 0.440276 0.661046 0.000769 0.406194 0.517123 0.460616 0.591356 0.002085 0.400176 0.221975 0.292566 0.497487 0.901064 0.342962 0.311064 0.180411 0.467299 0.732259 0.794282 0.716634 0.80231 0.133162 0.764342 0.194167 0.387014 0.567848 0.541921 0.303295 0.233903 0.370115 0.9245 0.216427 0.858651 0.671603 0.370954 0.257161 0.648418 0.082293 0.862478 0.332184 0.036596 0.765973 0.162248 0.561091 0.010119 0.297802 0.673297 0.77251 0.553154 0.641691 0.168433 0.038988 0.036423 0.248759 0.366142 0.056248 0.385919 0.161895 0.692888 0.604349 0.373336 0.247681 0.064373 0.245336 0.932465 0.448417 0.703873 0.91677 0.533886 0.372076 0.99688 0.40725 0.880598 0.275462 0.181149 0.774851 0.442865 0.833471 0.773188 0.60127 0.189581 0.591588 0.5729 0.63197 0.875621 0.032407 0.513253 0.507188 0.486426 0.098471 0.456656 0.42414 0.579525 0.097368 0.465708 0.073414 0.192578 0.967456 0.856319 0.787859 0.724325 0.997473 0.262668 0.325483 0.326448 0.391437 0.046038 0.688128 0.078955 0.306181 0.149714 0.052244 0.028203 0.354174 0.362578 0.0621 0.424261 0.586781 0.006246 0.942953 0.933172 0.194066 0.252812 0.750678 0.960828 0.047993 0.378789 0.91792 0.641902 0.062832 0.90769 0.159386 0.183554 0.106242 0.393554 0.058033 0.673234 0.16988 0.559075 0.14314 0.976954 0.533056 0.85173 0.999753 0.837871 0.230396 0.70024 0.589146 0.81855 0.464504 0.090548 0.896717 0.366263 0.095514 0.983343 0.741166 0.656626 0.627582 0.675532 0.887522 0.07748 0.213166 0.044944 0.458992 0.405006 0.600051 0.356224 0.571439 0.478609 0.421956 0.603782 0.114686 0.372316 0.190588 0.528019 0.69087 0.164198 0.36197 0.725641 0.019881 0.580148 0.888336 0.760715 0.981039 0.769952 0.644217 0.818444 0.64006 0.501282 0.739427 0.623639 0.175348 0.595873 0.133041 0.006959 0.620414 0.559065 0.45197 0.491405 0.482769 0.521738 0.745876 0.275723 0.599402 0.563708 0.35577 0.261184 0.884323 0.731107 0.016553 0.06179 0.874076 0.841299 0.096091 0.722886 0.341375 0.300514 0.072437 0.810026 0.411671 0.183649 0.277059 0.334925 0.855668 0.352048 0.31336 0.668114 0.768468 0.864861 861822372
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedElevationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
