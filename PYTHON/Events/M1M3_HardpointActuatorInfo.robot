*** Settings ***
Documentation    M1M3_HardpointActuatorInfo sender/logger tests.
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
${component}    HardpointActuatorInfo
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp ReferenceId ReferencePosition ModbusSubnet ModbusAddress XPosition YPosition ZPosition ILCUniqueId ILCApplicationType NetworkNodeType ILCSelectedOptions NetworkNodeOptions MajorRevision MinorRevision ADCScanRate MainLoadCellCoefficient MainLoadCellOffset MainLoadCellSensitivity BackupLoadCellCoefficient BackupLoadCellOffset BackupLoadCellSensitivity priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 67.003 -27431 -28970 -24426 19852 15738 -20054 -1802268894 757264478 510801346 1268703778 -1190853794 -382980462 -13638 -30492 5624 5952 -11757 29837 -3337 -31439 -27400 4286 19794 -10983 0.630812546772 0.973791647356 0.2800588223 0.325598416219 0.78360288979 0.0116068934318 0.46428402314 0.500903320919 0.535003299721 0.566602756678 0.159398573383 0.407503510216 0.502405904558 0.335528031302 0.434522222365 0.569372844333 0.291416571688 0.63864892909 test test test test test test 25675 6492 988 -20267 842 -19306 25279 28512 -29484 -26624 22070 -17433 22972 32410 -31937 -14834 3404 29263 -20686 -24142 -30755 -29403 -26420 -2931 -17136 -5755 -9942 -7658 -524 -23000 -24822 21586 -22136 -19873 14388 -2223 29409 -8410 -18768 -18016 25747 10430 0.873426911393 0.0768349001303 0.775938106278 0.383146875061 0.355047992221 0.273589342325 0.210668041532 0.334452377402 0.210042038526 0.538200330182 0.0628563322005 0.579459515792 0.855267447775 0.789351096271 0.259078530909 0.166337725183 0.552980459975 0.0223338844041 0.655982074546 0.0812105621126 0.0148045863288 0.678395020317 0.160905928253 0.742138935372 0.73660953141 0.965743708034 0.349418469451 0.442180799393 0.964359406155 0.448447628659 0.710802600752 0.89995080281 0.81264778379 0.246137104458 0.998755717964 0.693365806809 -1994948662
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointActuatorInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
*** Settings ***
Documentation    M1M3_HardpointActuatorInfo communications tests.
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
${component}    HardpointActuatorInfo
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp ReferenceId ReferencePosition ModbusSubnet ModbusAddress XPosition YPosition ZPosition ILCUniqueId ILCApplicationType NetworkNodeType ILCSelectedOptions NetworkNodeOptions MajorRevision MinorRevision ADCScanRate MainLoadCellCoefficient MainLoadCellOffset MainLoadCellSensitivity BackupLoadCellCoefficient BackupLoadCellOffset BackupLoadCellSensitivity priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 35.9677 -2343 -11343 -29123 -8011 5197 20305 1559100775 2131719356 855087861 464873961 -1632130773 -1592556948 -25729 -15576 16320 10221 -17515 31404 -24097 24925 25064 -9333 -23044 -28324 0.111251 0.238336 0.350185 0.454901 0.381883 0.46721 0.441918 0.974416 0.886493 0.731395 0.827596 0.802067 0.4081 0.530768 0.458319 0.967175 0.361056 0.281276 test test test test test test 12993 5619 30174 -18574 -394 6018 -25245 -15191 25447 15535 32670 13718 -4188 -12165 10920 -16231 32237 2673 4328 -17272 -28015 29568 11417 -8960 -7434 20082 -1369 -8957 20987 -30003 11284 -1017 -43 23255 -10451 32130 -15609 18974 18064 -26941 1639 29422 0.156863 0.203781 0.028774 0.251267 0.82384 0.062913 0.045238 0.391302 0.597969 0.397044 0.470181 0.928585 0.158604 0.274057 0.76211 0.804113 0.353915 0.364718 0.298599 0.222645 0.377881 0.116783 0.571018 0.645781 0.14511 0.426772 0.382937 0.991758 0.48957 0.865563 0.138876 0.282506 0.343732 0.69195 0.636903 0.727708 -362284954
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_HardpointActuatorInfo writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
