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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 17.728 0.923842488259 0.633800137432 0.689825676403 0.662776381787 0.929500280652 0.0644731911956 0.48999493294 0.111029231049 0.644813085447 0.861194468438 0.485435130265 0.119049966098 0.142891143293 0.848188489654 0.0287388441189 0.713225708012 0.469910488943 0.369389251977 0.735276511054 0.783644068232 0.676420615186 0.726794698625 0.727679907808 0.62415649194 0.702840085006 0.57257869008 0.282192696196 0.964000884949 0.637605012101 0.308996660928 0.900012227333 0.652293206285 0.543123775303 0.135932193183 0.965335677302 0.382300346196 0.559574962727 0.842232147193 0.875672741273 0.236273106244 0.520582010732 0.764100440387 0.0242293523412 0.443728924007 0.55358160401 0.591523369383 0.947304757797 0.110904993584 0.116880922404 0.343234924228 0.779449783681 0.0943969846559 0.247799180648 0.238076205885 0.458332271077 0.528919202142 0.248761834281 0.387595312404 0.347386147306 0.998700161497 0.865514694972 0.775638461634 0.693998604795 0.0682231240075 0.374802406541 0.858254125792 0.0765430606891 0.16634018067 0.0716758440472 0.255079583957 0.0605478903081 0.288836961373 0.514623326813 0.0397564865671 0.725697406283 0.836740668977 0.515291311088 0.0635342381859 0.18379668607 0.739991881686 0.39601624458 0.683651252177 0.918297285319 0.247047642522 0.578840555184 0.100259299858 0.747864235759 0.291111517082 0.91197318486 0.754310019556 0.730102816002 0.929854599086 0.0601080335391 0.743281190957 0.792204169675 0.271456877147 0.556050997759 0.494406002273 0.448567508252 0.0893919902469 0.815126008271 0.465570443793 0.07679807373 0.371896962692 0.632818773269 0.850107059868 0.987548857928 0.497709236543 0.256969038761 0.506328430331 0.623308559579 0.00278288926048 0.638844259399 0.844375896059 0.811361987866 0.18074665904 0.655630818317 0.24791973382 0.71736364968 0.370638156462 0.904093399484 0.0853355466937 0.607543857263 0.254172246609 0.213250868472 0.614232125198 0.566697019731 0.909967582405 0.692188404881 0.57665908181 0.933627153369 0.815070127818 0.830002978133 0.6519797098 0.999415332069 0.951759075668 0.497992424681 0.922917520608 0.345682118393 0.163919894613 0.920790514526 0.849969214005 0.98752041292 0.158271969601 0.111697309698 0.518660718469 0.709110778644 0.140572479117 0.926701779915 0.378855101476 0.361335229084 0.89418148227 0.965792519113 0.161120529069 0.642518776227 0.177771954701 0.281606997402 0.88491653237 0.677459172507 546042451
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
