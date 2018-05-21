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
