*** Settings ***
Documentation    OCS_ocsCommandStatus sender/logger tests.
Force Tags    cpp
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    ocs
${component}    ocsCommandStatus
${timeout}    30s

*** Test Cases ***
Create Sender Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Sender    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

Create Logger Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Logger    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send pUAaMkhVhWfvjQXUMzOQKQOJOUGiXhhcSGRmlMgflGjSBrjzfhFjfllUEmvgKKrGGFvvogifaBVMfhVCuZrwzVfQxnPlsDiuDOWPavyBHlWDprTzeEZHfBEoPtIzfonyqBrmyvZrRcIgLvvtybFPDcaGqAysDYDSXHPOfOWYetYbJmzuoHZvpWUujFNfzQILYbvtwloDrZAIwWqnccvsFaeTmZtequnucSTBofRzVOaXuPNnBIAExTmEdJMuwwEP 276184587 22.8128 jbUhjsPIxbBfcNLlnBLkVZLgwerGhXtRNZHLSNruPpPZiKiNjFAuRgjIqOhZlcRuABgBEKWjNEoLVjHKBLDfAzpfnkuvdiuVJTzrozMzhVdCvievrHqMMVweUSFlaZdkHtKqWmZuBhMWtUvQsVkEOCXGPWuiygWnpOdzGOdQyGryewbMOqFJCtEgYmaHjFIcEVqsqWZYDCaquBDHwccToTtiaFBljhbrknWvmIvslLUnokuJtOxFnKrnrbRCCcrC vXHzasyqDFwJIEAmTfamMReBBcoISCPQRayFlEyFSmHtAETWNovEbpUdJcgSMdvggfiGYxqXyUqBpGpNoPERMbmXOYipTjzxBILsoLHqImTzjkDiHxWuXVdwFRYwFRghgpYzZvaBHTsNxXpTVqljfVjfwmaPlNYYIXaWgEHUymOAuiIXmIHumfUDsnvpytEhnCtMwqDJFGgEVQyquHHHzmarrhBwQUOEtfoLojoFJxOlAqfYdxSCGgiboSrtuWZa -293066083 YmzYJyehaVgErvLKZQchEFRTCxUIDqGqbvrqJoyNMYXdbICNOkdaCeIEajrUIJispNqgVJZnEYkWHcyNrJKcvhZrhQFqqNOUFwHrrNgvFwXTtnnbSmAgniHEUcvvNHtQMMzcaXmegxikHwwdLKRIqphTJJxDGcltIdLqpamNRynNAIllicdrhEMcTHcpWUcBbhUugRVXBQUnDvNPtlusKzISAHESPKvZDxwzaKmoxZnNxPrELaQqfyFRcqVprMAH -288597462
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] ocs::logevent_ocsCommandStatus writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ocsCommandStatus generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -288597462
    Log    ${output}
    Should Contain X Times    ${output}    === Event ocsCommandStatus received =     1
    Should Contain    ${output}    CommandSource : pUAaMkhVhWfvjQXUMzOQKQOJOUGiXhhcSGRmlMgflGjSBrjzfhFjfllUEmvgKKrGGFvvogifaBVMfhVCuZrwzVfQxnPlsDiuDOWPavyBHlWDprTzeEZHfBEoPtIzfonyqBrmyvZrRcIgLvvtybFPDcaGqAysDYDSXHPOfOWYetYbJmzuoHZvpWUujFNfzQILYbvtwloDrZAIwWqnccvsFaeTmZtequnucSTBofRzVOaXuPNnBIAExTmEdJMuwwEP
    Should Contain    ${output}    SequenceNumber : 276184587
    Should Contain    ${output}    Identifier : 22.8128
    Should Contain    ${output}    Timestamp : jbUhjsPIxbBfcNLlnBLkVZLgwerGhXtRNZHLSNruPpPZiKiNjFAuRgjIqOhZlcRuABgBEKWjNEoLVjHKBLDfAzpfnkuvdiuVJTzrozMzhVdCvievrHqMMVweUSFlaZdkHtKqWmZuBhMWtUvQsVkEOCXGPWuiygWnpOdzGOdQyGryewbMOqFJCtEgYmaHjFIcEVqsqWZYDCaquBDHwccToTtiaFBljhbrknWvmIvslLUnokuJtOxFnKrnrbRCCcrC
    Should Contain    ${output}    CommandSent : vXHzasyqDFwJIEAmTfamMReBBcoISCPQRayFlEyFSmHtAETWNovEbpUdJcgSMdvggfiGYxqXyUqBpGpNoPERMbmXOYipTjzxBILsoLHqImTzjkDiHxWuXVdwFRYwFRghgpYzZvaBHTsNxXpTVqljfVjfwmaPlNYYIXaWgEHUymOAuiIXmIHumfUDsnvpytEhnCtMwqDJFGgEVQyquHHHzmarrhBwQUOEtfoLojoFJxOlAqfYdxSCGgiboSrtuWZa
    Should Contain    ${output}    StatusValue : -293066083
    Should Contain    ${output}    Status : YmzYJyehaVgErvLKZQchEFRTCxUIDqGqbvrqJoyNMYXdbICNOkdaCeIEajrUIJispNqgVJZnEYkWHcyNrJKcvhZrhQFqqNOUFwHrrNgvFwXTtnnbSmAgniHEUcvvNHtQMMzcaXmegxikHwwdLKRIqphTJJxDGcltIdLqpamNRynNAIllicdrhEMcTHcpWUcBbhUugRVXBQUnDvNPtlusKzISAHESPKvZDxwzaKmoxZnNxPrELaQqfyFRcqVprMAH
    Should Contain    ${output}    priority : -288597462
