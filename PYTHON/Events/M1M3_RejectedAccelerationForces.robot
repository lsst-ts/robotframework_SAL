*** Settings ***
Documentation    M1M3_RejectedAccelerationForces communications tests.
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
${component}    RejectedAccelerationForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 54.6436 0.783044 0.696026 0.151557 0.474264 0.894504 0.971092 0.126093 0.803228 0.197693 0.514277 0.103088 0.431726 0.926658 0.521127 0.928149 0.592753 0.989173 0.769824 0.250784 0.508994 0.447697 0.234357 0.372446 0.314567 0.297952 0.542598 0.449189 0.075419 0.737877 0.521204 0.535226 0.955313 0.892948 0.939816 0.975107 0.49186 0.22456 0.417506 0.794226 0.376183 0.555514 0.342579 0.125568 0.013007 0.989979 0.79958 0.402141 0.756909 0.813142 0.381532 0.259251 0.001138 0.587329 0.126051 0.681858 0.040345 0.75054 0.797871 0.795142 0.359426 0.224719 0.346194 0.999477 0.514504 0.325499 0.847695 0.596632 0.453961 0.972158 0.643934 0.834367 0.738252 0.666379 0.353448 0.007244 0.766907 0.130774 0.091903 0.509873 0.712417 0.30943 0.998539 0.531865 0.558279 0.350581 0.723552 0.161963 0.323582 0.05361 0.603166 0.557087 0.906937 0.549775 0.113598 0.767016 0.68621 0.168612 0.746647 0.08446 0.853509 0.196882 0.566084 0.938372 0.69788 0.089177 0.162836 0.781887 0.269498 0.493011 0.778964 0.774583 0.218624 0.018682 0.446788 0.037103 0.116585 0.743132 0.155505 0.570533 0.293673 0.802073 0.485607 0.238115 0.246556 0.705086 0.516224 0.345257 0.557924 0.427406 0.527673 0.985552 0.238061 0.396134 0.02329 0.056379 0.789331 0.986992 0.324261 0.839334 0.78717 0.317708 0.513946 0.451379 0.601983 0.176435 0.345593 0.73992 0.118783 0.427527 0.114444 0.981178 0.90119 0.732684 0.150893 0.313505 0.192272 0.805093 0.685719 0.533329 0.281276 0.187733 0.817299 0.67349 0.380087 0.086337 0.779445 0.777133 0.530896 0.224609 0.226764 0.386024 0.587335 0.564781 0.86878 0.206854 0.661733 0.037273 0.299772 0.418158 0.681151 0.047507 0.992779 0.220863 0.117676 0.591349 0.357636 0.552076 0.639424 0.561968 0.226514 0.864175 0.23679 0.11292 0.052901 0.248125 0.666429 0.003218 0.992891 0.271607 0.159654 0.443165 0.136557 0.554324 0.019674 0.847778 0.726156 0.371938 0.26074 0.316747 0.60071 0.655761 0.108253 0.880525 0.271162 0.678073 0.935204 0.939833 0.881416 0.046094 0.376807 0.899366 0.237229 0.951947 0.550233 0.119854 0.414937 0.696644 0.453882 0.257634 0.941663 0.465269 0.497887 0.756565 0.384191 0.878792 0.96281 0.361348 0.827042 0.684073 0.061967 0.773831 0.687026 0.569312 0.66046 0.725146 0.901818 0.067329 0.451953 0.64804 0.565836 0.356634 0.599649 0.879291 0.703132 0.72145 0.800099 0.071556 0.538243 0.591735 0.959733 0.542635 0.990875 0.456484 0.909724 0.359923 0.404912 0.426797 0.603478 0.177558 0.948678 0.441501 0.169172 0.084394 0.9618 0.980787 -2095745086
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedAccelerationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
