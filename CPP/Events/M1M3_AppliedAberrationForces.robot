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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 96.2998 0.0794019129314 0.94702386259 0.809357487223 0.467955398967 0.890022659355 0.478017723196 0.373391908384 0.954141362337 0.456743114749 0.822748155735 0.278045518661 0.00782310567919 0.31697150294 0.113991055973 0.828239078422 0.946509373731 0.0980107385651 0.907903445205 0.483726753213 0.793153356382 0.267173919828 0.948393576972 0.859371644128 0.212048125239 0.975569484566 0.690723327677 0.161066382323 0.670619180936 0.429689627179 0.297181696777 0.0659605952514 0.047353130693 0.14977645411 0.837156309209 0.0580624908126 0.649541658354 0.953494266817 0.801156900975 0.69977836924 0.85796072687 0.192882421958 0.773763297006 0.333657632758 0.29118608719 0.259922135423 0.216295808057 0.797630666276 0.973960756573 0.559257710987 0.623847635645 0.02286072879 0.797788453125 0.477923221711 0.644803438833 0.489254887624 0.631884935847 0.290995723728 0.693135419364 0.622346385587 0.197354496049 0.555461562761 0.930862262813 0.900163510315 0.75513626891 0.405960458302 0.807099615499 0.236146112518 0.724689640629 0.802106917482 0.585032462267 0.163448206764 0.48495610907 0.123907746153 0.402053649619 0.830359076332 0.841555528491 0.384054278704 0.195700893782 0.550676485932 0.91181447216 0.173616955544 0.886179180018 0.377519442103 0.306277146479 0.902672905478 0.110983297447 0.831954382553 0.61146779309 0.6403697308 0.714625200735 0.444838163801 0.305818086649 0.3032087501 0.00126500084409 0.783484338527 0.416281509651 0.43236073942 0.438659425405 0.0330741819798 0.0576591494261 0.331330166667 0.21074626276 0.0672559286925 0.757633451789 0.556318326844 0.637470241546 0.924424449887 0.151431310289 0.464302885511 0.985517739202 0.509980671369 0.497007454324 0.833698315076 0.283547670949 0.88825890977 0.679908330761 0.164345233422 0.483745853972 0.718188151733 0.789389110047 0.144555629863 0.114171103311 0.608069165927 0.358021580185 0.398691273735 0.661408304119 0.205031181691 0.0883217872551 0.853622236788 0.0197031785498 0.383133655325 0.0794259722358 0.948786110078 0.944338407948 0.477459795805 0.515222877088 0.835465853639 0.689377234444 0.360211975854 0.316499972669 0.603916830418 0.847858795308 0.487670878729 0.290344495679 0.182834669675 0.613465157609 0.53404384387 0.230095458523 0.500566067791 0.688427310762 0.496660538803 0.810621414277 0.251346050077 0.00531035777449 0.969338371464 0.604769899938 0.730935140713 0.772397405011 0.164668466636 1186543130
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedAberrationForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1186543130
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedAberrationForces received =     1
    Should Contain    ${output}    Timestamp : 96.2998
    Should Contain    ${output}    ZForces : 0.0794019129314
    Should Contain    ${output}    Fz : 0.94702386259
    Should Contain    ${output}    Mx : 0.809357487223
    Should Contain    ${output}    My : 0.467955398967
    Should Contain    ${output}    priority : 0.890022659355
