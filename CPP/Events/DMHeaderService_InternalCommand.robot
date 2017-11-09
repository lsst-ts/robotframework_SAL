*** Settings ***
Documentation    DMHeaderService_InternalCommand sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    dmHeaderService
${component}    InternalCommand
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 400 test 147 test 126 test 873 test 852 test 598 test 577 test 556 test 303 test 282 test 99 test 846 test 825 test 572 test 551 test 298 test 277 test 256 test 3 test 982 test 729 test 707 test 454 test 433 test 180 test 159 test 906 test 885 test 632 test 611 test 590 test 337 test 316 test 62 test 41 test 788 test 767 test 514 test 493 test 240 test 219 test 198 test 15 test 762 test 741 test 488 test 467 test 214 test 193 test 939 test 918 test 665 test 644 test 623 test 370 test 349 test 96 test 75 test 822 test 801 test 548 test 527 test 273 test 252 test 999 test 978 test 957 test 704 test 683 test 430 test 409 test 156 test 135 test 882 test 699 test 678 test 425 test 404 test 382 test 129 test 108 test 855 test 834 test 581 test 560 test 307 test 286 test 33 test 12 test 991 test 737 test 716 test 463 test 442 test 189 test 168 test 915 test 894 test 641 test 620 test 367 test 346 test 324 test 71 test 50 test 797 test 614 test 593 test 340 test 319 test 66 test 45 test 24 test 771 test 750 test 497 test 476 test 223 test 202 test 948 test 927 test 674 test 653 test 400 test 379 test 358 test 105 test 84 test 831 test 810 test 557 test 535 test 282 test 261 test 8 test 987 test 734 test 713 test 530 test 509 test 256 test 235 test 982 test 961 test 708 test 687 test 434 test 412 test 391 test 138 test 117 test 864 test 843 test 590 test 569 test 316 test 295 test 42 test 21 test 767 test 746 test 725 test 472 test 451 test 198 test 177 test 924 test 903 test 650 test 629 test 446 test 193 test 172 test 151 test 898 test 876 test 623 test 602 test 349 test 328 test 75 test 54 test 801 test 780 test 759 test 506 test 485 test 232 test 210 test 957 test 936 test 683 test 662 test 409 test 388 test 135 test 114 test 93 test 840 test 819 test 565 test 544 test 362 test 109 test 87 test 834 test 813 test 560 test 539 test 518 test 265 test 244 test 991 test 970 test 717 test 696 test 442 test 421 test 168 test 147 test 126 test 873 test 852 test 599 test 578 test 325 test 304 test 51 test 30 test 776 test 755 test 502 test 481 test 298 test 277 test 24 test 3 test 750 test 729 test 476 test 455 test 202 test 181 test 160 test 907 test 885 test 632 test 611 test 358 test 337 test 84 test 63 test 810 test 789 test 536 test 515 test 494 test 240 test 219 test 966 test 945 test 692 test 671 test 418 test 235 test 214 test 961 test 940 test 919 test 666 test 645 test 392 test 371 test 117 test 96 test 843 test 822 test 569 test 548 test 527 test 274 test 253 test 1000 test 979 test 726 test 705 test 451 test 430 test 177 test 156 test 903 test 882 test 861 test 608 test 587 test 404 test 151 test 130 test 877 test 856 test 603 test 582 test 328 test 307 test 286 test 33 test 12 test 759 test 738 test 485 test 464 test 211 test 190 test 937 test 915 test 894 test 641 test 620 test 367 test 346 test 93 test 72 test 819 test 798 test 545 test 524 test 271 test 320 test 67 test 46 test 792 test 771 test 518 test 497 test 244 test 223 test 970 test 949 test 696 test 675 test 654 test 401 test 380 test 126 test 105 test 852 test 831 test 578 test 557 test 304 test 283 test 262 test 9 test 988 test 735 test 713 test 460 test 439 test 186 test 3 test 982 test 729 test 708 test 687 test 434 test 413 test 160 test 139 test 886 test 865 test 612 test 590 test 337 test 316 test 295 test 42 test 21 test 768 test 747 test 494 test 473 test 220 test 199 test 946 test 924 test 671 test 650 test 629 test 376 test 355 test 172 test 919 test 898 test 645 test 624 test 371 test 350 test 97 test 76 test 55 test 801 test 780 test 527 test 506 test 253 test 232 test 979 test 958 test 705 test 684 test 663 test 410 test 388 test 135 test 114 test 861 test 840 test 587 test 566 test 313 test 292 test 109 test 88 test 835 test 814 test 561 test 540 test 287 test 265 test 12 test 991 test 738 test 717 test 464 test 443 test 422 test 169 test 148 test 895 test 874 test 620 test 599 test 346 test 325 test 72 test 51 test 30 test 777 test 756 test 503 test 482 test 229 test 46 test 25 test 772 test 751 test 498 test 476 test 455 test 202 test 181 test 928 test 907 test 654 test 633 test 380 test 359 test 106 test 85 test 63 test 810 test 789 test 536 test 515 test 262 test 241 test 988 test 967 test 714 test 693 test 440 test 418 test 397 test 215 test 962 test 940 test 687 test 666 test 413 test 392 test 139 test 118 test 865 test 844 test 823 test 570 test 549 test 295 test 274 test 21 test 1000 test 747 test 726 test 473 test 452 test 431 test 178 test 157 test 904 test 883 test 629 test 608 test 355 test 334 test 81 test 898 test 877 test 856 test 603 test 582 test 329 test 308 test 55 test 34 test 781 test 760 test 506 test 485 test 232 test 211 test 190 test 937 test 916 test 663 test 642 test 389 test 368 test 115 test 93 test 840 test 819 test 798 test 545 test 524 test 271 test 250 test 997 test 814 test 793 test 540 test 519 test 266 test 245 test 224 test 970 test 949 test 696 test 675 test 422 test 401 test 148 test 127 test 874 test 853 test 600 test 579 test 558 test 304 test 283 test 30 test 9 test 756 test 735 test 482 test 461 test 208 test 187 test 166 test 983 test 730 test 709 test 456 test 435 test 181 test 160 test 907 test 886 test 633 test 612 test 591 test 338 test 317 test 64 test 43 test 790 test 768 test 515 test 494 test 241 test 220 test 199 test 946 test 925 test 672 test 651 test 398 test 377 test 124 test 102 test 920 test 667 test 645 test 624 test 371 test 350 test 97 test 76 test 823 test 802 test 549 test 528 test 275 test 254 test 1 test 979 test 958 test 705 test 684 test 431 test 410 test 157 test 136 test 883 test 862 test 609 test 588 test 566 test 313 test 292 test 39 test 856 test 835 test 582 test 561 test 308 test 287 test 34 test 13 test 992 test 739 test 718 test 465 test 443 test 190 test 169 test 916 test 895 test 642 test 621 test 368 test 347 test 326 test 73 test 52 test 799 test 777 test 524 test 503 test 250 test 229 test 976 test 955 test 772 test 751 test 498 test 477 test 224 test 203 test 950 test 929 test 676 test 654 test 401 test 380 test 359 test 106 test 85 test 832 test 811 test 558 test 537 test 284 test 263 test 9 test 988 test 735 test 714 test 693 test 440 test 419 test 166 test 145 test 892 test 871 test 688 test 435 test 414 test 393 test 140 test 118 test 865 test 844 test 591 test 570 test 317 test 296 test 43 test 22 test 769 test 748 test 727 test 474 test 452 test 199 test 178 test 925 test 904 test 651 test 630 test 377 test 356 test 335 test 82 test 61 test 807 test 625 test 604 test 351 test 329 test 76 test 55 test 802 test 781 test 760 test 507 test 486 test 233 test 212 test 959 test 938 test 684 test 663 test 410 test 389 test 136 test 115 test 94 test 841 test 820 test 567 test 546 test 293 test 271 test 18 test 997 test 744 test 723 test 540 test 519 test 266 test 245 test 992 test 971 test 718 test 697 test 444 test 423 test 170 test 149 test 127 test 874 test 853 test 600 test 579 test 326 test 305 test 52 test 31 test 778 test 757 test 504 test 482 test 461 test 208 test 187 test 934 test 913 test 660 test 477 test 456 test 203 test 182 test 161 test 908 test 887 test 634 test 613 test 359 test 338 test 85 test 64 test 811 test 790 test 537 test 516 test 495 test 242 test 221 test 968 test 946 test 693 test 672 test 419 test 398 test 145 test 124 test 103 test 850 test 829 test 576 test 393 test 372 test 119 test 98 test 845 test 824 test 570 test 549 test 528 test 275 test 254 test 1 test 980 test 727 test 706 test 453 test 432 test 179 test 157 test 904 test 883 test 862 test 609 test 588 test 335 test 314 test 61 test 40 test 787 test 766 test 512 test 330 test 309 test 288 test 34 test 13 test 760 test 739 test 486 test 465 test 212 test 191 test 938 test 917 test 896 test 643 test 460 test 439 test 186 test 165 test 911 test 890 test 637 test 616 test 363 test 342 test 321 test 68 test 47 test 794 test 773 test 520 test 499 test 316 test 63 test 42 test 788 test 767 test 746 test 493 test 472 test 219 test 198 test 945 test 924 test 671 test 650 test 397 test 376 test 354 test 101 test 80 test 827 test 806 test 553 test 532 test 279 test 258 test 5 test 984 test 731 test 709 test 688 test 435 test 253 test 231 test 978 test 957 test 704 test 683 test 430 test 409 test 156 test 135 test 114 test 861 test 840 test 586 test 565 test 312 test 291 test 38 test 17 test 764 test 743 test 722 test 469 test 448 test 195 test 174 test 920 test 899 test 646 test 463 test 442 test 189 test 168 test 147 test 894 test 873 test 620 test 599 test 346 test 325 test 72 test 51 test 797 test 776 test 523 test 502 test 481 test 228 test 207 test 954 test 933 test 680 test 659 test 406 test 384 test 131 test 110 test 89 test 836 test 653 test 632 test 379 test 358 test 105 test 84 test 831 test 810 test 557 test 536 test 515 test 261 test 240 test 987 test 966 test 713 test 692 test -549602163
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] dmHeaderService::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : -549602163
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 400
    Should Contain    ${output}    priority : test
