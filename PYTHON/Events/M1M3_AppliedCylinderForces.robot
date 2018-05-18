*** Settings ***
Documentation    M1M3_AppliedCylinderForces sender/logger tests.
Force Tags    python    TSS-2617
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    m1m3
${component}    AppliedCylinderForces
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp SecondaryCylinderForces PrimaryCylinderForces priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 65.4207 -122692371 -2114487894 -1840685642 1297050213 546649821 -601186846 -445246006 -824035721 297459079 2112094632 422738229 -1260892341 1581677931 -880781848 605904833 -1794377914 486595950 1376719158 807808885 -1202675977 1830090681 -1412504544 499903822 1743373923 1644820040 -1990673832 -1748386012 -447576365 -1637427318 -2130889561 -400085320 -2116402511 542604558 1732791045 -1536907161 -1802125988 950132677 167070525 -1016444070 -1388626200 -719587963 657358544 -1114857476 1239282006 791998018 -2001322248 1706507133 2067010970 85090770 321969209 1998223504 1720032126 -948327693 831653971 -1854933089 1528195632 -46782757 2028313997 303468398 757509212 -908443325 1228215924 -305702196 -476441221 -1412714429 -873892553 -2053174858 1754786723 1905385377 1122833795 -1682444996 -503514978 1646763903 788989708 1949635800 292467284 885665111 855168038 -653520172 1547545883 1857054683 -1085597262 557979209 100921948 378720283 -1498085448 -1118174014 -801102173 -524231946 -1205882073 -987952891 -1953834542 -334434501 647186995 153304351 595316265 -673110652 -1794145726 197849474 1494972065 283136404 1149438241 -245749692 -725192028 -1679789576 1147671863 -1672463707 1948518243 -1748275956 -1743933368 2147019500 929571895 -579072562 -1631096223 -210314891 35274290 -1685594126 -419153216 1618539310 -77539202 2061635307 992139347 1523878326 334496814 -1913072884 -1933199374 506555364 -1933629075 339157611 317179647 -671576510 -187266743 914464749 200304858 2074473691 1791210513 1620227952 1965374996 803402081 -1143172303 219990380 559948401 1717163157 1669946108 912082955 517386961 -140808564 1978790876 -1919936179 1830206809 777471730 -1422438905 -907094682 -29100930 -1892263218 -177682091 1523760162 1339830402 -915146801 1017089358 -106770655 973756161 -2069731497 -664114523 751853640 1760276285 702191824 976840460 440122116 830580991 -2146561244 1942294175 2105276006 1573889902 1755853146 1344599462 1951679009 2134807837 -1723843588 -1926705949 2006478662 2056187535 832847101 295489960 -495038146 1552663821 1697453576 644000653 -2068417539 -1558917476 635159510 1298203745 -228345573 -1058301954 -956669454 -2125406778 2135862787 1331381408 -620750050 756797625 -1911683655 145259071 1882468367 1690907522 1757380702 -1762375942 -927147984 -13647446 -1086095050 1094421793 -1187347631 -1128073113 -726140558 1418301494 461293496 883786656 -355378619 1622803891 957302863 -2076616766 1662083469 901094709 412795781 943908353 125672094 -1339206944 1496956323 -1160082724 -2070902183 -426266383 -1465667879 644318247 1374430868 527806824 -1391934238 168030150 1727209991 -1500982283 -162648310 1980937824 1979262042 1333656521 719004979 513713843 -1992162224 -1493102699 -494650256 -1947715483 1179331278 1260725563 -509492402 1975246635 -1029769933 -855650534 -2146891272 1608504385 1033829266 -1555889648 1020124934 -1016086980 1437988889 -2134022207 660704456 -881258779 317481692 865795652 1790770681 -510579464 -328039535
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedCylinderForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
