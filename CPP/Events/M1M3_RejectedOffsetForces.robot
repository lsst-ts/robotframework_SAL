*** Settings ***
Documentation    M1M3_RejectedOffsetForces sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedOffsetForces
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_log

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage :  input parameters...

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Logger.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_log
    ${output}=    Read Until    logger ready =
    Log    ${output}
    Should Contain    ${output}    Event ${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Sender.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 42.156 0.935438877213 0.442336063829 0.555883678719 0.315236776396 0.25852046205 0.406683979383 0.800005548948 0.254248713698 0.122362006836 0.334280103414 0.623986292915 0.301148777233 0.896107993452 0.599803076606 0.197330115855 0.213060411288 0.198772151985 0.851778773743 0.280199550547 0.372447568499 0.0525939845754 0.977592090655 0.783165564534 0.9856136517 0.023319485666 0.515183942665 0.971755276892 0.0666677570769 0.737426048324 0.109230356138 0.314305462983 0.180916000447 0.802233780304 0.583004604158 0.906513604902 0.576074197208 0.323508230259 0.59873654656 0.380858249327 0.676571404458 0.669008359386 0.534205726091 0.131539308481 0.929110835945 0.966598591001 0.960721281932 0.340017478055 0.413384517356 0.850085734147 0.261014933666 0.225676098419 0.651823150613 0.724579452965 0.654898048165 0.522891383308 0.166014968233 0.821499261453 0.0701037646785 0.519418215575 0.672194617777 0.825686762782 0.573528768263 0.868566873234 0.621845127447 0.322374853011 0.400031567041 0.40220227243 0.749595352525 0.593530352544 0.332329995012 0.634674657713 0.571505136306 0.225879178268 0.237108538 0.104019452621 0.06719312675 0.728936386097 0.723676565214 0.897204985983 0.165413990411 0.88495715 0.144896361795 0.664238428798 0.506334327299 0.772001703164 0.0541132515562 0.650040881347 0.517417549924 0.458061544983 0.267308172766 0.297134685711 0.846710951538 0.481022087179 0.695794402499 0.942112664645 0.414596687924 0.939355653521 0.0144646547411 0.36844739867 0.334572580927 0.544639395699 0.497271935882 0.207225157846 0.548266922385 0.420349364186 0.675217477933 0.407382305108 0.326602992469 0.453923676525 0.139747201795 0.437084014869 0.170833212542 0.0691648907643 0.879088010959 0.540776302229 0.372160033281 0.63335163387 0.702233540208 0.849474051523 0.796404806451 0.099973844901 0.240939045056 0.594140213558 0.225101619509 0.336201718667 0.44664830531 0.12826896504 0.632132518096 0.256503875662 0.527671540144 0.300124553708 0.581451892258 0.112421617016 0.13154357057 0.0768697119241 0.585347495021 0.259060238307 0.307692669946 0.142700014362 0.733059542362 0.123580219907 0.2351775498 0.247863177281 0.680050557687 0.0946396613181 0.00725402204433 0.120764431075 0.463159456269 0.334032387269 0.328731123418 0.190895972126 0.630781378353 0.916458068369 0.959982519932 0.105865597455 0.399185265857 0.0260526625679 0.679803396849 0.504368378214 0.335715614355 0.464186876351 0.84093028128 0.783217751965 0.662996786926 0.966892845262 0.108808536228 0.128076866764 0.693158082211 0.821372769458 0.976095273306 0.667618871741 0.980676087497 0.703032280603 0.790595865348 0.178995405796 0.397511952601 0.3372383062 0.737516026022 0.83931742216 0.111974739064 0.823165475097 0.15027755454 0.205371983492 0.567487253518 0.211552796534 0.548110571303 0.83712363836 0.817232298752 0.470159506844 0.157231864153 0.771170542522 0.889711756578 0.158074969651 0.648072564185 0.582201364319 0.558264422832 0.0832043380121 0.059621121865 0.339190476821 0.574424873795 0.451757685755 0.427393385427 0.47892615613 0.74123547173 0.655558898773 0.69764739914 0.787550182393 0.731571608749 0.608558765021 0.359836488572 0.740782626226 0.579147700989 0.742751380987 0.944905544123 0.268461213501 0.0330549165856 0.686739041043 0.999364237124 0.769386762453 0.496282825852 0.614373017246 0.14851671975 0.354181620961 0.305751863022 0.0908581325844 0.0666374473314 0.312943744963 0.407355277813 0.48064478136 0.525493671761 0.910987356998 0.695424758788 0.324240344968 0.997188004287 0.765163471195 0.370652168439 0.13702847051 0.426217056913 0.757308871404 0.479332551467 0.582935536895 0.127967173512 0.703189628452 0.939881565488 0.346774891236 0.662821758814 0.834746127291 0.243336348335 0.778463588165 0.307942946253 0.020664404634 0.349061891287 0.593614438287 0.692657112285 0.0933970865544 0.0631286070218 0.124848891704 0.555139919529 0.163872577048 0.539566510235 0.219831959702 0.0205199057443 0.349657881782 0.73630781507 0.220966825482 0.63500173738 0.326176528575 0.292931821618 0.295701225689 0.0919677109304 0.52098709696 0.352547386257 0.349691154977 0.505226602345 0.111840100424 -1050084904
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedOffsetForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedOffsetForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1050084904
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedOffsetForces received =     1
    Should Contain    ${output}    Timestamp : 42.156
    Should Contain    ${output}    XForces : 0.935438877213
    Should Contain    ${output}    YForces : 0.442336063829
    Should Contain    ${output}    ZForces : 0.555883678719
    Should Contain    ${output}    Fx : 0.315236776396
    Should Contain    ${output}    Fy : 0.25852046205
    Should Contain    ${output}    Fz : 0.406683979383
    Should Contain    ${output}    Mx : 0.800005548948
    Should Contain    ${output}    My : 0.254248713698
    Should Contain    ${output}    Mz : 0.122362006836
    Should Contain    ${output}    ForceMagnitude : 0.334280103414
    Should Contain    ${output}    priority : 0.623986292915
