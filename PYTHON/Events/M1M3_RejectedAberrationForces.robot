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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 79.3848 0.349341708492 0.431539360968 0.587124866951 0.965566774849 0.300527883343 0.0545054952522 0.526866832139 0.981385350933 0.395368228604 0.631974320336 0.388387779635 0.3992753147 0.909544917924 0.857494880498 0.374481204524 0.735640837292 0.870776686671 0.830012435534 0.785825572805 0.810806570513 0.00234701464767 0.735750403471 0.698040040433 0.0744150855129 0.413810350826 0.90398931946 0.760159951766 0.231602642962 0.561638986855 0.441354256246 0.0493651349071 0.0339118472527 0.722948937583 0.858757213627 0.0167654306471 0.964004402229 0.172002636159 0.800828795733 0.930957745762 0.275522499477 0.891289644672 0.75449284823 0.157162114261 0.376390581891 0.973292634405 0.12901671229 0.305145781395 0.822800353913 0.682345858848 0.68973962788 0.45440971382 0.781204437384 0.533391677385 0.785737217906 0.450906900886 0.428064144667 0.269610152872 0.87948783116 0.308798376033 0.581896573377 0.486277886373 0.48843403211 0.430571188927 0.967949878044 0.0724247878135 0.879897822828 0.155480436446 0.32534561936 0.200658930974 0.031126172054 0.416013550323 0.0236330774027 0.555034813246 0.920526377116 0.458072767985 0.285425495234 0.828846506257 0.135398074847 0.332343666581 0.794371605268 0.349346613788 0.0934496287969 0.250161255079 0.160194942833 0.294225941635 0.00292970812222 0.509825304347 0.857177154684 0.412690246749 0.369878744192 0.537232314952 0.782547021294 0.223174117223 0.266782918183 0.848686239609 0.908830418671 0.529887769835 0.426685999746 0.0882571334606 0.726114864061 0.454050971257 0.976886190416 0.979153274687 0.225972779878 0.359865764354 0.664406739626 0.882265783273 0.219245055399 0.0533793534886 0.828666374767 0.711757983444 0.908042475351 0.812392375588 0.901755069844 0.724881212364 0.0694921779482 0.785305306051 0.184052474663 0.589964469488 0.0358330027493 0.815392796971 0.56590422085 0.850897278629 0.760032988771 0.244750994854 0.803818678468 0.163869862147 0.013849373499 0.1099517758 0.00734578885764 0.578083735508 0.498312341971 0.363862240801 0.43583240112 0.264849052714 0.0322885030137 0.774666881396 0.540318071513 0.956602115532 0.366307931274 0.975501090047 0.729043757861 0.898754576662 0.835358492114 0.291371601793 0.928899508809 0.907652324797 0.198226790681 0.727801711144 0.81829084811 0.573852635495 0.107710119615 0.614412978431 0.605395744005 0.501867431937 0.968026421832 0.413875551896 0.00965922422657 0.0824089929557 -611796892
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
