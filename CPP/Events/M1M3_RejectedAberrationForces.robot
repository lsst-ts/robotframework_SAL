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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 25.0795 0.527394898926 0.00987558770814 0.533698844842 0.0678917104152 0.761502592725 0.205709052454 0.364308366244 0.160969260419 0.65427682802 0.949827572565 0.759947599783 0.929026728584 0.324179196772 0.0440018861538 0.93573795424 0.446065093296 0.94858942769 0.306043190478 0.119207992395 0.937294649995 0.395219262667 0.840046856356 0.253250384406 0.604334142263 0.372405311545 0.547197501283 0.471634104117 0.667901519314 0.440189691702 0.855640962544 0.949873461155 0.574429120372 0.194461548224 0.107462544263 0.239007630983 0.398108564568 0.974354815576 0.787998138864 0.622456795954 0.259531792039 0.669474620628 0.0584064417481 0.0515532274155 0.704210245197 0.540084099586 0.297053587357 0.910896549972 0.0877814655475 0.581210802014 0.342113301351 0.483501048553 0.78954393077 0.178886056042 0.741580112548 0.479301931895 0.861145765121 0.345600524299 0.0214400788851 0.107424116178 0.846368531553 0.605256146464 0.684106803455 0.145437277508 0.333701827606 0.740532980274 0.621727214855 0.224563138892 0.306812427662 0.710155037042 0.727718109202 0.833529344573 0.808953402653 0.166522750385 0.521289563712 0.264695882837 0.738387966258 0.0119812063257 0.485214948576 0.722469955731 0.440607108311 0.049632800045 0.476010430909 0.544302534567 0.372458844708 0.656130205509 0.558514467946 0.383600728639 0.995089556235 0.767654117598 0.547352405527 0.105846811033 0.586885980648 0.268540789136 0.207657768442 0.0987607492664 0.0425055467061 0.302836798479 0.00170810821514 0.353980238355 0.364520308867 0.3160773824 0.515462707901 0.0525490641422 0.289329573401 0.615971615128 0.0548800424393 0.682558157865 0.879310201477 0.411859103824 0.444888790903 0.856183010583 0.76916344739 0.157307996173 0.661844871772 0.865833677262 0.626670170758 0.0555731772008 0.349340251912 0.139970100569 0.0283294385499 0.793624236185 0.132724015035 0.168619579518 0.256470659045 0.471625480503 0.112103855142 0.0554346361763 0.756716901143 0.292793539331 0.0345676907864 0.862137377913 0.565241438265 0.425468792558 0.253761881825 0.152221293132 0.838197813273 0.934352184213 0.225479668431 0.232870077526 0.149954577192 0.053577069016 0.425052996885 0.0756729578147 0.83429487115 0.591171959296 0.555067009979 0.383524854711 0.301024019337 0.544188346886 0.266852951033 0.0348330104676 0.793853587157 0.418708083441 0.75930518045 0.111740062884 0.427348940997 0.495071601273 0.109420404601 0.545496360662 1165872410
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event RejectedAberrationForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1165872410
    Log    ${output}
    Should Contain X Times    ${output}    === Event RejectedAberrationForces received =     1
    Should Contain    ${output}    Timestamp : 25.0795
    Should Contain    ${output}    ZForces : 0.527394898926
    Should Contain    ${output}    Fz : 0.00987558770814
    Should Contain    ${output}    Mx : 0.533698844842
    Should Contain    ${output}    My : 0.0678917104152
    Should Contain    ${output}    priority : 0.761502592725
