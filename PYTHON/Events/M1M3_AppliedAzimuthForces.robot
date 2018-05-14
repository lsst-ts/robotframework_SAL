*** Settings ***
Documentation    M1M3_AppliedAzimuthForces sender/logger tests.
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
${component}    AppliedAzimuthForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 13.6173 0.890733995675 0.136372278663 0.382447713147 0.875017438161 0.82247933429 0.122534103121 0.0597103899197 0.230892397958 0.522566811784 0.451979388643 0.886525915081 0.164956801263 0.873915892473 0.244901705308 0.956355983174 0.104511620445 0.204922444212 0.507216249562 0.834437856093 0.476913035363 0.716927855918 0.93129581679 0.732590563214 0.296761551523 0.877269334282 0.812519424544 0.356752210579 0.964605220203 0.214708332351 0.606696754578 0.837182983078 0.188319043323 0.543530612738 0.432769162738 0.0894991153233 0.083986387691 0.3519843902 0.261615169689 0.451300137737 0.728526590324 0.193967800727 0.172323967784 0.341089022121 0.884943705393 0.797039788029 0.815417867184 0.864376910812 0.141526047049 0.0313680830214 0.943435625423 0.397674568386 0.393799380285 0.948756816533 0.281240615316 0.890337463918 0.74572956875 0.474231473165 0.719278830409 0.870674196138 0.59017292009 0.765696651558 0.0297655897396 0.621772334085 0.173417188703 0.508816672056 0.133250008577 0.612419587563 0.146751276932 0.950897036132 0.153023684619 0.528492276932 0.127649573529 0.62012307462 0.666454881633 0.706573413181 0.621377862997 0.25551045241 0.0767464442898 0.392754626605 0.34441568767 0.743758352717 0.343017610947 0.711253980038 0.269913163244 0.26071647506 0.176466280962 0.715095905381 0.427348692343 0.279295275396 0.868040201664 0.644309251605 0.100360533422 0.846525143687 0.812576567586 0.409666645976 0.549294700586 0.704049706846 0.144634084225 0.200955051491 0.498364213527 0.372382163412 0.107479192089 0.434860858673 0.866598194027 0.791751090541 0.922022655462 0.0909426886013 0.890706700849 0.906914349472 0.468052857882 0.0664846696465 0.465249359473 0.0849215020688 0.340361321115 0.623442256179 0.496335952088 0.18982833759 0.211404592563 0.022999275225 0.935004441403 0.458799079495 0.33057462326 0.255567907264 0.761542292443 0.916205176944 0.57819412574 0.512129637081 0.840643248234 0.919598782537 0.796399005061 0.89801367864 0.625781548816 0.827826960022 0.0671898129431 0.654992320404 0.985657137788 0.645454330242 0.178593052195 0.917397762549 0.991131227723 0.928288892141 0.829524575648 0.579363629745 0.137538507489 0.667222365288 0.880396084452 0.320492973117 0.294140376418 0.690997198539 0.657631626286 0.0148635113893 0.906836154776 0.382270933128 0.787773470467 0.28521946146 0.771911438859 0.187793073925 0.438992181638 0.466891819651 0.872443637207 0.192612879163 0.995051382206 0.487987737352 0.457140082999 0.6786933665 0.569961473544 0.796808214154 0.156802041562 0.269846030597 0.525632029933 0.532367489236 0.639048471295 0.0433025443892 0.811329137057 0.968400629453 0.683159459971 0.204678020731 0.666350427325 0.18496474913 0.17614395963 0.376075118069 0.427503708529 0.939540246275 0.459661408694 0.604631994053 0.259556102531 0.819595321949 0.971672611818 0.646145510513 0.187765861714 0.483300760712 0.357872709094 0.977140746562 0.336183092241 0.275665599801 0.565717200549 0.019054687135 0.741792455808 0.224633883615 0.547811487911 0.420733812871 0.94752246524 0.605497022419 0.644816829912 0.27340449883 0.109190598817 0.786245044112 0.20159081718 0.387774850587 0.242366135361 0.317971023115 0.594062078926 0.907448015292 0.879401651425 0.0852603627041 0.859540992176 0.0993103407217 0.521945057701 0.844489801976 0.0371400263472 0.552476675454 0.5834038559 0.933901125998 0.992398157241 0.24978481581 0.399187036334 0.950252345482 0.676108081483 0.945684929946 0.287783522311 0.573310469957 0.236813071313 0.300466549918 0.276749242439 0.701343129019 0.264861385182 0.276507620059 0.107392504392 0.295348790375 0.998155323105 0.638976937066 0.779959870346 0.146531801948 0.781858472153 0.886147823397 0.715359306772 0.208758241073 0.775531819981 0.262695670226 0.734282199476 0.014061703846 0.952233999589 0.76546987157 0.0086745475176 0.377465221911 0.900131663022 0.381806678758 0.576833373319 0.62204258143 0.204384688669 0.860889017041 0.280696812138 0.930845524903 0.280451003417 0.55143229414 0.290177389554 0.00337769981414 0.383390711639 0.00511317006586 0.272245144996 0.68792682938 0.383467694252 0.178232737912 0.0796219334481 0.288776923897 -912257445
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedAzimuthForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
