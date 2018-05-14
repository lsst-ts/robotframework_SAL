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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 5.4492 0.697107669141 0.315688482324 0.549155023861 0.0829669677567 0.520609133089 0.860515897108 0.151451077268 0.725374633564 0.809122322178 0.244192157759 0.157123865178 0.976330044344 0.248226130945 0.470022918809 0.779032290549 0.66834287596 0.847893282279 0.0365438162488 0.599676107102 0.626254433874 0.0382125455685 0.304645866501 0.734159999214 0.180626432991 0.0938600009066 0.928107087514 0.270711729679 0.296560788277 0.722250537228 0.979081492072 0.363133452545 0.459120561465 0.866986250431 0.997442892942 0.252860645852 0.360038074007 0.574310232751 0.585627802733 0.748553050586 0.259597282281 0.320724707176 0.973135583663 0.733318123827 0.0915557654679 0.207303965332 0.744013500727 0.155638595446 0.0222997975276 0.735667942361 0.210016700332 0.968081432269 0.821515164588 0.937458855844 0.441442770191 0.560010608902 0.390309190826 0.748751755621 0.267585407172 0.995476296333 0.390526292252 0.177762809746 0.962426252989 0.626073220078 0.431842827505 0.58893041162 0.179864153275 0.787725451679 0.152795907557 0.776871894463 0.262477141029 0.670463802061 0.940446671214 0.761784379076 0.412238972043 0.584237317168 0.0179851848946 0.999999107977 0.27373628655 0.281883520986 0.0497986383602 0.992758966714 0.134399826265 0.309265461432 0.706217769511 0.300753536035 0.314455449832 0.318759895392 0.987667542629 0.323046982233 0.459848668409 0.836408236842 0.516929038823 0.709972539964 0.694259744067 0.174045063601 0.571946496996 0.795904818044 0.696460710457 0.368006768405 0.171431804258 0.190610074727 0.618451051477 0.961419300479 0.234784614957 0.588687847561 0.659040358011 0.596871888108 0.505370284341 0.93735286744 0.228685114995 0.962378615437 0.507986609777 0.323311445446 0.471413868396 0.726814745003 0.0799897402402 0.934806802288 0.840526320189 0.403919402719 0.464912228169 0.87853167203 0.79874849751 0.322833515792 0.212547548089 0.957692492126 0.259613130581 0.952195195504 0.551673381594 0.436815885592 0.358442838328 0.0213416688604 0.166213130566 0.698806858787 0.44899617693 0.702549241706 0.784156932282 0.575198127049 0.733374003119 0.923747358869 0.634898899069 0.201623831794 0.860844714073 0.00111797999536 0.120674615311 0.0414968400752 0.32275936449 0.451230937471 0.990086820452 0.7070738381 0.132179562418 0.915360974462 0.433729810667 0.450123271045 0.235261725835 0.645635987753 0.688930448974 0.845784752771 0.963134878707 0.983147550924 -1635875951
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedActiveOpticForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1635875951
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedActiveOpticForces received =     1
    Should Contain    ${output}    Timestamp : 5.4492
    Should Contain    ${output}    ZForces : 0.697107669141
    Should Contain    ${output}    Fz : 0.315688482324
    Should Contain    ${output}    Mx : 0.549155023861
    Should Contain    ${output}    My : 0.0829669677567
    Should Contain    ${output}    priority : 0.520609133089
