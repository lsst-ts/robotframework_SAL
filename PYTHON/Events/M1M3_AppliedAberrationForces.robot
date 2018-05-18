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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 45.7279 0.729479079395 0.261653421251 0.413486422357 0.851561876267 0.747842688098 0.544416607184 0.476358388458 0.070677204435 0.225003660947 0.724572778923 0.914830132196 0.463138236666 0.0521619551094 0.00907922579058 0.880290574072 0.372929963913 0.687403467672 0.574014908592 0.87587904739 0.212201795457 0.766379023759 0.716416291924 0.37684362652 0.172120562058 0.180598229392 0.805980005427 0.718433915319 0.500935036104 0.978316287792 0.357108934544 0.947194038036 0.56329521207 0.774831189322 0.906405646911 0.278943109313 0.162746337863 0.134295312084 0.894344573691 0.40434603813 0.367716066934 0.200240915008 0.365651168775 0.726983318889 0.404673524488 0.405364638038 0.994942743378 0.397481615191 0.0024479302156 0.515103048565 0.891764432844 0.953293534848 0.899955801164 0.835248466515 0.648114201224 0.933914719245 0.410613177972 0.469082738591 0.515892401469 0.857424721195 0.631548062984 0.012490580946 0.876180497358 0.019320911346 0.915972515391 0.299569159542 0.395788983173 0.323467818216 0.590983804455 0.0266853862361 0.995530674287 0.737025672888 0.00863041715229 0.185550805219 0.661030051108 0.168173236625 0.257589581297 0.689871949811 0.876875038202 0.429423096654 0.957898840575 0.669371696386 0.224327353006 0.684844649434 0.173894643789 0.528404408319 0.244385958895 0.422843709469 0.506450227827 0.424338377656 0.72761192832 0.367638705393 0.640313729361 0.529820442474 0.773628169554 0.457434563957 0.0601240232381 0.859623523858 0.301064798064 0.839022214818 0.0269152085291 0.819726189855 0.572357990881 0.166487810734 0.383001496634 0.747835205387 0.0402434590969 0.963332707373 0.1079544227 0.998392168609 0.913316207943 0.368404525998 0.553544511258 0.867314422139 0.377253500321 0.393632467471 0.729335116927 0.686206234557 0.912216433022 0.616040818529 0.952143687665 0.75198651672 0.44663739138 0.167263450045 0.369794024549 0.24474802994 0.810934823894 0.655170612993 0.596039186722 0.893781412226 0.208760311699 0.771238683495 0.150282534141 0.558459519211 0.723441257727 0.632759516763 0.337905336215 0.563797331355 0.0908195082521 0.731359051851 0.336300941757 0.595633806305 0.19635412751 0.610781483325 0.523290843516 0.685369198925 0.168632101585 0.709951787684 0.321834220921 0.128631286514 0.971338016966 0.302298021801 0.388459209744 0.47244091226 0.751192172376 0.37097540948 0.0476128661215 0.647855677237 0.927852920995 0.0119763778141 589250748
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
