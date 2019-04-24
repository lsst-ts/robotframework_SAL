*** Settings ***
Documentation    Scheduler GeneralPropConfig communications tests.
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
${component}    generalPropConfig
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

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}_${component}/cpp/standalone/sacpp_${subSystem}_pub
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_downtime test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_generalPropConfig
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
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : LSST    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}propId : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}twilightBoundary : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}deltaLst : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}decWindow : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxAirmass : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxCloud : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minDistanceMoon : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}excludePlanets : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numRegionSelections : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionTypes : LSST    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMinimums : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMinimums : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMinimums : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMinimums : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMinimums : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMinimums : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMinimums : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMinimums : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMinimums : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMinimums : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMaximums : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMaximums : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMaximums : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMaximums : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMaximums : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMaximums : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMaximums : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMaximums : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMaximums : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionMaximums : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionBounds : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionBounds : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionBounds : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionBounds : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionBounds : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionBounds : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionBounds : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionBounds : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionBounds : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionBounds : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}regionCombiners : LSST    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numTimeRanges : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeStarts : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeStarts : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeStarts : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeStarts : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeStarts : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeStarts : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeStarts : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeStarts : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeStarts : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeStarts : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeEnds : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeEnds : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeEnds : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeEnds : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeEnds : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeEnds : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeEnds : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeEnds : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeEnds : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeRangeEnds : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSelectionMappings : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSelectionMappings : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSelectionMappings : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSelectionMappings : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSelectionMappings : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSelectionMappings : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSelectionMappings : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSelectionMappings : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSelectionMappings : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numSelectionMappings : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selectionMappings : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selectionMappings : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selectionMappings : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selectionMappings : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selectionMappings : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selectionMappings : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selectionMappings : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selectionMappings : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selectionMappings : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}selectionMappings : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numExclusionSelections : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionTypes : LSST    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMinimums : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMinimums : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMinimums : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMinimums : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMinimums : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMinimums : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMinimums : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMinimums : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMinimums : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMinimums : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMaximums : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMaximums : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMaximums : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMaximums : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMaximums : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMaximums : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMaximums : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMaximums : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMaximums : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionMaximums : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionBounds : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionBounds : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionBounds : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionBounds : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionBounds : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionBounds : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionBounds : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionBounds : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionBounds : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exclusionBounds : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fieldRevisitLimit : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilters : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterNames : LSST    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numVisits : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numVisits : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numVisits : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numVisits : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numVisits : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numVisits : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numVisits : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numVisits : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numVisits : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numVisits : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGroupedVisits : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGroupedVisits : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGroupedVisits : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGroupedVisits : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGroupedVisits : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGroupedVisits : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGroupedVisits : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGroupedVisits : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGroupedVisits : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numGroupedVisits : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxGroupedVisits : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxGroupedVisits : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxGroupedVisits : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxGroupedVisits : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxGroupedVisits : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxGroupedVisits : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxGroupedVisits : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxGroupedVisits : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxGroupedVisits : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxGroupedVisits : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brightLimit : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}darkLimit : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSeeing : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}numFilterExposures : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 0    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 1    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 2    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 3    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 4    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 5    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 6    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 7    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 8    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exposures : 9    1
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxNumTargets : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}acceptSerendipity : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}acceptConsecutiveVisits : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}restartLostSequences : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}restartCompleteSequences : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxVisitsGoal : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}airmassBonus : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hourAngleBonus : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hourAngleMax : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}restrictGroupedVisits : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeInterval : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeWindowStart : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeWindowMax : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeWindowEnd : 1    10
    Should Contain X Times    ${generalPropConfig_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeWeight : 1    10
