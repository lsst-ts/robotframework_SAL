*** Settings ***
Documentation    M1M3_RejectedAberrationForces sender/logger tests.
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
${component}    RejectedAberrationForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 8.8263 0.871015788259 0.767151229187 0.637136404278 0.786221363186 0.830537584599 0.848234383721 0.950641753083 0.650177239894 0.259272418679 0.329729448617 0.576912269953 0.0621181450988 0.211624980891 0.484235894728 0.0979291942413 0.548733989044 0.510289597921 0.80726959834 0.846563465387 0.916290555059 0.924491093121 0.356910372939 0.0968921876921 0.509243672157 0.556100029842 0.939128666685 0.74919142818 0.816238391405 0.804473398468 0.264984885299 0.877518181565 0.448861356793 0.864410281643 0.657917120889 0.440218850223 0.80526622715 0.174429162353 0.543031901271 0.327886473937 0.718681008742 0.388538675767 0.800711460025 0.268482424318 0.725002481536 0.392713971141 0.340420842007 0.165300338739 0.660714883057 0.876175818853 0.0769864226276 0.468922304084 0.0177420758762 0.0187335468278 0.969565153711 0.547874045169 0.270638268464 0.28645623505 0.580081230298 0.560466882263 0.248672309696 0.0459606243999 0.888004278707 0.326465939062 0.526120358662 0.862647433873 0.273843271498 0.438512737024 0.897241466056 0.861837653137 0.429192483269 0.0918528542616 0.889604647267 0.933249832526 0.628743226149 0.957207225641 0.163212629138 0.422039288831 0.464176341372 0.199002687561 0.178421317078 0.931248911938 0.548544075674 0.0840919071664 0.698065941286 0.305664424536 0.780322079273 0.729332801757 0.392887632563 0.852237458357 0.401985703063 0.291760261132 0.830260170374 0.734643374448 0.614923704642 0.632213235892 0.714889429781 0.0857571600733 0.561257283677 0.377911550057 0.235423543718 0.910587887944 0.302729784799 0.503295653872 0.0607714739774 0.856209057415 0.206102822789 0.218491357694 0.246302575836 0.705402611858 0.0748822641202 0.482724073361 0.840394011437 0.714611340503 0.818649110855 0.0678439063759 0.871407965449 0.79403030284 0.231318263675 0.871567191444 0.387361900886 0.442969853541 0.90053982391 0.648268244783 0.435269552042 0.85511093744 0.882394329901 0.3670514834 0.590713447849 0.219008976868 0.0400674513004 0.765734379554 0.0103404792683 0.0359331195849 0.601518755886 0.959981672208 0.595868961826 0.269030711227 0.336873116459 0.59738559022 0.375811294126 0.606588134945 0.179995602001 0.0801289671744 0.157164827933 0.903856137569 0.81339544453 0.76283558294 0.137921450458 0.0846875198736 0.972078653939 0.916196273391 0.18555843122 0.947303831491 0.251480936055 0.0382320162114 0.479328569873 0.815044885708 0.0967486954772 0.429098889485 -1983904348
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
*** Settings ***
Documentation    M1M3_RejectedAberrationForces communications tests.
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
${component}    RejectedAberrationForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 13.6942 0.031599 0.750157 0.761889 0.162102 0.825 0.749223 0.35788 0.56701 0.315288 0.340878 0.404196 0.092442 0.356298 0.703037 0.139951 0.715351 0.22151 0.912236 0.489502 0.423073 0.595654 0.27796 0.672574 0.871932 0.885018 0.624547 0.373054 0.378709 0.225683 0.918705 0.203069 0.428024 0.946174 0.713702 0.05518 0.38635 0.92264 0.015429 0.8239 0.425914 0.657824 0.042253 0.468199 0.392202 0.412776 0.932496 0.23054 0.446042 0.201489 0.358671 0.360592 0.270937 0.542472 0.743407 0.383063 0.860491 0.70222 0.802804 0.780421 0.66437 0.513461 0.321967 0.505809 0.015085 0.075503 0.940529 0.571734 0.110752 0.386613 0.330109 0.590476 0.27497 0.481114 0.58657 0.936252 0.987779 0.683459 0.760852 0.271153 0.854322 0.18592 0.376176 0.264804 0.293518 0.838544 0.641022 0.517528 0.284427 0.852534 0.324446 0.573077 0.989463 0.818689 0.504277 0.65747 0.337596 0.357769 0.926048 0.871897 0.617637 0.420602 0.73398 0.711868 0.615511 0.796003 0.015713 0.005325 0.039794 0.702686 0.684137 0.08314 0.85973 0.820084 0.621526 0.171575 0.26943 0.869601 0.093885 0.182675 0.36315 0.450399 0.682801 0.773415 0.841054 0.879616 0.979227 0.592834 0.538524 0.965472 0.826635 0.199551 0.75509 0.978742 0.654951 0.765501 0.492349 0.871323 0.997318 0.250913 0.138753 0.269054 0.645886 0.944296 0.714686 0.028663 0.832845 0.969926 0.980363 0.543989 0.662785 0.067505 0.049319 0.930852 0.2802 0.990725 0.088414 0.812255 0.009843 0.372313 1720970527
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
