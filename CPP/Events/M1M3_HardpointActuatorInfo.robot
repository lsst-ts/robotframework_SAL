*** Settings ***
Documentation    M1M3_HardpointActuatorInfo sender/logger tests.
Force Tags    cpp    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    HardpointActuatorInfo
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 0.3601 -6495 -4763 9158 -29640 3045 -508 -1626309036 -1500027997 983979618 1564647291 -202217283 904146972 4882 24003 -2607 -17690 28490 2382 -4041 -11770 3048 -4942 -15066 2113 0.454311242957 0.348471167849 0.934301293002 0.685433911438 0.931537257705 0.589522976809 0.392146070782 0.753497354501 0.875118679445 0.958436538527 0.85670939833 0.310800037817 0.54140280276 0.305162372603 0.207897653121 0.692777763812 0.403571481262 0.268029065136 test test test test test test 26673 -26899 -18182 -19301 -30234 -30927 20010 26501 -13071 24255 4699 7660 31159 10421 15910 22353 32725 -216 -32394 790 28738 29564 -5632 31963 27202 3301 26379 14028 -9265 -27019 -20867 -15683 17432 -21301 -11548 -7930 11 -26305 5581 -16941 -10957 -25065 0.856640954248 0.316819074577 0.626478799559 0.390105846494 0.425667548934 0.862827404875 0.445799575198 0.09504206732 0.952335531676 0.450940288775 0.101444868763 0.275156990947 0.00597450635388 0.996690496769 0.874735702691 0.153378105219 0.977858036991 0.586130507023 0.443219018206 0.0889530395595 0.275478912218 0.479847304084 0.259397804391 0.522426600022 0.828296258285 0.510587534059 0.671849563229 0.786139188725 0.625214256314 0.389405934148 0.613520250083 0.242571240887 0.864603872613 0.974520825668 0.535804763688 0.81721095689 -918162378
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointActuatorInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event HardpointActuatorInfo generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -918162378
    Log    ${output}
    Should Contain X Times    ${output}    === Event HardpointActuatorInfo received =     1
    Should Contain    ${output}    Timestamp : 0.3601
    Should Contain    ${output}    ReferenceId : -6495
    Should Contain    ${output}    ReferencePosition : -4763
    Should Contain    ${output}    ModbusSubnet : 9158
    Should Contain    ${output}    ModbusAddress : -29640
    Should Contain    ${output}    XPosition : 3045
    Should Contain    ${output}    YPosition : -508
    Should Contain    ${output}    ZPosition : -1626309036
    Should Contain    ${output}    ILCUniqueId : -1500027997
    Should Contain    ${output}    ILCApplicationType : 983979618
    Should Contain    ${output}    NetworkNodeType : 1564647291
    Should Contain    ${output}    ILCSelectedOptions : -202217283
    Should Contain    ${output}    NetworkNodeOptions : 904146972
    Should Contain    ${output}    MajorRevision : 4882
    Should Contain    ${output}    MinorRevision : 24003
    Should Contain    ${output}    ADCScanRate : -2607
    Should Contain    ${output}    MainLoadCellCoefficient : -17690
    Should Contain    ${output}    MainLoadCellOffset : 28490
    Should Contain    ${output}    MainLoadCellSensitivity : 2382
    Should Contain    ${output}    BackupLoadCellCoefficient : -4041
    Should Contain    ${output}    BackupLoadCellOffset : -11770
    Should Contain    ${output}    BackupLoadCellSensitivity : 3048
    Should Contain    ${output}    priority : -4942
