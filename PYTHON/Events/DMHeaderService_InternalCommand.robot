*** Settings ***
Documentation    DMHeaderService_InternalCommand sender/logger tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    dmHeaderService
${component}    InternalCommand
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : CommandObject priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 744 test 491 test 470 test 449 test 196 test 175 test 922 test 901 test 648 test 627 test 373 test 352 test 99 test 78 test 57 test 804 test 783 test 530 test 509 test 256 test 235 test 982 test 960 test 707 test 686 test 433 test 412 test 391 test 138 test 955 test 934 test 681 test 660 test 407 test 386 test 133 test 112 test 859 test 837 test 816 test 563 test 542 test 289 test 268 test 15 test 994 test 741 test 720 test 467 test 446 test 425 test 171 test 150 test 897 test 876 test 623 test 602 test 349 test 328 test 75 test 54 test 871 test 850 test 597 test 576 test 323 test 302 test 48 test 27 test 774 test 753 test 500 test 479 test 226 test 205 test 184 test 931 test 910 test 657 test 635 test 382 test 361 test 108 test 87 test 834 test 813 test 792 test 539 test 518 test 265 test 244 test 991 test 969 test 787 test 534 test 512 test 259 test 238 test 217 test 964 test 943 test 690 test 669 test 416 test 395 test 142 test 121 test 868 test 846 test 593 test 572 test 551 test 298 test 277 test 24 test 3 test 750 test 729 test 476 test 455 test 201 test 180 test 159 test 906 test 885 test 702 test 449 test 428 test 175 test 154 test 901 test 880 test 627 test 606 test 585 test 332 test 310 test 57 test 36 test 783 test 762 test 509 test 488 test 235 test 214 test 193 test 940 test 919 test 666 test 644 test 391 test 370 test 117 test 96 test 843 test 822 test 639 test 618 test 365 test 344 test 91 test 70 test 817 test 796 test 543 test 521 test 268 test 247 test 994 test 973 test 952 test 699 test 678 test 425 test 404 test 151 test 130 test 876 test 855 test 602 test 581 test 560 test 307 test 286 test 33 test 12 test 759 test 738 test 555 test 302 test 281 test 28 test 7 test 985 test 732 test 711 test 458 test 437 test 184 test 163 test 910 test 889 test 636 test 615 test 362 test 341 test 319 test 66 test 45 test 792 test 771 test 518 test 497 test 244 test 223 test 970 test 949 test 928 test 674 test 653 test 400 test 218 test 196 test 943 test 922 test 669 test 648 test 395 test 374 test 353 test 100 test 79 test 826 test 805 test 551 test 530 test 277 test 256 test 3 test 982 test 729 test 708 test 687 test 434 test 413 test 160 test 139 test 885 test 864 test 611 test 590 test 337 test 316 test 133 test 112 test 859 test 838 test 585 test 564 test 311 test 290 test 37 test 16 test 762 test 741 test 720 test 467 test 446 test 193 test 172 test 919 test 898 test 645 test 624 test 371 test 349 test 328 test 75 test 54 test 801 test 780 test 527 test 506 test 253 test 232 test 49 test 796 test 775 test 754 test 501 test 480 test 226 test 205 test 952 test 931 test 678 test 657 test 404 test 383 test 130 test 109 test 88 test 835 test 813 test 560 test 539 test 286 test 265 test 12 test 991 test 738 test 717 test 696 test 443 test 422 test 169 test 147 test 965 test 712 test 691 test 437 test 416 test 163 test 142 test 121 test 868 test 847 test 594 test 573 test 320 test 299 test 46 test 24 test 771 test 750 test 497 test 476 test 455 test 202 test 181 test 928 test 907 test 654 test 633 test 379 test 358 test 105 test 84 test 901 test 880 test 627 test 606 test 353 test 332 test 79 test 58 test 805 test 784 test 531 test 510 test 488 test 235 test 214 test 961 test 940 test 687 test 666 test 413 test 392 test 139 test 118 test 97 test 844 test 822 test 569 test 548 test 295 test 274 test 21 test 1000 test 817 test 564 test 543 test 522 test 269 test 248 test 995 test 974 test 721 test 699 test 446 test 425 test 172 test 151 test 898 test 877 test 856 test 603 test 582 test 329 test 308 test 54 test 33 test 780 test 759 test 506 test 485 test 464 test 211 test 190 test 937 test 916 test 733 test 480 test 459 test 206 test 185 test 931 test 910 test 889 test 636 test 615 test 362 test 341 test 88 test 67 test 814 test 793 test 540 test 519 test 265 test 244 test 223 test 970 test 949 test 696 test 675 test 422 test 401 test 148 test 127 test 874 test 852 test 670 test 649 test 396 test 374 test 121 test 100 test 847 test 826 test 573 test 552 test 299 test 278 test 257 test 4 test 983 test 729 test 708 test 455 test 434 test 181 test 160 test 907 test 886 test 633 test 612 test 591 test 338 test 317 test 63 test 42 test 789 test 768 test 585 test 332 test 311 test 290 test 37 test 16 test 763 test 742 test 489 test 468 test 215 test 194 test 940 test 919 test 666 test 645 test 624 test 371 test 350 test 97 test 76 test 823 test 802 test 549 test 527 test 274 test 253 test 232 test 979 test 958 test 705 test 684 test 501 test 248 test 227 test 974 test 953 test 700 test 679 test 658 test 404 test 383 test 130 test 109 test 856 test 835 test 582 test 561 test 308 test 287 test 34 test 13 test 992 test 738 test 717 test 464 test 443 test 190 test 169 test 916 test 895 test 642 test 621 test 600 test 417 test 164 test 143 test 890 test 869 test 615 test 594 test 341 test 320 test 67 test 46 test 25 test 772 test 751 test 498 test 477 test 224 test 202 test 949 test 928 test 675 test 654 test 401 test 380 test 359 test 106 test 85 test 832 test 811 test 557 test 536 test 283 test 101 test 79 test 58 test 805 test 784 test 531 test 510 test 257 test 236 test 983 test 962 test 709 test 688 test 435 test 413 test 392 test 139 test 118 test 865 test 844 test 591 test 570 test 317 test 296 test 43 test 22 test 768 test 747 test 726 test 473 test 452 test 269 test 16 test 995 test 742 test 721 test 468 test 447 test 426 test 173 test 152 test 899 test 877 test 624 test 603 test 350 test 329 test 76 test 55 test 802 test 781 test 760 test 507 test 486 test 232 test 211 test 958 test 937 test 684 test 663 test 410 test 389 test 368 test 115 test 932 test 911 test 658 test 637 test 384 test 363 test 110 test 88 test 835 test 814 test 793 test 540 test 519 test 266 test 245 test 992 test 971 test 718 test 697 test 443 test 422 test 169 test 148 test 127 test 874 test 853 test 600 test 579 test 326 test 305 test 52 test 30 test 848 test 595 test 574 test 552 test 299 test 278 test 25 test 4 test 751 test 730 test 477 test 456 test 203 test 182 test 161 test 907 test 886 test 633 test 612 test 359 test 338 test 85 test 64 test 811 test 790 test 537 test 516 test 495 test 241 test 220 test 967 test 785 test 763 test 510 test 489 test 236 test 215 test 194 test 941 test 920 test 667 test 646 test 393 test 372 test 118 test 97 test 844 test 823 test 570 test 549 test 528 test 275 test 254 test 1 test 980 test 727 test 705 test 452 test 431 test 178 test 157 test 136 test 883 test 700 test 679 test 426 test 405 test 152 test 131 test 878 test 857 test 604 test 582 test 561 test 308 test 287 test 34 test 13 test 760 test 739 test 486 test 465 test 212 test 191 test 938 test 916 test 895 test 642 test 621 test 368 test 347 test 94 test 73 test 820 test 799 test 616 test 363 test 342 test 321 test 68 test 47 test 793 test 772 test 519 test 498 test 245 test 224 test 971 test 950 test 929 test 676 test 655 test 402 test 380 test 127 test 106 test 853 test 832 test 579 test 558 test 305 test 284 test 263 test 10 test 989 test 736 test 553 test 532 test 279 test 257 test 4 test 983 test 730 test 709 test 688 test 435 test 414 test 161 test 140 test 887 test 866 test 613 test 591 test 338 test 317 test 296 test 43 test 22 test 769 test 748 test 495 test 474 test 221 test 200 test 946 test 925 test 672 test 722 test 468 test 447 test 194 test 173 test 920 test 899 test 646 test 625 test 372 test 351 test 330 test 77 test 55 test 802 test 781 test 528 test 507 test 254 test 233 test 980 test 959 test 706 test 685 test 664 test 411 test 389 test 136 test 115 test 862 test 841 test 588 test 405 test 384 test 131 test 110 test 89 test 836 test 815 test 632 test 379 test 358 test 105 test 84 test 831 test 810 test 556 test 535 test 514 test 261 test 240 test 987 test 966 test 713 test 692 test 439 test 418 test 165 test 143 test 122 test 869 test 848 test 595 test 412 test 391 test 138 test 117 test 864 test 843 test 590 test 569 test 548 test 295 test 274 test 20 test 999 test 746 test 725 test 472 test 451 test 198 test 177 test 156 test 903 test 882 test 629 test 607 test 354 test 333 test 80 test 59 test 806 test 785 test 532 test 511 test 328 test 307 test 54 test 33 test 780 test 759 test 506 test 485 test 231 test 210 test 957 test 936 test 915 test 662 test 641 test 388 test 367 test 114 test 93 test 840 test 818 test 565 test 544 test 523 test 270 test 249 test 996 test 975 test 722 test 701 test 448 test 265 test 244 test 991 test 970 test 949 test 695 test 674 test 421 test 400 test 147 test 126 test 873 test 852 test 599 test 578 test 325 test 304 test 282 test 29 test 8 test 755 test 734 test 481 test 460 test 207 test 186 test 933 test 912 test 891 test 638 test 616 test 363 test 181 test 160 test 906 test 885 test 632 test 611 test 358 test 337 test 316 test 63 test 42 test 789 test 768 test 515 test 493 test 240 test 219 test 966 test -1881877698
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] dmHeaderService::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
