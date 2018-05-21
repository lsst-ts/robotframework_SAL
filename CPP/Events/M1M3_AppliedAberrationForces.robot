*** Settings ***
Documentation    M1M3_AppliedAberrationForces sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedAberrationForces
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 39.237 0.994700719663 0.498598766247 0.93915803463 0.633393028553 0.61496996569 0.538744247478 0.479180467753 0.254211212426 0.577455867902 0.0280237496598 0.782003667602 0.361952595861 0.306446256977 0.070698014768 0.88694204039 0.0652862588711 0.95947546777 0.842222264227 0.4253462416 0.292118505596 0.454943863484 0.632639751902 0.548804386736 0.123403190849 0.806336779977 0.51222662088 0.700887879562 0.644996536912 0.0997039302593 0.609190739889 0.212344037359 0.803761495041 0.844927799525 0.46017598099 0.264873204113 0.999076139956 0.822219460866 0.498650277034 0.859906265102 0.85534131815 0.751042556664 0.306232956958 0.634968316881 0.875013813564 0.223508495493 0.255017586118 0.971411580571 0.542906996688 0.237395800183 0.135354494142 0.283060247265 0.87796903742 0.277050103838 0.736375321152 0.191808555643 0.524125677398 0.0439589523486 0.251016820954 0.499084916583 0.008032376518 0.884329652651 0.581801590554 0.311956019627 0.39707026515 0.740737014847 0.113870553593 0.635833272053 0.814953463619 0.833639754412 0.934127571691 0.842704639937 0.857142977733 0.506573922865 0.940609376438 0.654007537894 0.288848625816 0.363609901222 0.898675188384 0.0730296210817 0.983626115978 0.740328097498 0.623952986369 0.0556768100085 0.404446485076 0.0542671170661 0.394802339388 0.227246738483 0.494124489838 0.0710238170385 0.214639378849 0.528710496714 0.227544994374 0.419569708951 0.66792682603 0.843516145245 0.226431586276 0.7833264672 0.0698290210017 0.382971716203 0.032527525466 0.826407269921 0.35262972048 0.0328574969419 0.485474817608 0.96081205285 0.268950190019 0.180794213147 0.430978247601 0.0167131626173 0.101803589284 0.760933555083 0.249188728214 0.81387125273 0.474506534423 0.868652141559 0.830522404284 0.245540944527 0.353089673626 0.373306214578 0.530116228571 0.464651648168 0.318530754614 0.614789837904 0.355107365947 0.498393224331 0.380954671635 0.411770898981 0.243411582558 0.684778475479 0.908680287409 0.081503028524 0.0320280625501 0.813118294301 0.925575098019 0.576435257739 0.0966946645898 0.885078776725 0.677037893816 0.162735430169 0.397086052056 0.169139700001 0.113663191706 0.782754341491 0.505912201777 0.208820502789 0.187437647371 0.319819654543 0.95693124302 0.677569694983 0.929212413315 0.894519391531 0.692078858653 0.183293035384 0.126353806234 0.904995563437 0.408977049869 0.357985074795 0.888991434557 0.00848338486754 -1892262561
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event AppliedAberrationForces generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1892262561
    Log    ${output}
    Should Contain X Times    ${output}    === Event AppliedAberrationForces received =     1
    Should Contain    ${output}    Timestamp : 39.237
    Should Contain    ${output}    ZForces : 0.994700719663
    Should Contain    ${output}    Fz : 0.498598766247
    Should Contain    ${output}    Mx : 0.93915803463
    Should Contain    ${output}    My : 0.633393028553
    Should Contain    ${output}    priority : 0.61496996569
