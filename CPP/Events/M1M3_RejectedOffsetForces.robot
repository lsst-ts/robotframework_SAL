*** Settings ***
Documentation    M1M3_RejectedOffsetForces sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    RejectedOffsetForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 40.2166 0.11746440054 0.948680776814 0.922610250526 0.787038450045 0.253708889693 0.636001503071 0.160440952112 0.446529744969 0.0868030794007 0.36070883718 0.859387286277 0.207107618917 0.316679053974 0.259145479161 0.727497024956 0.780667639535 0.0176189823849 0.905068113911 0.797019836894 0.572611130931 0.429948956905 0.958591785168 0.224832468407 0.494882792406 0.742395761685 0.00196773694882 0.129271092803 0.124926286466 0.505425372902 0.831315759289 0.66849921736 0.589628595524 0.765844917428 0.291418225939 0.355576416935 0.694023026286 0.988287163936 0.857947120225 0.543065366501 0.243243366123 0.99470188792 0.880365284651 0.216043866997 0.965929195267 0.703233579154 0.899419931537 0.738401893565 0.40307131692 0.772786562989 0.232508271813 0.917167664821 0.0934382141797 0.0287202895908 0.333971145728 0.115334240989 0.785793678421 0.789790792898 0.343415698109 0.710897165187 0.0855444408034 0.185197659063 0.887174709577 0.970490316233 0.543863730271 0.716144164519 0.742302708946 0.493775427646 0.134962862316 0.724317928293 0.849857693012 0.055344416507 0.809692355406 0.138424768209 0.313274306261 0.908473440147 0.917946022921 0.758670156184 0.920456209263 0.667548172411 0.288393289212 0.0774277393232 0.207380727443 0.704021099198 0.12839564425 0.526391582981 0.597658036475 0.296676011259 0.426856595053 0.197508884991 0.52316342979 0.413123417429 0.0492937083086 0.0614052469612 0.6995945819 0.734090935044 0.571684385944 0.573884155834 0.427113068156 0.598225133457 0.0500915188737 0.585145673101 0.892318869961 0.79023297488 0.447067220159 0.271852198919 0.554919874966 0.351401474496 0.907938350949 0.20289508302 0.184805631236 0.892898398304 0.00415251576715 0.0452356209426 0.542717746252 0.58701721187 0.207373819036 0.760063209673 0.0731677435605 0.848909380948 0.535332282964 0.730720775277 0.643364848487 0.510291467272 0.539361439984 0.747339006452 0.0788460029927 0.778463969805 0.573248350037 0.636070321301 0.21488759141 0.488097088437 0.886661816388 0.126486298888 0.625918126008 0.156393045369 0.828956156466 0.238367108199 0.955558437713 0.96356361527 0.587510548752 0.454737233738 0.357896019817 0.954212935171 0.517949912403 0.468797637868 0.00763008942297 0.443772201098 0.975910218385 0.0271406398263 0.412325469736 0.0916605682951 0.713161987712 0.805303047431 0.25851602616 0.56434181584 0.312975607798 0.580188482609 0.278241778852 0.877936520539 0.336279220896 0.795187861342 0.480804411193 0.872742256611 0.180073955264 0.851603982646 0.333200162748 0.208157002109 0.0603930069925 0.724953545057 0.825989971611 0.916001061878 0.554821051986 0.54528304784 0.550915555681 0.0420449480798 0.259388772778 0.96063938151 0.231953031823 0.403449955744 0.426366088783 0.853253146399 0.350775822628 0.712813351677 0.234832987473 0.0458312947617 0.207719285712 0.589629273804 0.18985461666 0.0816558570199 0.218249892306 0.653885209241 0.681262889935 0.669391506876 0.153663151 0.833306962902 0.547888829447 0.152030136218 0.27904424803 0.605922650961 0.292182794447 0.928706931156 0.535759001514 0.705939093703 0.20359762126 0.492968627995 0.237941717636 0.142702567319 0.151995903584 0.957655998697 0.617364198528 0.141098529694 0.926915615055 0.887744665496 0.0423934752156 0.678871087694 0.340045610879 0.168971795436 0.609379625771 0.914646116221 0.0447795529951 0.870605372085 0.0616055310291 0.492882412822 0.212292881091 0.0131945068623 0.535244399391 0.505865729314 0.622590909018 0.767198997969 0.980717979664 0.944466476284 0.911853178229 0.0763031287004 0.37273287823 0.804389860111 0.65867829818 0.345217723345 0.407882091223 0.482591326529 0.207098280119 0.659000328147 0.394559923006 0.36460291196 0.116833626508 0.985378596926 0.599508140329 0.132622662276 0.704802149842 0.877204897117 0.194706621826 0.778050535856 0.193493712649 0.713214498573 0.0351303371648 0.362486820451 0.70988558246 0.80101863827 0.135406731852 0.925567806369 0.15429116993 0.091799435813 0.78160513263 0.589752735102 0.371251517511 0.687301068505 0.211476522906 0.872594412428 0.485223370143 0.0519135281492 0.210196089381 0.846828228027 0.175600288889 0.925922300266 0.739165522419 0.610881182537 -285713616
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedOffsetForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedOffsetForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -285713616
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedOffsetForces received =     1
    Should Contain    ${output}    Timestamp : 40.2166
    Should Contain    ${output}    XForces : 0.11746440054
    Should Contain    ${output}    YForces : 0.948680776814
    Should Contain    ${output}    ZForces : 0.922610250526
    Should Contain    ${output}    Fx : 0.787038450045
    Should Contain    ${output}    Fy : 0.253708889693
    Should Contain    ${output}    Fz : 0.636001503071
    Should Contain    ${output}    Mx : 0.160440952112
    Should Contain    ${output}    My : 0.446529744969
    Should Contain    ${output}    Mz : 0.0868030794007
    Should Contain    ${output}    ForceMagnitude : 0.36070883718
    Should Contain    ${output}    priority : 0.859387286277
