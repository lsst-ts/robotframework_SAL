*** Settings ***
Documentation    M1M3_AppliedAberrationForces sender/logger tests.
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
${component}    AppliedAberrationForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 67.4879 0.700871040221 0.480675973053 0.919316244792 0.443290743409 0.347493502912 0.241398312877 0.290820405216 0.692412396651 0.22802479154 0.0470176782756 0.296848806566 0.382165554793 0.589198557062 0.659397886132 0.690093079203 0.617618543407 0.7550700423 0.671936983649 0.287437493637 0.0644640433183 0.0528689837088 0.0192192247363 0.816234254576 0.74177285557 0.446789422438 0.864101710702 0.841662275222 0.552196954051 0.0374733087024 0.54392322867 0.133530935773 0.0874350526936 0.74350292304 0.681572601384 0.30645453546 0.911621371207 0.397063253178 0.409985866301 0.450183747824 0.548120896285 0.292622626553 0.391917142349 0.37441884585 0.171376645104 0.54824794605 0.341391880708 0.687891456686 0.315695404199 0.42420223254 0.463242249949 0.441596919209 0.559331859868 0.919248793924 0.412380224701 0.825234237244 0.152308671527 0.238336619824 0.31919916863 0.917701884264 0.989569542968 0.365929684601 0.835967323328 0.271197660835 0.19967052449 0.936077196594 0.285265754987 0.3135200549 0.184451505957 0.0678433148143 0.252497735054 0.413566526211 0.717723994295 0.707443037763 0.355037268954 0.5171658979 0.813526249819 0.624650687867 0.25911365449 0.635533214606 0.464153732183 0.839249106139 0.423505301651 0.18829194103 0.923644216816 0.0106037514996 0.425193829873 0.0769320893136 0.567173837991 0.666121207367 0.769157034879 0.415989637484 0.331227745886 0.994478826628 0.570730398257 0.151628825049 0.608055604227 0.875492073479 0.253982036384 0.990937864587 0.832404871811 0.710567578232 0.911939535957 0.549049177994 0.993576538964 0.565401447193 0.145098352193 0.604527168254 0.790943472546 0.718472267812 0.193157118835 0.0972957392026 0.463302355376 0.530804884424 0.202662927925 0.936068834625 0.0331440458887 0.412187367019 0.900827129531 0.97883967372 0.677224872595 0.52529810022 0.762682890865 0.571549063507 0.662604357233 0.751419891937 0.879316087007 0.457188165848 0.55376269818 0.527548788579 0.270013653553 0.456314634481 0.47929529201 0.680571687904 0.846429848824 0.552402278923 0.330052551424 0.255780744503 0.923448388455 0.890090240998 0.72046580155 0.778549000349 0.835737975743 0.601384009565 0.501081484774 0.250685403972 0.202880965798 0.32829247123 0.126194527229 0.416084100538 0.885665857985 0.0801686455824 0.256887073651 0.675260580639 0.928812095228 0.768040606572 0.538956303279 0.556643395571 0.837047955992 0.184754523243 -878323118
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
