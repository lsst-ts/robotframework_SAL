*** Settings ***
Documentation    PromptProcessing_promptprocessingEntitySummaryState sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    promptprocessing
${component}    promptprocessingEntitySummaryState
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send OFsYZuZGQneETUTpVNezrJeaFUCxOYNAfbDldIotxtIUdnMXPAfHzbgEWZWxRdAFYVdKGUyWxCWbWfLopVEhGQahJrtoYsKZqcgPbkyqxBjbKwOqPpjujDiTswFTPgXeurzzIZVPQEPVievoIMMoyNzHpRIjQkhbXnuvGNMbyOfGdZsPkCEhyeCZoTWakUTTSsHaBrimkNjXRbVfVkWYCDAsrSVGFFxsRpiLnbtnzGZXCQoZVealwJglqDGswRQE 84.7707 AIHuLMhANEQTxhMSCpdfzZCuychzyLbjemHEthkuUPvZTwPSgDoPqYbXtQJoPJIyCHcRbjVWNPANMBNXwjRsFoMYspABbuCowUsVMsFbLOyNNMzJULBRewPftHCgxrGLEUtCAayNWmrKgHLhgfXHpQMJPCHelQrNnQGxGFXPUAWMhFTdcOjjvmhkIILRJJyqWgDITtDpiPKwMQeRNqCmWyJgXSKCJOqfHzCXHsCzFWCarhZhcGeHvLPyxkjRjaOC 1926700968 toMcbIkfeBXPjYJYSeGtrXavCOPbsThAjMhINDUnxfmyDfRGKkZovUxMkRtOuNkOpGJlOGGkMzIqEusJkhFrstYdMjpKpgVxFQZsyfkNmTxBDSyPcYiYkbqaIZrEHNjukDWxVecVJydtmAKoIhWABAcEHBjuinAjbTVXItwkvHJclaiRLarPavgNSVKAckBlYCcHbBCtwlwILhJxrIySxMhuQHbBpaTfhQiHPmGUcPAZbFPaDhRuWgHFnGVryuHc GVzfXYONXpneRhkPVFyYmjMtRftdsyfhdCXyEXyLCXmEdervnAsgFcAqSiojTCYgJCRObDNicEGKJUnpGNWibXXUisFqxsbdVHEmQnjtkELHlSBrwKqftYOVthFGFVccPzTlAfzxGMNNRXvDUgkqYduNAbVFFkBngqqQHwqprERPHpRAjsCmesiKIUSzolPuvvWkIjIHNoUIqpBlaqpkFewfeVzZhyAeqcClfyKoHVwyUIUrMhxEMfwoZqjtmgng PaEdcgjDNPNYvAZzKDQlUBkkcnjPBwToroZUfsnmOQZUxisjgRNzAXOXLziWWBvUrVhnANZOHsXjDlweMPkrVZgCyPhneZHcAemntTjYcKCtgUZIluDQoNwDXPjOFOpcqPgBfbzbbCaNBiavNVJYIDnqlNarNjGDlTaywojKviGAydiHeJvPacvDdcIscIUGXKLPHSZUGhwKEOFyPnXaQURBcayiULBGeAtdELJORSplMhbbuJcYkocmoOIQaZDL GRfudsugHTfmOeQFFfmxyBJqprUYGyTDtnYQETUgLdSCTaIuireaplOFfUsprJxEusiWuHgpPKyACjChVTCBOEwHNjhxmtJrzarqCoDLDDFvItajrhrjkPyfJSMgwBEDXRbUWCGRZSDlRzMywlVSsbmgiwdTAaVRddVGspCHjmAiGtEClFqcDzStpJxpymhkxwkIMlRuhaRRNuTneVmrNsAUJmTpamAwqpciTVoKDpiJnIThozXEkdDjUnPSlWYM hUFVySCETEwEYrUJRrYSDLqkeGEtKqWnORhdFtuytQIeParkNtXpKVuaeWEHOnZjRPVqOZBDWqeYcpPNArXiTaodhctGFRzaxEUQzqUxyeEEHrOsVbFDQXKOWUrOjmnXhqsKaasqzdlLqQNZDijBrtwUpRNPQcFKamghvelLGTHrSOcNZdAnVYWKUxWrsIziDKtPYatjaXcXrFyEPDTbuEoeYMcBYdNpaMpwzMAftGytdwxHiAxLRjZFUpksurLq 1462339484 1573246113
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] promptprocessing::logevent_promptprocessingEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event promptprocessingEntitySummaryState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1573246113
    Log    ${output}
    Should Contain X Times    ${output}    === Event promptprocessingEntitySummaryState received =     1
    Should Contain    ${output}    Name : OFsYZuZGQneETUTpVNezrJeaFUCxOYNAfbDldIotxtIUdnMXPAfHzbgEWZWxRdAFYVdKGUyWxCWbWfLopVEhGQahJrtoYsKZqcgPbkyqxBjbKwOqPpjujDiTswFTPgXeurzzIZVPQEPVievoIMMoyNzHpRIjQkhbXnuvGNMbyOfGdZsPkCEhyeCZoTWakUTTSsHaBrimkNjXRbVfVkWYCDAsrSVGFFxsRpiLnbtnzGZXCQoZVealwJglqDGswRQE
    Should Contain    ${output}    Identifier : 84.7707
    Should Contain    ${output}    Timestamp : AIHuLMhANEQTxhMSCpdfzZCuychzyLbjemHEthkuUPvZTwPSgDoPqYbXtQJoPJIyCHcRbjVWNPANMBNXwjRsFoMYspABbuCowUsVMsFbLOyNNMzJULBRewPftHCgxrGLEUtCAayNWmrKgHLhgfXHpQMJPCHelQrNnQGxGFXPUAWMhFTdcOjjvmhkIILRJJyqWgDITtDpiPKwMQeRNqCmWyJgXSKCJOqfHzCXHsCzFWCarhZhcGeHvLPyxkjRjaOC
    Should Contain    ${output}    Address : 1926700968
    Should Contain    ${output}    CurrentState : toMcbIkfeBXPjYJYSeGtrXavCOPbsThAjMhINDUnxfmyDfRGKkZovUxMkRtOuNkOpGJlOGGkMzIqEusJkhFrstYdMjpKpgVxFQZsyfkNmTxBDSyPcYiYkbqaIZrEHNjukDWxVecVJydtmAKoIhWABAcEHBjuinAjbTVXItwkvHJclaiRLarPavgNSVKAckBlYCcHbBCtwlwILhJxrIySxMhuQHbBpaTfhQiHPmGUcPAZbFPaDhRuWgHFnGVryuHc
    Should Contain    ${output}    PreviousState : GVzfXYONXpneRhkPVFyYmjMtRftdsyfhdCXyEXyLCXmEdervnAsgFcAqSiojTCYgJCRObDNicEGKJUnpGNWibXXUisFqxsbdVHEmQnjtkELHlSBrwKqftYOVthFGFVccPzTlAfzxGMNNRXvDUgkqYduNAbVFFkBngqqQHwqprERPHpRAjsCmesiKIUSzolPuvvWkIjIHNoUIqpBlaqpkFewfeVzZhyAeqcClfyKoHVwyUIUrMhxEMfwoZqjtmgng
    Should Contain    ${output}    Executing : PaEdcgjDNPNYvAZzKDQlUBkkcnjPBwToroZUfsnmOQZUxisjgRNzAXOXLziWWBvUrVhnANZOHsXjDlweMPkrVZgCyPhneZHcAemntTjYcKCtgUZIluDQoNwDXPjOFOpcqPgBfbzbbCaNBiavNVJYIDnqlNarNjGDlTaywojKviGAydiHeJvPacvDdcIscIUGXKLPHSZUGhwKEOFyPnXaQURBcayiULBGeAtdELJORSplMhbbuJcYkocmoOIQaZDL
    Should Contain    ${output}    CommandsAvailable : GRfudsugHTfmOeQFFfmxyBJqprUYGyTDtnYQETUgLdSCTaIuireaplOFfUsprJxEusiWuHgpPKyACjChVTCBOEwHNjhxmtJrzarqCoDLDDFvItajrhrjkPyfJSMgwBEDXRbUWCGRZSDlRzMywlVSsbmgiwdTAaVRddVGspCHjmAiGtEClFqcDzStpJxpymhkxwkIMlRuhaRRNuTneVmrNsAUJmTpamAwqpciTVoKDpiJnIThozXEkdDjUnPSlWYM
    Should Contain    ${output}    ConfigurationsAvailable : hUFVySCETEwEYrUJRrYSDLqkeGEtKqWnORhdFtuytQIeParkNtXpKVuaeWEHOnZjRPVqOZBDWqeYcpPNArXiTaodhctGFRzaxEUQzqUxyeEEHrOsVbFDQXKOWUrOjmnXhqsKaasqzdlLqQNZDijBrtwUpRNPQcFKamghvelLGTHrSOcNZdAnVYWKUxWrsIziDKtPYatjaXcXrFyEPDTbuEoeYMcBYdNpaMpwzMAftGytdwxHiAxLRjZFUpksurLq
    Should Contain    ${output}    priority : 1462339484
    Should Contain    ${output}    priority : 1573246113
