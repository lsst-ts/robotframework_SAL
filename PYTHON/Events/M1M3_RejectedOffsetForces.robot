*** Settings ***
Documentation    M1M3_RejectedOffsetForces communications tests.
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
${component}    RejectedOffsetForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 14.2645 0.049287 0.42814 0.116987 0.539747 0.603966 0.903362 0.768031 0.57699 0.834447 0.87852 0.546483 0.440119 0.746709 0.352021 0.669264 0.323882 0.95805 0.725474 0.554766 0.878066 0.39154 0.926615 0.081601 0.179433 0.399541 0.830472 0.227806 0.796761 0.896455 0.915726 0.672067 0.329848 0.272495 0.023028 0.975144 0.174766 0.065245 0.592485 0.13083 0.404405 0.157028 0.869031 0.021097 0.263373 0.389502 0.66329 0.33345 0.548876 0.282212 0.425867 0.521517 0.539302 0.14387 0.277451 0.923725 0.221775 0.070706 0.825149 0.32088 0.722947 0.844538 0.499311 0.702948 0.116064 0.523559 0.402286 0.096443 0.296976 0.763948 0.598894 0.861777 0.672578 0.723498 0.603725 0.176623 0.227378 0.676918 0.508451 0.687149 0.032751 0.302006 0.492742 0.209099 0.733639 0.150749 0.18175 0.004749 0.616366 0.518188 0.605839 0.138659 0.129517 0.480976 0.099772 0.028996 0.735969 0.675953 0.920093 0.674698 0.546574 0.405147 0.956078 0.61677 0.513457 0.061499 0.908643 0.387897 0.687511 0.226665 0.569918 0.92948 0.039887 0.354946 0.376818 0.610569 0.853141 0.664741 0.783846 0.282538 0.720501 0.136502 0.206233 0.706133 0.393012 0.599118 0.026839 0.631333 0.034273 0.546871 0.311624 0.703009 0.315017 0.971375 0.626373 0.297055 0.156916 0.99362 0.86205 0.06118 0.582049 0.725238 0.539324 0.734401 0.223581 0.572069 0.656983 0.166572 0.362985 0.990545 0.428637 0.050835 0.231656 0.465564 0.723522 0.195256 0.285079 0.843954 0.78016 0.091612 0.823329 0.925292 0.679874 0.817594 0.604148 0.73551 0.024226 0.196098 0.632415 0.542637 0.135184 0.578035 0.205248 0.150136 0.829815 0.098836 0.144875 0.777701 0.727141 0.552849 0.246618 0.741829 0.201547 0.255669 0.640644 0.016547 0.060512 0.377958 0.741865 0.550207 0.7982 0.727087 0.994892 0.381907 0.777137 0.641801 0.682087 0.531322 0.949576 0.633659 0.89238 0.745904 0.450763 0.014998 0.502024 0.063956 0.944257 0.744433 0.344472 0.05771 0.871113 0.309023 0.869516 0.744707 0.126457 0.903449 0.166105 0.781074 0.514386 0.354767 0.169238 0.757772 0.40364 0.390626 0.185721 0.0972 0.930597 0.623127 0.540249 0.214788 0.668753 0.591421 0.575917 0.514987 0.634435 0.656307 0.515638 0.399837 0.613098 0.599382 0.881386 0.721117 0.075878 0.14383 0.134347 0.813966 0.195019 0.163716 0.993816 0.808259 0.610488 0.511888 0.562302 0.996143 0.052492 0.054802 0.297029 0.756099 0.275575 0.287907 0.634647 0.81762 0.713435 0.972634 0.191153 0.448889 0.816286 0.95315 0.520213 0.919436 0.112147 0.013337 0.031029 0.113138 0.53996 0.625218 -775468736
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedOffsetForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
