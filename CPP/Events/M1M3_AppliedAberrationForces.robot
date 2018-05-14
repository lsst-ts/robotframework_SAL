*** Settings ***
Documentation    M1M3_AppliedAberrationForces sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedAberrationForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 83.992 0.18188518687 0.427741685605 0.666270057373 0.0714654121466 0.214494183515 0.858054897683 0.435707904049 0.546508174457 0.736661399667 0.609024458216 0.404554618938 0.521314315115 0.58534096878 0.959965636428 0.386561426663 0.162947303779 0.685882456756 0.220276533084 0.147689700351 0.733428137647 0.950357283019 0.699727904098 0.508199950505 0.101972614269 0.267604539072 0.856154924186 0.299702100481 0.123552931957 0.450787111332 0.351274980638 0.415601362112 0.62100911806 0.301263939509 0.923125961392 0.643379617709 0.572105038826 0.316073925864 0.830131538919 0.389442086706 0.729275352424 0.257120790121 0.335321994665 0.802381625355 0.936153390802 0.00263077360315 0.00832274290559 0.0980370944348 0.521968006819 0.0787772130885 0.0357022363765 0.832763009379 0.319832820805 0.809885023442 0.137866728753 0.562275609258 0.113990450462 0.790738543513 0.561493763122 0.599522608181 0.650785740671 0.109564697511 0.0146585782982 0.42945967162 0.888267948105 0.121395960706 0.129939051573 0.171499472829 0.812825795806 0.837847422132 0.715623629137 0.85773104528 0.817214108408 0.709886543756 0.629639833568 0.32878472933 0.792903799382 0.943297288323 0.937217697866 0.579733778579 0.940205118412 0.440414650667 0.988332590304 0.422781694142 0.399943733427 0.860051182058 0.540928571407 0.0838235670393 0.422384413324 0.54417893168 0.204875116032 0.0849402565826 0.133330401626 0.253978287827 0.731835830128 0.525417462732 0.330358681338 0.364951304661 0.843101590347 0.103709650483 0.955569394703 0.311142262173 0.717103829308 0.382600821558 0.0817418629858 0.521092355397 0.392847411657 0.457042611912 0.992257247375 0.255694088063 0.0119623750441 0.854873537024 0.718783523838 0.939778678056 0.0459458124362 0.497805033281 0.293352888112 0.219946554551 0.196032315469 0.00788729137189 0.801874284373 0.3519757759 0.786960843207 0.809059141952 0.229455965631 0.907737843892 0.0568036812761 0.477877270806 0.611097886449 0.206313075688 0.365730778478 0.789263359865 0.91728631005 0.102530165657 0.503493476236 0.503027288074 0.258856552098 0.948569739441 0.202485893452 0.484924947415 0.64862731879 0.598841355255 0.38320546293 0.0504049078093 0.431584291376 0.16607274436 0.567158066072 0.948588817903 0.274348050058 0.62619496276 0.912635786726 0.486777371616 0.793096383216 0.616291183203 0.282621132971 0.645331064614 0.737702764287 0.788128472549 0.468730489767 0.767041315127 -1908217645
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedAberrationForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1908217645
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedAberrationForces received =     1
    Should Contain    ${output}    Timestamp : 83.992
    Should Contain    ${output}    ZForces : 0.18188518687
    Should Contain    ${output}    Fz : 0.427741685605
    Should Contain    ${output}    Mx : 0.666270057373
    Should Contain    ${output}    My : 0.0714654121466
    Should Contain    ${output}    priority : 0.214494183515
