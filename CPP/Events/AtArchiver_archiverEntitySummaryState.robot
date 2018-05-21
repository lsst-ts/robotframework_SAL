*** Settings ***
Documentation    AtArchiver_archiverEntitySummaryState sender/logger tests.
Force Tags    cpp    TSS-2674
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send ClzQohXqYSbNYmzmZovXpXqxUHSpJmkAntnuElRGEeUZNIebnVqlkFZCGzZxpbATTkzKUyhHaEQFfDnwjpwwXsCxlzNbMOeolJdjyOZVSAzMCaMNsKBvXuxnoffTwMQm 55.0982 tlFpcoNyuYAYkKKeCQqvWIfGeINWeeLdVSpJFkFkWDNPzJTQSJwNjRCLJZIajefBeAypMoGRqDBClRQNIDXEeqZfEpSYTRiYTMOoFqcwBeEeldNSMBLqtRanlIxgDptVscEwqAvYMamOtmBoTbmPONIPWKZhdKBxDyAqTOjpEyTHlaPsQhsXzjoQlyOOoGMFGQySwyerlcuewLnIQXDzGiBnqiyYeHTGLooHQgoHaUfEVwURlOSoOGdZSUEuWQoG 448893888 bguPGhgifplItyknmVmeRmYqtLdKNPaQcWwClIOndkCRfkGAcnWzOQXKdBHLVHJiuaqSNUpACsKuzboVvRCMHfCpMpTBBYquZIqstVhDRdAarUvzrwFIzSYdtNtFPlkL OAykAdKcxXtftdtDawkiLVXYhFUSMLdyiboZKBVGOSwGqvDRBdvinbqCoNuuMXcZilpXddysgAZuasfhxSfZGfKeXTtPfJNytTzoztVDQCClVLRYOGJmbPtiSSbtxpTY kLiDEJUELLbdJWYIbAPVCQuVZXhBKXpSyPQHTnGXeVbgjeyBzsOWUXxXwdjWndxVNkJLImrBrDycADijEBGBVTBJMbbJzuDxoKGJwYMdsQjwGWWkWozjJEmUYRTQmxQv QgGWXwLgIlJtLamvOrtcyMaPfrYJHwHDDjGilMqawkzQSaBpDwbeWXQalMilEaVJuDjtxCkLcBQfTJulpwYAEGddKaZiraMuCbkBRgVhPXWaPmlDXbmnqSSHVFmDiCec ycgqdMKWzeSSlCewbAXcoRltbgkWmKSWWuEXBzEVrXgFuxzxCisXxPsmROMgqWJCCOgTQsFrsabvTBKqiaffNaEwUvxTOvGQwLNZLZsvpYvSXpTmaxDQIwcupngGOUmt -1829017233
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atArchiver::logevent_archiverEntitySummaryState writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event archiverEntitySummaryState generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -1829017233
    Log    ${output}
    Should Contain X Times    ${output}    === Event archiverEntitySummaryState received =     1
    Should Contain    ${output}    Name : ClzQohXqYSbNYmzmZovXpXqxUHSpJmkAntnuElRGEeUZNIebnVqlkFZCGzZxpbATTkzKUyhHaEQFfDnwjpwwXsCxlzNbMOeolJdjyOZVSAzMCaMNsKBvXuxnoffTwMQm
    Should Contain    ${output}    Identifier : 55.0982
    Should Contain    ${output}    Timestamp : tlFpcoNyuYAYkKKeCQqvWIfGeINWeeLdVSpJFkFkWDNPzJTQSJwNjRCLJZIajefBeAypMoGRqDBClRQNIDXEeqZfEpSYTRiYTMOoFqcwBeEeldNSMBLqtRanlIxgDptVscEwqAvYMamOtmBoTbmPONIPWKZhdKBxDyAqTOjpEyTHlaPsQhsXzjoQlyOOoGMFGQySwyerlcuewLnIQXDzGiBnqiyYeHTGLooHQgoHaUfEVwURlOSoOGdZSUEuWQoG
    Should Contain    ${output}    Address : 448893888
    Should Contain    ${output}    CurrentState : bguPGhgifplItyknmVmeRmYqtLdKNPaQcWwClIOndkCRfkGAcnWzOQXKdBHLVHJiuaqSNUpACsKuzboVvRCMHfCpMpTBBYquZIqstVhDRdAarUvzrwFIzSYdtNtFPlkL
    Should Contain    ${output}    PreviousState : OAykAdKcxXtftdtDawkiLVXYhFUSMLdyiboZKBVGOSwGqvDRBdvinbqCoNuuMXcZilpXddysgAZuasfhxSfZGfKeXTtPfJNytTzoztVDQCClVLRYOGJmbPtiSSbtxpTY
    Should Contain    ${output}    Executing : kLiDEJUELLbdJWYIbAPVCQuVZXhBKXpSyPQHTnGXeVbgjeyBzsOWUXxXwdjWndxVNkJLImrBrDycADijEBGBVTBJMbbJzuDxoKGJwYMdsQjwGWWkWozjJEmUYRTQmxQv
    Should Contain    ${output}    CommandsAvailable : QgGWXwLgIlJtLamvOrtcyMaPfrYJHwHDDjGilMqawkzQSaBpDwbeWXQalMilEaVJuDjtxCkLcBQfTJulpwYAEGddKaZiraMuCbkBRgVhPXWaPmlDXbmnqSSHVFmDiCec
    Should Contain    ${output}    ConfigurationsAvailable : ycgqdMKWzeSSlCewbAXcoRltbgkWmKSWWuEXBzEVrXgFuxzxCisXxPsmROMgqWJCCOgTQsFrsabvTBKqiaffNaEwUvxTOvGQwLNZLZsvpYvSXpTmaxDQIwcupngGOUmt
    Should Contain    ${output}    priority : -1829017233
