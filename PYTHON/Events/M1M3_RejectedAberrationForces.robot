*** Settings ***
Documentation    M1M3_RejectedAberrationForces sender/logger tests.
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
${component}    RejectedAberrationForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 45.6895 0.623500047822 0.388859956069 0.214035094177 0.788694340775 0.364436738227 0.301278013984 0.47901594737 0.178524107875 0.223074891816 0.669487234085 0.491747908787 0.24099589175 0.00190598807388 0.407684292117 0.50744672289 0.0076180250736 0.176193891036 0.27409330404 0.813501570656 0.709770480176 0.0623049182902 0.960283160587 0.824352500502 0.853493904869 0.766781190914 0.214569423736 0.666421064666 0.474502058945 0.561043728319 0.444646836814 0.991409309022 0.777131997064 0.390679810415 0.907861217068 0.889308590506 0.251943901892 0.0485098234194 0.736869585639 0.284164597783 0.944299199782 0.31668330676 0.375559998426 0.38968714027 0.2195649879 0.939270580275 0.247543273952 0.0190155169695 0.731933390732 0.854290550714 0.77025444704 0.38101146589 0.147454669851 0.255836118193 0.175674296174 0.864762757239 0.599308246462 0.888738125801 0.622820540648 0.533622795829 0.210551048618 0.0899637012426 0.506638981864 0.94089160292 0.808845274221 0.704813799271 0.230765930259 0.764164726618 0.0679131260719 0.30025177848 0.496685619779 0.616642992736 0.175225602603 0.856146732282 0.0155426382469 0.668544512529 0.704307330454 0.912693241173 0.0351345666902 0.566105973149 0.22916817641 0.922361390225 0.704978909059 0.862063367291 0.513277988166 0.842321163509 0.448966995537 0.201013122542 0.761769401725 0.42045919663 0.0915852212313 0.892184425083 0.133243569766 0.3231727906 0.883458193236 0.1527743638 0.945313329004 0.0387563128126 0.997408391232 0.0900816259046 0.664212510101 0.828411162349 0.566460114777 0.183143248842 0.400967120674 0.241529413903 0.898125832974 0.428757857213 0.685055327513 0.820847263865 0.065636777064 0.534728731214 0.137095099005 0.783823520962 0.733167387661 0.437239156086 0.486276223965 0.622542105337 0.34725091206 0.160616582725 0.2588667493 0.589793517517 0.668996666511 0.472715220168 0.234527409237 0.596181511039 0.532196266977 0.525091543016 0.662941321543 0.00804287213308 0.87311917347 0.32423662684 0.190858012687 0.669318273542 0.555236080954 0.157937988093 0.948568312121 0.297298458675 0.308627891803 0.000624123336459 0.279196215987 0.993747914851 0.520038820867 0.610738758218 0.149571865611 0.802935587979 0.498906020062 0.958082949862 0.733769612197 0.0923977635105 0.0347783348988 0.0871086504013 0.861675830874 0.0919425739439 0.716247948117 0.0687273886709 0.831652468256 0.525901253659 0.887119239007 0.67586228424 2038638739
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedAberrationForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
