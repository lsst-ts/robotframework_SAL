*** Settings ***
Documentation    M1M3_RejectedAberrationForces sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedAberrationForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 72.5986 0.0966265612285 0.478213514996 0.345166471059 0.473723240551 0.804643476399 0.621515509115 0.724300906948 0.0911605360612 0.808149034251 0.263219536485 0.772408452205 0.299531050364 0.602482295221 0.182657404548 0.834477709858 0.582303699191 0.00664644379457 0.135617646625 0.810425947057 0.745037991426 0.0741481410365 0.778820703623 0.942088790627 0.347809780901 0.579984009944 0.169646610008 0.516175214512 0.869422389516 0.732358912276 0.317675416618 0.29470417969 0.602815370273 0.897209874627 0.761170502404 0.941452107063 0.920117682937 0.417491721784 0.00565724062753 0.603307904935 0.35089936335 0.46950862916 0.025622999898 0.146034052394 0.282204195812 0.967455840857 0.958299978067 0.767138317752 0.39760993372 0.797079381182 0.235430104954 0.35862171925 0.179826723518 0.0696110633796 0.907159242073 0.46084947438 0.536531501957 0.583114659626 0.333283805404 0.142769035561 0.180617939277 0.957467466363 0.478566197853 0.940495294254 0.00183440021632 0.676085424753 0.0418877047091 0.911709872647 0.387882428801 0.651832427086 0.558860239441 0.100877789936 0.573157174314 0.0887662493558 0.596174386177 0.833029420054 0.564068875292 0.413453142595 0.699082290238 0.159923818569 0.301522402309 0.24676883134 0.450899313951 0.402352785168 0.390239950693 0.826476058954 0.794111647026 0.283840781538 0.969277633095 0.729154147927 0.592478791202 0.572560094761 0.88214417968 0.995260965131 0.614074944091 0.0339408279781 0.289148467164 0.164557097988 0.0246303825586 0.241098213397 0.845644158586 0.490047021271 0.799942181752 0.46681425515 0.0324915641422 0.577913269459 0.297964480084 0.076278621817 0.0840952226057 0.179619196037 0.405865061034 0.367250087766 0.392447660069 0.143121440035 0.173573036049 0.658432998699 0.321414295472 0.0960596574439 0.535397053288 0.2964152386 0.994541457456 0.903491056434 0.999443367545 0.151515541087 0.619945770375 0.0929253302886 0.436566498546 0.417180306586 0.063914142122 0.575039563035 0.552157341179 0.258798744606 0.178213701085 0.380382663892 0.680942833034 0.519164820788 0.573761231249 0.961863514696 0.250716621982 0.892588371348 0.344827882877 0.522529152561 0.463134989873 0.41199810959 0.42568469423 0.933316262569 0.500008462884 0.249413935538 0.23857855324 0.772801383376 0.891372854705 0.282182754818 0.131140046158 0.340221316 0.28753488121 0.206899262102 0.504323356245 0.818238114256 0.928747252897 0.887197681234 1669268821
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedAberrationForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1669268821
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedAberrationForces received =     1
    Should Contain    ${output}    Timestamp : 72.5986
    Should Contain    ${output}    ZForces : 0.0966265612285
    Should Contain    ${output}    Fz : 0.478213514996
    Should Contain    ${output}    Mx : 0.345166471059
    Should Contain    ${output}    My : 0.473723240551
    Should Contain    ${output}    priority : 0.804643476399
