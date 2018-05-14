*** Settings ***
Documentation    Hexapod_configureAzimuthRawLUT commander/controller tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    hexapod
${component}    configureAzimuthRawLUT
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -17780 -26806 8447 3737 1923 -19294 24158 22135 -19149 29928 -8229 4796 17096 -18807 -2064 -32174 -27336 -29242 -18666 20579 -22977 30748 -22247 -11603 23665 22549 -24476 7461 -20124 -22463 19888 10856 17097 19179 -24829 21912 25051 0.327870209778 0.030639608039 0.383962776524 0.286668152318 0.186511096059 0.515814520259 0.901727500532 0.213418367605 0.974274847421 0.0402360381702 0.79777988025 0.789730061336 0.812934960932 0.364808924254 0.767182409343 0.65437438887 0.93046463639 0.73050359999 0.86477765062 0.814428609064 0.0459448300359 0.116381266684 0.928810736439 0.794404447351 0.743730963142 0.748629370531 0.327586848664 0.0490833929755 0.713035945626 0.364976031395 0.534226108586 0.552714765786 0.694614753074 0.20569990528 0.640827275466 0.992288498955 0.786642801085 0.0706751239829 0.151437202816 0.594972858706 0.651679606902 0.0235972440862 0.796736983829 0.361702006647 0.206448782088 0.428581590427 0.502129075623 0.620013474299 0.0518576484639 0.267643569611 0.868746143795 0.149109105708 0.293698088631 0.59441769714 0.372365568844 0.0203372678196 0.310133842526 0.00904761402362 0.391624589859 0.773408966579 0.0285276347492 0.963594593801 0.105053760373 0.227251908332 0.212878426808 0.613738476502 0.30605147435 0.0880328989112 0.0464971473979 0.0817636572755 0.772707839075 0.24153468789 0.536545468933 0.450449125165 0.897076642045 0.561669078088 0.0203880738312 0.535635193672 0.390241733509 0.247878673275 0.272043214167 0.867328451118 0.854290652067 0.0749718092562 0.318210925179 0.215966037608 0.907298998185 0.661252814846 0.575145866944 0.259935935878 0.523305547767 0.781479694231 0.918268491068 0.620426197258 0.981803418475 0.775630994455 0.995618791457 0.626402285753 0.342221327423 0.0301655681112 0.880503095019 0.279643346014 0.589834754978 0.170840341237 0.502542116098 0.662570027092 0.778726600608 0.0219828928469 0.761137957024 0.336320271559 0.945253232075 0.524846105641 0.708872944411 0.781756852249 0.344275438691 0.928602260586 0.0270651820685 0.486846711443 0.0692416754943 0.893507563658 0.961007557682 0.585788120452 0.862687046439 0.279722616006 0.101142195462 0.0497197304544 0.0865083066054 0.98508961079 0.207189414464 0.998730194641 0.979363928922 0.172404218962 0.324961937009 0.161418507114 0.673909726733 0.400807017346 0.91906754601 0.71574604662 0.344944361152 0.00268160654048 0.343645183237 0.884903182977 0.607478704811 0.144382353691 0.74581872464 0.710346211002 0.0232106640588 0.491802655613 0.247384071181 0.151618991682 0.718147204017 0.470324590203 0.863474548447 0.882510741714 0.530632413175 0.374875819323 0.889793125226 0.906736898155 0.548856207078 0.870608368752 0.922188201143 0.783188829923 0.723918677512 0.774389976299 0.180023839654 0.874726057413 0.32728956645 0.198698259035 0.418967162526 0.376868122087 0.18358243839 0.0101760267552 0.508335890696 0.77963970906 0.416544769312 0.72825639805 0.29090730688 0.130766333905 0.864162768479 0.730461746178 0.542921732046 0.927019603061 0.482977121123 0.258660889469 0.601841385494 0.706676569454 0.534501591489 0.817205770138 0.875861351693 0.873919108657 0.635661628543 0.949992770259 0.595818840048 0.959330063636 0.141265444072 0.69853859456 0.729284729479 0.671931716958 0.46951009523 0.551571825137 0.852384126086 0.387795277116 0.833375473679 0.920082014471 0.354067477886 0.925376970769 0.144220507372 0.509746055356 0.602536720471 0.164660173482 0.385475043605 0.718918289678 0.113359896402 0.174020668652 0.760938975937 0.838210407886 0.729356304723 0.631123585341 0.726705496635 0.863106581222 0.295275562679 0.732219100362
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
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -17780 -26806 8447 3737 1923 -19294 24158 22135 -19149 29928 -8229 4796 17096 -18807 -2064 -32174 -27336 -29242 -18666 20579 -22977 30748 -22247 -11603 23665 22549 -24476 7461 -20124 -22463 19888 10856 17097 19179 -24829 21912 25051 0.327870209778 0.030639608039 0.383962776524 0.286668152318 0.186511096059 0.515814520259 0.901727500532 0.213418367605 0.974274847421 0.0402360381702 0.79777988025 0.789730061336 0.812934960932 0.364808924254 0.767182409343 0.65437438887 0.93046463639 0.73050359999 0.86477765062 0.814428609064 0.0459448300359 0.116381266684 0.928810736439 0.794404447351 0.743730963142 0.748629370531 0.327586848664 0.0490833929755 0.713035945626 0.364976031395 0.534226108586 0.552714765786 0.694614753074 0.20569990528 0.640827275466 0.992288498955 0.786642801085 0.0706751239829 0.151437202816 0.594972858706 0.651679606902 0.0235972440862 0.796736983829 0.361702006647 0.206448782088 0.428581590427 0.502129075623 0.620013474299 0.0518576484639 0.267643569611 0.868746143795 0.149109105708 0.293698088631 0.59441769714 0.372365568844 0.0203372678196 0.310133842526 0.00904761402362 0.391624589859 0.773408966579 0.0285276347492 0.963594593801 0.105053760373 0.227251908332 0.212878426808 0.613738476502 0.30605147435 0.0880328989112 0.0464971473979 0.0817636572755 0.772707839075 0.24153468789 0.536545468933 0.450449125165 0.897076642045 0.561669078088 0.0203880738312 0.535635193672 0.390241733509 0.247878673275 0.272043214167 0.867328451118 0.854290652067 0.0749718092562 0.318210925179 0.215966037608 0.907298998185 0.661252814846 0.575145866944 0.259935935878 0.523305547767 0.781479694231 0.918268491068 0.620426197258 0.981803418475 0.775630994455 0.995618791457 0.626402285753 0.342221327423 0.0301655681112 0.880503095019 0.279643346014 0.589834754978 0.170840341237 0.502542116098 0.662570027092 0.778726600608 0.0219828928469 0.761137957024 0.336320271559 0.945253232075 0.524846105641 0.708872944411 0.781756852249 0.344275438691 0.928602260586 0.0270651820685 0.486846711443 0.0692416754943 0.893507563658 0.961007557682 0.585788120452 0.862687046439 0.279722616006 0.101142195462 0.0497197304544 0.0865083066054 0.98508961079 0.207189414464 0.998730194641 0.979363928922 0.172404218962 0.324961937009 0.161418507114 0.673909726733 0.400807017346 0.91906754601 0.71574604662 0.344944361152 0.00268160654048 0.343645183237 0.884903182977 0.607478704811 0.144382353691 0.74581872464 0.710346211002 0.0232106640588 0.491802655613 0.247384071181 0.151618991682 0.718147204017 0.470324590203 0.863474548447 0.882510741714 0.530632413175 0.374875819323 0.889793125226 0.906736898155 0.548856207078 0.870608368752 0.922188201143 0.783188829923 0.723918677512 0.774389976299 0.180023839654 0.874726057413 0.32728956645 0.198698259035 0.418967162526 0.376868122087 0.18358243839 0.0101760267552 0.508335890696 0.77963970906 0.416544769312 0.72825639805 0.29090730688 0.130766333905 0.864162768479 0.730461746178 0.542921732046 0.927019603061 0.482977121123 0.258660889469 0.601841385494 0.706676569454 0.534501591489 0.817205770138 0.875861351693 0.873919108657 0.635661628543 0.949992770259 0.595818840048 0.959330063636 0.141265444072 0.69853859456 0.729284729479 0.671931716958 0.46951009523 0.551571825137 0.852384126086 0.387795277116 0.833375473679 0.920082014471 0.354067477886 0.925376970769 0.144220507372 0.509746055356 0.602536720471 0.164660173482 0.385475043605 0.718918289678 0.113359896402 0.174020668652 0.760938975937 0.838210407886 0.729356304723 0.631123585341 0.726705496635 0.863106581222 0.295275562679 0.732219100362
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    azIndex : -17780    1
    Should Contain X Times    ${output}    fz1 : 0.327870209778    1
    Should Contain X Times    ${output}    fz2 : 0.0706751239829    1
    Should Contain X Times    ${output}    fz3 : 0.897076642045    1
    Should Contain X Times    ${output}    fz4 : 0.524846105641    1
    Should Contain X Times    ${output}    fz5 : 0.247384071181    1
    Should Contain X Times    ${output}    fz6 : 0.706676569454    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    azIndex(37) = [-17780, -26806, 8447, 3737, 1923, -19294, 24158, 22135, -19149, 29928, -8229, 4796, 17096, -18807, -2064, -32174, -27336, -29242, -18666, 20579, -22977, 30748, -22247, -11603, 23665, 22549, -24476, 7461, -20124, -22463, 19888, 10856, 17097, 19179, -24829, 21912, 25051]    1
    Should Contain X Times    ${output}    fz1(37) = [0.327870209778, 0.030639608039, 0.383962776524, 0.286668152318, 0.186511096059, 0.515814520259, 0.901727500532, 0.213418367605, 0.974274847421, 0.0402360381702, 0.79777988025, 0.789730061336, 0.812934960932, 0.364808924254, 0.767182409343, 0.65437438887, 0.93046463639, 0.73050359999, 0.86477765062, 0.814428609064, 0.0459448300359, 0.116381266684, 0.928810736439, 0.794404447351, 0.743730963142, 0.748629370531, 0.327586848664, 0.0490833929755, 0.713035945626, 0.364976031395, 0.534226108586, 0.552714765786, 0.694614753074, 0.20569990528, 0.640827275466, 0.992288498955, 0.786642801085]    1
    Should Contain X Times    ${output}    fz2(37) = [0.0706751239829, 0.151437202816, 0.594972858706, 0.651679606902, 0.0235972440862, 0.796736983829, 0.361702006647, 0.206448782088, 0.428581590427, 0.502129075623, 0.620013474299, 0.0518576484639, 0.267643569611, 0.868746143795, 0.149109105708, 0.293698088631, 0.59441769714, 0.372365568844, 0.0203372678196, 0.310133842526, 0.00904761402362, 0.391624589859, 0.773408966579, 0.0285276347492, 0.963594593801, 0.105053760373, 0.227251908332, 0.212878426808, 0.613738476502, 0.30605147435, 0.0880328989112, 0.0464971473979, 0.0817636572755, 0.772707839075, 0.24153468789, 0.536545468933, 0.450449125165]    1
    Should Contain X Times    ${output}    fz3(37) = [0.897076642045, 0.561669078088, 0.0203880738312, 0.535635193672, 0.390241733509, 0.247878673275, 0.272043214167, 0.867328451118, 0.854290652067, 0.0749718092562, 0.318210925179, 0.215966037608, 0.907298998185, 0.661252814846, 0.575145866944, 0.259935935878, 0.523305547767, 0.781479694231, 0.918268491068, 0.620426197258, 0.981803418475, 0.775630994455, 0.995618791457, 0.626402285753, 0.342221327423, 0.0301655681112, 0.880503095019, 0.279643346014, 0.589834754978, 0.170840341237, 0.502542116098, 0.662570027092, 0.778726600608, 0.0219828928469, 0.761137957024, 0.336320271559, 0.945253232075]    1
    Should Contain X Times    ${output}    fz4(37) = [0.524846105641, 0.708872944411, 0.781756852249, 0.344275438691, 0.928602260586, 0.0270651820685, 0.486846711443, 0.0692416754943, 0.893507563658, 0.961007557682, 0.585788120452, 0.862687046439, 0.279722616006, 0.101142195462, 0.0497197304544, 0.0865083066054, 0.98508961079, 0.207189414464, 0.998730194641, 0.979363928922, 0.172404218962, 0.324961937009, 0.161418507114, 0.673909726733, 0.400807017346, 0.91906754601, 0.71574604662, 0.344944361152, 0.00268160654048, 0.343645183237, 0.884903182977, 0.607478704811, 0.144382353691, 0.74581872464, 0.710346211002, 0.0232106640588, 0.491802655613]    1
    Should Contain X Times    ${output}    fz5(37) = [0.247384071181, 0.151618991682, 0.718147204017, 0.470324590203, 0.863474548447, 0.882510741714, 0.530632413175, 0.374875819323, 0.889793125226, 0.906736898155, 0.548856207078, 0.870608368752, 0.922188201143, 0.783188829923, 0.723918677512, 0.774389976299, 0.180023839654, 0.874726057413, 0.32728956645, 0.198698259035, 0.418967162526, 0.376868122087, 0.18358243839, 0.0101760267552, 0.508335890696, 0.77963970906, 0.416544769312, 0.72825639805, 0.29090730688, 0.130766333905, 0.864162768479, 0.730461746178, 0.542921732046, 0.927019603061, 0.482977121123, 0.258660889469, 0.601841385494]    1
    Should Contain X Times    ${output}    fz6(37) = [0.706676569454, 0.534501591489, 0.817205770138, 0.875861351693, 0.873919108657, 0.635661628543, 0.949992770259, 0.595818840048, 0.959330063636, 0.141265444072, 0.69853859456, 0.729284729479, 0.671931716958, 0.46951009523, 0.551571825137, 0.852384126086, 0.387795277116, 0.833375473679, 0.920082014471, 0.354067477886, 0.925376970769, 0.144220507372, 0.509746055356, 0.602536720471, 0.164660173482, 0.385475043605, 0.718918289678, 0.113359896402, 0.174020668652, 0.760938975937, 0.838210407886, 0.729356304723, 0.631123585341, 0.726705496635, 0.863106581222, 0.295275562679, 0.732219100362]    1
    Should Contain X Times    ${output}    === [ackCommand_configureAzimuthRawLUT] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
