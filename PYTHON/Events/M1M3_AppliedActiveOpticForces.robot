*** Settings ***
Documentation    M1M3_AppliedActiveOpticForces sender/logger tests.
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
${component}    AppliedActiveOpticForces
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp ZForces Fz Mx My priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 90.7988 0.624397153795 0.00496969567083 0.730923244986 0.810776185005 0.0604277606081 0.348246852507 0.321277080423 0.767262494953 0.852878595645 0.734251289186 0.372701664247 0.952249912464 0.50069895791 0.201339741987 0.793192485889 0.451899421464 0.171313057741 0.681779185705 0.493618399947 0.762848322734 0.98339430329 0.904314504916 0.716558488983 0.425226382135 0.674020777502 0.657388639861 0.48467817431 0.734197022551 0.571633896315 0.923924679941 0.918048625239 0.37246323696 0.113398875488 0.313900017778 0.697142016209 0.107906373146 0.595281693665 0.875126857957 0.95191079449 0.0621654724015 0.19135234994 0.879794927184 0.959033516473 0.859304513734 0.638981393459 0.589630342084 0.424417618011 0.590134170708 0.456894130116 0.824552646809 0.446828107501 0.259570870615 0.0328814280309 0.664822270442 0.29663587698 0.238620256544 0.445032255926 0.207079046737 0.986275779544 0.0217535949192 0.959422812631 0.715319087687 0.22769245191 0.775642477134 0.0384015682533 0.435193625222 0.305458032482 0.444372764864 0.778629041664 0.010783742558 0.699464390903 0.122439618905 0.284298334447 0.672163294431 0.272397201279 0.0736600426105 0.133510479568 0.362260205839 0.673304544023 0.60185840723 0.447461209384 0.351081671161 0.168063447844 0.413134180221 0.719390441691 0.504911324417 0.227992722272 0.345167346649 0.779776241425 0.819626039969 0.732511999413 0.596129704675 0.446977314931 0.161239430556 0.0304584308705 0.0116586996962 0.142935377384 0.357155378112 0.289134201078 0.05300560139 0.25962170634 0.954577207835 0.181304918606 0.98117366304 0.0562886537902 0.963575783483 0.298039721237 0.102234198366 0.583857987818 0.217393961642 0.447046030473 0.643512438002 0.581246601912 0.542369908832 0.0455272993516 0.150425570162 0.434259835993 0.00612397374541 0.0353915338593 0.123397123284 0.633778642998 0.350735948705 0.896973460117 0.886870024608 0.906891756395 0.898797701712 0.656990120949 0.941131808828 0.831601506608 0.549376408501 0.502180028722 0.879004566934 0.043506700277 0.683227392103 0.595386897705 0.719643802464 0.0969539619712 0.939163802191 0.820977357206 0.440094493378 0.726638822589 0.416553909377 0.970318986702 0.125178499549 0.00493443607421 0.293842356984 0.301574499823 0.555625307241 0.89944964648 0.800739641646 0.0650989849284 0.051507441359 0.684139121311 0.538281916057 0.542235289526 0.691824130443 0.192310514143 0.0816217427336 0.8181519459 -1949316566
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
