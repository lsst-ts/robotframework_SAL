*** Settings ***
Documentation    CatchupArchiver_catchuparchiverEntitySummaryState sender/logger tests.
Force Tags    cpp    TSS-2620
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    catchuparchiver
${component}    catchuparchiverEntitySummaryState
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send PVzJkAAYNWYsgrniMLeGuDHPvCOGCkPIfZXCAumOLMlazGmTxyLpbkzJWZlzNDtySBzVjIvruABsRNFpsniKhxVQlYeOyNBXujOztQvsskmwsMmyQinoyqBYgegyertDNsGuwgerRjIJpfyroXVUjKPOwuyBAvRcxLGUcjtGhmwWYTWBqbsXCpelzpDqWwIZwFMBCULEQDDnAzCljpTjYetNVrwWblueWVbiBSQiLkeRHlbTsvKzLVOBDsObzSxX 95.1833 NAYNCsVGMvKswQCUOEFroBsVAqWYCeHqLUqRidhmoEpiIgBnwsIpBwvFToSRpSizbIfpUbkLWzSaTEJdXRDzaRVpJupCKhhrKwlecKPvNfonOwXNceqTsFCjQbwjenwaFonNCujEToiwbuhiTmbiAMUoVpSbujvEcZxwGPaqemSuTBInzrZiSfyXxkZrxjBmFUGGHFudlbGtPDYLTaqAYPrnvKkljtmACZffqvgaUhcAHlcbFetrhNkXrwdRuykp -634881892 lcUCkKDLxfbmBDWhPQfccFUgfKOcfoIWOkLFSYLxvmWJeRxDefWhydHsUihMxdlyVbZKaSfnKkYGTvwOpxxInJxGHyeaCYpnmptlzseIiVGKdNCgEweBcznLUZNdqMaFMeGYQpZRzUCOZpgbzFOBsAeMYlDpZywMYiZbFZzHfQnKCnfxbndTaxzElqfQamChxKNiqvohCzFOxRudjipinbTsYYXybNRizXulmXLrgAkxCWlAQZLTmbPVaTFZJEGX tgvwPNmZoFKYTddhEAYWuEEHiIFzSJdHCsnFpcvBgZUBmvnKZJXoCLnZeZLBmIvErkDZIzGdPQRruuikptvgoqbABrbWphcegtyHxYbOPgVgYqGTvBvQKhhzqEaMvRZBhuLfRIGOYrrnYmouSrrScTIqFiQuMQIUzwjpEiniNdaqXBUbLUIBOFvqgXJuiJILYIZtUQbiFASfOkuYpBHfnqsAGYMxTZsIwfBzjOxZVviMXHVQIivzMXWoypkRZHcw pTPVNFmBxMGmXHAxFvkcvqObXJxNERCGCRgtuJSQZWHOZXsIZnITNmofPQdvXjOaibWtzlZfIFvaBalLeVItGruvMXYvgqIzwWhEggGAkPnsbkPNqYsWMEIAKAKayElskZMNXwNCQBApsjJjGRlBiSVTZkuKQyaEdxabnWqkWbZSQZbmAFzRRzGUkjfTfNBHBTQxuICIIWAxGxYriNgLwZWLkCiWZObbjvAwhBoWvjnXZfFliUACymNdniLMBxXu CVoXfcTpWKzwhLaFfLENlpuUrRtFbSHwBNxtVTUFegDbkvAMXrLAqgQFDKCqkqSjRUBFYwBjmKFFANdNGFrTOTItXYNdQNUqFAVUilqqwpYjvnTFzwxLrXeulsXbdVUTUcXLDArqEeYGySXztzoTjTkXdskNyGLVxeklHPFhtznmSKOsdiPkRiqTePgOOdhgCEZaWmoKSMbyZJsSbHYXcNbgJQZJYtRgwpynsSwwFhqMsspzvWqeVcqUoGjrqhyR pMtfYymbSZSOdVeOrtYMQrYRSmdZJJCLePBEkhPTyOIEBKUQlfulgaFNEpjqguGiEuAEfkHbNOyakwvGUYTSzGEXFpbvFGLFNNtGwDDhqOFIINvMbvQQElJgQkIQkDobvKMLmnPORCkocMMpmBIuwIyCwAUVMzxvvuHfxgucPxYQzLkKECqiyIGHIaGHUqpfIFKqGnOhvamZRtthGZDxJtLozPdnvGNvinWjSgAPEaTBbeFIvltLFsDiYBoUvauq -110263427 -1245679351
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] catchuparchiver::logevent_catchuparchiverEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event catchuparchiverEntitySummaryState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1245679351
    Log    ${output}
    Should Contain X Times    ${output}    === Event catchuparchiverEntitySummaryState received =     1
    Should Contain    ${output}    Name : PVzJkAAYNWYsgrniMLeGuDHPvCOGCkPIfZXCAumOLMlazGmTxyLpbkzJWZlzNDtySBzVjIvruABsRNFpsniKhxVQlYeOyNBXujOztQvsskmwsMmyQinoyqBYgegyertDNsGuwgerRjIJpfyroXVUjKPOwuyBAvRcxLGUcjtGhmwWYTWBqbsXCpelzpDqWwIZwFMBCULEQDDnAzCljpTjYetNVrwWblueWVbiBSQiLkeRHlbTsvKzLVOBDsObzSxX
    Should Contain    ${output}    Identifier : 95.1833
    Should Contain    ${output}    Timestamp : NAYNCsVGMvKswQCUOEFroBsVAqWYCeHqLUqRidhmoEpiIgBnwsIpBwvFToSRpSizbIfpUbkLWzSaTEJdXRDzaRVpJupCKhhrKwlecKPvNfonOwXNceqTsFCjQbwjenwaFonNCujEToiwbuhiTmbiAMUoVpSbujvEcZxwGPaqemSuTBInzrZiSfyXxkZrxjBmFUGGHFudlbGtPDYLTaqAYPrnvKkljtmACZffqvgaUhcAHlcbFetrhNkXrwdRuykp
    Should Contain    ${output}    Address : -634881892
    Should Contain    ${output}    CurrentState : lcUCkKDLxfbmBDWhPQfccFUgfKOcfoIWOkLFSYLxvmWJeRxDefWhydHsUihMxdlyVbZKaSfnKkYGTvwOpxxInJxGHyeaCYpnmptlzseIiVGKdNCgEweBcznLUZNdqMaFMeGYQpZRzUCOZpgbzFOBsAeMYlDpZywMYiZbFZzHfQnKCnfxbndTaxzElqfQamChxKNiqvohCzFOxRudjipinbTsYYXybNRizXulmXLrgAkxCWlAQZLTmbPVaTFZJEGX
    Should Contain    ${output}    PreviousState : tgvwPNmZoFKYTddhEAYWuEEHiIFzSJdHCsnFpcvBgZUBmvnKZJXoCLnZeZLBmIvErkDZIzGdPQRruuikptvgoqbABrbWphcegtyHxYbOPgVgYqGTvBvQKhhzqEaMvRZBhuLfRIGOYrrnYmouSrrScTIqFiQuMQIUzwjpEiniNdaqXBUbLUIBOFvqgXJuiJILYIZtUQbiFASfOkuYpBHfnqsAGYMxTZsIwfBzjOxZVviMXHVQIivzMXWoypkRZHcw
    Should Contain    ${output}    Executing : pTPVNFmBxMGmXHAxFvkcvqObXJxNERCGCRgtuJSQZWHOZXsIZnITNmofPQdvXjOaibWtzlZfIFvaBalLeVItGruvMXYvgqIzwWhEggGAkPnsbkPNqYsWMEIAKAKayElskZMNXwNCQBApsjJjGRlBiSVTZkuKQyaEdxabnWqkWbZSQZbmAFzRRzGUkjfTfNBHBTQxuICIIWAxGxYriNgLwZWLkCiWZObbjvAwhBoWvjnXZfFliUACymNdniLMBxXu
    Should Contain    ${output}    CommandsAvailable : CVoXfcTpWKzwhLaFfLENlpuUrRtFbSHwBNxtVTUFegDbkvAMXrLAqgQFDKCqkqSjRUBFYwBjmKFFANdNGFrTOTItXYNdQNUqFAVUilqqwpYjvnTFzwxLrXeulsXbdVUTUcXLDArqEeYGySXztzoTjTkXdskNyGLVxeklHPFhtznmSKOsdiPkRiqTePgOOdhgCEZaWmoKSMbyZJsSbHYXcNbgJQZJYtRgwpynsSwwFhqMsspzvWqeVcqUoGjrqhyR
    Should Contain    ${output}    ConfigurationsAvailable : pMtfYymbSZSOdVeOrtYMQrYRSmdZJJCLePBEkhPTyOIEBKUQlfulgaFNEpjqguGiEuAEfkHbNOyakwvGUYTSzGEXFpbvFGLFNNtGwDDhqOFIINvMbvQQElJgQkIQkDobvKMLmnPORCkocMMpmBIuwIyCwAUVMzxvvuHfxgucPxYQzLkKECqiyIGHIaGHUqpfIFKqGnOhvamZRtthGZDxJtLozPdnvGNvinWjSgAPEaTBbeFIvltLFsDiYBoUvauq
    Should Contain    ${output}    priority : -110263427
    Should Contain    ${output}    priority : -1245679351
