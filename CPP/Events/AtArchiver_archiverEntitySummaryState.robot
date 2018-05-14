*** Settings ***
Documentation    AtArchiver_archiverEntitySummaryState sender/logger tests.
Force Tags    cpp    TSS-2624
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atArchiver
${component}    archiverEntitySummaryState
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send BSNPJabWxUxOTGfaPwstDFsbvzVwdebonDwsxduAPMGNwbMoFfuPciZDMWUvCkaDQavoKAEqApBaAvsDtAjTWUkVmeYZxcELOClgdYTnqkkRLpJtkJOCRydHtHqQhcjP 71.7617 eeiuAXDQbrIKVazfKowViEYwcBvXMaggtTaRQUBOOKlnSYKiIDCNevOBKzqfUcOJLTmnhAybTRejkGMbecVIMdWNPRcroqPuNEvvlWNNADMgIPLUgTcXTyuAKEyyypzXOsbuXePIYLPGasfsnfoSbXpBRWhJwnAFfXuyDRsgsGYlTdcISTNCydtQMCgNqgfGgPsGmeZbsxewgZrSCQFSJOvoCPSKlGWHcUCyjKwqPlaQYRzrnsgnftjBjbpxuLeh -1086283160 BRmNUqiqfxAeOlUDlvdztwlRaSOALhAvrYEYMHUssclfklruJjXVFmrOINQQKWerTEgTOKcXKcoBAdhxTRqinTUJZMVEWUYhLdfofbAoAsLNwsURkGfenoYwcVzaVhLX qpDhEMiCVPyEPvHfNcwLrbNAzprhqCzKLlLBeSdnqcxnCKuIPBngFazxCDlrcyfaTHVUoHrxOmlQDhnZMrGQxdeNMBGqLCTYSjuAyDIydRYShbtDwrbYivdHRRMemsir ZVBgUzhZMxaaPnbPqQvHrnhgQswxBJuZRbFLNstRerebZGCaMMGScHypTLqzUxJAdVNDVtTsWNAWkEEqADSKNpDGPEpXazxgyuJfraUOcPVcbnpCKFiAoiVPdNXCwoou asWxmAxzhIVjbVWZNujSOLLmytYEnghpEJMvcgRQxZKHeYKdSkKbuFyrOJHCtIJLXBkecEbcdwRwJNqlCXXuFVciLAiZBKhYbeQlWpxWRQvwixNUHUYHxjgnERqyHwIZ UsUPeamUwhaIPBNwVkTApvCFyrhjRmVdLgnxOuKIQLpfpHHeZiAfjikyXcEXGKEPIOjXnLBvpWIYXHwKdXAKQagYPJMYIFMqleKqINUrcUPuABapRLYZHrevuxDxxpch 1524214062 1136891047
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atArchiver::logevent_archiverEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event archiverEntitySummaryState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1136891047
    Log    ${output}
    Should Contain X Times    ${output}    === Event archiverEntitySummaryState received =     1
    Should Contain    ${output}    Name : BSNPJabWxUxOTGfaPwstDFsbvzVwdebonDwsxduAPMGNwbMoFfuPciZDMWUvCkaDQavoKAEqApBaAvsDtAjTWUkVmeYZxcELOClgdYTnqkkRLpJtkJOCRydHtHqQhcjP
    Should Contain    ${output}    Identifier : 71.7617
    Should Contain    ${output}    Timestamp : eeiuAXDQbrIKVazfKowViEYwcBvXMaggtTaRQUBOOKlnSYKiIDCNevOBKzqfUcOJLTmnhAybTRejkGMbecVIMdWNPRcroqPuNEvvlWNNADMgIPLUgTcXTyuAKEyyypzXOsbuXePIYLPGasfsnfoSbXpBRWhJwnAFfXuyDRsgsGYlTdcISTNCydtQMCgNqgfGgPsGmeZbsxewgZrSCQFSJOvoCPSKlGWHcUCyjKwqPlaQYRzrnsgnftjBjbpxuLeh
    Should Contain    ${output}    Address : -1086283160
    Should Contain    ${output}    CurrentState : BRmNUqiqfxAeOlUDlvdztwlRaSOALhAvrYEYMHUssclfklruJjXVFmrOINQQKWerTEgTOKcXKcoBAdhxTRqinTUJZMVEWUYhLdfofbAoAsLNwsURkGfenoYwcVzaVhLX
    Should Contain    ${output}    PreviousState : qpDhEMiCVPyEPvHfNcwLrbNAzprhqCzKLlLBeSdnqcxnCKuIPBngFazxCDlrcyfaTHVUoHrxOmlQDhnZMrGQxdeNMBGqLCTYSjuAyDIydRYShbtDwrbYivdHRRMemsir
    Should Contain    ${output}    Executing : ZVBgUzhZMxaaPnbPqQvHrnhgQswxBJuZRbFLNstRerebZGCaMMGScHypTLqzUxJAdVNDVtTsWNAWkEEqADSKNpDGPEpXazxgyuJfraUOcPVcbnpCKFiAoiVPdNXCwoou
    Should Contain    ${output}    CommandsAvailable : asWxmAxzhIVjbVWZNujSOLLmytYEnghpEJMvcgRQxZKHeYKdSkKbuFyrOJHCtIJLXBkecEbcdwRwJNqlCXXuFVciLAiZBKhYbeQlWpxWRQvwixNUHUYHxjgnERqyHwIZ
    Should Contain    ${output}    ConfigurationsAvailable : UsUPeamUwhaIPBNwVkTApvCFyrhjRmVdLgnxOuKIQLpfpHHeZiAfjikyXcEXGKEPIOjXnLBvpWIYXHwKdXAKQagYPJMYIFMqleKqINUrcUPuABapRLYZHrevuxDxxpch
    Should Contain    ${output}    priority : 1524214062
    Should Contain    ${output}    priority : 1136891047
