*** Settings ***
Documentation    Scheduler SequencePropConfig communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Scheduler
${component}    sequencePropConfig
${timeout}    30s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_sub

Start Subscriber
    [Tags]    functional
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_sub    alias=Subscriber
    Log    ${output}
    Should Contain    "${output}"   "1"
    ${object}=    Get Process Object    Subscriber
    Log    ${object.stdout.peek()}
    ${string}=    Convert To String    ${object.stdout.peek()}
    Should Contain    ${string}    ===== Scheduler subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_downtime test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_sequencePropConfig
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::${component}_${revcode} writing a message containing :    9
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    9

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== Scheduler subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : LSST    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}propId : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}twilightBoundary : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}deltaLst : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decWindow : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxAirmass : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxCloud : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minDistanceMoon : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}excludePlanets : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numUserRegions : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userRegionIds : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userRegionIds : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userRegionIds : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userRegionIds : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userRegionIds : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userRegionIds : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userRegionIds : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userRegionIds : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userRegionIds : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userRegionIds : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequences : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceNames : LSST    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilters : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilters : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilters : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilters : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilters : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilters : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilters : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilters : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilters : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilters : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceFilters : LSST    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilterVisits : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilterVisits : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilterVisits : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilterVisits : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilterVisits : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilterVisits : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilterVisits : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilterVisits : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilterVisits : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceFilterVisits : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceEvents : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceEvents : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceEvents : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceEvents : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceEvents : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceEvents : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceEvents : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceEvents : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceEvents : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceEvents : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceMaxMissed : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceMaxMissed : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceMaxMissed : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceMaxMissed : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceMaxMissed : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceMaxMissed : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceMaxMissed : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceMaxMissed : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceMaxMissed : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSubSequenceMaxMissed : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeIntervals : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeIntervals : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeIntervals : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeIntervals : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeIntervals : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeIntervals : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeIntervals : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeIntervals : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeIntervals : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeIntervals : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowStarts : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowStarts : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowStarts : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowStarts : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowStarts : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowStarts : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowStarts : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowStarts : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowStarts : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowStarts : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowMaximums : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowMaximums : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowMaximums : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowMaximums : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowMaximums : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowMaximums : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowMaximums : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowMaximums : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowMaximums : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowMaximums : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowEnds : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowEnds : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowEnds : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowEnds : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowEnds : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowEnds : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowEnds : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowEnds : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowEnds : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWindowEnds : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWeights : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWeights : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWeights : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWeights : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWeights : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWeights : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWeights : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWeights : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWeights : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subSequenceTimeWeights : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numMasterSubSequences : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}masterSubSequenceNames : LSST    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numNestedSubSequences : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nestedSubSequenceNames : LSST    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numMasterSubSequenceEvents : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numMasterSubSequenceMaxMissed : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}masterSubSequenceTimeIntervals : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}masterSubSequenceTimeWindowStarts : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}masterSubSequenceTimeWindowMaximums : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}masterSubSequenceTimeWindowEnds : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}masterSubSequenceTimeWeights : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numNestedSubSequenceFilters : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nestedSubSequenceFilters : LSST    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numNestedSubSequenceFilterVisits : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numNestedSubSequenceEvents : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numNestedSubSequenceMaxMissed : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nestedSubSequenceTimeIntervals : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nestedSubSequenceTimeWindowStarts : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nestedSubSequenceTimeWindowMaximums : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nestedSubSequenceTimeWindowEnds : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}nestedSubSequenceTimeWights : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilters : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterNames : LSST    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 0    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 1    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 2    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 3    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 4    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 5    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 6    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 7    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 8    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 9    1
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxNumTargets : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}acceptSerendipity : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}acceptConsecutiveVisits : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}restartLostSequences : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}restartCompleteSequences : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxVisitsGoal : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airmassBonus : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hourAngleBonus : 1    10
    Should Contain X Times    ${sequencePropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hourAngleMax : 1    10
