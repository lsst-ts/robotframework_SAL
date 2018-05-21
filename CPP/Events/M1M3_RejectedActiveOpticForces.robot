*** Settings ***
Documentation    M1M3_RejectedActiveOpticForces sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedActiveOpticForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 29.9726 0.0167591072182 0.957214183131 0.0588057804816 0.101960259591 0.623687821452 0.381441677232 0.554132397603 0.460608420343 0.225360643987 0.400259614595 0.364949011356 0.344089943123 0.345683729735 0.174602562798 0.641812662726 0.0662518486598 0.785736794428 0.449502335544 0.243798833219 0.9881850763 0.571670390204 0.618409364095 0.119161149739 0.0749034656998 0.837700350048 0.470808049734 0.0398691564475 0.499413186047 0.378824891542 0.95672933762 0.414663821184 0.55001722797 0.797313697674 0.380533665121 0.72869689302 0.887858829297 0.541994215405 0.0692457067268 0.837220014981 0.187535468072 0.453411215546 0.891640849919 0.0377764096951 0.210328858475 0.726563952709 0.3788277774 0.861368362289 0.651457698385 0.991029083976 0.852833523479 0.0741094291302 0.535017684608 0.805464869495 0.666427031616 0.647144229869 0.517047911732 0.916231974591 0.512311496566 0.921486049498 0.342658402669 0.0580441153529 0.177170807397 0.03653971443 0.532395288555 0.64383750912 0.336665446182 0.880761246243 0.718086762591 0.677418196755 0.283218892275 0.345812491468 0.0366919053883 0.248326344568 0.959755756526 0.848944180985 0.907397367389 0.835024985108 0.4569314491 0.927029251865 0.722591393959 0.397254579021 0.835933878765 0.262308415042 0.51869230738 0.149952384904 0.35752484665 0.134166842147 0.00923669636613 0.753166462137 0.216337914697 0.841707458284 0.553899150563 0.0825290521727 0.00747716080404 0.791036129919 0.417681520055 0.713346965194 0.638352969513 0.573529716166 0.614052156722 0.83720992238 0.0102048896975 0.596860051326 0.748484929294 0.861347926155 0.452577546536 0.198866130094 0.901977579482 0.839889901877 0.203213669465 0.350798622288 0.0304753929303 0.518654917365 0.0880865038173 0.641396819251 0.0432165614758 0.94135036037 0.0569814838575 0.941623802913 0.545941046898 0.581402881708 0.728101860656 0.540010421477 0.155893239279 0.0915215726306 0.613855721492 0.722323962184 0.523393576111 0.0975028103133 0.249699543778 0.682492581898 0.0582134396321 0.668095827913 0.968622499867 0.63986872832 0.645173556101 0.702054492767 0.543601167983 0.39512791395 0.256201511422 0.341735961387 0.340259814101 0.00323793498245 0.244156922166 0.856379881337 0.20309928739 0.731168499873 0.0809262304845 0.802148049367 0.378840081456 0.3418805098 0.788104563338 0.718210162304 0.534287758391 0.773117176046 0.188413401443 0.996583190106 0.53934354236 0.462501036346 1239834499
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedActiveOpticForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1239834499
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedActiveOpticForces received =     1
    Should Contain    ${output}    Timestamp : 29.9726
    Should Contain    ${output}    ZForces : 0.0167591072182
    Should Contain    ${output}    Fz : 0.957214183131
    Should Contain    ${output}    Mx : 0.0588057804816
    Should Contain    ${output}    My : 0.101960259591
    Should Contain    ${output}    priority : 0.623687821452
