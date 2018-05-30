*** Settings ***
Documentation    M1M3_AppliedAberrationForces sender/logger tests.
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
${component}    AppliedAberrationForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 67.8048 0.995533306732 0.210029654392 0.462221703771 0.221599216537 0.986060243444 0.59323668603 0.766578564885 0.940985938135 0.538359447127 0.884104786965 0.245766371724 0.969201613693 0.20476384072 0.340597374955 0.108719797537 0.87168094585 0.117970518793 0.956311460077 0.587551981181 0.647899558909 0.347514914286 0.0944806529285 0.0530725531665 0.446884333281 0.0755086961821 0.329986063468 0.299119391336 0.853780497268 0.879609857932 0.497577936492 0.115610802071 0.446371640947 0.684673016811 0.540397641629 0.174569492395 0.910712659472 0.480147722753 0.986544933475 0.494697485986 0.0086714580448 0.0168400661314 0.386041630149 0.12047181276 0.111143727795 0.508830015959 0.931548043644 0.224624673315 0.758154145906 0.747268532252 0.222764836542 0.376887853725 0.441458073008 0.977751017655 0.822788834882 0.351987515716 0.944631145286 0.541632101087 0.276666355137 0.78143189852 0.185572879652 0.991890716723 0.883148045832 0.354393871281 0.210949602082 0.64656687447 0.68853928515 0.487412998314 0.770572923342 0.209646523023 0.0772972077667 0.945633772109 0.345631110884 0.04044827297 0.971038555714 0.490726322288 0.915908917621 0.326399123123 0.910417807694 0.560364785226 0.795503344811 0.304381385715 0.157633157639 0.230285685515 0.461852400902 0.71917652979 0.238406151929 0.538176635656 0.810863251928 0.891385473177 0.539553209632 0.85050846773 0.550105908793 0.478725707026 0.109251942189 0.357814706182 0.96409491374 0.128794265702 0.304029971354 0.887444836913 0.389484382572 0.810024207862 0.563183446425 0.262544866144 0.956345838366 0.0201478914099 0.585857478512 0.811539363987 0.69729399072 0.401565627442 0.307731071787 0.540498504618 0.0322186264403 0.157341798348 0.846369062109 0.0988241512797 0.882067183459 0.118094875209 0.798210269196 0.478697619315 0.884102358634 0.0873376740492 0.531255813352 0.150325537824 0.272841932076 0.435360556962 0.283579645863 0.989430688992 0.546095509614 0.385894402528 0.194534509852 0.0261764684496 0.581722662071 0.284869477439 0.142093308863 0.466635260909 0.886819420683 0.989354150685 0.341507040458 0.241037465375 0.698618632595 0.519842903684 0.824838187559 0.903237248074 0.442931014674 0.844323543147 0.818194286374 0.306476886749 0.518696048832 0.42634113023 0.369799389305 0.239158049549 0.446412907626 0.265144275246 0.204064608963 0.631502093456 0.505336514572 0.399138613981 0.23934647711 0.42195197173 -639992821
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
*** Settings ***
Documentation    M1M3_AppliedAberrationForces communications tests.
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
${component}    AppliedAberrationForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 81.1332 0.958933 0.613671 0.176557 0.751666 0.879376 0.016238 0.514667 0.439392 0.431126 0.564347 0.340453 0.535184 0.958481 0.698981 0.945159 0.759003 0.904707 0.059941 0.930724 0.426371 0.674491 0.021567 0.654397 0.984267 0.650389 0.502792 0.708327 0.015749 0.146029 0.646192 0.71043 0.786694 0.768399 0.140608 0.711006 0.724862 0.910198 0.691638 0.933726 0.504017 0.604534 0.15095 0.253984 0.524182 0.62699 0.788198 0.134202 0.592281 0.229563 0.493739 0.258847 0.564044 0.063942 0.990816 0.655369 0.006173 0.486859 0.456095 0.448446 0.853813 0.069815 0.329511 0.941425 0.218427 0.801792 0.926007 0.185176 0.874438 0.015423 0.298491 0.709189 0.023753 0.517268 0.355662 0.236888 0.257464 0.54687 0.604793 0.515361 0.574703 0.19856 0.30163 0.682493 0.324495 0.310774 0.144123 0.583624 0.248801 0.790519 0.411374 0.492718 0.496727 0.988554 0.557828 0.343134 0.29778 0.488836 0.57342 0.516058 0.595808 0.685718 0.548926 0.129823 0.858717 0.88873 0.668505 0.200896 0.51091 0.297882 0.955583 0.482092 0.853686 0.420925 0.066093 0.658655 0.454875 0.063144 0.243519 0.320773 0.355167 0.003722 0.971642 0.466929 0.413847 0.257947 0.986836 0.969368 0.879126 0.268773 0.291075 0.864185 0.843965 0.392752 0.070283 0.44308 0.493814 0.092646 0.841173 0.373202 0.439659 0.853226 0.114391 0.298906 0.374807 0.420308 0.490075 0.709139 0.903927 0.176569 0.0151 0.402747 0.501574 0.033791 0.276858 0.827875 0.333682 0.533565 0.746212 0.939444 -753119515
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
