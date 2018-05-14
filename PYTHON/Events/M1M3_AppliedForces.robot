*** Settings ***
Documentation    M1M3_AppliedForces sender/logger tests.
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
${component}    AppliedForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 46.295 0.975558826939 0.938097138368 0.786906539924 0.634065270352 0.0852632029335 0.0751188568417 0.105256243249 0.930847457855 0.173146315095 0.559242050294 0.341456413089 0.589431446394 0.822913841948 0.282238044983 0.636472741037 0.0775892194587 0.0215648344361 0.925692854794 0.62266760131 0.995769391842 0.490244705434 0.441502850097 0.463994777441 0.202776009346 0.177449146565 0.832196487189 0.359131871373 0.169294649099 0.479016249318 0.637562542462 0.11456478247 0.120469775385 0.959912476722 0.606851171815 0.370405823561 0.768051305646 0.0366452533686 0.680098227396 0.814231306302 0.745114580396 0.5921486691 0.665381585507 0.263468479358 0.173807341584 0.516481897992 0.233969317197 0.778523270811 0.459292421133 0.65644420533 0.107219358167 0.675330291037 0.294304049734 0.346074801385 0.332641106897 0.156297535959 0.56991403548 0.0489037227954 0.166376215919 0.283602415356 0.18046341783 0.0502608102681 0.911555798936 0.920871312089 0.784985557659 0.990556528533 0.36035859184 0.199717925436 0.715545441195 0.623080501586 0.355042096894 0.295371824755 0.48636503969 0.676958874593 0.572063585508 0.921564035307 0.156875338807 0.918194777065 0.418365384147 0.539239104893 0.502843086681 0.748421623622 0.24844148471 0.410515911872 0.859867821078 0.740212135149 0.666688415179 0.876087767427 0.75293166623 0.613906677237 0.504397383842 0.685320218581 0.472571531106 0.00346255115314 0.63793259136 0.461970336852 0.933860773016 0.763435529616 0.568707737721 0.354497399045 0.840156898814 0.981618922058 0.0456185210926 0.874166406771 0.902560043199 0.218047122894 0.866701756501 0.608045682173 0.470706018723 0.000261282595014 0.831686829282 0.431470568177 0.48627090364 0.522842645801 0.900623259107 0.411949030269 0.81111467076 0.682805118451 0.227623301063 0.345350173683 0.17068761227 0.511384561719 0.503341171309 0.086382253545 0.0891173661882 0.845084232511 0.36487130907 0.537277261218 0.770805187997 0.358671252218 0.308320273882 0.0530838395456 0.936851200267 0.640830806665 0.328630548848 0.3173201804 0.987423897647 0.739018288642 0.203719269748 0.148852808777 0.63455481229 0.736617253898 0.542217711747 0.758181508308 0.290138792795 0.175263991227 0.177444221512 0.239895435946 0.318196801303 0.478039701659 0.267151064177 0.976256206736 0.751403796992 0.151998091944 0.283311208916 0.622695550931 0.634082772138 0.185661317171 0.706172572814 0.399427217743 0.408284642934 0.382603808866 0.540310556803 0.316145777047 0.656897804687 0.269895859535 0.516956564266 0.242484889204 0.656840137229 0.0496768560787 0.77227196969 0.97722310326 0.899049919733 0.416446479909 0.271257350136 0.0210424401773 0.662981200958 0.0720406171601 0.561017855206 0.846899922266 0.713923378543 0.748213346547 0.591669713284 0.311142891118 0.189242743627 0.542243609455 0.759264317246 0.774187485404 0.111904963562 0.819368485104 0.706171837667 0.831198260103 0.185110106921 0.813735353331 0.75620523617 0.549603978854 0.444703837091 0.922649999884 0.783070540716 0.993478885055 0.721257642096 0.436160741892 0.798146527973 0.323448578092 0.393047479135 0.276000721219 0.860930838432 0.989291665609 0.292801886774 0.853912898824 0.890462745738 0.886078980654 0.570176968205 0.241410423064 0.399712770581 0.302163627396 0.969692861851 0.438816758357 0.945396185714 0.84999760716 0.481824805403 0.641457056611 0.916854339703 0.187202263879 0.614729110658 0.354590391006 0.344758497271 0.687329573049 0.505109696741 0.658341388355 0.478254921854 0.77821640755 0.298563703164 0.250896483677 0.668644068556 0.39505169278 0.368466838323 0.500865860356 0.518989034339 0.148401003508 0.515771005007 0.620302891814 0.488348299949 0.6502774108 0.987029858151 0.659328951527 0.667343714032 0.162852305164 0.795045202711 0.941907537375 0.179834839634 0.36284214098 0.811324320919 0.610771363993 0.12977920795 0.899426216348 0.642891731329 0.902205385938 0.385869750516 0.326856524265 0.363491791533 0.177933878896 0.460917839301 0.488423474719 0.979541968142 0.936236691765 0.688015672749 0.549408323373 0.428798239401 0.337648373653 0.824069308694 0.37676022682 0.47723636829 0.467340002006 0.740581887914 0.927418691271 -1395648156
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
