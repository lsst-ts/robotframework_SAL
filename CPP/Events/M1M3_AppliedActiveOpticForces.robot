*** Settings ***
Documentation    M1M3_AppliedActiveOpticForces sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedActiveOpticForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 85.171 0.846053586451 0.657902416557 0.728710279898 0.614826357695 0.939921436085 0.860219372987 0.438910504024 0.177081516751 0.132543339755 0.804714394229 0.378169978307 0.454604459109 0.929409659704 0.125113245668 0.941504890882 0.55032116545 0.753672608011 0.157619209647 0.576991593836 0.13589729497 0.531853880618 0.00914038920712 0.949639599676 0.0252330546822 0.706407951977 0.583079843424 0.818404623067 0.0937255703567 0.86476508944 0.379518484516 0.939375212257 0.0676524373094 0.293364562291 0.505224010259 0.220647224677 0.778811005848 0.629757514864 0.249374341961 0.531832582877 0.546472545026 0.681041648613 0.227403690912 0.387208133707 0.839077017548 0.449086739432 0.404850175908 0.614246454137 0.983577517669 0.89080267273 0.948009450048 0.459439931988 0.855341682687 0.127832356785 0.852460447311 0.0924380126143 0.380787660644 0.501142109398 0.426055145185 0.385437619897 0.944873873511 0.782474681845 0.0411185943616 0.793194600005 0.0148886547753 0.942337108794 0.207720123412 0.800340007326 0.893562384441 0.938076213019 0.867430754035 0.312711864542 0.737085169516 0.564007708402 0.336938267494 0.529674220018 0.136524870354 0.373843874383 0.31561792785 0.373036598305 0.130188080083 0.516508312532 0.648323895956 0.521418519871 0.956487520153 0.625872154881 0.0757525418157 0.451817084302 0.0600006676476 0.404255298379 0.919948090251 0.210107384368 0.934686178855 0.557353972414 0.115755714886 0.657670626229 0.0549606401067 0.9225411177 0.136075947597 0.355435502707 0.747173225721 0.152969149242 0.704852680592 0.0842099086084 0.512435763727 0.834615397104 0.430512613022 0.144033566742 0.00782773627396 0.93113939909 0.0466508314739 0.767234095091 0.473373404411 0.768045873949 0.253167066438 0.785806464812 0.540722044502 0.117735453342 0.256500004749 0.693483521745 0.119004122717 0.232728829779 0.618825695099 0.21508192233 0.619400097219 0.481038814628 0.153003941696 0.417841585383 0.318198901767 0.484785907267 0.145272535411 0.373790143625 0.310415750207 0.228314360688 0.732271378106 0.218333745174 0.633320064934 0.410668768387 0.116692717059 0.519794769606 0.491842944946 0.291733722665 0.459395132991 0.00897230971306 0.363045836488 0.617220138259 0.792812293774 0.709992928644 0.872617333226 0.885055387066 0.897732394033 0.0678383436527 0.728085266079 0.63977726464 0.890956230492 0.0902689168519 0.204987602595 0.50855944126 0.547723443644 0.350881888067 -290068504
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedActiveOpticForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -290068504
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedActiveOpticForces received =     1
    Should Contain    ${output}    Timestamp : 85.171
    Should Contain    ${output}    ZForces : 0.846053586451
    Should Contain    ${output}    Fz : 0.657902416557
    Should Contain    ${output}    Mx : 0.728710279898
    Should Contain    ${output}    My : 0.614826357695
    Should Contain    ${output}    priority : 0.939921436085
