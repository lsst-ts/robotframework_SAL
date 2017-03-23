*** Settings ***
Documentation    Hexapod_configureLut commander/controller tests.
Suite Setup    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot

*** Variables ***
${subSystem}    hexapod
${component}    configureLut
${timeout}    45s

*** Test Cases ***
Create Commander Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Commander    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

Create Controller Session
    [Documentation]    Connect to the SAL host.
    [Tags]    smoke
    Comment    Connect to host.
    Open Connection    host=${Host}    alias=Controller    timeout=${timeout}    prompt=${Prompt}
    Comment    Login.
    Log    ${ContInt}
    Login With Public Key    ${UserName}    keyfile=${KeyFile}    password=${PassWord}
    Directory Should Exist    ${SALInstall}
    Directory Should Exist    ${SALHome}

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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 67.2576 51.5007 62.6902 68.5432 71.5905 55.4334 58.3971 99.4328 8.5355 20.4561 9.5014 84.4935 11.7975 23.7862 70.4948 45.8029 14.9431 55.4079 9.5161 96.814 73.5967 94.0154 58.7238 88.1013 38.962 3.9206 88.7146 3.5146 64.4933 13.3983 23.5248 79.4506 30.3768 12.0809 66.5796 61.4669 95.4546 23.4496 42.2993 55.5371 45.5313 75.6703 77.8624 34.585 18.9944 11.4365 41.6407 24.0518 29.8382 55.3792 6.317 74.4009 76.541 60.3597 76.6457 89.6135 94.8782 79.1562 12.7375 54.7394 20.0849 68.8459 6.4582 85.7828 15.606 37.4293 43.2652 64.2012 2.9714 70.7201 19.7584 22.615 83.118 0.7274 46.8032 28.5001 51.9796 54.5586 36.3401 12.8476 60.5928 4.2314 2.9904 30.2586 63.1668 28.3522 58.4771 58.4965 48.7639 13.0117 11.0421 55.3566 57.3474 20.8128 78.5912 48.9387 13.2921 96.6947 50.1943 1.447 88.6026 53.3742 92.7791 30.7598 63.2111 33.5338 72.4152 91.6495 69.4704 85.1458 5.5081 84.9148 99.7507 9.3243 58.5246 45.5477 77.9896 20.0049 65.762 45.4937 3.6032 31.9249 57.8994 76.7003 32.1279 64.3671 85.5062 70.885 22.1107 69.1177 98.0254 28.0428 71.6406 88.0351 81.1422 77.4603 92.7966 57.0612 38.4998 25.4333 34.3094 58.2048 77.405 25.0171 65.5432 48.9229 97.8343 92.4856 63.1996 94.5225 82.8902 17.0958 38.5091 99.7242 47.1304 90.8896 15.6769 45.8259 95.8176 91.874 72.138 34.1619 82.2911 5.5046 10.1814 43.6395 39.9563 41.1502 4.4397 26.0546 84.8966 31.7169 86.1667 20.049 89.3553 80.0455 81.421 18.7414 65.4074 16.5894 46.2393 70.406 23.9292 32.2963 8.9653 17.9671 2.6828 63.7989 12.9994 61.8524 87.7045 3.9062 68.5796 67.0654 15.7591 55.3624 94.3322 43.9387 1.2986 38.6448 79.0144 10.5896 25.5578 14.1588 64.3109 8.5601 63.2989 60.7345 92.6336 99.188 12.7336 23.3613 83.5004 59.7867 86.4716 83.4174 84.7542 5.2098 7.045 8.7929 33.235 39.9303 77.216 21.0803 47.0967 39.7768 18.6807 91.9963 34.7795 47.55 10.2317 68.9414 38.014 82.4063 8.8722 74.5586 51.1374 35.8431 81.1377 56.3809 16.113 54.7071 60.0635 6.7972 49.0126 28.829 35.0155 55.9864 40.2595 16.9403 32.4674 81.5765 29.417 57.4827 67.94 18.9313 5.6759 78.8608 52.0101 80.4131 78.7739 43.6891 72.1032 94.61 72.4547 13.6229 12.7726 73.8662 98.317 16.1899 51.3364 21.5782 17.4122 72.1975 30.3788 89.2518 74.159 23.4636 55.6352 70.8396 69.0924 35.9683 8.933 40.3053 36.2649 88.1541 94.9956 52.2065 7.4568 35.4794 10.0787 82.6655 33.7974 42.4744 43.5674 3.4973 5.1854 92.1564 90.1123 82.5015 40.0277 2.0851 4.7034 39.356 43.1787 75.3607 76.1859 72.1893 61.0399 83.905 45.0666 12.9557 20.6399 58.7846 58.3194 94.8689 30.5579 53.3804 45.1846 8.5926 98.4475 54.6485 6.1866 19.8313 48.982 95.2639 80.4088 13.4095 98.2981 43.686 64.4989 72.0209 45.1494 87.7617 82.5002 5.2205 72.1127 22.4966 87.1336 19.1314 53.9301 11.3853 4.8669 86.1148 57.2091 62.5854 89.5743 8.5878 58.181 22.013 5.2946 62.2513 33.9365 52.288 38.5376 95.9817 48.7034 56.4762 40.3086 48.4144 97.0766 50.6061 38.3896 79.5342 94.3132 49.0498 81.7257 28.4079 32.8178 30.2434 14.0768 72.2433 7.764 88.4455 66.7373 0.5102 67.0089 57.4591 70.8006 69.0798 42.5555 77.1245 80.2795 22.1704 80.7292 35.5659 32.2549 39.0855 70.9812 85.7935 31.8594 18.0916 32.845 58.7457 17.0791 5.6514 97.3793 53.832 74.3801 68.9459 53.9291 80.4185 30.463 61.16 72.5975 62.1271 68.2363 63.3066 57.8723 46.0495 56.2735 11.7568 64.1123 99.1274 42.7566 88.9689 6.7443 18.0644 48.8522 5.2696 49.4973 41.0315 5.0657 77.9455 15.5516 95.8641 71.7672 84.3283 88.9966 20.4206 9.9847 34.4462 82.3727 14.6185 23.3524 74.4771 28.1841 3.2896 89.2419 83.7936 89.3944 80.0455 37.8991 17.277 59.262 21.1326 99.0073 3.3787 95.3098 77.409 10.2588 16.1935 83.1432 62.6985 23.9126 32.211 22.2758 25.8125 34.2512 77.1688 50.2089 46.6191 7.4748 13.2084 96.3501 63.4349 48.021 13.0425 3.2279 72.7715 32.2196 19.5259 92.3338 54.8039 43.3872 47.2145 50.9162 33.2187 86.7579 5.9841 21.9174 84.2303 51.56 77.3159 58.5323 68.0533 37.3596 13.5989 52.8829 59.2322 68.9725 11.839 79.3986 51.091 47.9489 45.8217 53.4908 37.5757 19.472 81.9931 83.4817 29.9103 31.8109 73.7762 49.4299 85.7729 42.157 58.8867 32.134 18.9663 2.922 85.9856 42.4267 84.8927 54.1849 75.2531 86.8648 8.7921 94.7202 68.0232 59.9182 35.5048 85.2032 93.5587 63.019 50.4428 80.1697 4.672 70.7227 55.6856 13.1997 20.9687 1.5539 32.5668 60.8894 38.5354 88.948 86.5344 18.997 43.5678
    ${output}=    Read Until Prompt
    Log    ${output}
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( timed out :)

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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 67.2576 51.5007 62.6902 68.5432 71.5905 55.4334 58.3971 99.4328 8.5355 20.4561 9.5014 84.4935 11.7975 23.7862 70.4948 45.8029 14.9431 55.4079 9.5161 96.814 73.5967 94.0154 58.7238 88.1013 38.962 3.9206 88.7146 3.5146 64.4933 13.3983 23.5248 79.4506 30.3768 12.0809 66.5796 61.4669 95.4546 23.4496 42.2993 55.5371 45.5313 75.6703 77.8624 34.585 18.9944 11.4365 41.6407 24.0518 29.8382 55.3792 6.317 74.4009 76.541 60.3597 76.6457 89.6135 94.8782 79.1562 12.7375 54.7394 20.0849 68.8459 6.4582 85.7828 15.606 37.4293 43.2652 64.2012 2.9714 70.7201 19.7584 22.615 83.118 0.7274 46.8032 28.5001 51.9796 54.5586 36.3401 12.8476 60.5928 4.2314 2.9904 30.2586 63.1668 28.3522 58.4771 58.4965 48.7639 13.0117 11.0421 55.3566 57.3474 20.8128 78.5912 48.9387 13.2921 96.6947 50.1943 1.447 88.6026 53.3742 92.7791 30.7598 63.2111 33.5338 72.4152 91.6495 69.4704 85.1458 5.5081 84.9148 99.7507 9.3243 58.5246 45.5477 77.9896 20.0049 65.762 45.4937 3.6032 31.9249 57.8994 76.7003 32.1279 64.3671 85.5062 70.885 22.1107 69.1177 98.0254 28.0428 71.6406 88.0351 81.1422 77.4603 92.7966 57.0612 38.4998 25.4333 34.3094 58.2048 77.405 25.0171 65.5432 48.9229 97.8343 92.4856 63.1996 94.5225 82.8902 17.0958 38.5091 99.7242 47.1304 90.8896 15.6769 45.8259 95.8176 91.874 72.138 34.1619 82.2911 5.5046 10.1814 43.6395 39.9563 41.1502 4.4397 26.0546 84.8966 31.7169 86.1667 20.049 89.3553 80.0455 81.421 18.7414 65.4074 16.5894 46.2393 70.406 23.9292 32.2963 8.9653 17.9671 2.6828 63.7989 12.9994 61.8524 87.7045 3.9062 68.5796 67.0654 15.7591 55.3624 94.3322 43.9387 1.2986 38.6448 79.0144 10.5896 25.5578 14.1588 64.3109 8.5601 63.2989 60.7345 92.6336 99.188 12.7336 23.3613 83.5004 59.7867 86.4716 83.4174 84.7542 5.2098 7.045 8.7929 33.235 39.9303 77.216 21.0803 47.0967 39.7768 18.6807 91.9963 34.7795 47.55 10.2317 68.9414 38.014 82.4063 8.8722 74.5586 51.1374 35.8431 81.1377 56.3809 16.113 54.7071 60.0635 6.7972 49.0126 28.829 35.0155 55.9864 40.2595 16.9403 32.4674 81.5765 29.417 57.4827 67.94 18.9313 5.6759 78.8608 52.0101 80.4131 78.7739 43.6891 72.1032 94.61 72.4547 13.6229 12.7726 73.8662 98.317 16.1899 51.3364 21.5782 17.4122 72.1975 30.3788 89.2518 74.159 23.4636 55.6352 70.8396 69.0924 35.9683 8.933 40.3053 36.2649 88.1541 94.9956 52.2065 7.4568 35.4794 10.0787 82.6655 33.7974 42.4744 43.5674 3.4973 5.1854 92.1564 90.1123 82.5015 40.0277 2.0851 4.7034 39.356 43.1787 75.3607 76.1859 72.1893 61.0399 83.905 45.0666 12.9557 20.6399 58.7846 58.3194 94.8689 30.5579 53.3804 45.1846 8.5926 98.4475 54.6485 6.1866 19.8313 48.982 95.2639 80.4088 13.4095 98.2981 43.686 64.4989 72.0209 45.1494 87.7617 82.5002 5.2205 72.1127 22.4966 87.1336 19.1314 53.9301 11.3853 4.8669 86.1148 57.2091 62.5854 89.5743 8.5878 58.181 22.013 5.2946 62.2513 33.9365 52.288 38.5376 95.9817 48.7034 56.4762 40.3086 48.4144 97.0766 50.6061 38.3896 79.5342 94.3132 49.0498 81.7257 28.4079 32.8178 30.2434 14.0768 72.2433 7.764 88.4455 66.7373 0.5102 67.0089 57.4591 70.8006 69.0798 42.5555 77.1245 80.2795 22.1704 80.7292 35.5659 32.2549 39.0855 70.9812 85.7935 31.8594 18.0916 32.845 58.7457 17.0791 5.6514 97.3793 53.832 74.3801 68.9459 53.9291 80.4185 30.463 61.16 72.5975 62.1271 68.2363 63.3066 57.8723 46.0495 56.2735 11.7568 64.1123 99.1274 42.7566 88.9689 6.7443 18.0644 48.8522 5.2696 49.4973 41.0315 5.0657 77.9455 15.5516 95.8641 71.7672 84.3283 88.9966 20.4206 9.9847 34.4462 82.3727 14.6185 23.3524 74.4771 28.1841 3.2896 89.2419 83.7936 89.3944 80.0455 37.8991 17.277 59.262 21.1326 99.0073 3.3787 95.3098 77.409 10.2588 16.1935 83.1432 62.6985 23.9126 32.211 22.2758 25.8125 34.2512 77.1688 50.2089 46.6191 7.4748 13.2084 96.3501 63.4349 48.021 13.0425 3.2279 72.7715 32.2196 19.5259 92.3338 54.8039 43.3872 47.2145 50.9162 33.2187 86.7579 5.9841 21.9174 84.2303 51.56 77.3159 58.5323 68.0533 37.3596 13.5989 52.8829 59.2322 68.9725 11.839 79.3986 51.091 47.9489 45.8217 53.4908 37.5757 19.472 81.9931 83.4817 29.9103 31.8109 73.7762 49.4299 85.7729 42.157 58.8867 32.134 18.9663 2.922 85.9856 42.4267 84.8927 54.1849 75.2531 86.8648 8.7921 94.7202 68.0232 59.9182 35.5048 85.2032 93.5587 63.019 50.4428 80.1697 4.672 70.7227 55.6856 13.1997 20.9687 1.5539 32.5668 60.8894 38.5354 88.948 86.5344 18.997 43.5678
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : target    1
    Should Contain X Times    ${output}    property : lut    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    xlut : 67.2576    1
    Should Contain X Times    ${output}    ylut : 11.0421    1
    Should Contain X Times    ${output}    zlut : 46.2393    1
    Should Contain X Times    ${output}    ulut : 51.3364    1
    Should Contain X Times    ${output}    vlut : 97.0766    1
    Should Contain X Times    ${output}    wlut : 10.2588    1
    Should Contain    ${output}    === command configureLut issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

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
    Should Contain X Times    ${output}    xlut : 67.2576    1
    Should Contain X Times    ${output}    ylut : 11.0421    1
    Should Contain X Times    ${output}    zlut : 46.2393    1
    Should Contain X Times    ${output}    ulut : 51.3364    1
    Should Contain X Times    ${output}    vlut : 97.0766    1
    Should Contain X Times    ${output}    wlut : 10.2588    1
    Should Contain X Times    ${output}    === [ackCommand_configureLut] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
