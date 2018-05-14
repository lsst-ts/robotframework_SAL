*** Settings ***
Documentation    Hexapod_configureAzimuthRawLUT commander/controller tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    hexapod
${component}    configureAzimuthRawLUT
${timeout}    30s

*** Test Cases ***
Verify Component Commander and Controller
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_${component}.py

Start Commander - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments :

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -28676 20023 -20199 26975 -17959 12349 30537 6572 8279 -16180 20577 -11296 -29715 10113 -27827 18077 -7084 -17923 -28945 -3359 26829 -3165 -572 -3130 -23236 29802 17560 26113 5388 22909 13159 -26285 5130 -26387 -30905 22433 22363 0.299168573472 0.0434006384108 0.367690974884 0.933921460629 0.497504328551 0.425943162402 0.0197923798309 0.557302680804 0.26847778814 0.0372610761538 0.182079559481 0.825089151168 0.819462375858 0.133660670888 0.0675997219694 0.147447540418 0.350810312887 0.7882452477 0.87856594008 0.83856745613 0.67183940846 0.281523026945 0.414629893523 0.347766803188 0.707709399998 0.333696319816 0.0846304674501 0.748300437327 0.232722328589 0.615604721151 0.793661394073 0.6760058867 0.399009224346 0.0279988067478 0.343775651385 0.244077554347 0.166295416796 0.386375257178 0.339851017052 0.443543087414 0.740026069994 0.339846361432 0.581134185224 0.937850686517 0.414853340293 0.173344696519 0.395198969694 0.573851342613 0.394263703241 0.993399607047 0.482701826208 0.81058162688 0.164206857257 0.918087591507 0.0176807863873 0.850070463381 0.087300568518 0.294113079752 0.705569189596 0.238080882859 0.81416930946 0.273774558094 0.013967077428 0.124511711503 0.69202771665 0.874444206875 0.784253928067 0.756699750437 0.0558170998403 0.075805200121 0.785859362006 0.274626113524 0.741545271147 0.0567247709115 0.363065438 0.164759999056 0.0907962536003 0.342379873715 0.09849974614 0.911674412942 0.107665951903 0.768194777937 0.00589448686024 0.965493570237 0.952218972282 0.0132348586988 0.215757449576 0.133527292541 0.724935873169 0.649695296026 0.00760018633478 0.0293736773889 0.204377672289 0.791603714527 0.773326746552 0.488285466432 0.559048977748 0.330803133744 0.469170188721 0.414929031833 0.823717453915 0.167661431506 0.976386219406 0.719081106514 0.665851446353 0.195336432452 0.550550616571 0.990638624514 0.215542956597 0.0788322780357 0.224688039582 0.233985084429 0.102444866128 0.444354300658 0.0634833277805 0.738102850377 0.348680108152 0.0652335901853 0.127586723369 0.444551550131 0.403568101931 0.582376256554 0.15330369985 0.358589452443 0.83296241886 0.174864735723 0.707886453 0.290666767798 0.666600695022 0.14856876893 0.613347531142 0.690495824334 0.908813855472 0.54152303305 0.752257049069 0.892852451486 0.915212391899 0.121955067225 0.857203558611 0.660200988539 0.0124019702123 0.560850947057 0.733612556512 0.932285166898 0.579053048863 0.0276768900225 0.0163249336249 0.103610103977 0.574368721189 0.130975762196 0.679096763802 0.511777967183 0.561839600142 0.885181873374 0.00182043143412 0.617123393898 0.860863341332 0.91508800562 0.0721116438584 0.000645686751786 0.078433384834 0.00158183184767 0.714995507408 0.624959780852 0.121792280644 0.818784721297 0.408903920585 0.0657315068478 0.764674040849 0.202817650848 0.0980746588395 0.598959076522 0.454929453302 0.672017529349 0.39103433866 0.0139971499895 0.403457264121 0.450543652623 0.861314743812 0.0858556823166 0.734172612224 0.08003083905 0.935385121416 0.339862150584 0.95379974754 0.926605411581 0.961389086197 0.959203762882 0.856651579631 0.0178765370979 0.400782238312 0.0674495813131 0.0790494131327 0.241755822331 0.817980981385 0.205841418553 0.18581587307 0.877234357754 0.394452584668 0.753076516447 0.0194694660389 0.302138406583 0.860848999215 0.75567200884 0.526814280083 0.980387579914 0.313982501557 0.0362047228059 0.651920727496 0.852694752842 0.294784020028 0.451230349831 0.550951775585 0.659505073572 0.859704040462 0.602113006193 0.738443168835 0.54290795123 0.994372242475 0.171713174971 0.131996443522 0.830606841999
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Controller.
    ${input}=    Write    python ${subSystem}_Controller_${component}.py
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Commander.
    ${input}=    Write    python ${subSystem}_Commander_${component}.py -28676 20023 -20199 26975 -17959 12349 30537 6572 8279 -16180 20577 -11296 -29715 10113 -27827 18077 -7084 -17923 -28945 -3359 26829 -3165 -572 -3130 -23236 29802 17560 26113 5388 22909 13159 -26285 5130 -26387 -30905 22433 22363 0.299168573472 0.0434006384108 0.367690974884 0.933921460629 0.497504328551 0.425943162402 0.0197923798309 0.557302680804 0.26847778814 0.0372610761538 0.182079559481 0.825089151168 0.819462375858 0.133660670888 0.0675997219694 0.147447540418 0.350810312887 0.7882452477 0.87856594008 0.83856745613 0.67183940846 0.281523026945 0.414629893523 0.347766803188 0.707709399998 0.333696319816 0.0846304674501 0.748300437327 0.232722328589 0.615604721151 0.793661394073 0.6760058867 0.399009224346 0.0279988067478 0.343775651385 0.244077554347 0.166295416796 0.386375257178 0.339851017052 0.443543087414 0.740026069994 0.339846361432 0.581134185224 0.937850686517 0.414853340293 0.173344696519 0.395198969694 0.573851342613 0.394263703241 0.993399607047 0.482701826208 0.81058162688 0.164206857257 0.918087591507 0.0176807863873 0.850070463381 0.087300568518 0.294113079752 0.705569189596 0.238080882859 0.81416930946 0.273774558094 0.013967077428 0.124511711503 0.69202771665 0.874444206875 0.784253928067 0.756699750437 0.0558170998403 0.075805200121 0.785859362006 0.274626113524 0.741545271147 0.0567247709115 0.363065438 0.164759999056 0.0907962536003 0.342379873715 0.09849974614 0.911674412942 0.107665951903 0.768194777937 0.00589448686024 0.965493570237 0.952218972282 0.0132348586988 0.215757449576 0.133527292541 0.724935873169 0.649695296026 0.00760018633478 0.0293736773889 0.204377672289 0.791603714527 0.773326746552 0.488285466432 0.559048977748 0.330803133744 0.469170188721 0.414929031833 0.823717453915 0.167661431506 0.976386219406 0.719081106514 0.665851446353 0.195336432452 0.550550616571 0.990638624514 0.215542956597 0.0788322780357 0.224688039582 0.233985084429 0.102444866128 0.444354300658 0.0634833277805 0.738102850377 0.348680108152 0.0652335901853 0.127586723369 0.444551550131 0.403568101931 0.582376256554 0.15330369985 0.358589452443 0.83296241886 0.174864735723 0.707886453 0.290666767798 0.666600695022 0.14856876893 0.613347531142 0.690495824334 0.908813855472 0.54152303305 0.752257049069 0.892852451486 0.915212391899 0.121955067225 0.857203558611 0.660200988539 0.0124019702123 0.560850947057 0.733612556512 0.932285166898 0.579053048863 0.0276768900225 0.0163249336249 0.103610103977 0.574368721189 0.130975762196 0.679096763802 0.511777967183 0.561839600142 0.885181873374 0.00182043143412 0.617123393898 0.860863341332 0.91508800562 0.0721116438584 0.000645686751786 0.078433384834 0.00158183184767 0.714995507408 0.624959780852 0.121792280644 0.818784721297 0.408903920585 0.0657315068478 0.764674040849 0.202817650848 0.0980746588395 0.598959076522 0.454929453302 0.672017529349 0.39103433866 0.0139971499895 0.403457264121 0.450543652623 0.861314743812 0.0858556823166 0.734172612224 0.08003083905 0.935385121416 0.339862150584 0.95379974754 0.926605411581 0.961389086197 0.959203762882 0.856651579631 0.0178765370979 0.400782238312 0.0674495813131 0.0790494131327 0.241755822331 0.817980981385 0.205841418553 0.18581587307 0.877234357754 0.394452584668 0.753076516447 0.0194694660389 0.302138406583 0.860848999215 0.75567200884 0.526814280083 0.980387579914 0.313982501557 0.0362047228059 0.651920727496 0.852694752842 0.294784020028 0.451230349831 0.550951775585 0.659505073572 0.859704040462 0.602113006193 0.738443168835 0.54290795123 0.994372242475 0.171713174971 0.131996443522 0.830606841999
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device :    1
    Should Contain X Times    ${output}    property :    1
    Should Contain X Times    ${output}    action :    1
    Should Contain X Times    ${output}    value :    1
    Should Contain X Times    ${output}    azIndex : -28676    1
    Should Contain X Times    ${output}    fz1 : 0.299168573472    1
    Should Contain X Times    ${output}    fz2 : 0.386375257178    1
    Should Contain X Times    ${output}    fz3 : 0.363065438    1
    Should Contain X Times    ${output}    fz4 : 0.233985084429    1
    Should Contain X Times    ${output}    fz5 : 0.574368721189    1
    Should Contain X Times    ${output}    fz6 : 0.926605411581    1
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain X Times    ${output}    azIndex(37) = [-28676, 20023, -20199, 26975, -17959, 12349, 30537, 6572, 8279, -16180, 20577, -11296, -29715, 10113, -27827, 18077, -7084, -17923, -28945, -3359, 26829, -3165, -572, -3130, -23236, 29802, 17560, 26113, 5388, 22909, 13159, -26285, 5130, -26387, -30905, 22433, 22363]    1
    Should Contain X Times    ${output}    fz1(37) = [0.299168573472, 0.0434006384108, 0.367690974884, 0.933921460629, 0.497504328551, 0.425943162402, 0.0197923798309, 0.557302680804, 0.26847778814, 0.0372610761538, 0.182079559481, 0.825089151168, 0.819462375858, 0.133660670888, 0.0675997219694, 0.147447540418, 0.350810312887, 0.7882452477, 0.87856594008, 0.83856745613, 0.67183940846, 0.281523026945, 0.414629893523, 0.347766803188, 0.707709399998, 0.333696319816, 0.0846304674501, 0.748300437327, 0.232722328589, 0.615604721151, 0.793661394073, 0.6760058867, 0.399009224346, 0.0279988067478, 0.343775651385, 0.244077554347, 0.166295416796]    1
    Should Contain X Times    ${output}    fz2(37) = [0.386375257178, 0.339851017052, 0.443543087414, 0.740026069994, 0.339846361432, 0.581134185224, 0.937850686517, 0.414853340293, 0.173344696519, 0.395198969694, 0.573851342613, 0.394263703241, 0.993399607047, 0.482701826208, 0.81058162688, 0.164206857257, 0.918087591507, 0.0176807863873, 0.850070463381, 0.087300568518, 0.294113079752, 0.705569189596, 0.238080882859, 0.81416930946, 0.273774558094, 0.013967077428, 0.124511711503, 0.69202771665, 0.874444206875, 0.784253928067, 0.756699750437, 0.0558170998403, 0.075805200121, 0.785859362006, 0.274626113524, 0.741545271147, 0.0567247709115]    1
    Should Contain X Times    ${output}    fz3(37) = [0.363065438, 0.164759999056, 0.0907962536003, 0.342379873715, 0.09849974614, 0.911674412942, 0.107665951903, 0.768194777937, 0.00589448686024, 0.965493570237, 0.952218972282, 0.0132348586988, 0.215757449576, 0.133527292541, 0.724935873169, 0.649695296026, 0.00760018633478, 0.0293736773889, 0.204377672289, 0.791603714527, 0.773326746552, 0.488285466432, 0.559048977748, 0.330803133744, 0.469170188721, 0.414929031833, 0.823717453915, 0.167661431506, 0.976386219406, 0.719081106514, 0.665851446353, 0.195336432452, 0.550550616571, 0.990638624514, 0.215542956597, 0.0788322780357, 0.224688039582]    1
    Should Contain X Times    ${output}    fz4(37) = [0.233985084429, 0.102444866128, 0.444354300658, 0.0634833277805, 0.738102850377, 0.348680108152, 0.0652335901853, 0.127586723369, 0.444551550131, 0.403568101931, 0.582376256554, 0.15330369985, 0.358589452443, 0.83296241886, 0.174864735723, 0.707886453, 0.290666767798, 0.666600695022, 0.14856876893, 0.613347531142, 0.690495824334, 0.908813855472, 0.54152303305, 0.752257049069, 0.892852451486, 0.915212391899, 0.121955067225, 0.857203558611, 0.660200988539, 0.0124019702123, 0.560850947057, 0.733612556512, 0.932285166898, 0.579053048863, 0.0276768900225, 0.0163249336249, 0.103610103977]    1
    Should Contain X Times    ${output}    fz5(37) = [0.574368721189, 0.130975762196, 0.679096763802, 0.511777967183, 0.561839600142, 0.885181873374, 0.00182043143412, 0.617123393898, 0.860863341332, 0.91508800562, 0.0721116438584, 0.000645686751786, 0.078433384834, 0.00158183184767, 0.714995507408, 0.624959780852, 0.121792280644, 0.818784721297, 0.408903920585, 0.0657315068478, 0.764674040849, 0.202817650848, 0.0980746588395, 0.598959076522, 0.454929453302, 0.672017529349, 0.39103433866, 0.0139971499895, 0.403457264121, 0.450543652623, 0.861314743812, 0.0858556823166, 0.734172612224, 0.08003083905, 0.935385121416, 0.339862150584, 0.95379974754]    1
    Should Contain X Times    ${output}    fz6(37) = [0.926605411581, 0.961389086197, 0.959203762882, 0.856651579631, 0.0178765370979, 0.400782238312, 0.0674495813131, 0.0790494131327, 0.241755822331, 0.817980981385, 0.205841418553, 0.18581587307, 0.877234357754, 0.394452584668, 0.753076516447, 0.0194694660389, 0.302138406583, 0.860848999215, 0.75567200884, 0.526814280083, 0.980387579914, 0.313982501557, 0.0362047228059, 0.651920727496, 0.852694752842, 0.294784020028, 0.451230349831, 0.550951775585, 0.659505073572, 0.859704040462, 0.602113006193, 0.738443168835, 0.54290795123, 0.994372242475, 0.171713174971, 0.131996443522, 0.830606841999]    1
    Should Contain X Times    ${output}    === [ackCommand_configureAzimuthRawLUT] acknowledging a command with :    1
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    1
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
