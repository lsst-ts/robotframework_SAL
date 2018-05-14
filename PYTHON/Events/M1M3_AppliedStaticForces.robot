*** Settings ***
Documentation    M1M3_AppliedStaticForces sender/logger tests.
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
${component}    AppliedStaticForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 83.7268 0.290539214836 0.354988739438 0.0639893636013 0.532809205457 0.181474370385 0.959693425538 0.903985975137 0.149554904092 0.577982640752 0.123257669488 0.258496405156 0.963915215178 0.398258052259 0.646003904088 0.71833306042 0.671612183154 0.345588801084 0.902261641951 0.701413687891 0.270474572774 0.120792984655 0.578918442259 0.194580573321 0.574416666185 0.91624261448 0.0028593480684 0.554027684146 0.720955333024 0.560108249745 0.426303190944 0.367782665013 0.920463877973 0.382777803124 0.538451419019 0.429770542668 0.209013777776 0.52049711225 0.996107708282 0.714444580414 0.982290285858 0.735908608988 0.856219333017 0.246569389225 0.906657400854 0.116216992645 0.802503477445 0.328832833032 0.146786859554 0.117229173505 0.1421257008 0.707001962975 0.259800895992 0.118803271011 0.579270972305 0.974813723771 0.607872912114 0.307238734383 0.441544702113 0.397470593271 0.580529274149 0.570049051617 0.396366405908 0.606262158734 0.823209551792 0.924007088915 0.761670860798 0.15276195499 0.215380861688 0.177650252554 0.9058938239 0.884934256158 0.610971096087 0.762634169823 0.295131235512 0.937272143933 0.436993078527 0.060040093154 0.912607232692 0.313833418302 0.66854533021 0.825016244278 0.353554889256 0.999467266625 0.546241622219 0.102821555326 0.0797210120911 0.214655408756 0.123907606181 0.9094911313 0.0681904485655 0.562395416195 0.609904158451 0.918618622139 0.888247082077 0.301175946881 0.908424672028 0.19190851964 0.47649010178 5.74709042954e-05 0.79686630565 0.482385026196 0.286713084626 0.824848931602 0.17024782234 0.634585805115 0.336902012391 0.134746637942 0.723640660799 0.480286065099 0.112285636124 0.648518817472 0.176368603437 0.906891784442 0.243474918201 0.764912207826 0.347900665036 0.574075680796 0.93559171135 0.22684335027 0.476638806976 0.6005434367 0.287074338798 0.765211635826 0.282382290873 0.657933619603 0.0474299283589 0.400736029348 0.641523628553 0.210444803296 0.905422144724 0.112121741239 0.394267981025 0.302440356785 0.349152506671 0.418130896238 0.873517092412 0.834231176824 0.660363532647 0.0784107523146 0.687734122743 0.544632318247 0.954056677983 0.719442393884 0.703297980009 0.84940021266 0.297260107879 0.0797949441936 0.916008464778 0.345002940706 0.651309074721 0.738792705902 0.787773407853 0.715840767849 0.273953398534 0.185161328489 0.76939020602 0.712461097145 0.831947726811 0.573603750903 0.114400490779 0.809408779031 0.379575994449 0.876062568264 0.506905555149 0.0598376769679 0.597729278895 0.202383701388 0.971063897471 0.0727474255941 0.960424103623 0.713144459173 0.400976961712 0.67775990558 0.208871211052 0.0957986371381 0.39602710461 0.363746890458 0.528061269667 0.907270683137 0.516913498774 0.184506718608 0.685709131021 0.0425331449224 0.688986489609 0.968799560578 0.573739648693 0.0851082013162 0.794256041977 0.842751991546 0.0770650590317 0.4028702745 0.751927849478 0.04855131914 0.378908964214 0.0594184226175 0.777881554803 0.587492036319 0.617022185045 0.32879779878 0.311279531256 0.812749861873 0.29549549849 0.568761210541 0.846424370422 0.865392135283 0.177431853033 0.7078510481 0.895335141032 0.756003697035 0.853469054016 0.716090556842 0.657421885161 0.955146761071 0.158470228204 0.425513787902 0.558088064365 0.602917634967 0.236058342861 0.777571237338 0.8481665798 0.830316882964 0.262837729404 0.00473713192627 0.381234446141 0.678155446464 0.174906709659 0.103848737903 0.52633992546 0.88704941844 0.786767735225 0.0443602676111 0.863918886481 0.366544077163 0.468381397158 0.253510839482 0.171349679807 0.371764237713 0.0724217192447 0.551497545293 0.775589823489 0.280718633646 0.279729547512 0.0862533834442 0.205739701172 0.317758009795 0.838262237718 0.792345289855 0.2478342911 0.482428248738 0.766975567228 0.652602446881 0.130555456883 0.392757793898 0.725152953181 0.607250538074 0.0733273062153 0.292676153134 0.00382270268509 0.0755219773124 0.660308278311 0.221537912001 0.190131681251 0.908795646834 0.996463950232 0.736363815497 0.0823884107013 0.9370374237 0.774854067046 0.678214533906 0.99716107487 0.923341739006 0.32553568427 0.740642055759 0.67641948131 0.0505880661865 105880016
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedStaticForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
