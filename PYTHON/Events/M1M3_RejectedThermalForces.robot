*** Settings ***
Documentation    M1M3_RejectedThermalForces sender/logger tests.
Force Tags    python    Checking if skipped: m1m3
TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedThermalForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 90.4934 0.702751329804 0.572911826356 0.554876627865 0.778270830269 0.125827754666 0.0440523923888 0.314969072894 0.744210612183 0.854621250551 0.173296704997 0.825697270123 0.162634677055 0.906483863039 0.197698469214 0.533454577374 0.674174681176 0.321240140613 0.917687684901 0.406369771996 0.366382082779 0.984721651418 0.554871975377 0.595096392118 0.27184933085 0.100810967758 0.99178513757 0.943598389582 0.891503083217 0.471033348018 0.746705790343 0.693996549404 0.387032831137 0.618939741829 0.616335236425 0.584508844415 0.337800091728 0.553025130761 0.836234683701 0.522530419754 0.839255327546 0.77850711891 0.460217758105 0.46776062463 0.63288243026 0.115963540925 0.787800010566 0.69854633131 0.480345900981 0.767290771993 0.499484402647 0.799386323769 0.0127260550529 0.445820187455 0.167142456822 0.73594056551 0.985597211348 0.378839921878 0.893880576259 0.0185487383572 0.537842227389 0.102014987858 0.628260257129 0.783480880322 0.0142668005105 0.286500855038 0.654423596605 0.113237062065 0.177579565003 0.832839212018 0.936605957245 0.586986973471 0.498315354572 0.926686356164 0.806667455444 0.642862776977 0.850499524128 0.227427492322 0.22465755015 0.511584259829 0.798099703646 0.113425739161 0.492348807052 0.869926859692 0.144562796056 0.331547852907 0.0948895981514 0.0125366494783 0.0891079298081 0.472292978128 0.111107273583 0.806124233826 0.593310723983 0.652286070884 0.22252457585 0.669288083914 0.787113904318 0.541152489558 0.122423590212 0.791984275817 0.615661256701 0.410047060241 0.701606460226 0.545763035046 0.578881343954 0.184494879188 0.0353730495787 0.306051509944 0.485353597811 0.519564791514 0.897286662621 0.627457767438 0.406734646258 0.836000754485 0.262163133991 0.218703789858 0.849488030999 0.80487612253 0.456191107583 0.011039108927 0.520071526238 0.677165750675 0.901798421703 0.75938037573 0.51386745206 0.346976645718 0.882655872752 0.282688401619 0.00109683652688 0.0733863310449 0.819838397573 0.735298472266 0.85694499394 0.976902144678 0.336778968843 0.845100276099 0.26492628148 0.380068450623 0.603360562543 0.0680721692521 0.123811880391 0.0459872354073 0.606012470433 0.560511308565 0.242654099787 0.701035019024 0.0133946893235 0.725953286081 0.0806270306956 0.563760738689 0.782818686629 0.00767171290132 0.914599890435 0.500291019721 0.695335948085 0.116121402627 0.143111331394 0.340153674751 0.543434947833 0.498546442408 0.795143908933 0.355473235332 0.138964871916 0.370364732965 0.2970202934 0.697706787623 0.309333526295 0.948636287457 0.872526645729 0.789162274737 0.847059876656 0.772716188805 0.137937206344 0.0961482431716 0.679312904404 0.24135597313 0.680716931128 0.443701092363 0.213287540697 0.618813490309 0.731243387695 0.908504135482 0.495082699866 0.827719247272 0.400496473717 0.783992516426 0.570003937494 0.132065729202 0.143569518589 0.946203664416 0.296876694595 0.940664617602 0.927654905051 0.340451594547 0.283220956627 0.35081626674 0.807446902156 0.790544918809 0.726227834196 0.971108076281 0.192864909707 0.682635493546 0.211040003483 0.555581328077 0.56336121943 0.423830173024 0.400889206636 0.662911624548 0.929272614524 0.620779294355 0.00698075879892 0.284957339907 0.830020565246 0.0461190847891 0.170909172969 0.915336764619 0.560398818792 0.950331469648 0.472646294949 0.439565338124 0.324192419778 0.695267739528 0.272807024313 0.499279083196 0.796538693544 0.744234293844 0.141417336121 0.560021632478 0.446435502429 0.147095100951 0.576305880602 0.17040566259 0.868229455609 0.129090826223 0.329596674878 0.283615216548 0.408845873732 0.193168714549 0.975103643585 0.362650782097 0.258126268913 0.890542400952 0.222934738668 0.779026281542 0.425155722116 0.0987703591118 0.757949645725 0.658151422973 0.798972203177 0.838277187712 0.803737672697 0.744164506544 0.513763111828 0.305504904617 0.865134832995 0.220984998737 0.411893592387 0.392622791307 0.779793194946 0.0318519216962 0.592179594326 0.342320588794 0.188807661674 0.650352425353 0.24037622216 0.016392256607 0.580661417405 0.586576669671 0.709631784486 0.289800170407 0.093546830153 0.0459086911638 0.079927847853 0.925355818946 0.939899814562 0.635402735614 -1605591424
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedThermalForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
