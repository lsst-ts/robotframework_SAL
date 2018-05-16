*** Settings ***
Documentation    Sequencer_sequencerCommandStatus sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    sequencer
${component}    sequencerCommandStatus
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send oJHFJRPXncaBXEnyCUFFJPXPHHsYqwdTYhbsqyXAqLBbYnDCOHcanntTbTvmmoBnwbYsAqtTPWWufyKQduZBdbMKeiEdepRffFQZhjzEptVOskSaRvaiAFLoSUioFdkcSzuwuNwChoIyCbfKWHFNBWtlpyKQdHmGkrIhhguAFVRwxJZgRrBiWfthRwfOczffWDbFUhkialredYCjULYXtUEzSLyFYSjKXTKZGRURkNPjNmQRdKzJLIMIslcckHYh -1608164982 61.7995 cefkUprTAVGCYsMWWdjQnUaKylskMVBssiHiNdrTcmaDqmAQWPyttAOetwqcIJvZDpcJAVxjWuTfQPiLExrSwFzGyoMgKDZhvjKSWtDmBBnIRlnwRsZLFaWOLCxMKnscKbwaaavfWckvtErHuiYhNIASatjFHFjcnidUSQfbOorYjVFOpbsxSByBgcTcKbPvTLnHHudnsAYKdgZskZTNUsaGHZrWlikHGvhmSERqabcZOnndzYAuJXrOCXkUpGMX RblPjrEzsmeaxYkpsbJIbDvtruDtgHkgdQUfrIBHVMhxKaeXFqMRYPzdoqSVvYjcYvSnTnzGwbNhLPwkLkuSdLqYvbNzMHwXzCyQkIQBrWtXKorkFyDhykLmgpNhurLWYXChUdOMiKWWogRyblSxEpsQgsOgIFLCHTjvSVWCXsszbHGoyOhgqUGiIiInSxcOCDsyXKJRoYHQYetJzxlBazUsckOgBjBaVlDyFuLiLllPOUPlZXpVouRwoghqNSME -2030218531 LvvmvpdRRESbZgCIVASkQCLpkiyPVURiSgcWxOEUATPNCEVBqxVTNppvlpNBWmpaPnUYsNvTfQCBErQJcRMdzlwVeQIrwPeMLDaWMEuYeHTbEUOSyCNYdXYJvYNZCFXVTAMLQCFvolxMappYmZmrrjZsqnXmrrNICKKcBfPCihSgJlSHvoBprtoSlOTUZfpjFslYmPSveRNQapZaNfzauQYAZHTiffwHOwxbsgGGuoZtkVmrwbwHvBgPIodzuhIW -2061993786
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] sequencer::logevent_sequencerCommandStatus writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event sequencerCommandStatus generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -2061993786
    Log    ${output}
    Should Contain X Times    ${output}    === Event sequencerCommandStatus received =     1
    Should Contain    ${output}    CommandSource : oJHFJRPXncaBXEnyCUFFJPXPHHsYqwdTYhbsqyXAqLBbYnDCOHcanntTbTvmmoBnwbYsAqtTPWWufyKQduZBdbMKeiEdepRffFQZhjzEptVOskSaRvaiAFLoSUioFdkcSzuwuNwChoIyCbfKWHFNBWtlpyKQdHmGkrIhhguAFVRwxJZgRrBiWfthRwfOczffWDbFUhkialredYCjULYXtUEzSLyFYSjKXTKZGRURkNPjNmQRdKzJLIMIslcckHYh
    Should Contain    ${output}    SequenceNumber : -1608164982
    Should Contain    ${output}    Identifier : 61.7995
    Should Contain    ${output}    Timestamp : cefkUprTAVGCYsMWWdjQnUaKylskMVBssiHiNdrTcmaDqmAQWPyttAOetwqcIJvZDpcJAVxjWuTfQPiLExrSwFzGyoMgKDZhvjKSWtDmBBnIRlnwRsZLFaWOLCxMKnscKbwaaavfWckvtErHuiYhNIASatjFHFjcnidUSQfbOorYjVFOpbsxSByBgcTcKbPvTLnHHudnsAYKdgZskZTNUsaGHZrWlikHGvhmSERqabcZOnndzYAuJXrOCXkUpGMX
    Should Contain    ${output}    CommandSent : RblPjrEzsmeaxYkpsbJIbDvtruDtgHkgdQUfrIBHVMhxKaeXFqMRYPzdoqSVvYjcYvSnTnzGwbNhLPwkLkuSdLqYvbNzMHwXzCyQkIQBrWtXKorkFyDhykLmgpNhurLWYXChUdOMiKWWogRyblSxEpsQgsOgIFLCHTjvSVWCXsszbHGoyOhgqUGiIiInSxcOCDsyXKJRoYHQYetJzxlBazUsckOgBjBaVlDyFuLiLllPOUPlZXpVouRwoghqNSME
    Should Contain    ${output}    StatusValue : -2030218531
    Should Contain    ${output}    Status : LvvmvpdRRESbZgCIVASkQCLpkiyPVURiSgcWxOEUATPNCEVBqxVTNppvlpNBWmpaPnUYsNvTfQCBErQJcRMdzlwVeQIrwPeMLDaWMEuYeHTbEUOSyCNYdXYJvYNZCFXVTAMLQCFvolxMappYmZmrrjZsqnXmrrNICKKcBfPCihSgJlSHvoBprtoSlOTUZfpjFslYmPSveRNQapZaNfzauQYAZHTiffwHOwxbsgGGuoZtkVmrwbwHvBgPIodzuhIW
    Should Contain    ${output}    priority : -2061993786
