*** Settings ***
Documentation    EEC_InternalCommand sender/logger tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    eec
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 938 test 917 test 664 test 643 test 390 test 369 test 116 test 95 test 842 test 821 test 568 test 547 test 526 test 272 test 251 test 998 test 977 test 724 test 703 test 450 test 429 test 176 test 155 test 902 test 881 test 859 test 606 test 585 test 332 test 311 test 128 test 875 test 854 test 601 test 580 test 327 test 306 test 285 test 32 test 11 test 758 test 736 test 483 test 462 test 209 test 188 test 935 test 914 test 893 test 640 test 619 test 366 test 345 test 92 test 70 test 817 test 796 test 543 test 522 test 269 test 248 test 65 test 44 test 791 test 770 test 517 test 496 test 243 test 222 test 969 test 947 test 694 test 673 test 652 test 399 test 378 test 125 test 104 test 851 test 830 test 577 test 556 test 302 test 281 test 260 test 7 test 986 test 733 test 712 test 459 test 438 test 185 test 164 test 911 test 728 test 707 test 686 test 433 test 411 test 158 test 137 test 884 test 863 test 610 test 589 test 336 test 315 test 294 test 41 test 20 test 766 test 745 test 492 test 471 test 218 test 197 test 944 test 923 test 670 test 649 test 628 test 375 test 354 test 100 test 79 test 826 test 644 test 622 test 369 test 348 test 95 test 74 test 53 test 800 test 779 test 526 test 505 test 252 test 231 test 977 test 956 test 703 test 682 test 661 test 408 test 387 test 134 test 113 test 860 test 839 test 586 test 564 test 311 test 290 test 37 test 16 test 995 test 742 test 559 test 538 test 285 test 264 test 11 test 990 test 737 test 716 test 463 test 441 test 420 test 167 test 146 test 893 test 872 test 619 test 598 test 345 test 324 test 71 test 50 test 29 test 775 test 754 test 501 test 480 test 227 test 206 test 953 test 932 test 679 test 658 test 475 test 454 test 201 test 180 test 927 test 906 test 652 test 631 test 378 test 357 test 104 test 83 test 62 test 809 test 788 test 535 test 514 test 261 test 239 test 986 test 965 test 712 test 691 test 438 test 417 test 396 test 143 test 122 test 869 test 848 test 595 test 573 test 391 test 138 test 116 test 863 test 842 test 821 test 568 test 547 test 294 test 273 test 20 test 999 test 746 test 725 test 472 test 450 test 429 test 176 test 155 test 972 test 719 test 698 test 445 test 424 test 171 test 150 test 897 test 876 test 855 test 602 test 581 test 327 test 145 test 124 test 871 test 849 test 596 test 575 test 322 test 301 test 280 test 27 test 6 test 753 test 732 test 479 test 458 test 204 test 183 test 930 test 909 test 656 test 635 test 614 test 361 test 340 test 87 test 66 test 813 test 791 test 538 test 517 test 264 test 313 test 60 test 39 test 786 test 765 test 512 test 491 test 238 test 217 test 964 test 943 test 690 test 669 test 647 test 394 test 373 test 120 test 99 test 846 test 825 test 572 test 551 test 298 test 277 test 256 test 2 test 981 test 728 test 707 test 454 test 433 test 180 test 159 test 976 test 723 test 702 test 681 test 428 test 407 test 154 test 133 test 879 test 858 test 605 test 584 test 331 test 310 test 57 test 36 test 15 test 762 test 741 test 488 test 466 test 213 test 192 test 939 test 918 test 665 test 644 test 623 test 370 test 349 test 96 test 913 test 892 test 639 test 618 test 365 test 344 test 90 test 69 test 48 test 795 test 774 test 521 test 500 test 247 test 226 test 973 test 952 test 699 test 677 test 424 test 403 test 382 test 129 test 108 test 855 test 834 test 581 test 560 test 307 test 286 test 32 test 11 test 829 test 808 test 554 test 533 test 280 test 259 test 6 test 985 test 732 test 711 test 458 test 437 test 416 test 163 test 141 test 888 test 867 test 614 test 593 test 340 test 319 test 66 test 45 test 24 test 771 test 750 test 497 test 475 test 222 test 201 test 948 test 927 test 744 test 491 test 470 test 449 test 196 test 175 test 922 test 901 test 648 test 627 test 374 test 352 test 99 test 78 test 825 test 804 test 783 test 530 test 509 test 256 test 235 test 982 test 961 test 707 test 686 test 433 test 412 test 391 test 138 test 117 test 864 test 681 test 660 test 407 test 386 test 133 test 112 test 859 test 838 test 816 test 563 test 542 test 289 test 268 test 15 test 994 test 741 test 720 test 467 test 446 test 193 test 172 test 150 test 897 test 876 test 623 test 602 test 349 test 328 test 75 test 54 test 801 test 618 test 597 test 576 test 323 test 302 test 49 test 27 test 774 test 753 test 500 test 479 test 226 test 205 test 184 test 931 test 910 test 657 test 636 test 382 test 361 test 108 test 87 test 834 test 813 test 560 test 539 test 518 test 265 test 244 test 991 test 808 test 787 test 534 test 513 test 259 test 238 test 217 test 964 test 943 test 690 test 669 test 416 test 395 test 142 test 121 test 868 test 847 test 593 test 572 test 551 test 298 test 277 test 24 test 3 test 750 test 729 test 476 test 455 test 202 test 180 test 159 test 977 test 724 test 702 test 449 test 428 test 175 test 154 test 901 test 880 test 627 test 606 test 585 test 332 test 311 test 57 test 36 test 783 test 762 test 509 test 488 test 235 test 214 test 961 test 940 test 919 test 666 test 645 test 391 test 370 test 117 test 96 test 843 test 660 test 639 test 386 test 365 test 344 test 91 test 70 test 817 test 796 test 543 test 522 test 268 test 247 test 994 test 973 test 952 test 699 test 678 test 425 test 404 test 151 test 130 test 877 test 855 test 602 test 581 test 328 test 307 test 286 test 33 test 12 test 829 test 576 test 555 test 302 test 281 test 28 test 7 test 754 test 732 test 711 test 458 test 437 test 184 test 163 test 910 test 889 test 636 test 615 test 362 test 341 test 320 test 66 test 45 test 792 test 771 test 518 test 497 test 244 test 223 test 970 test 949 test 696 test 745 test 492 test 471 test 218 test 197 test 943 test 922 test 669 test 648 test 395 test 374 test 353 test 100 test 79 test 826 test 805 test 552 test 530 test 277 test 256 test 3 test 982 test 729 test 708 test 687 test 434 test 413 test 160 test 139 test 885 test 864 test 611 test 429 test 407 test 154 test 133 test 112 test 859 test 838 test 585 test 564 test 311 test 290 test 37 test 16 test 763 test 741 test 720 test 467 test 446 test 193 test 172 test 919 test 898 test 645 test 624 test 371 test 350 test 96 test 75 test 54 test 801 test 780 test 597 test 344 test 323 test 70 test 49 test 796 test 775 test 522 test 501 test 480 test 227 test 205 test 952 test 931 test 678 test 657 test 404 test 383 test 130 test 109 test 88 test 835 test 814 test 560 test 539 test 286 test 265 test 12 test 991 test 738 test 717 test 464 test 513 test 260 test 239 test 986 test 965 test 712 test 691 test 438 test 416 test 163 test 142 test 121 test 868 test 847 test 594 test 573 test 320 test 299 test 46 test 25 test 771 test 750 test 497 test 476 test 455 test 202 test 181 test 928 test 907 test 654 test 633 test 450 test 197 test 176 test 923 test 902 test 880 test 627 test 606 test 353 test 332 test 79 test 58 test 805 test 784 test 531 test 510 test 489 test 235 test 214 test 961 test 940 test 687 test 666 test 413 test 392 test 139 test 118 test 865 test 844 test 823 test 569 test 548 test 366 test 113 test 91 test 838 test 817 test 564 test 543 test 290 test 269 test 248 test 995 test 974 test 721 test 700 test 446 test 425 test 172 test 151 test 898 test 877 test 856 test 603 test 582 test 329 test 308 test 55 test 33 test 780 test 759 test 506 test 485 test 302 test 281 test 28 test 7 test 754 test 733 test 480 test 459 test 206 test 185 test 932 test 910 test 657 test 636 test 615 test 362 test 341 test 88 test 67 test 814 test 793 test 540 test 519 test 266 test 244 test 223 test 970 test 949 test 696 test 675 test 422 test 239 test 218 test 965 test 944 test 691 test 670 test 649 test 396 test 375 test 121 test 100 test 847 test 826 test 573 test 552 test 299 test 278 test 257 test 4 test 983 test 730 test 708 test 455 test 434 test 181 test 160 test 907 test 886 test 633 test 612 test 591 test 338 test 155 test 134 test 881 test 860 test 607 test 585 test 332 test 311 test 58 test 37 test 16 test 763 test 742 test 489 test 468 test 215 test 194 test 941 test 919 test 666 test 645 test 624 test 371 test 350 test 97 test 76 test 823 test 802 test 549 test 528 test 274 test 253 test 71 test 50 test 796 test 775 test 522 test 501 test 248 test 227 test 974 test 953 test 700 test 679 test 426 test 405 test 383 test 130 test 109 test 856 test 835 test 582 test 561 test 308 test 287 test 34 test 13 test 992 test 739 test 717 test 464 test 443 test 190 test 7 test 986 test 733 test 712 test 459 test 438 test 417 test 164 test 143 test 890 test 869 test 616 test 594 test 341 test 320 test 67 test 46 test 25 test 772 test 751 test 498 test 477 test 224 test 203 test 949 test 928 test 675 test 654 test 401 test 380 test 359 test 106 test 923 test 902 test 649 test 628 test 375 test 354 test 101 test 80 test 826 test 805 test 784 test 531 test 510 test 257 test 236 test 983 test 962 test 709 test 688 test 435 test 414 test 392 test 1458037656
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] eec::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
