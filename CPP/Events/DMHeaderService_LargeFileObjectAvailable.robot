*** Settings ***
Documentation    DMHeaderService_LargeFileObjectAvailable sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    dmHeaderService
${component}    LargeFileObjectAvailable
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 1867813537 pFJQkWFHQaSziSmWvnkjDUbEiYZBEKredfbdmLqpDTNywXWISsdnEUiGcBciTTPjITrxdSSLYIKNlzcbGNjffhRBQJVUeUIOTYyCiVCEwcPRImqmgoMoekrqFvDYPTCrgHQxSijR cNTaYLtSFqPiVYFgHmJIRwKfgOLYoVCqQEKkoAVSmPfYeQHeOFsJlpyUjXeLRADfVvSkChdbJpuosifypyBBTFzgfqNBZaZpLwuJwjbmFxdUfzsDjBQQNfTRkxkBaIueJzDvuGjyRfVtiSLLpqmNZvroiBfpEHYtYccfrVCRhTlLylWAnsmcaZmEmsEYNkblqMxaRGfoZiriVwkPnRSEREuYpAvlKzksODrIaVkcAgnTcCxTADiLuMnrRLOqcdYEzTPKOxuRkeQdymwGdfQnRkHqsqghDuKuKAjqAHLQgKWjvZzejeNLvPDgkgUrkbHGmYcFKYqFlhBToQsGilCfuFguamsEfiSNUPcDaMBENhoNxExerFxjTGmKIfGszIoN aovDvLNYKNRfJALuEazAHmDXEjpRefJklwqIPZlThOsqQzdEIxdsUjnqNywZFqukLDMpwuobmjbMMhamsOkESlFodkMTkaVzAkOeHLuochqrxZUrnTtzHoTTrOsEWJSaockuMFazgkqyvsceJZwhjAqQRhiOlddhkfONezPFFYOwflhinFwMwZBSSJkuulHSFHMXenXAcHAJPfsNEwkhQRkwnjIpaDdVarPyWUjZaEccdEPZXCcrNABYAsMbglajdPHMQcbkZDutokTvHstXnwwgnlDumuFSYlUMgrwvbRfpqNzrUyfsVKbuQblBTuPHuuUQyCacCJlRpWfqYNbsfyCRmLYlbkuhgaKHngBCOsmwnZHzZGCdLEGZXBJHeypPVhyWZAVwCbHDjdz wuvIjTUVYpkcczYyzBpKLyCGMkQbpYvgfCTrIryNUlVEqOWkhTSVDixLeIxHpLowajzPxDutYpeaqbHNQOxeNToDrSbOvWVljsSsoHkfEbjdVxEPhHIsNhmhvIqRGHDvxhREVkSuXhQJytDbomWSmfXimxLRPQZcOplLxdOPxUlZWYHnRhDsCSAtfbtlyUeEMFvAGcRpqnCIUWKTVuCwTGiTMcdWWbvyHImKzXnXIRfFfYnHImouKvEQfXnBdjnHyEIJZDPXfWSBYhoRhSqrQjaGmceRLkrSxRWRCYiIHYrzRIjaHugtULFNlUIrsueGTwfJtHlkVfGGZgGZifbzjRoiLirPJvqdsrmfxdTIvWpjJKBPblAehkFRXOtgWlNdzGHlbizDisXugRjxvGCBJuVVAyqlqyGXeWYLAoQVJqBdcuNYJgttNmgSOySJVgndLgMWIxPeproUbCQZIDsAAKBhLjNTzhTmBWupvMkAQmesseloernRGyHDmMXMbJljUgsGKySHMJvpIQuYdzhkCUoAjZGRybBDfimesjmjrAmudQnoxmvyjMjUaqKSKUpmFheiJHtmrdHlUKrTbUqfSSaCoMehXTIsqvrSlGeaStkxnONRgQoiyqLSGBzSZcLiUtLuLrw 0.376173173581 test 799652327
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] dmHeaderService::logevent_LargeFileObjectAvailable writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event LargeFileObjectAvailable generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 799652327
    Log    ${output}
    Should Contain X Times    ${output}    === Event LargeFileObjectAvailable received =     1
    Should Contain    ${output}    Byte_Size : 1867813537
    Should Contain    ${output}    Checksum : pFJQkWFHQaSziSmWvnkjDUbEiYZBEKredfbdmLqpDTNywXWISsdnEUiGcBciTTPjITrxdSSLYIKNlzcbGNjffhRBQJVUeUIOTYyCiVCEwcPRImqmgoMoekrqFvDYPTCrgHQxSijR
    Should Contain    ${output}    Generator : cNTaYLtSFqPiVYFgHmJIRwKfgOLYoVCqQEKkoAVSmPfYeQHeOFsJlpyUjXeLRADfVvSkChdbJpuosifypyBBTFzgfqNBZaZpLwuJwjbmFxdUfzsDjBQQNfTRkxkBaIueJzDvuGjyRfVtiSLLpqmNZvroiBfpEHYtYccfrVCRhTlLylWAnsmcaZmEmsEYNkblqMxaRGfoZiriVwkPnRSEREuYpAvlKzksODrIaVkcAgnTcCxTADiLuMnrRLOqcdYEzTPKOxuRkeQdymwGdfQnRkHqsqghDuKuKAjqAHLQgKWjvZzejeNLvPDgkgUrkbHGmYcFKYqFlhBToQsGilCfuFguamsEfiSNUPcDaMBENhoNxExerFxjTGmKIfGszIoN
    Should Contain    ${output}    Mime : aovDvLNYKNRfJALuEazAHmDXEjpRefJklwqIPZlThOsqQzdEIxdsUjnqNywZFqukLDMpwuobmjbMMhamsOkESlFodkMTkaVzAkOeHLuochqrxZUrnTtzHoTTrOsEWJSaockuMFazgkqyvsceJZwhjAqQRhiOlddhkfONezPFFYOwflhinFwMwZBSSJkuulHSFHMXenXAcHAJPfsNEwkhQRkwnjIpaDdVarPyWUjZaEccdEPZXCcrNABYAsMbglajdPHMQcbkZDutokTvHstXnwwgnlDumuFSYlUMgrwvbRfpqNzrUyfsVKbuQblBTuPHuuUQyCacCJlRpWfqYNbsfyCRmLYlbkuhgaKHngBCOsmwnZHzZGCdLEGZXBJHeypPVhyWZAVwCbHDjdz
    Should Contain    ${output}    Type : wuvIjTUVYpkcczYyzBpKLyCGMkQbpYvgfCTrIryNUlVEqOWkhTSVDixLeIxHpLowajzPxDutYpeaqbHNQOxeNToDrSbOvWVljsSsoHkfEbjdVxEPhHIsNhmhvIqRGHDvxhREVkSuXhQJytDbomWSmfXimxLRPQZcOplLxdOPxUlZWYHnRhDsCSAtfbtlyUeEMFvAGcRpqnCIUWKTVuCwTGiTMcdWWbvyHImKzXnXIRfFfYnHImouKvEQfXnBdjnHyEIJZDPXfWSBYhoRhSqrQjaGmceRLkrSxRWRCYiIHYrzRIjaHugtULFNlUIrsueGTwfJtHlkVfGGZgGZifbzjRoiLirPJvqdsrmfxdTIvWpjJKBPblAehkFRXOtgWlNdzGHlbizDisXugRjxvGCBJuVVAyqlqyGXeWYLAoQVJqBdcuNYJgttNmgSOySJVgndLgMWIxPeproUbCQZIDsAAKBhLjNTzhTmBWupvMkAQmesseloernRGyHDmMXMbJljUgsGKySHMJvpIQuYdzhkCUoAjZGRybBDfimesjmjrAmudQnoxmvyjMjUaqKSKUpmFheiJHtmrdHlUKrTbUqfSSaCoMehXTIsqvrSlGeaStkxnONRgQoiyqLSGBzSZcLiUtLuLrw
    Should Contain    ${output}    URL : 0.376173173581
    Should Contain    ${output}    Version : test
    Should Contain    ${output}    priority : 799652327
