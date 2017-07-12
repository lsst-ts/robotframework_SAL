*** Settings ***
Documentation    TCS_InternalCommand sender/logger tests.
Force Tags    python
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : CommandObject priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py a y Y U l H S K q W A R T a F A j X k D X I t O A X A R u S a N q g m I Z Z j v v L D M C M U L K t Z B B s U u L O D g g U b Z q b O x U A i h t U h R q J r h B i J h g W j w o d g j M p z C B h W Q e H S a w c i x e K b I y b C g r F r q Q o j m F J a j P G b r q G a S X M g f j Q m K g f z E R v U P v g h p U N l L o H H i U g R e K a Y S G x j p r t O m u M b a O Y N m y h l c G M H L n Z p w z t P e g Q W r S V Y k j v B Y B R Q i K V C V l x z l Y T i x e D c M X S a R M g s M j B B g O V H m t F j C S x a R c w f d O u o K t p h v S M J v o m A M m v L z F s e Z W k X n i v X T J P U V F R h S a f b u n v x P J V o n Q F b k Q O l o q q v e J j p d z P a o Q j A b X b J U f J j f t R k E t b J I r A k L j H A J Z Y W b z P h H Z s a K y N L e X p n w F y V X j q k B V Z M Y Z T L h o L F c U d t k B h w n C d h C g G Z D r o Z q s m S v E H d F w B r h y a M b T a x F W E e P r J N S x t t y k T s M I K Y F Q e w x W o T L j J t Q S r p e g o t y U d p O Y X e P U s J u g C z N u J q e L y u W H y W S b q J v j S m t o H x R K Z q g o W L L f u J Q I h Q h C p G t G T D E R R f w W B d i C H U y t h n K r P F h k m e N Y o E S v v j c W Z F X o U B h i I M p U z b Z c Y A F y p K d b I P K h n J L H c t e O K y o s x P L g i L X K I e y J u e a o W h F b D I w j s b i e Q i X K f X K d D B X K j N w y k Z y s r u G k o M l l Q C t T H V A A s I f o t N l w Q I V C e m Q e X e g i h L j E b M E n g a M z l w N P V R l c I D u g v r s P t P z C Z t W m O I n g x o R R c D e s p b S Y h b P u V J O P f f e B U B M O h M T V T L z y r Q x F I C E m j m w T c K r T C z q o c Q c J Q m V X K g T D K e N u V e d c D c d T H q s E N l P z C r x m F Q b i v Q j E y T w f f H D H G j p K F I V S v n F h a o J P I B a P J x q e L p O r U Z t I p t z S M U H I q V M u G L l q A n B R r z K d f o S E L P e t e g Y d e R v u k t Y Z d u M g d q J X C m d q D l q z o E f u j C U N f N u q B M J P f q A F I b a D k U e Q u H J S h b O o G Y Z k v z m v v q u J Z I b q w y S -502370670
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] tcs::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
