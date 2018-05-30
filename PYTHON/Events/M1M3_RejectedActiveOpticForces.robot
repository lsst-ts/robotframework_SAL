*** Settings ***
Documentation    M1M3_RejectedActiveOpticForces sender/logger tests.
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
${component}    RejectedActiveOpticForces
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp ZForces Fz Mx My priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 28.4804 0.421964978828 0.342398041773 0.573455029968 0.656816706732 0.0899285879683 0.305864180143 0.522014030169 0.832042892368 0.779033891787 0.120255876462 0.837437156643 0.44656612281 0.216867838967 0.279712801616 0.798360146416 0.339956154459 0.724357802109 0.118493925121 0.28527050919 0.101572721563 0.918181145715 0.184542566829 0.241198712124 0.117771176395 0.332400908766 0.972954245891 0.0767328170005 0.118417160562 0.951329248157 0.0109552387337 0.440811823831 0.131320768509 0.165622429377 0.335734436625 0.809101444126 0.0742170313881 0.237208368886 0.956612624429 0.579576722724 0.704176002987 0.798136723939 0.437081364449 0.114398528072 0.659637398003 0.776277010735 0.0687305714918 0.21382394199 0.445701344638 0.484531275664 0.965843737829 0.180011900308 0.174658008651 0.672154757394 0.324727658502 0.467221468286 0.729281966701 0.381120739031 0.838337950353 0.0983619634317 0.600922998826 0.613688315933 0.818463482489 0.871511511128 0.891410280638 0.564034180638 0.981771465693 0.91909211141 0.0180790582077 0.576504245238 0.497950767959 0.856249683186 0.100755100202 0.0518496516147 0.911331241276 0.836676630618 0.337225933067 0.256399088105 0.810774717348 0.0250679789571 0.683121928967 0.210318985861 0.0893410930612 0.582510962269 0.94119612503 0.863313667456 0.303187050936 0.863328453071 0.393803118897 0.787946324463 0.113803702421 0.226920145459 0.667257493947 0.0377787373346 0.218459207756 0.0664761679717 0.381373577187 0.67301679409 0.541667003496 0.601593897103 0.561731374454 0.563902083199 0.448120651579 0.875948718026 0.569311516629 0.800091537505 0.0802228513652 0.138357586818 0.411613941206 0.260236730969 0.407680451597 0.416811061075 0.44735596018 0.836695277095 0.830943921336 0.20482081 0.865854779742 0.855294398507 0.683748934327 0.729082461719 0.397968587514 0.131211220784 0.461199077828 0.160905459476 0.884436363312 0.267069521348 0.368092916754 0.486053068887 0.874214737632 0.024276303101 0.860966901075 0.823876895011 0.905901905673 0.54322383742 0.0226619643263 0.510437486327 0.921688836224 0.454377307697 0.408211654318 0.218503542406 0.349903505164 0.675430544686 0.437415450082 0.359403504945 0.818848642276 0.167188281931 0.498917116632 0.917275140738 0.0506617040073 0.19213252375 0.666468043831 0.693569717979 0.220163776124 0.186747505254 0.425562534068 0.75422723434 0.712628060568 0.980273508141 0.0596638576648 0.0351356428535 -1138866245
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
*** Settings ***
Documentation    M1M3_RejectedActiveOpticForces communications tests.
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
${component}    RejectedActiveOpticForces
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp ZForces Fz Mx My priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 82.1258 0.016335 0.442297 0.067507 0.20709 0.758677 0.178667 0.980881 0.698796 0.955297 0.124598 0.791944 0.704388 0.286382 0.068232 0.841244 0.181062 0.019398 0.752851 0.82737 0.960505 0.555704 0.498228 0.03172 0.61927 0.758007 0.115929 0.727658 0.189446 0.091312 0.446375 0.992733 0.475644 0.287903 0.847966 0.136273 0.368933 0.646916 0.352268 0.738089 0.087167 0.229854 0.129462 0.812647 0.972279 0.80704 0.787396 0.894662 0.430418 0.44716 0.204383 0.296474 0.611756 0.076531 0.247622 0.467975 0.171076 0.337169 0.538878 0.172885 0.23984 0.89041 0.198166 0.505216 0.077931 0.884656 0.87318 0.188767 0.767628 0.167888 0.279057 0.056169 0.365573 0.889412 0.107605 0.924484 0.882384 0.541671 0.874469 0.207568 0.261008 0.800636 0.418133 0.414028 0.666459 0.495778 0.364958 0.937703 0.42158 0.210917 0.636444 0.698787 0.142878 0.401425 0.307537 0.702533 0.357752 0.584842 0.153653 0.982944 0.367225 0.978546 0.616992 0.957928 0.648119 0.25817 0.017272 0.340891 0.970636 0.704675 0.703125 0.68776 0.261977 0.150179 0.059434 0.778833 0.998415 0.724009 0.173475 0.888071 0.402926 0.363548 0.690023 0.024728 0.774812 0.649623 0.721748 0.072401 0.256487 0.0829 0.417129 0.694955 0.690719 0.414157 0.550828 0.173496 0.102264 0.348165 0.542595 0.919346 0.765896 0.759422 0.627541 0.616521 0.315065 0.220983 0.041195 0.976783 0.101561 0.524682 0.264199 0.015553 0.030152 0.835342 0.840071 0.653407 0.069069 0.963385 0.012653 0.167874 -354851979
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
