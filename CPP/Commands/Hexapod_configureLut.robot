*** Settings ***
Documentation    Hexapod_configureLut commander/controller tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    hexapod
${component}    configureLut
${timeout}    30s

*** Test Cases ***
Create Commander Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Commander    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}

Create Controller Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Controller    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Run Keyword If    "${ContInt}"=="false"    Login    ${UserName}    ${PassWord}
    Run Keyword If    "${ContInt}"=="true"    Login With Public Key    ${UserName}    keyfile=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}
    Directory Should Exist    ${SALWorkDir}/${subSystem}

Verify Component Commander and Controller
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_${component}_controller

Start Commander - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   Usage : \ input parameters...

Start Commander - Verify Timeout without Controller
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 28.6386 92.4719 57.6732 96.915 34.4736 18.4933 38.9354 79.6848 76.3917 37.9794 5.0505 54.8813 21.3339 68.0829 53.3299 13.6767 8.9487 47.8109 77.0427 77.3361 42.8018 15.58 18.287 17.8383 23.9142 28.0581 60.2481 66.935 8.2694 65.8601 86.1706 22.3397 45.0225 47.5031 67.1571 98.4653 5.4475 54.1795 99.5839 92.8781 77.2734 39.0034 7.5151 8.5687 94.4727 9.7784 42.8895 25.4871 71.7387 3.3511 46.5886 74.1326 35.4641 54.8811 24.798 62.0574 5.8922 99.6661 79.3148 57.5515 45.6979 8.1376 58.0102 56.2946 54.2152 41.3449 46.9268 41.7041 89.3656 60.3796 67.9494 25.3831 78.8111 7.9289 96.6838 32.1904 77.8338 49.753 47.3729 65.3288 44.6242 21.7067 28.7397 36.6913 23.2786 9.8595 21.763 5.1933 12.7334 56.4324 26.4434 97.3124 20.0619 66.2008 60.1888 34.8376 50.9968 18.497 93.1257 75.7863 66.0561 0.8195 73.4618 78.1498 51.9586 95.205 34.5977 38.7276 73.5789 16.3541 89.8274 76.5577 96.3203 56.6318 21.9188 20.0001 50.5914 99.1558 63.3413 11.9486 53.954 25.6505 77.5634 49.354 92.4828 65.6714 97.3743 70.8611 13.8854 17.8688 89.3181 72.1803 55.3719 73.4353 91.5104 83.7529 25.6295 38.8099 73.0109 23.3512 13.2814 42.7679 7.287 2.5457 98.5051 48.3261 89.552 5.9957 87.7765 75.591 44.7413 31.7142 4.8657 86.8573 3.1607 23.5468 29.1205 65.2538 89.3276 21.1603 54.0536 60.2387 85.9062 10.2651 49.7078 33.5892 65.4659 3.4252 47.2609 42.8674 36.754 87.9109 94.4022 48.0584 36.0708 14.9768 14.6108 48.9329 38.4721 21.179 40.6851 86.2001 7.0884 75.6831 51.7757 82.5059 63.2261 34.1078 86.3007 14.2802 79.9966 26.1154 59.8022 32.0845 80.2652 66.1261 67.6245 95.4095 84.0712 80.7254 62.3013 86.3174 97.8345 95.54 81.1937 15.5812 59.0669 74.8762 40.375 91.9145 42.2558 41.6156 70.0015 48.5453 99.4704 63.219 23.4182 79.7142 53.1143 42.3541 25.6088 65.9045 79.4497 18.0987 21.984 64.4318 43.5522 94.0821 16.919 44.7758 21.4801 56.2881 6.1659 91.2464 41.6403 19.1929 22.7635 50.7862 85.8867 12.455 14.4063 62.3973 93.2564 14.2292 78.2427 47.4016 43.0117 77.3558 88.4146 81.7701 29.8326 96.8506 51.4134 13.2938 2.553 31.5255 6.5218 4.7313 30.4826 65.6234 67.4772 50.2776 85.7605 8.357 14.9988 87.7029 24.2874 89.6534 67.0533 25.5907 86.6746 51.791 74.476 32.8649 39.3939 97.4731 15.9176 95.9964 33.1764 11.1093 22.9949 54.7525 39.6365 82.1994 5.8734 68.0084 99.685 69.5927 38.1322 67.7492 90.3566 14.2887 90.5449 49.4118 42.3132 44.3154 54.1357 49.3442 85.777 32.2796 7.6689 98.2249 33.0501 0.592 95.0349 38.2441 84.0638 78.815 50.3534 1.0738 72.733 98.4307 65.2984 13.3185 36.4983 14.2268 68.4414 75.5682 61.9721 16.992 85.3186 74.1562 76.984 55.8502 95.2731 37.1963 30.0044 95.7226 23.6442 8.2692 11.005 15.2344 22.3383 36.7423 31.7983 16.0155 85.5074 90.1127 43.285 39.1737 21.083 60.5658 78.2303 73.021 22.4308 79.1556 59.9319 42.4742 45.0355 91.0974 19.9697 79.8525 72.5332 17.6998 32.2238 75.0778 86.1005 65.5801 96.784 99.1896 42.011 46.5246 6.2319 25.9036 85.9162 65.5665 86.0778 86.9979 96.9268 5.8688 40.0495 96.9905 92.6792 40.1003 38.4404 67.4849 91.7213 23.9672 43.4591 65.6283 4.3142 83.8934 30.5802 52.9915 64.6227 8.3704 16.5033 81.3058 22.5549 45.1605 93.4785 92.4601 76.7875 39.3807 33.849 46.6657 78.7402 85.9221 29.3029 1.1439 67.8505 73.2714 64.2627 52.0416 42.9501 38.6202 41.0111 59.4249 22.3216 59.4171 51.6618 89.5297 53.0101 99.0078 82.9077 65.3408 84.7444 17.2427 63.6652 39.9473 22.6383 3.2348 15.0995 48.7169 77.1287 56.2907 52.1719 87.4398 91.3194 28.1949 14.7428 25.6127 44.6583 53.9867 11.7501 76.755 22.8243 71.8316 58.3354 53.9797 41.1794 12.9038 47.4463 9.3704 43.7192 32.5674 26.7987 35.4779 34.2159 83.9465 77.0431 3.4774 46.4996 40.6835 55.0589 85.1959 89.027 13.2019 34.1659 98.8259 71.4508 3.6663 98.6807 52.8414 87.554 70.096 69.2722 44.4111 61.362 9.0468 98.3557 1.0061 89.3839 50.6055 94.6027 72.1401 55.3835 2.5363 6.1239 1.6026 94.1024 95.1958 87.8391 88.3327 62.5444 65.8283 38.7679 17.7799 40.5559 76.1481 80.8294 75.5297 8.2213 71.5146 20.9631 63.8621 46.0671 72.2561 78.3414 70.7582 28.9821 48.223 86.9009 83.4478 12.1545 98.6431 23.1112 79.3087 14.0654 81.3645 42.1596 62.5441 18.6747 91.8768 14.6205 24.9549 45.705 74.8251 24.4003 67.88 19.6626 81.8454 63.618 83.5728 62.5747 25.2952 79.783 10.3103 98.4692 37.9291 46.5996 8.4466 27.6307 27.3522 19.068 50.5008 52.6247 66.0747 21.0952 17.0084
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    === [waitForCompletion_${component}] command 0 timed out :

Start Controller
    [Tags]    functional
    Switch Connection    Controller
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Controller.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_controller
    ${output}=    Read Until    controller ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} controller ready

Start Commander
    [Tags]    functional
    Switch Connection    Commander
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/cpp/src
    Comment    Start Commander.
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 28.6386 92.4719 57.6732 96.915 34.4736 18.4933 38.9354 79.6848 76.3917 37.9794 5.0505 54.8813 21.3339 68.0829 53.3299 13.6767 8.9487 47.8109 77.0427 77.3361 42.8018 15.58 18.287 17.8383 23.9142 28.0581 60.2481 66.935 8.2694 65.8601 86.1706 22.3397 45.0225 47.5031 67.1571 98.4653 5.4475 54.1795 99.5839 92.8781 77.2734 39.0034 7.5151 8.5687 94.4727 9.7784 42.8895 25.4871 71.7387 3.3511 46.5886 74.1326 35.4641 54.8811 24.798 62.0574 5.8922 99.6661 79.3148 57.5515 45.6979 8.1376 58.0102 56.2946 54.2152 41.3449 46.9268 41.7041 89.3656 60.3796 67.9494 25.3831 78.8111 7.9289 96.6838 32.1904 77.8338 49.753 47.3729 65.3288 44.6242 21.7067 28.7397 36.6913 23.2786 9.8595 21.763 5.1933 12.7334 56.4324 26.4434 97.3124 20.0619 66.2008 60.1888 34.8376 50.9968 18.497 93.1257 75.7863 66.0561 0.8195 73.4618 78.1498 51.9586 95.205 34.5977 38.7276 73.5789 16.3541 89.8274 76.5577 96.3203 56.6318 21.9188 20.0001 50.5914 99.1558 63.3413 11.9486 53.954 25.6505 77.5634 49.354 92.4828 65.6714 97.3743 70.8611 13.8854 17.8688 89.3181 72.1803 55.3719 73.4353 91.5104 83.7529 25.6295 38.8099 73.0109 23.3512 13.2814 42.7679 7.287 2.5457 98.5051 48.3261 89.552 5.9957 87.7765 75.591 44.7413 31.7142 4.8657 86.8573 3.1607 23.5468 29.1205 65.2538 89.3276 21.1603 54.0536 60.2387 85.9062 10.2651 49.7078 33.5892 65.4659 3.4252 47.2609 42.8674 36.754 87.9109 94.4022 48.0584 36.0708 14.9768 14.6108 48.9329 38.4721 21.179 40.6851 86.2001 7.0884 75.6831 51.7757 82.5059 63.2261 34.1078 86.3007 14.2802 79.9966 26.1154 59.8022 32.0845 80.2652 66.1261 67.6245 95.4095 84.0712 80.7254 62.3013 86.3174 97.8345 95.54 81.1937 15.5812 59.0669 74.8762 40.375 91.9145 42.2558 41.6156 70.0015 48.5453 99.4704 63.219 23.4182 79.7142 53.1143 42.3541 25.6088 65.9045 79.4497 18.0987 21.984 64.4318 43.5522 94.0821 16.919 44.7758 21.4801 56.2881 6.1659 91.2464 41.6403 19.1929 22.7635 50.7862 85.8867 12.455 14.4063 62.3973 93.2564 14.2292 78.2427 47.4016 43.0117 77.3558 88.4146 81.7701 29.8326 96.8506 51.4134 13.2938 2.553 31.5255 6.5218 4.7313 30.4826 65.6234 67.4772 50.2776 85.7605 8.357 14.9988 87.7029 24.2874 89.6534 67.0533 25.5907 86.6746 51.791 74.476 32.8649 39.3939 97.4731 15.9176 95.9964 33.1764 11.1093 22.9949 54.7525 39.6365 82.1994 5.8734 68.0084 99.685 69.5927 38.1322 67.7492 90.3566 14.2887 90.5449 49.4118 42.3132 44.3154 54.1357 49.3442 85.777 32.2796 7.6689 98.2249 33.0501 0.592 95.0349 38.2441 84.0638 78.815 50.3534 1.0738 72.733 98.4307 65.2984 13.3185 36.4983 14.2268 68.4414 75.5682 61.9721 16.992 85.3186 74.1562 76.984 55.8502 95.2731 37.1963 30.0044 95.7226 23.6442 8.2692 11.005 15.2344 22.3383 36.7423 31.7983 16.0155 85.5074 90.1127 43.285 39.1737 21.083 60.5658 78.2303 73.021 22.4308 79.1556 59.9319 42.4742 45.0355 91.0974 19.9697 79.8525 72.5332 17.6998 32.2238 75.0778 86.1005 65.5801 96.784 99.1896 42.011 46.5246 6.2319 25.9036 85.9162 65.5665 86.0778 86.9979 96.9268 5.8688 40.0495 96.9905 92.6792 40.1003 38.4404 67.4849 91.7213 23.9672 43.4591 65.6283 4.3142 83.8934 30.5802 52.9915 64.6227 8.3704 16.5033 81.3058 22.5549 45.1605 93.4785 92.4601 76.7875 39.3807 33.849 46.6657 78.7402 85.9221 29.3029 1.1439 67.8505 73.2714 64.2627 52.0416 42.9501 38.6202 41.0111 59.4249 22.3216 59.4171 51.6618 89.5297 53.0101 99.0078 82.9077 65.3408 84.7444 17.2427 63.6652 39.9473 22.6383 3.2348 15.0995 48.7169 77.1287 56.2907 52.1719 87.4398 91.3194 28.1949 14.7428 25.6127 44.6583 53.9867 11.7501 76.755 22.8243 71.8316 58.3354 53.9797 41.1794 12.9038 47.4463 9.3704 43.7192 32.5674 26.7987 35.4779 34.2159 83.9465 77.0431 3.4774 46.4996 40.6835 55.0589 85.1959 89.027 13.2019 34.1659 98.8259 71.4508 3.6663 98.6807 52.8414 87.554 70.096 69.2722 44.4111 61.362 9.0468 98.3557 1.0061 89.3839 50.6055 94.6027 72.1401 55.3835 2.5363 6.1239 1.6026 94.1024 95.1958 87.8391 88.3327 62.5444 65.8283 38.7679 17.7799 40.5559 76.1481 80.8294 75.5297 8.2213 71.5146 20.9631 63.8621 46.0671 72.2561 78.3414 70.7582 28.9821 48.223 86.9009 83.4478 12.1545 98.6431 23.1112 79.3087 14.0654 81.3645 42.1596 62.5441 18.6747 91.8768 14.6205 24.9549 45.705 74.8251 24.4003 67.88 19.6626 81.8454 63.618 83.5728 62.5747 25.2952 79.783 10.3103 98.4692 37.9291 46.5996 8.4466 27.6307 27.3522 19.068 50.5008 52.6247 66.0747 21.0952 17.0084
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : target    1
    Should Contain X Times    ${output}    property : lut    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    xlut : 28.6386    1
    Should Contain X Times    ${output}    ylut : 92.4719    1
    Should Contain X Times    ${output}    zlut : 57.6732    1
    Should Contain X Times    ${output}    ulut : 96.915    1
    Should Contain X Times    ${output}    vlut : 34.4736    1
    Should Contain X Times    ${output}    wlut : 18.4933    1
    Should Contain    ${output}    === command configureLut issued =
    Should Contain    ${output}    === [waitForCompletion_${component}] command 0 completed ok :

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command configureLut received =
    Should Contain    ${output}    device : target
    Should Contain    ${output}    property : lut
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    xlut : 28.6386    1
    Should Contain X Times    ${output}    ylut : 26.4434    1
    Should Contain X Times    ${output}    zlut : 40.6851    1
    Should Contain X Times    ${output}    ulut : 86.6746    1
    Should Contain X Times    ${output}    vlut : 42.011    1
    Should Contain X Times    ${output}    wlut : 77.0431    1
    Should Contain X Times    ${output}    === [ackCommand_configureLut] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
