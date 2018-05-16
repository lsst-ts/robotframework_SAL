*** Settings ***
Documentation    M1M3_RejectedThermalForces sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedThermalForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 4.6369 0.767431270712 0.0962730867259 0.0698242882132 0.630058798669 0.0679890702621 0.356239851428 0.377273693569 0.482587737212 0.444648176711 0.208376377656 0.839092870555 0.856336064305 0.0661030777697 0.416571040259 0.121410069169 0.985491756948 0.0883600232081 0.0429557709191 0.35925008923 0.94325411072 0.667942187532 0.732045182514 0.353924472454 0.580179150944 0.562530847581 0.821682990921 0.571782948301 0.327469910379 0.489078727048 0.31518378219 0.830549637966 0.514291901937 0.240111539697 0.80307215131 0.0714254664981 0.491895500793 0.260938718673 0.581036997803 0.267550384278 0.0517609696039 0.320510365983 0.835875550499 0.806872696442 0.513619707313 0.211678029284 0.401900460517 0.61057254751 0.0332268433107 0.939059586892 0.734753204121 0.347737069261 0.959973924908 0.545815244752 0.159910366482 0.151997364632 0.374062068935 0.420856460971 0.415132632162 0.49029524688 0.93840923928 0.77584732879 0.215860911572 0.204068173391 0.723562068371 0.0433289748374 0.620442252169 0.993931642593 0.940576785085 0.668881956722 0.446404345288 0.36950766908 0.0638288163476 0.847515154366 0.0886845432667 0.716458858495 0.734943689796 0.702666355653 0.576786005281 0.48994202996 0.737254260031 0.801953091871 0.573971249375 0.517738970219 0.281289348739 0.401331321026 0.863548077654 0.877769319363 0.821677859828 0.411344516695 0.555004002253 0.238865010243 0.669969768176 0.907117921969 0.920736045883 0.206510730146 0.228302453037 0.380043183502 0.118129371552 0.141133747622 0.776041799602 0.368056842314 0.0803535974347 0.164111568544 0.550133942827 0.114663769781 0.968529283003 0.250164097413 0.987340875317 0.556583715099 0.567244018086 0.120145639462 0.443472174728 0.602625037948 0.650661997886 0.760251825776 0.67261083626 0.27199080051 0.697117370667 0.83033815026 0.360774739332 0.591650886235 0.016647814821 0.424406999364 0.101717428477 0.969241367404 0.454128268676 0.338389976827 0.262082135483 0.251286985238 0.328461859233 0.341142432351 0.930029126538 0.165309085595 0.25575813281 0.935409534975 0.255958080801 0.525186789912 0.0117585296363 0.218783279663 0.265028974114 0.344127894878 0.881340477168 0.30909988041 0.553976401774 0.0156030409888 0.266915458351 0.0611276283571 0.851463907503 0.798440190519 0.572340981816 0.601109598732 0.365410613302 0.41868260923 0.486513127844 0.675894794255 0.945605345917 0.474092457937 0.127849682058 0.382614862093 0.785535090176 0.880139674279 0.168742015066 0.85757956507 0.795702638801 0.489691061793 0.332459729104 0.403870279039 0.440335498903 0.386732970407 0.885439372032 0.788517607686 0.648003091694 0.783400907506 0.916544690984 0.427581062675 0.149305677239 0.891685467112 0.886318580669 0.0499678509115 0.847625430913 0.441991684375 0.983789997928 0.848815701917 0.774665974512 0.0616837993945 0.160519163633 0.173310875666 0.823488660228 0.90207364928 0.0815676891042 0.354297452895 0.939518111437 0.105726574527 0.812219604596 0.279635702119 0.555976069359 0.122087839171 0.128494716883 0.761353041511 0.780288397003 0.533985896566 0.204095741449 0.328469382064 0.44672712059 0.0949291027349 0.746562118894 0.42432953838 0.601673180406 0.990167049769 0.839995298861 0.36475529894 0.336624798352 0.435947742889 0.980355113212 0.657863707896 0.755263876966 0.445033409326 0.552424994278 0.162331660343 0.503959897402 0.674700570431 0.0824412104805 0.97317602603 0.363114648892 0.496143060184 0.637136855149 0.343096535852 0.0533290931331 0.595510426333 0.916011791873 0.0869176752329 0.827862084317 0.901497924887 0.690539353921 0.0062155668042 0.970143410095 0.153095324747 0.199781423569 0.62984344768 0.18716862002 0.922957179503 0.00273184639899 0.922807703349 0.11819452143 0.317276379546 0.00312556736937 0.235896221598 0.666879808901 0.300910637394 0.0502801325704 0.141290425323 0.415110061246 0.320649590959 0.414410824191 0.957833239766 0.485665899567 0.467156734398 0.801678223869 0.248552205018 0.576988861115 0.942319565172 0.0492091601881 0.133827010971 0.623111754322 0.141948261239 0.495979322786 0.638613760722 0.599692449383 0.650261839982 0.351405264077 0.675448557804 0.762885150015 0.67620938744 0.418868896018 0.546965646628 -1685841217
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedThermalForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedThermalForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1685841217
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedThermalForces received =     1
    Should Contain    ${output}    Timestamp : 4.6369
    Should Contain    ${output}    XForces : 0.767431270712
    Should Contain    ${output}    YForces : 0.0962730867259
    Should Contain    ${output}    ZForces : 0.0698242882132
    Should Contain    ${output}    Fx : 0.630058798669
    Should Contain    ${output}    Fy : 0.0679890702621
    Should Contain    ${output}    Fz : 0.356239851428
    Should Contain    ${output}    Mx : 0.377273693569
    Should Contain    ${output}    My : 0.482587737212
    Should Contain    ${output}    Mz : 0.444648176711
    Should Contain    ${output}    ForceMagnitude : 0.208376377656
    Should Contain    ${output}    priority : 0.839092870555
