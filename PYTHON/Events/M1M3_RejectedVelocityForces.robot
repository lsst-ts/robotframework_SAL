*** Settings ***
Documentation    M1M3_RejectedVelocityForces sender/logger tests.
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
${component}    RejectedVelocityForces
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp XForces YForces ZForces Fx Fy Fz Mx My Mz ForceMagnitude priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 70.2312 0.202492154787 0.514503827314 0.339840557045 0.0848062264444 0.0906507491793 0.354889556987 0.629419396898 0.704816199383 0.455429555936 0.700259781623 0.988169482241 0.0654215694815 0.747928563568 0.793481430615 0.258273053956 0.710994977523 0.205124990865 0.577199873067 0.908332376092 0.753334712341 0.724706623385 0.737095733652 0.688281091837 0.915893733786 0.777545410929 0.895126737633 0.951653532075 0.61408572285 0.0736337524218 0.261383192028 0.284811519658 0.308430553551 0.756357822928 0.173009284903 0.193885570555 0.477322397596 0.753971345912 0.0944297142281 0.838643760114 0.219815201282 0.464568463029 0.241452990109 0.951043051487 0.276587859217 0.865831803063 0.446328084029 0.557260183951 0.944578268939 0.295854973925 0.980157035337 0.477709206884 0.598365329631 0.738863697905 0.244028188573 0.489090890187 0.115532824809 0.472693195855 0.0588993574462 0.418906700174 0.864156158095 0.301529286215 0.418063149368 0.386642634916 0.494747734487 0.766899646571 0.0190358986154 0.976486503703 0.693766230731 0.365906655882 0.17437399711 0.635888432144 0.974187277268 0.90814489314 0.104173186584 0.436361795136 0.930128408363 0.596272697728 0.647454319554 0.942973357464 0.376819836078 0.916347532782 0.799171998818 0.753950704903 0.894903974011 0.799377638258 0.998679877205 0.350048401854 0.374253476531 0.569181392039 0.243300693932 0.2277788752 0.693007534801 0.819389512702 0.0575746511079 0.928989762903 0.411650667372 0.962435713299 0.806165156319 0.205028922631 0.122328588982 0.851279245774 0.445050705759 0.00505733405612 0.165305172168 0.100134614721 0.491780888259 0.269827617889 0.102143465954 0.267428022959 0.492891575476 0.530923107605 0.581723565849 0.383699289713 0.466614775012 0.759740401639 0.0312849181887 0.218036849958 0.622482418614 0.977080066097 0.973689090132 0.0236246841585 0.335025766622 0.115769445255 0.377294324721 0.841769584404 0.982033952907 0.287267622079 0.606203547431 0.078727653619 0.169249316742 0.806913995267 0.947947245818 0.157054268803 0.429039536207 0.619594500175 0.678245038316 0.789248857907 0.366693457334 0.0858742632871 0.600891571856 0.942985617067 0.573364138984 0.0571735123237 0.465968357069 0.921308129284 0.899570534469 0.235531020842 0.311579812363 0.508361736185 0.904772055696 0.478325039766 0.845832924466 0.600272198225 0.837842153061 0.46720322935 0.941170452416 0.814399194629 0.422649726737 0.484976292831 0.399432050804 0.319182467046 0.723707183013 0.0016846059702 0.574768187097 0.577541202029 0.638027292845 0.0523995901525 0.173438032088 0.713104547342 0.433253251708 0.753881671763 0.984882132676 0.90563515164 0.478577455087 0.392810959885 0.221390336631 0.0567755062199 0.594451854827 0.95738143973 0.847684518996 0.718657269753 0.79598925227 0.872520487247 0.533014316656 0.897534924832 0.427852816738 0.392499227049 0.307301350202 0.165194321302 0.52107727763 0.065890597475 0.51085141372 0.423572828459 0.065976475981 0.162249507485 0.872022281138 0.413019924935 0.513791150606 0.0772359289492 0.7352844799 0.381073176243 0.35009019953 0.17907599814 0.252789081999 0.302060731014 0.0706790772585 0.702418987247 0.0721205961446 0.977788468291 0.0121063440659 0.0381570426247 0.748927954215 0.704920440308 0.526775946536 0.181439162983 0.582186499196 0.32886866529 0.0976875041338 0.371840524791 0.659764746869 0.831199919937 0.76186906232 0.645140059388 0.981839418483 0.928725903908 0.0759882711865 0.595299958945 0.527318065585 0.443859106814 0.312023198926 0.0339188478874 0.391918850865 0.273092443669 0.0988533116434 0.850952317475 0.686691524338 0.185476309444 0.551898409821 0.665938004309 0.282651990116 0.584743219289 0.0527565217417 0.0464038616999 0.4018908255 0.370231638169 0.677664701041 0.111587934989 0.284939298377 0.139988349471 0.322062858741 0.336754295453 0.677655554189 0.658334942734 0.142060579805 0.701282803922 0.66539057086 0.996280765918 0.871865661649 0.873822165283 0.661682466137 0.736109142556 0.459636383875 0.826252384767 0.66691451334 0.919347863391 0.477723749656 0.166090940291 0.0447379788964 0.74637724629 0.91777470178 0.853507694843 0.802984462763 0.566678180483 0.00624018004001 0.815985783761 113359017
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedVelocityForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
*** Settings ***
Documentation    M1M3_RejectedVelocityForces communications tests.
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
${component}    RejectedVelocityForces
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp XForces YForces ZForces Fx Fy Fz Mx My Mz ForceMagnitude priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 20.9354 0.361107 0.928165 0.177248 0.672786 0.021464 0.679663 0.030175 0.931665 0.316426 0.374941 0.447929 0.856028 0.167136 0.952181 0.337935 0.065478 0.559259 0.784954 0.01992 0.129127 0.191936 0.324147 0.900518 0.184144 0.42269 0.599167 0.301422 0.080753 0.821555 0.314013 0.802804 0.997537 0.462067 0.399896 0.50063 0.343988 0.794771 0.248891 0.182037 0.613056 0.696295 0.831272 0.554287 0.979048 0.877582 0.975292 0.019089 0.883372 0.9842 0.381754 0.00535 0.959904 0.099154 0.825788 0.163529 0.350371 0.065929 0.088905 0.795226 0.516322 0.411507 0.678586 0.576897 0.240908 0.120609 0.437371 0.132022 0.068482 0.469942 0.333204 0.696268 0.555275 0.88495 0.206675 0.617773 0.963726 0.58144 0.875067 0.389271 0.932762 0.677117 0.654159 0.869557 0.972283 0.982884 0.620152 0.748397 0.991201 0.643188 0.664877 0.920359 0.750983 0.72097 0.619697 0.316715 0.946304 0.531887 0.197406 0.869423 0.483046 0.265998 0.665708 0.057596 0.286269 0.566999 0.60744 0.468675 0.325669 0.195794 0.134304 0.57241 0.927378 0.782318 0.845158 0.769245 0.419612 0.525517 0.254351 0.987192 0.407206 0.832444 0.293746 0.471721 0.96318 0.842516 0.915839 0.114201 0.855621 0.267067 0.088499 0.407756 0.45613 0.709776 0.840045 0.252008 0.634061 0.088267 0.395153 0.5595 0.90472 0.757447 0.494488 0.677006 0.224105 0.520639 0.650218 0.175219 0.180925 0.27393 0.131073 0.150824 0.778133 0.972066 0.393769 0.212442 0.550547 0.811393 0.017247 0.892876 0.633587 0.443594 0.088165 0.642216 0.228328 0.047704 0.094409 0.015445 0.824829 0.321006 0.514558 0.739035 0.165992 0.040598 0.349765 0.845275 0.688275 0.024154 0.296315 0.20549 0.643953 0.662134 0.156045 0.37346 0.517962 0.31859 0.734406 0.713567 0.657332 0.507082 0.345306 0.422743 0.591871 0.481416 0.450515 0.822263 0.050589 0.924442 0.041122 0.558658 0.681871 0.176274 0.666843 0.034773 0.570698 0.529824 0.206145 0.118556 0.574337 0.879288 0.680328 0.87488 0.250623 0.422701 0.358466 0.788722 0.905775 0.452292 0.618496 0.675571 0.028856 0.681458 0.081375 0.782401 0.725785 0.422631 0.742054 0.219342 0.971576 0.732315 0.019471 0.311992 0.266563 0.950306 0.679122 0.79659 0.731257 0.676091 0.775182 0.043362 0.330951 0.017977 0.641902 0.095414 0.3891 0.80562 0.147394 0.732221 0.642823 0.22123 0.640651 0.894499 0.25283 0.331046 0.577994 0.797036 0.572393 0.572595 0.842355 0.029925 0.629171 0.447146 0.850128 0.924681 0.093838 0.325013 0.706774 0.243128 0.488305 0.756718 0.216482 0.78852 0.763971 0.462419 0.900734 0.363496 -1857733074
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedVelocityForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1