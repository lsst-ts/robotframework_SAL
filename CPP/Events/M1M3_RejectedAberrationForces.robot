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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 18.5602 0.364234089625 0.748630751293 0.774455511759 0.984171283647 0.93343523303 0.736726963227 0.0552238757572 0.392483015756 0.319140849249 0.469672482969 0.875868974489 0.332929516963 0.0813828705513 0.804652543018 0.629789320892 0.126881323915 0.71855281257 0.620599737268 0.78847686464 0.253721811086 0.598830025814 0.512858267535 0.653214592668 0.750959316538 0.00509840586987 0.78241632753 0.0104317850076 0.898740896301 0.643933739074 0.885179244792 0.644137280598 0.825969338113 0.339768121263 0.838318037299 0.586108678761 0.83778584855 0.69475616781 0.362948479006 0.663331205958 0.827058031078 0.850109790669 0.972652249837 0.0295621013908 0.026865696249 0.384257326594 0.897772610072 0.751704278188 0.685458418309 0.969821776002 0.519288609193 0.279097545795 0.874301358022 0.0203683945997 0.957081595844 0.201073657608 0.300705166637 0.536789445669 0.343357334305 0.640167675414 0.737888671965 0.853127793094 0.121740196484 0.26617283864 0.180452489128 0.99871066657 0.428826071303 0.289814091814 0.152836699277 0.721910981166 0.826779288159 0.72566630547 0.344389695862 0.457126724596 0.145005119465 0.0704970064838 0.157283564962 0.682470039923 0.227109042244 0.160278121905 0.799827824245 0.163438318269 0.714948400507 0.63120562316 0.271167846237 0.484387939602 0.426997296333 0.281749565012 0.798197278099 0.0964739402697 0.578694352649 0.459209194201 0.84770866799 0.808743296696 0.823583180059 0.932637312654 0.922826107854 0.623959422406 0.61679577676 0.843235217503 0.390649127923 0.255785481119 0.0969877861309 0.0567789670698 0.49962959179 0.506346050174 0.22331461712 0.979862756274 0.173339216939 0.413242720581 0.520932609303 0.252852680734 0.136682401491 0.552199057914 0.825978916735 0.808173487246 0.0297447635252 0.330592795772 0.125426150106 0.252729231349 0.0948174190901 0.422213338894 0.101040032111 0.943248965202 0.834262291537 0.669262372097 0.259062917004 0.0679753736903 0.827196943761 0.265544177904 0.490805644247 0.303242374298 0.651728030184 0.303409867181 0.369557738209 0.809384117206 0.50585906833 0.843149443403 0.0451882674117 0.858064473245 0.201240210935 0.105826876103 0.771122241099 0.406594186646 0.156726007332 0.776026966962 0.522398648977 0.46178029775 0.973576676383 0.461478375174 0.0472721538738 0.632981574063 0.4565739454 0.227494173149 0.265824566477 0.536899189941 0.743756673444 0.984576172364 0.222589843379 0.465080637487 980228201
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedAberrationForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 980228201
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedAberrationForces received =     1
    Should Contain    ${output}    Timestamp : 18.5602
    Should Contain    ${output}    ZForces : 0.364234089625
    Should Contain    ${output}    Fz : 0.748630751293
    Should Contain    ${output}    Mx : 0.774455511759
    Should Contain    ${output}    My : 0.984171283647
    Should Contain    ${output}    priority : 0.93343523303
