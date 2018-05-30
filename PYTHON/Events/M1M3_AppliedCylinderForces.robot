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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 80.4954 1088530340 2117733566 1871905383 -832334253 51012273 1635596057 1788046747 278685380 444874137 1568149202 -1761536291 196537388 2080924451 1422915577 389998666 1058786857 1675342653 2140280567 277080546 -1212304490 93388223 -1419337058 612761370 1133722520 673706399 -2015301932 -1826072442 -1228058121 942696940 626379937 1453565917 -1832798841 -455974209 -361527032 -1903939926 -605840334 131083512 2137862250 -512483077 -1473612205 2043975302 -1392841702 2014428001 -1017280916 -1842640716 1017651062 -1436784295 -1194891318 208925781 131623888 444101746 295193315 222625908 -935171670 -2039303825 -689113413 -384748876 -1268744474 1413883977 -1295882843 1390186031 -550642283 -380841660 -1661937058 1704942010 1618292464 1602365789 1864496647 895116809 -1502453006 -1806483445 1697521856 892074867 2121885388 -357294683 1281210346 -339372678 1134221112 1305591578 681048972 -979401974 -789715607 -922529771 -609876035 119580161 -716041113 1603274748 1179105850 -377572297 -1578071028 -1277140813 -1947268597 1219128907 910174234 -126988379 -15987928 2122794721 -732619774 1565099632 -414099728 1600160281 1662984438 -1418604539 -1859865619 1844582797 -1014605555 -1300696434 -344541505 1022964949 -392026283 814195448 -1364721330 677547209 -1620155330 -1946290574 1284282534 -1691582512 1807931610 -1398998682 -1812769080 1130400571 -664369517 -521013639 1198859361 -1022177570 726189111 -1041138828 -1618794383 -1369655128 -179562513 279175244 1421825774 -408636754 -1781376691 -1115822128 858552059 -703996905 -250429268 578538146 164331644 783191538 -1593760320 77893725 -325623693 1000924485 -428242758 -430569125 626050604 1600968678 -1929933187 1438298765 1032688130 -1670446973 -1433759286 771326565 1586581177 -1024219397 -2010531024 -1368943369 -1798938252 -1756441446 -1746471442 -2137406161 1123806681 946003226 -279787756 973208265 964050198 -1083874749 703449400 -453384338 1393395974 1026028636 -1786508719 -1728129320 1180151152 508146542 -1807476980 998510621 240015328 -1939135889 -1888944079 1770799804 -570573434 -1785786659 1993394436 719915382 2090013485 -2018082203 -1603838028 -1333184093 2027572546 1170191128 -995570477 -633451742 324625825 15075194 1861536463 1692335355 -1282776107 -1585497441 -486713164 465201486 -776425384 -1168159488 -347857557 -643623792 -1144430488 1832854772 -200976805 388043335 -1339231735 -1913536195 2127143788 -182103598 1399878451 -132893359 986757393 1999531327 -1552581191 -1808709294 176121923 -2137336843 -506646208 16153484 874372444 -354309918 1854605167 -1890113568 -268139232 901084805 -812758319 -732413650 -969138125 -22608859 -617498243 1046013157 1910576001 1533737389 594071497 -1482246871 1873555667 -1029213316 -1756595624 -1900427093 -2120194970 2030887341 1792168820 -1541163705 1629043739 992497745 660391278 477111439 -1923775619 1217452705 -1762200044 -961431581 -2048206454 -15214547 -914747686 -1187736915 1011822116 786176108 1888611917 -85059062 -1193118717 144448919 -1447789776 1320208431
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
*** Settings ***
Documentation    M1M3_AppliedCylinderForces communications tests.
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 77.8041 -1873193677 -876385784 1609844849 -142308701 1802508429 -1936667620 834524217 -1631467251 1440741075 226227568 -106051583 1155802649 180890678 -696968100 1636151428 1057827097 2127207381 -564081635 1568583366 -195996738 -188369358 -2146906717 192374044 -1771784949 411630297 582330376 -1228455233 101089823 1472257931 -914193318 -1199088784 94845615 -408316483 1298733800 -13647699 -1232000740 -2082979266 -1590178768 -395717921 2087307251 178038157 -308089169 198451236 866739210 -1592360328 1102522174 -1372346209 1693129260 487473549 817671566 -1809480179 1820872733 -938579809 1214072745 -1896432782 -649198728 60989436 -898714652 -87137829 2146026426 -2099239447 -574265497 -300814611 279191986 -638527007 -1051800900 -92606861 -970104896 -2136406522 -1772248466 -591294483 473721919 768593358 1664538825 1205293132 128486404 -1281022465 -1397330300 -758439878 -1330440640 -2137585169 1543776579 -766507082 -1361021125 -377497944 -2013160833 -57432851 130088709 -2066575428 -320525224 1620214722 -799731018 605114562 567116061 -1502965905 -870291592 1816284675 4076595 598883689 184410089 1681066222 1733694698 -785039810 2135124290 -1844054532 -1122789432 -2038307687 -1634822353 -1161084017 -2107406338 -1747945807 -48676612 -1097754805 897729310 -855315380 990880402 -2059240720 -1979165148 1535652086 -676624135 1874140208 -751327553 973584287 -2021192815 290980044 -1401195324 346330615 -1109770905 -186182216 365630797 1391887985 1010768099 1174540234 1222516376 -1998167639 -898404905 -1964012494 263223718 -1163945668 603326211 390919541 -1542119715 -732341395 991611550 212025361 1577559938 -1819914004 -2091666571 1634425213 -982760041 284129065 -803919958 1721449594 -1266964480 20412839 -1499762679 -1975598200 -1753827647 1076262561 1352251604 1476021354 518587566 -1431944335 2042805650 -1498900439 1528165762 -900892219 1795804236 1466294365 -96877185 -1696936762 -1020256986 87362361 1170026826 578009027 1240441450 698415995 -768804912 658454148 -1913811852 1698865064 1656775463 -1600430153 562146406 1700266854 805201394 1096999693 166589023 -832436290 -1524052468 -1743521350 -1581984358 -1270528393 119696809 2095284416 742232159 1061085498 -1204761221 249788634 579942397 1165374075 -213772017 -1065587050 -515491133 1286718001 -350873401 791604440 274652805 -1755333119 196877831 1426215775 2106391525 1946853023 -1499860674 -1937819447 1951734616 -1868171897 2070926938 -1382526576 1307667906 -1684207269 1975731930 -1366452293 634007793 -469051527 252459345 -1574778017 -1407653967 -2005434367 -957082744 -569857859 -1742568205 1051656107 -201379753 1025317430 1684931124 -918712129 1327428167 602691581 -1099259075 -2144249786 2051686898 685369178 1021111155 688205744 -1935361074 480389814 1138162411 697702515 8756299 1040052629 2003376146 556700518 1772147433 -857263726 -43325334 1262628416 -1787802479 1642194057 19913692 1384809433 -382673404 1849439505 1711261999 -2117354483 1896876426 -1321400637 1880450524 -1573035818
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
