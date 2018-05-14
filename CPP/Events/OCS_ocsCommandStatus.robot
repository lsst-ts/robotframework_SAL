*** Settings ***
Documentation    OCS_ocsCommandStatus sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    ocs
${component}    ocsCommandStatus
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send zxjQYcipzpTNemVuaDsTtLfYxMmkphICOpAngRMjQlLdXmrEVCwrBimlmwEOOrlzZgWQpXRrgfymBULTTjUnDeTIkGqWzxrrHsgLzQCifhcHMtBvtmHESnhSpMShFCdbnhhsWHVElesumfETQImGcIXOLJqfLGYikepxtzSqFVnIffgiosAzrLuacKjTukZgDmsRENzsRhmEgMDBMscqaqWBIVMhTZvyjYGpoQywZnSllPwPMzGchmJxQaxZCmWE 1406363913 93.0987 pYbanQbKGNzlviYKAhpWpmOmLMOujpCKSjvQJdKdaffiUZNMUAUroGKdGPLRVLKsAziRCnuYkfaGRbLbUfPtYevkIsjXwDPnVXZMJopwGiYwzcFncyYCKvbZAcXxKlmaVkNcEFGrNKvPUCctUpjXaCQhyVvwCDPjZgdpAuduevsitQCiywvuBbToTGNHORcZgffRwzXcQPGshXJDgenPesblaQeaOneubCQOdiYAOeClWXVmHYBbvMjoJBHmPTKf dWfGyAsAmOOzuWsmYHOLFetrpVYZoUrUUCTUcLWdZiGgiqaXUQiwtiEtYNRgquNRxwIzDrFxccJlfJHtHPeZkStrklzydtcRYhMeTbbzSlJzTtqJpLsDdrsZrZujTncVpKhURnunmkdtkJIUIMSXUoXIikjizpqmNawqNWnmONFylTFWklYsrOXFxoQUZEIIpSorDizOaiaIqcjbfRUUxkFmdxKbaDoljDsmZITJLXJwONGpojhBKzjFTwDQVUyy 113963744 IPnnpuYgqRZfmurWNZzSfscmnVwANmeYiUuUuYnHFPZCwrrDmXWkfDKmBwTUKEpxqnRzZEERCNVJtQbaPptMLEXOIEiBhwhpEjoEQaZQufdqhQiOZhyPECRUFrEOGSDsoueVLnKOGIFWMUihYEEyCuZzxfxDWvxxdqgIpuYJnpkvHDITqgQSUTJvvkyYxgBUzdElJRlGdbpBJmhDdyNtGndKJKpteorrWexPeiwLGxINXeKiaJSgiHSuroHCPZdz 1835643870
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] ocs::logevent_ocsCommandStatus writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ocsCommandStatus generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1835643870
    Log    ${output}
    Should Contain X Times    ${output}    === Event ocsCommandStatus received =     1
    Should Contain    ${output}    CommandSource : zxjQYcipzpTNemVuaDsTtLfYxMmkphICOpAngRMjQlLdXmrEVCwrBimlmwEOOrlzZgWQpXRrgfymBULTTjUnDeTIkGqWzxrrHsgLzQCifhcHMtBvtmHESnhSpMShFCdbnhhsWHVElesumfETQImGcIXOLJqfLGYikepxtzSqFVnIffgiosAzrLuacKjTukZgDmsRENzsRhmEgMDBMscqaqWBIVMhTZvyjYGpoQywZnSllPwPMzGchmJxQaxZCmWE
    Should Contain    ${output}    SequenceNumber : 1406363913
    Should Contain    ${output}    Identifier : 93.0987
    Should Contain    ${output}    Timestamp : pYbanQbKGNzlviYKAhpWpmOmLMOujpCKSjvQJdKdaffiUZNMUAUroGKdGPLRVLKsAziRCnuYkfaGRbLbUfPtYevkIsjXwDPnVXZMJopwGiYwzcFncyYCKvbZAcXxKlmaVkNcEFGrNKvPUCctUpjXaCQhyVvwCDPjZgdpAuduevsitQCiywvuBbToTGNHORcZgffRwzXcQPGshXJDgenPesblaQeaOneubCQOdiYAOeClWXVmHYBbvMjoJBHmPTKf
    Should Contain    ${output}    CommandSent : dWfGyAsAmOOzuWsmYHOLFetrpVYZoUrUUCTUcLWdZiGgiqaXUQiwtiEtYNRgquNRxwIzDrFxccJlfJHtHPeZkStrklzydtcRYhMeTbbzSlJzTtqJpLsDdrsZrZujTncVpKhURnunmkdtkJIUIMSXUoXIikjizpqmNawqNWnmONFylTFWklYsrOXFxoQUZEIIpSorDizOaiaIqcjbfRUUxkFmdxKbaDoljDsmZITJLXJwONGpojhBKzjFTwDQVUyy
    Should Contain    ${output}    StatusValue : 113963744
    Should Contain    ${output}    Status : IPnnpuYgqRZfmurWNZzSfscmnVwANmeYiUuUuYnHFPZCwrrDmXWkfDKmBwTUKEpxqnRzZEERCNVJtQbaPptMLEXOIEiBhwhpEjoEQaZQufdqhQiOZhyPECRUFrEOGSDsoueVLnKOGIFWMUihYEEyCuZzxfxDWvxxdqgIpuYJnpkvHDITqgQSUTJvvkyYxgBUzdElJRlGdbpBJmhDdyNtGndKJKpteorrWexPeiwLGxINXeKiaJSgiHSuroHCPZdz
    Should Contain    ${output}    priority : 1835643870
