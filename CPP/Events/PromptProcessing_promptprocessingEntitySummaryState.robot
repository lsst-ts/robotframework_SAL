*** Settings ***
Documentation    PromptProcessing_promptprocessingEntitySummaryState sender/logger tests.
Force Tags    cpp    TSS-2633
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    promptProcessing
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send JdYadSiSQDUQbPXfOoebZKaIjmixjdpfbQEvSKKOyownmsoFIrgLkUHXlSfHgapDuVGWyXuddSLSzivdUjLRpwJLIFGbNerdMDlEcNfVQotMPwsVwcTioZOLUyDCGKQxmgLhdpTDYZlJskLmyMjvWkwwsnMXFVWQgmTYAUMJiaUQAxnNCuWBZxxWVjbPvDLtbtAsZmzOYZaKdFVCgigJauRkjCxavpnyullycuPkeEMOSsZYNmsWdTOLSThJZYao 90.6467 lnzksPdZrwviiQdFKMcEbPzJjwzgKJbLmOMZFbMkmyOVdQIxlvmdwmuPQMnZAPkrHNxQwUxWCoAETEwbxCXhlmPbEGaroEGcpIfBluGDhUuAeiNnbcrWSrVyTxstWrjtCezaUvrEFbaHnoAtmzLOxsaoITqaeEiOsBhgWttHyyZgdlAFcXjkGdRKUXxgHlqQGkcgTCtEvDRgNObdulfYkQBsvFmvRTgHgdbPEayIRaaGsprRoWJcRkGuRGABJnxB 1678614019 vqTczSsJAhrFPYbmEHtJjnQwBJtzkZQzkhRkHvDrwTjyWIaknwxiuhczPAaQXUTohVeIPwBrlBUUTxCzZPNXQcMDnElXXHuTHbvuXLhbdIqtVCZwWutVPMqHnTVdBWtZLxpIfMZwLISDDhjJiRKJMsQyrdriavUdKvzAeVIPnrnmQDouzIIWfmULEGNuVJPGpYpyxYxIqPFSHBnKOCfCKQdVpyOXEVGjuxVuTDMlNlBMNGgMUvTSCoHBGwHBpyJO FWWIKBAiprrocVoIdcXLRCIfNvbJSfrWHtOrmmhBPnLUCDbqfanHSGtSuNGvbDaIEZgbHpQKHGSyzFpGcrrSJphpJmDSErSqqbkiohVyTKxCjthwOeYjTjZeGkOXmWlaGzseMOFtTDbNHlXRzOLhFPkPlVtYnVLHfjMoDJAzktccjqOpCkxNXLeaELmuAikbVcMRIfGACALjybJdtxjfHKbFDaMGnoiHftiEcGHxyaknzgfycfsumykpAjLFmCel nNEyjiLbnlSFntEiAJJEXDxpFoCawfoTowfHmVzlbWzxVgMQNgLVaPBkIVibxzDTobUjVOnFAuMuNXFpamDgixRODsHoQwmohHWjzUKnnVpMvrELHKzDkhSHqxWuDgueBIixPAWgbDcOzjwtkKgpSAdKJzxgBnDSbpCkXtPVXTpIiPefKgJPvsfHIJxPuSzdaMShROIJJmrZPLCnhKVXAVoPCtqRtQqytHRaZBiTeqGnwpcJMxxoVDyvjzubvhJj HyPSxJsnxSWaEWvciIjSYdcJURDqUKcvpIXGszsGCNBysvjQmoEWpKSIWNOlVwELFrhrgKWMGbzoPXcugDhVRZPBFeIctWiuaGWhKsAriUtiRkYZkBkSONCFloxROMlQCczZqCVLbEaXJPeiBdZdiuErSZskowFDfeZEAATftWxEonKNSjbutXXOnDhTuDHnEZVsRdUsCSoIPycXDZjUUFvOcOvvSZPUDgZnGZHlyOgAmxhXbBrGBqGfHlbVeMsu nhblXpMOhXoPHnSSzAdtvgFfsnRILQexwqZkeuNYWMWUBSVtdQuTAGTWllXuvVJhTkLlQdfXNPCoKJZBKcpwCENHGoKqCKupGKpGZMUFbGoEWqfmzpVwoOgeOAVACQiSnMhPZEWUibRWrcghbsqpFjkWgvYxfcWePWXDoZOHOeUnOqBOvmpAsfUgvJNcRsiHKuWHlyTqMgVqWqKZqtsZrywUEyBdzNfjaljWyHjvKjPHllBWJxTENhjsLRJIWqMI -1888199045 -1319875316
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] promptProcessing::logevent_promptprocessingEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event promptprocessingEntitySummaryState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1319875316
    Log    ${output}
    Should Contain X Times    ${output}    === Event promptprocessingEntitySummaryState received =     1
    Should Contain    ${output}    Name : JdYadSiSQDUQbPXfOoebZKaIjmixjdpfbQEvSKKOyownmsoFIrgLkUHXlSfHgapDuVGWyXuddSLSzivdUjLRpwJLIFGbNerdMDlEcNfVQotMPwsVwcTioZOLUyDCGKQxmgLhdpTDYZlJskLmyMjvWkwwsnMXFVWQgmTYAUMJiaUQAxnNCuWBZxxWVjbPvDLtbtAsZmzOYZaKdFVCgigJauRkjCxavpnyullycuPkeEMOSsZYNmsWdTOLSThJZYao
    Should Contain    ${output}    Identifier : 90.6467
    Should Contain    ${output}    Timestamp : lnzksPdZrwviiQdFKMcEbPzJjwzgKJbLmOMZFbMkmyOVdQIxlvmdwmuPQMnZAPkrHNxQwUxWCoAETEwbxCXhlmPbEGaroEGcpIfBluGDhUuAeiNnbcrWSrVyTxstWrjtCezaUvrEFbaHnoAtmzLOxsaoITqaeEiOsBhgWttHyyZgdlAFcXjkGdRKUXxgHlqQGkcgTCtEvDRgNObdulfYkQBsvFmvRTgHgdbPEayIRaaGsprRoWJcRkGuRGABJnxB
    Should Contain    ${output}    Address : 1678614019
    Should Contain    ${output}    CurrentState : vqTczSsJAhrFPYbmEHtJjnQwBJtzkZQzkhRkHvDrwTjyWIaknwxiuhczPAaQXUTohVeIPwBrlBUUTxCzZPNXQcMDnElXXHuTHbvuXLhbdIqtVCZwWutVPMqHnTVdBWtZLxpIfMZwLISDDhjJiRKJMsQyrdriavUdKvzAeVIPnrnmQDouzIIWfmULEGNuVJPGpYpyxYxIqPFSHBnKOCfCKQdVpyOXEVGjuxVuTDMlNlBMNGgMUvTSCoHBGwHBpyJO
    Should Contain    ${output}    PreviousState : FWWIKBAiprrocVoIdcXLRCIfNvbJSfrWHtOrmmhBPnLUCDbqfanHSGtSuNGvbDaIEZgbHpQKHGSyzFpGcrrSJphpJmDSErSqqbkiohVyTKxCjthwOeYjTjZeGkOXmWlaGzseMOFtTDbNHlXRzOLhFPkPlVtYnVLHfjMoDJAzktccjqOpCkxNXLeaELmuAikbVcMRIfGACALjybJdtxjfHKbFDaMGnoiHftiEcGHxyaknzgfycfsumykpAjLFmCel
    Should Contain    ${output}    Executing : nNEyjiLbnlSFntEiAJJEXDxpFoCawfoTowfHmVzlbWzxVgMQNgLVaPBkIVibxzDTobUjVOnFAuMuNXFpamDgixRODsHoQwmohHWjzUKnnVpMvrELHKzDkhSHqxWuDgueBIixPAWgbDcOzjwtkKgpSAdKJzxgBnDSbpCkXtPVXTpIiPefKgJPvsfHIJxPuSzdaMShROIJJmrZPLCnhKVXAVoPCtqRtQqytHRaZBiTeqGnwpcJMxxoVDyvjzubvhJj
    Should Contain    ${output}    CommandsAvailable : HyPSxJsnxSWaEWvciIjSYdcJURDqUKcvpIXGszsGCNBysvjQmoEWpKSIWNOlVwELFrhrgKWMGbzoPXcugDhVRZPBFeIctWiuaGWhKsAriUtiRkYZkBkSONCFloxROMlQCczZqCVLbEaXJPeiBdZdiuErSZskowFDfeZEAATftWxEonKNSjbutXXOnDhTuDHnEZVsRdUsCSoIPycXDZjUUFvOcOvvSZPUDgZnGZHlyOgAmxhXbBrGBqGfHlbVeMsu
    Should Contain    ${output}    ConfigurationsAvailable : nhblXpMOhXoPHnSSzAdtvgFfsnRILQexwqZkeuNYWMWUBSVtdQuTAGTWllXuvVJhTkLlQdfXNPCoKJZBKcpwCENHGoKqCKupGKpGZMUFbGoEWqfmzpVwoOgeOAVACQiSnMhPZEWUibRWrcghbsqpFjkWgvYxfcWePWXDoZOHOeUnOqBOvmpAsfUgvJNcRsiHKuWHlyTqMgVqWqKZqtsZrywUEyBdzNfjaljWyHjvKjPHllBWJxTENhjsLRJIWqMI
    Should Contain    ${output}    priority : -1888199045
    Should Contain    ${output}    priority : -1319875316
