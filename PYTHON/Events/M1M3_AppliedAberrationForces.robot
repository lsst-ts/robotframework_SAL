*** Settings ***
Documentation    M1M3_AppliedAberrationForces sender/logger tests.
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 42.8183 0.961067661181 0.226400018716 0.802004650375 0.552575368468 0.888339835716 0.343906911936 0.4242063376 0.683635821957 0.748599774892 0.0574255189812 0.858920711181 0.601792309869 0.0338155658987 0.633310350139 0.167930639061 0.866113475703 0.227127496143 0.268194999183 0.482107218824 0.746400541144 0.151422030058 0.933000493455 0.809661452216 0.585124809596 0.410066613018 0.856618864493 0.328121691897 0.568125581474 0.646653157102 0.465495610942 0.430329307076 0.908776494758 0.496090631012 0.528434176906 0.143133018253 0.635104989463 0.674774245767 0.756817884326 0.521154520466 0.0912595411549 0.38193629941 0.140176388155 0.260298895837 0.502240898305 0.532430158307 0.282396044244 0.363529132174 0.725738034373 0.269468736375 0.0343865324706 0.984756476254 0.787942358575 0.418461226502 0.592005808494 0.437038065158 0.951017251504 0.852935193197 0.758962743859 0.1429379196 0.504225784562 0.664506081231 0.376653500627 0.239217961814 0.478672148947 0.414689809584 0.825627727906 0.0949709210334 0.699292238365 0.801696790293 0.902605163102 0.265647998791 0.394095937335 0.598661526593 0.215782641059 0.596301190207 0.772833177293 0.646533126356 0.611302896356 0.202799065688 0.753933042547 0.521663434083 0.632404985266 0.871710480645 0.263909049105 0.767783248951 0.669812386889 0.79033123865 0.82530147242 0.205982559005 0.86031980904 0.974055541931 0.165886013986 0.286923084541 0.349367428154 0.776496636304 0.349331001699 0.919304193411 0.508970127275 0.470369504338 0.516564689744 0.692454044984 0.548058260073 0.644319600806 0.924607502599 0.772342327975 0.965232253199 0.836410936669 0.323217530967 0.533216256266 0.565225079086 0.63682093053 0.626895908996 0.0667477583926 0.731028055599 0.806309671035 0.142252686985 0.224555713528 0.709002352043 0.0891907155323 0.0891226751114 0.759106108006 0.249372408066 0.839899760946 0.271003667268 0.864301401354 0.104343813683 0.83622801365 0.47846323296 0.771893150597 0.03235563826 0.525389770419 0.926436038629 0.342929339448 0.369133173404 0.614607468585 0.370524523135 0.505747423113 0.787411084459 0.577844697108 0.658436918731 0.938280707137 0.48903394809 0.208570292004 0.956970327731 0.479192656858 0.779456453021 0.248430110305 0.0334970522097 0.941844559291 0.492231400821 0.423323808422 0.277892465188 0.682460292494 0.550616345978 0.0491356355366 0.074433849193 0.190139337833 0.13499476397 0.291328839349 -220112048
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
