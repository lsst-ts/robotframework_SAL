*** Settings ***
Documentation    TCS_InternalCommand sender/logger tests.
Force Tags    cpp
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    tcs
${component}    InternalCommand
${timeout}    30s

*** Test Cases ***
Create Sender Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Sender    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

Create Logger Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Logger    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send C m d b s n v y x x V z j c d r c j T j V C W V D q T i v X D d m m D a G n K L r o C C B g u F E a f A X X P D d f H V J x G X c k s l f c y V V t y k V h P F t r f M Q h s c t b E N N r U g G D G a j X S E f F F V a P t n t T w Y I e F m P F f d W J v q h E Y l N b P p f S c U B S j P s U L G D Q z U z Z O v B k o a T A T r U O f v w j B D g J C n R Q H g I W I r t B N Q z X K Y n Y c T b J g h g c s b a f F I s c i N W z t o r t h p F A c R p Y V G b r O G d S C Z q j N K o U D N P b x s i U a d G C f x s T t S G U A H L L R V C Q T r a k Y B E G U y J h w F z c q j F K G i c D B H c s b A f N A r s X b c W r Q i E T g W j r t R o V X G U s n y a n q W j c w G o i N s J A d X G z h i F Y w I Y Z F T A T m x G a r l o D c r c u t i Y M D H L P d Q Q j H k r C Z F v f p b y s I Z A K D G y f I e b V J v a f S B N v Q C F B S b B V y B k p l h D z J A d f J L A G I J c E a a o j m c a N f Q t T U k p Y v g k g P b o d N R b B x v M s a Z F f h A z O p N D Z k p o r T c c W k d f j p C D z U z W g B a g x Y x Z u Q y A I Q J g R v W z t y z U p P F O k T w e f C f Y J L V b g A T B R z U y I B b K A O y L H w P X w c m B C A x q Y l D L M t A T D b m z z d I u z H Z a w p Y h K o x s D T Q J c t R n G J J z s O W C p A s z Q N x G A z U b A f d v K P g V c b k g R z P l O B P p Z v n s h v j S e d i D y D B N m y Z m v h E o g e o f t z Q G F s i K G X q K C v r q Z F S e g u J W M t C V w k R R X W O g y r b K P o D v N U G K F I p w v b W H T T Z w w c T s z u r X g J p V o F i F X v Q N g m F v H u y I K D q f q L M g P W l b Z w v e c n f t w O p N d S g e B q q A w v E S M F b V e m z A A I m R d a I s Y O j v O t E t A X S K v d E W W T i t x g a M b W A C D R E T D C F D j U c P p I S x A B w F i O T m v A i I n Q L t Y c n g F t l K x y q e I q g m y c v W n I E V e S n h R v p n C m l z S E i M N A N c c p D l I K F a q j V w k m B l y k D e z V K y G O K k d Y f W p S o M z W V m i W n y T W s u T o s j h W n V n R M w Y Y o f J k p i w r L r F J e h m c u -1994969639
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] tcs::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1994969639
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : C
    Should Contain    ${output}    priority : m
