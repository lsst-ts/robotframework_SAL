*** Settings ***
Documentation    OCS_ocsScriptError sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    ocs
${component}    ocsScriptError
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send llnnzLzYHMVpUueywfPbCFIFsqbeNfVkFYVrCtccOOQsMrxvEHARWNwJuADxiOrVrJYslISRdwxDhARdoBeTZcrftYeDtoRpVjIYMllvkbbMcYrJpaccKVIuIPmCHjemghRBASbMeLeAVkCwijyIdtHIkUjKYgCEydshPXUmJZoBeBayOvwBeldTTQXpVPRIvroZerBFkBuijVfkQKhZfbxnlIRmPxukpYETLWRFMOBHuspHLnoUEFYLPbRBsKMz 96.6 ddUhMPUVukjyvfyWbvOzNLfnKsbXIkRsalZlAfcaruITtsFrTMTutXMTRWBIJlPqRMNKHHBgBxUOItEIfnuiuuoFJlHUdyziuJfpMmNTjlDhSzVLmYGpMXNhOzUHAGMotehpquARuveYZbkfNUdVDgcStAfoktnhpMirTkYXrTestRdnLNoInyZjTLrscwxnQXkmRsSiwhZuuvpJxoUSWXpnVbDTQlWgojUCAhuArongmnrpuDMjNdWYwdlylTCZ 1785623322 1532635888 BPXiVMIMAbJiLhrluOFkSqbXAMrUAOxqeKVbAnkIUWTbFDbFwftlnMzMYiSUuFannkoDLzXNrixxdmWPggRnfbCIVSxtvJtPeLKTBqACCmoAjRSoXsPRqsRbHpmbBYxNQCZudKTaHHlNRYDXttETnzPRsjkVoyXNGjIiMioyJFFjtlmxRtADyvLAnEOsgtUEQEgegSrwvnHjsUdLvDiucwTJAfhpULpPYhhUDngJrYgSkBEfeqaFxjhYEJhguqrz -22845574
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] ocs::logevent_ocsScriptError writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ocsScriptError generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -22845574
    Log    ${output}
    Should Contain X Times    ${output}    === Event ocsScriptError received =     1
    Should Contain    ${output}    ocsScriptName : llnnzLzYHMVpUueywfPbCFIFsqbeNfVkFYVrCtccOOQsMrxvEHARWNwJuADxiOrVrJYslISRdwxDhARdoBeTZcrftYeDtoRpVjIYMllvkbbMcYrJpaccKVIuIPmCHjemghRBASbMeLeAVkCwijyIdtHIkUjKYgCEydshPXUmJZoBeBayOvwBeldTTQXpVPRIvroZerBFkBuijVfkQKhZfbxnlIRmPxukpYETLWRFMOBHuspHLnoUEFYLPbRBsKMz
    Should Contain    ${output}    ocsScriptIdentifier : 96.6
    Should Contain    ${output}    ocsScriptTimestamp : ddUhMPUVukjyvfyWbvOzNLfnKsbXIkRsalZlAfcaruITtsFrTMTutXMTRWBIJlPqRMNKHHBgBxUOItEIfnuiuuoFJlHUdyziuJfpMmNTjlDhSzVLmYGpMXNhOzUHAGMotehpquARuveYZbkfNUdVDgcStAfoktnhpMirTkYXrTestRdnLNoInyZjTLrscwxnQXkmRsSiwhZuuvpJxoUSWXpnVbDTQlWgojUCAhuArongmnrpuDMjNdWYwdlylTCZ
    Should Contain    ${output}    ocsScriptLineNumber : 1785623322
    Should Contain    ${output}    ocsScriptErrorCode : 1532635888
    Should Contain    ${output}    ocsScriptErrorText : BPXiVMIMAbJiLhrluOFkSqbXAMrUAOxqeKVbAnkIUWTbFDbFwftlnMzMYiSUuFannkoDLzXNrixxdmWPggRnfbCIVSxtvJtPeLKTBqACCmoAjRSoXsPRqsRbHpmbBYxNQCZudKTaHHlNRYDXttETnzPRsjkVoyXNGjIiMioyJFFjtlmxRtADyvLAnEOsgtUEQEgegSrwvnHjsUdLvDiucwTJAfhpULpPYhhUDngJrYgSkBEfeqaFxjhYEJhguqrz
    Should Contain    ${output}    priority : -22845574
