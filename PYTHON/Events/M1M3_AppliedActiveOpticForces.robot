*** Settings ***
Documentation    M1M3_AppliedActiveOpticForces sender/logger tests.
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
${component}    AppliedActiveOpticForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 85.5168 0.0990086067389 0.588519616573 0.977772414324 0.500807254144 0.107696120821 0.257853503219 0.917298375807 0.15821167635 0.594619584182 0.783195394945 0.665019645012 0.635466357441 0.0160586070256 0.354537906715 0.952203703861 0.0808097031846 0.616018215963 0.134010868073 0.693565537553 0.407235602961 0.419034069866 0.307424437843 0.92499867177 0.261129469994 0.91026323382 0.0549158164489 0.0346065618246 0.847027620622 0.545010354335 0.731562260112 0.865710992904 0.23606723268 0.317213383467 0.463233050694 0.354977935885 0.11197340871 0.960120939886 0.652644920976 0.264832812878 0.235256659179 0.597924266831 0.896508688426 0.301303225703 0.356151734889 0.774717770411 0.524777789329 0.391160314949 0.976417765767 0.981172032414 0.586042299763 0.22121926337 0.730648776732 0.275101068856 0.239047024896 0.275328385078 0.610860785659 0.20811216765 0.519389376747 0.118427606708 0.729083656967 0.121787795617 0.469330456285 0.582947036317 0.177835668682 0.981527893008 0.758711535916 0.0158365987175 0.415245945057 0.58648503258 0.141827282125 0.663963256861 0.0300617865404 0.425595555795 0.563125584775 0.35509733002 0.126607506177 0.677697497368 0.701342507517 0.554549785033 0.235710111648 0.0328451717599 0.893751462676 0.244476331655 0.806194378069 0.488994279287 0.231020180406 0.196348045528 0.785723650966 0.358485822482 0.0564836844827 0.538544479203 0.107935402562 0.090487295571 0.208135534125 0.342358819892 0.860986901726 0.554978323275 0.596785154694 0.763639394282 0.902170608686 0.391324099042 0.566981325098 0.94705595434 0.441380592049 0.568074367004 0.941340022402 0.643403507178 0.312566536822 0.350365983708 0.953524531936 0.550760346824 0.212114786957 0.723075750775 0.950319270316 0.340553175693 0.0580050029557 0.435962780565 0.878524291098 0.0128705300919 0.598449563578 0.80937935266 0.0672139738639 0.0574756822772 0.712235927732 0.698975182039 0.983431465784 0.421039283516 0.572518669763 0.440882392327 0.302322003479 0.679529249028 0.648542696501 0.972835627756 0.732292609713 0.334127241364 0.844164198276 0.911467722851 0.180111952035 0.130291105696 0.252284866023 0.271068086944 0.228689910436 0.266366321018 0.822200138035 0.8247546018 0.832890906641 0.204508022523 0.772269114759 0.0485614503738 0.904307708095 0.926914615311 0.309569866937 0.580886274978 0.0380522576064 0.65080224372 0.399843810119 0.350714687277 0.891371825132 0.214606849124 1605900979
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
*** Settings ***
Documentation    M1M3_AppliedActiveOpticForces communications tests.
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
${component}    AppliedActiveOpticForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 11.8092 0.562093 0.152866 0.762228 0.471838 0.95822 0.408136 0.414742 0.500123 0.868753 0.965373 0.757725 0.089454 0.371076 0.598256 0.283951 0.473936 0.604874 0.319075 0.399154 0.176303 0.883958 0.257598 0.367749 0.743629 0.404075 0.141262 0.547443 0.512966 0.284495 0.679019 0.110509 0.99074 0.086146 0.72219 0.416988 0.979964 0.736049 0.359867 0.000166 0.092712 0.645357 0.00362 0.943361 0.357727 0.162689 0.660453 0.393147 0.647316 0.35549 0.985735 0.657679 0.212373 0.425565 0.896581 0.672074 0.824655 0.847329 0.869508 0.649346 0.640956 0.200178 0.150505 0.723349 0.049942 0.361865 0.377027 0.065887 0.465335 0.701797 0.445885 0.36969 0.324708 0.727823 0.249139 0.601634 0.22605 0.921851 0.468083 0.009949 0.106952 0.65453 0.368273 0.885416 0.808968 0.703073 0.862893 0.015013 0.291575 0.980942 0.702824 0.903792 0.588643 0.380772 0.162343 0.521771 0.582161 0.7442 0.9415 0.001336 0.45596 0.962185 0.662284 0.893497 0.132201 0.624281 0.78772 0.875333 0.5187 0.563396 0.038631 0.526473 0.058708 0.192804 0.18867 0.903663 0.664457 0.757183 0.957686 0.657764 0.712722 0.618003 0.741389 0.984225 0.26183 0.468855 0.157189 0.715443 0.347274 0.409492 0.603127 0.109596 0.141736 0.711646 0.726281 0.800427 0.072258 0.754576 0.648203 0.232446 0.127234 0.915121 0.658562 0.909203 0.683786 0.517783 0.027801 0.169605 0.045745 0.785013 0.542817 0.786364 0.813409 0.615236 0.677729 0.386485 0.393944 0.449745 0.038269 0.835968 1386491609
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
