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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 89.9689 0.691221771205 0.450930755894 0.845491470984 0.15860995618 0.702622646945 0.387167826847 0.828195051104 0.699300355979 0.578198646411 0.0502744720971 0.891150132633 0.72266765577 0.48421996037 0.54685818761 0.675040154621 0.0492526350631 0.36314554668 0.486942834783 0.94509315964 0.242645959485 0.869720809954 0.176513992793 0.607623578263 0.125254356225 0.223853915469 0.846031764447 0.0691669068891 0.924525369055 0.49412147123 0.0716507517608 0.567100098985 0.295917646951 0.602923930948 0.132180852597 0.688683582022 0.375604854038 0.495011340946 0.349617473817 0.653152219397 0.87970637909 0.617809189447 0.317293003199 0.0713055113015 0.333616607229 0.954348555407 0.343436706631 0.0845311565438 0.661390881153 0.993800211299 0.764759032075 0.807573730678 0.605479238176 0.570463796685 0.507682899202 0.0198759085567 0.103329897055 0.161217036974 0.316207635036 0.326705200635 0.378811393611 0.403877170568 0.499034063595 0.809007882566 0.500871517707 0.107600904811 0.320536668117 0.671580451547 0.478007830307 0.993104718086 0.324615479406 0.627457341657 0.475745234517 0.957855662764 0.142523466967 0.426843667527 0.733350025685 0.134553063682 0.40560622836 0.715905028652 0.833960055269 0.389567294282 0.190564004773 0.758060495533 0.772859085736 0.322874863264 0.963644889037 0.589602935448 0.726028314177 0.571652762997 0.653147309459 0.565696745125 0.0822888757375 0.906584145351 0.321900717748 0.648891645631 0.545010964962 0.959945331519 0.449087370632 0.121290916283 0.365947162436 0.0641325947596 0.274255795366 0.616482006735 0.557762169333 0.55157178291 0.821059886435 0.707857017794 0.317845485347 0.993702247629 0.390241338798 0.438861676797 0.788664980377 0.506781234244 0.795729229806 0.130113731576 0.616114500994 0.351823087379 0.138613078884 0.809830418474 0.385623530464 0.563944168659 0.0645721241844 0.859267757676 0.665008165031 0.975892148975 0.586855385426 0.322645019071 0.392523494761 0.527380931287 0.772318840785 0.736462639368 0.502656174183 0.169567231793 0.302039356011 0.677256456818 0.124286906911 0.57584146675 0.851500106096 0.431207019607 0.407299480595 0.240225279072 0.0799862613757 0.540253102919 0.464981637384 0.121724353159 0.118739934835 0.53725110377 0.0290406834662 0.6916712496 0.43363321766 0.568493626521 0.847452961367 0.750245062329 0.900766544309 0.782450400316 0.458461481494 0.591009928333 0.266519207107 0.393438163948 -1883668560
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedActiveOpticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedActiveOpticForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1883668560
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedActiveOpticForces received =     1
    Should Contain    ${output}    Timestamp : 89.9689
    Should Contain    ${output}    ZForces : 0.691221771205
    Should Contain    ${output}    Fz : 0.450930755894
    Should Contain    ${output}    Mx : 0.845491470984
    Should Contain    ${output}    My : 0.15860995618
    Should Contain    ${output}    priority : 0.702622646945
