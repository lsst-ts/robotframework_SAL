*** Settings ***
Documentation    M1M3_AppliedThermalForces communications tests.
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
${component}    AppliedThermalForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 67.2821 0.049957 0.516853 0.835094 0.123483 0.581206 0.298504 0.738293 0.70789 0.327215 0.165032 0.607902 0.509648 0.825969 0.560413 0.784864 0.849159 0.025697 0.49663 0.653508 0.425629 0.800067 0.302258 0.674488 0.435459 0.154165 0.210585 0.727799 0.858653 0.002767 0.822268 0.268486 0.554884 0.678856 0.95031 0.195797 0.605029 0.955207 0.233735 0.820299 0.66913 0.740436 0.060077 0.913085 0.791513 0.146437 0.766429 0.237148 0.958445 0.879521 0.524002 0.314302 0.082834 0.354314 0.726104 0.008045 0.893709 0.091836 0.400869 0.813255 0.876858 0.092973 0.898245 0.048903 0.237958 0.964165 0.527022 0.82441 0.439446 0.308942 0.66697 0.503602 0.024527 0.649934 0.820328 0.583392 0.903949 0.83675 0.179093 0.486254 0.691152 0.536884 0.693281 0.716705 0.967795 0.488116 0.41609 0.118906 0.499688 0.57619 0.997487 0.681388 0.719967 0.482697 0.318544 0.949722 0.685482 0.65204 0.397509 0.358607 0.218102 0.043315 0.424966 0.280681 0.919091 0.027812 0.728657 0.623805 0.443022 0.649198 0.375626 0.008958 0.019731 0.766905 0.56129 0.775446 0.35388 0.810673 0.704013 0.644032 0.715746 0.049571 0.192623 0.904177 0.748445 0.804634 0.293812 0.785869 0.081564 0.483548 0.608386 0.687145 0.334641 0.895818 0.772197 0.886544 0.04143 0.59764 0.359351 0.049201 0.286376 0.67273 0.456739 0.570478 0.66633 0.923902 0.546962 0.669811 0.887262 0.238171 0.032342 0.732851 0.657478 0.896191 0.840936 0.63623 0.584668 0.760341 0.986099 0.316871 0.95758 0.588071 0.173605 0.701363 0.769695 0.984845 0.373484 0.331691 0.171418 0.477388 0.98277 0.720679 0.662933 0.573893 0.863318 0.662174 0.857757 0.261573 0.236328 0.932832 0.711639 0.981413 0.542948 0.304982 0.979554 0.149752 0.453722 0.847838 0.911114 0.39874 0.30985 0.36664 0.07806 0.666757 0.294125 0.888869 0.773952 0.758729 0.488153 0.357949 0.462972 0.208726 0.312112 0.471763 0.508303 0.187321 0.781144 0.453566 0.285236 0.756684 0.033484 0.641452 0.248028 0.863818 0.000043 0.367028 0.103135 0.664273 0.586656 0.109171 0.792128 0.798746 0.662819 0.85968 0.249188 0.415609 0.18423 0.329767 0.569636 0.333852 0.875744 0.87994 0.824401 0.830221 0.397732 0.926236 0.816848 0.86272 0.737493 0.785706 0.893133 0.500667 0.785248 0.143029 0.479062 0.088923 0.979779 0.310431 0.853677 0.749075 0.481233 0.076699 0.657553 0.280627 0.576015 0.343079 0.892982 0.711134 0.423103 0.820641 0.046871 0.253254 0.99111 0.481769 0.308812 0.201866 0.061133 0.890078 0.808273 0.459978 0.643826 0.270875 0.744532 0.576321 0.163862 0.610523 7657447
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedThermalForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
