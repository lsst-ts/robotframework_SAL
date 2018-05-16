*** Settings ***
Documentation    PromptProcessing_promptprocessingEntityShutdown sender/logger tests.
Force Tags    cpp    TSS-2633
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    promptProcessing
${component}    promptprocessingEntityShutdown
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send vIEnityFuOZpZWDlVenLuQJnkCJZLHDeojJXHjeXqdxRvavcqFtMshwqYwiqtTgThdUgOcDwQpGpaICoOLCUUXoYUESqrxePZGitOBHNzEModtJnLcuuSxNkRTpqdEjjhzsgALkpjTWafiseiUjhhsdTikpBBxqyyfCQPyIheiGmhMllJIiasYRRKjdxWVakQUkqfGJIMbikIhPppkyQRaYClcTvyIurWceDjjKaBWTekmArvvdTRJUqFXaKeQQK 7.5423 iYokmIjsZPOhpKjbtdzKlmGLjiFiTvqywHauvkloFrhbavWJodPpMWsRUdLKhNITjDbpiljRfiqPhLieFBFNdmJpvirhJrBloXVZcixlQCwprIaIIVLURiLCBhXFzDtBmavTHLaoUsieHTZDTFJbmQfTrDCobppYZRIqjoKroTlsEpTUvgmMxZzDcfOoezJFnvyHOielrAWafHXlGZWSBSUfiQLTziRbVLTlIMlbdRNKDSmOKmEvacRvHwjpXBby -441099328 999347796 1661582648
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] promptProcessing::logevent_promptprocessingEntityShutdown writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event promptprocessingEntityShutdown generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1661582648
    Log    ${output}
    Should Contain X Times    ${output}    === Event promptprocessingEntityShutdown received =     1
    Should Contain    ${output}    Name : vIEnityFuOZpZWDlVenLuQJnkCJZLHDeojJXHjeXqdxRvavcqFtMshwqYwiqtTgThdUgOcDwQpGpaICoOLCUUXoYUESqrxePZGitOBHNzEModtJnLcuuSxNkRTpqdEjjhzsgALkpjTWafiseiUjhhsdTikpBBxqyyfCQPyIheiGmhMllJIiasYRRKjdxWVakQUkqfGJIMbikIhPppkyQRaYClcTvyIurWceDjjKaBWTekmArvvdTRJUqFXaKeQQK
    Should Contain    ${output}    Identifier : 7.5423
    Should Contain    ${output}    Timestamp : iYokmIjsZPOhpKjbtdzKlmGLjiFiTvqywHauvkloFrhbavWJodPpMWsRUdLKhNITjDbpiljRfiqPhLieFBFNdmJpvirhJrBloXVZcixlQCwprIaIIVLURiLCBhXFzDtBmavTHLaoUsieHTZDTFJbmQfTrDCobppYZRIqjoKroTlsEpTUvgmMxZzDcfOoezJFnvyHOielrAWafHXlGZWSBSUfiQLTziRbVLTlIMlbdRNKDSmOKmEvacRvHwjpXBby
    Should Contain    ${output}    Address : -441099328
    Should Contain    ${output}    priority : 999347796
    Should Contain    ${output}    priority : 1661582648
