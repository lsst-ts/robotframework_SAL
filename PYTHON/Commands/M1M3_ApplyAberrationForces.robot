*** Settings ***
Documentation    M1M3_ApplyAberrationForces communications tests.
Force Tags    python    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    ApplyAberrationForces
${timeout}    30s

*** Test Cases ***
Verify Component Commander and Controller
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_${component}.py

Start Commander - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments :

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 0.118327 0.0115 0.22377 0.871245 0.314818 0.430009 0.25079 0.87422 0.623814 0.480091 0.759295 0.524394 0.053289 0.099429 0.144419 0.972102 0.663644 0.02555 0.77246 0.472818 0.326151 0.067076 0.105349 0.967618 0.024904 0.765681 0.554188 0.368847 0.178754 0.151596 0.487801 0.146017 0.788758 0.697936 0.983456 0.885573 0.889305 0.484756 0.086221 0.183859 0.99284 0.323017 0.431699 0.579404 0.741646 0.309509 0.228382 0.413434 0.23401 0.025805 0.026294 0.907869 0.513582 0.040515 0.288015 0.107699 0.338891 0.012064 0.898485 0.986322 0.301949 0.017271 0.167311 0.274205 0.631009 0.132828 0.179687 0.265657 0.286984 0.650568 0.412899 0.169465 0.217635 0.226576 0.231557 0.389476 0.243201 0.471654 0.114129 0.146415 0.200187 0.825631 0.94976 0.704372 0.860216 0.173423 0.111353 0.530084 0.657426 0.506011 0.918226 0.900487 0.569243 0.442006 0.097426 0.148103 0.767504 0.729479 0.258131 0.152813 0.226109 0.105733 0.694456 0.48713 0.844468 0.705159 0.905448 0.659503 0.498383 0.444446 0.464611 0.245178 0.58916 0.790527 0.025735 0.757074 0.316418 0.926659 0.557852 0.096137 0.349785 0.590834 0.215212 0.456335 0.343785 0.742177 0.423011 0.685437 0.342223 0.532229 0.024925 0.130706 0.726305 0.578836 0.079683 0.427423 0.701043 0.077148 0.858109 0.555731 0.323688 0.226693 0.216414 0.309619 0.012535 0.995753 0.716717 0.69806 0.812192 0.490324 0.201767 0.854095 0.6635 0.658826 0.507237 0.215722
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Controller.
    ${input}=    Write    python ${subSystem}_Controller_${component}.py
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 0.118327 0.0115 0.22377 0.871245 0.314818 0.430009 0.25079 0.87422 0.623814 0.480091 0.759295 0.524394 0.053289 0.099429 0.144419 0.972102 0.663644 0.02555 0.77246 0.472818 0.326151 0.067076 0.105349 0.967618 0.024904 0.765681 0.554188 0.368847 0.178754 0.151596 0.487801 0.146017 0.788758 0.697936 0.983456 0.885573 0.889305 0.484756 0.086221 0.183859 0.99284 0.323017 0.431699 0.579404 0.741646 0.309509 0.228382 0.413434 0.23401 0.025805 0.026294 0.907869 0.513582 0.040515 0.288015 0.107699 0.338891 0.012064 0.898485 0.986322 0.301949 0.017271 0.167311 0.274205 0.631009 0.132828 0.179687 0.265657 0.286984 0.650568 0.412899 0.169465 0.217635 0.226576 0.231557 0.389476 0.243201 0.471654 0.114129 0.146415 0.200187 0.825631 0.94976 0.704372 0.860216 0.173423 0.111353 0.530084 0.657426 0.506011 0.918226 0.900487 0.569243 0.442006 0.097426 0.148103 0.767504 0.729479 0.258131 0.152813 0.226109 0.105733 0.694456 0.48713 0.844468 0.705159 0.905448 0.659503 0.498383 0.444446 0.464611 0.245178 0.58916 0.790527 0.025735 0.757074 0.316418 0.926659 0.557852 0.096137 0.349785 0.590834 0.215212 0.456335 0.343785 0.742177 0.423011 0.685437 0.342223 0.532229 0.024925 0.130706 0.726305 0.578836 0.079683 0.427423 0.701043 0.077148 0.858109 0.555731 0.323688 0.226693 0.216414 0.309619 0.012535 0.995753 0.716717 0.69806 0.812192 0.490324 0.201767 0.854095 0.6635 0.658826 0.507237 0.215722
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    ZForces : 0.118327    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    ZForces(156) = [0.118327, 0.0115, 0.22377, 0.871245, 0.314818, 0.430009, 0.25079, 0.87422, 0.623814, 0.480091, 0.759295, 0.524394, 0.053289, 0.099429, 0.144419, 0.972102, 0.663644, 0.02555, 0.77246, 0.472818, 0.326151, 0.067076, 0.105349, 0.967618, 0.024904, 0.765681, 0.554188, 0.368847, 0.178754, 0.151596, 0.487801, 0.146017, 0.788758, 0.697936, 0.983456, 0.885573, 0.889305, 0.484756, 0.086221, 0.183859, 0.99284, 0.323017, 0.431699, 0.579404, 0.741646, 0.309509, 0.228382, 0.413434, 0.23401, 0.025805, 0.026294, 0.907869, 0.513582, 0.040515, 0.288015, 0.107699, 0.338891, 0.012064, 0.898485, 0.986322, 0.301949, 0.017271, 0.167311, 0.274205, 0.631009, 0.132828, 0.179687, 0.265657, 0.286984, 0.650568, 0.412899, 0.169465, 0.217635, 0.226576, 0.231557, 0.389476, 0.243201, 0.471654, 0.114129, 0.146415, 0.200187, 0.825631, 0.94976, 0.704372, 0.860216, 0.173423, 0.111353, 0.530084, 0.657426, 0.506011, 0.918226, 0.900487, 0.569243, 0.442006, 0.097426, 0.148103, 0.767504, 0.729479, 0.258131, 0.152813, 0.226109, 0.105733, 0.694456, 0.48713, 0.844468, 0.705159, 0.905448, 0.659503, 0.498383, 0.444446, 0.464611, 0.245178, 0.58916, 0.790527, 0.025735, 0.757074, 0.316418, 0.926659, 0.557852, 0.096137, 0.349785, 0.590834, 0.215212, 0.456335, 0.343785, 0.742177, 0.423011, 0.685437, 0.342223, 0.532229, 0.024925, 0.130706, 0.726305, 0.578836, 0.079683, 0.427423, 0.701043, 0.077148, 0.858109, 0.555731, 0.323688, 0.226693, 0.216414, 0.309619, 0.012535, 0.995753, 0.716717, 0.69806, 0.812192, 0.490324, 0.201767, 0.854095, 0.6635, 0.658826, 0.507237, 0.215722]    1
    Should Contain X Times    ${output}    === [ackCommand_ApplyAberrationForces] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
