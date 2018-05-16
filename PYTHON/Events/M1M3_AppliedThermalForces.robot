*** Settings ***
Documentation    M1M3_AppliedThermalForces sender/logger tests.
Force Tags    python    Checking if skipped: m1m3
TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedThermalForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 87.6127 0.685501773469 0.333831137001 0.558783847268 0.576111256277 0.853769733253 0.329573524021 0.675870405485 0.274534807817 0.385776565293 0.635645937333 0.391537382065 0.552414386038 0.898847717 0.138607981994 0.145204218085 0.20290923788 0.686869218109 0.854016110913 0.442284906102 0.995725639286 0.397659291774 0.904624469552 0.390315984152 0.127471166288 0.208231275292 0.583063228858 0.849233266167 0.518150153277 0.703742063618 0.438885866664 0.8922819389 0.909213563864 0.589095658442 0.221015925219 0.160487955591 0.347861318192 0.0525360205144 0.122571291411 0.762351745356 0.891840145852 0.257137512584 0.837991454624 0.43452878769 0.361011872636 0.841899331209 0.639954951695 0.880053948282 0.8189425333 0.429952652802 0.517713045439 0.592069386419 0.743059304576 0.959036136692 0.357536923047 0.593220319905 0.444284827493 0.797598274196 0.180826447479 0.463880269538 0.898858975007 0.677267362363 0.913353683671 0.247008295872 0.267370838706 0.822766957412 0.664869236622 0.682649083514 0.104379345046 0.567743036725 0.0801889987091 0.78717972791 0.816437537375 0.494985041556 0.790094387671 0.776875146084 0.0935166969496 0.0321638670514 0.259600919765 0.195947145623 0.943036497298 0.549351849751 0.598276658399 0.672156394822 0.986392517829 0.810064972004 0.906798146415 0.569825438745 0.263563425036 0.0012144158902 0.316085233386 0.566833375517 0.369819572565 0.210933540945 0.246518720401 0.0657459244747 0.913406008819 0.439183987172 0.803466996954 0.798843318777 0.404356257807 0.112750319003 0.459027401443 0.212561433242 0.784679941982 0.276041508652 0.66016940166 0.835282552739 0.473225145119 0.983613075874 0.052586454864 0.874369925962 0.934446755794 0.104237136656 0.0793783491052 0.583316059584 0.168964094463 0.148417464266 0.205467080895 0.480635106428 0.543651649944 0.166559825165 0.432647282443 0.0752427028527 0.863447383909 0.94257168553 0.581817112454 0.671485364033 0.987427753123 0.921225236721 0.754833177863 0.344121052724 0.425851753582 0.446323506943 0.630940318412 0.824609081322 0.319304528293 0.944639288947 0.517273712847 0.526333089724 0.592186663302 0.145678925061 0.0807295832094 0.301371750499 0.1805904863 0.844091617503 0.345379397541 0.97683353018 0.647181125343 0.767561186817 0.691776553402 0.22565812375 0.527779677492 0.0637272368058 0.0714154961522 0.185455780299 0.195415371365 0.0627857087324 0.166409732963 0.0211963482225 0.085275686112 0.831517818602 0.292565152237 0.126299046225 0.316356961808 0.974758390537 0.0098050349659 0.0440648936682 0.97303418979 0.876153829691 0.757006906873 0.799348320996 0.259121478895 0.749432214311 0.864088403086 0.275016965176 0.801349079469 0.337324977617 0.972330001261 0.412253825422 0.0963297338167 0.523791803617 0.901033758453 0.0475469080353 0.918034787675 0.91824816055 0.735810134623 0.928684208897 0.485173900007 0.212043118505 0.595031966859 0.587816982945 0.86594166141 0.452915521046 0.568869551794 0.335088321808 0.389887424263 0.798507307869 0.87309828757 0.520371335828 0.384895303109 0.508283005651 0.425060798658 0.666442609565 0.939670615177 0.114675549095 0.93100840926 0.17379628971 0.951559447538 0.319757308998 0.132308862993 0.616257204948 0.323466989768 0.574287783195 0.162996873414 0.153608527497 0.44845609598 0.601186403748 0.518654559599 0.04398782224 0.918912788633 0.229424609678 0.425043488522 0.289536997828 0.714420610715 0.58379636224 0.775830776187 0.281598987964 0.243502837757 0.440361093059 0.297390565783 0.503010451622 0.980373533739 0.614581609829 0.306170274217 0.935990574526 0.492777457482 0.981503139029 0.0942564805734 0.982660104546 0.856851698703 0.0129832977598 0.878148972823 0.651180832802 0.156966796941 0.886550940588 0.482296629743 0.225807133351 0.149807541222 0.767399526747 0.684073575713 0.769131055859 0.793328575166 0.475637215413 0.427520550455 0.0411759978255 0.461905964684 0.0209852804099 0.476963231174 0.957560162782 0.423027625471 0.210491922892 0.50203928081 0.197903617732 0.685525235164 0.417176126114 0.802284977045 0.0739810683584 0.610670635427 0.248688861791 0.853370780931 0.906508929261 0.294137897526 0.566659798008 0.792539154226 0.862924920138 187971225
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedThermalForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
