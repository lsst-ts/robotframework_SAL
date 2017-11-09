*** Settings ***
Documentation    EEC_InternalCommand sender/logger tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    eec
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send 675 test 422 test 401 test 148 test 127 test 874 test 853 test 600 test 578 test 557 test 304 test 283 test 30 test 9 test 756 test 735 test 482 test 461 test 208 test 187 test 934 test 912 test 891 test 638 test 617 test 364 test 343 test 90 test 907 test 886 test 633 test 612 test 359 test 338 test 317 test 64 test 43 test 789 test 768 test 515 test 494 test 241 test 220 test 967 test 946 test 925 test 672 test 651 test 398 test 376 test 123 test 102 test 849 test 828 test 575 test 554 test 301 test 280 test 259 test 6 test 823 test 802 test 549 test 528 test 275 test 253 test 1000 test 979 test 726 test 705 test 684 test 431 test 410 test 157 test 136 test 883 test 862 test 609 test 587 test 334 test 313 test 292 test 39 test 18 test 765 test 744 test 491 test 470 test 217 test 196 test 942 test 760 test 739 test 718 test 464 test 443 test 190 test 169 test 916 test 895 test 642 test 621 test 368 test 347 test 326 test 73 test 51 test 798 test 777 test 524 test 503 test 250 test 229 test 976 test 955 test 702 test 681 test 660 test 406 test 385 test 132 test 111 test 858 test 675 test 654 test 401 test 380 test 127 test 106 test 85 test 832 test 811 test 558 test 537 test 284 test 262 test 9 test 988 test 735 test 714 test 693 test 440 test 419 test 166 test 145 test 892 test 871 test 617 test 596 test 343 test 322 test 69 test 48 test 27 test 774 test 591 test 570 test 317 test 296 test 43 test 22 test 769 test 748 test 494 test 473 test 452 test 199 test 178 test 925 test 904 test 651 test 630 test 377 test 356 test 103 test 81 test 60 test 807 test 786 test 533 test 512 test 259 test 238 test 985 test 964 test 711 test 690 test 507 test 486 test 233 test 212 test 959 test 937 test 684 test 663 test 410 test 389 test 136 test 115 test 94 test 841 test 820 test 567 test 546 test 292 test 271 test 18 test 997 test 744 test 723 test 470 test 449 test 428 test 175 test 154 test 901 test 879 test 626 test 444 test 423 test 169 test 148 test 895 test 874 test 853 test 600 test 579 test 326 test 305 test 52 test 31 test 778 test 756 test 503 test 482 test 461 test 208 test 187 test 934 test 913 test 660 test 639 test 386 test 365 test 112 test 90 test 837 test 816 test 795 test 612 test 359 test 338 test 85 test 64 test 811 test 790 test 537 test 516 test 263 test 242 test 221 test 967 test 946 test 693 test 672 test 419 test 398 test 145 test 124 test 871 test 850 test 829 test 576 test 554 test 301 test 280 test 27 test 6 test 753 test 732 test 479 test 296 test 275 test 254 test 1 test 980 test 727 test 706 test 453 test 431 test 178 test 157 test 904 test 883 test 630 test 609 test 588 test 335 test 314 test 61 test 40 test 787 test 765 test 512 test 491 test 238 test 217 test 196 test 943 test 922 test 669 test 648 test 465 test 212 test 29 test 8 test 755 test 734 test 713 test 460 test 439 test 186 test 164 test 911 test 890 test 637 test 616 test 363 test 342 test 89 test 68 test 47 test 794 test 773 test 519 test 498 test 245 test 224 test 971 test 950 test 697 test 676 test 493 test 472 test 219 test 198 test 945 test 924 test 671 test 650 test 396 test 375 test 122 test 101 test 80 test 827 test 806 test 553 test 532 test 279 test 258 test 5 test 984 test 730 test 709 test 456 test 435 test 414 test 161 test 140 test 887 test 704 test 683 test 430 test 409 test 156 test 135 test 114 test 861 test 839 test 586 test 565 test 312 test 291 test 38 test 17 test 764 test 743 test 490 test 469 test 448 test 194 test 173 test 920 test 899 test 646 test 625 test 372 test 351 test 98 test 915 test 894 test 873 test 620 test 599 test 346 test 325 test 71 test 50 test 797 test 776 test 523 test 502 test 481 test 228 test 207 test 954 test 933 test 680 test 658 test 405 test 384 test 131 test 110 test 857 test 836 test 815 test 632 test 379 test 358 test 105 test 84 test 831 test 810 test 557 test 536 test 282 test 261 test 240 test 987 test 966 test 713 test 692 test 439 test 418 test 165 test 144 test 891 test 869 test 848 test 595 test 574 test 321 test 300 test 47 test 864 test 843 test 590 test 569 test 316 test 295 test 274 test 21 test 1000 test 746 test 725 test 472 test 451 test 198 test 177 test 924 test 903 test 650 test 629 test 608 test 355 test 333 test 80 test 59 test 806 test 785 test 532 test 349 test 328 test 307 test 54 test 33 test 780 test 759 test 506 test 485 test 232 test 211 test 957 test 936 test 683 test 662 test 641 test 388 test 367 test 114 test 93 test 840 test 819 test 566 test 544 test 291 test 270 test 249 test 996 test 813 test 792 test 539 test 518 test 265 test 244 test 991 test 970 test 717 test 696 test 675 test 421 test 400 test 147 test 126 test 873 test 852 test 599 test 578 test 325 test 304 test 51 test 30 test 8 test 755 test 573 test 552 test 298 test 277 test 24 test 3 test 750 test 729 test 476 test 455 test 434 test 181 test 160 test 907 test 886 test 632 test 611 test 358 test 337 test 84 test 63 test 42 test 789 test 768 test 515 test 494 test 311 test 58 test 37 test 784 test 763 test 509 test 488 test 467 test 214 test 193 test 940 test 919 test 666 test 645 test 392 test 371 test 118 test 96 test 75 test 822 test 801 test 548 test 527 test 274 test 253 test 1000 test 817 test 796 test 543 test 522 test 501 test 248 test 227 test 973 test 952 test 699 test 678 test 425 test 404 test 151 test 130 test 877 test 856 test 835 test 582 test 561 test 307 test 286 test 33 test 12 test 759 test 738 test 485 test 302 test 281 test 260 test 7 test 986 test 733 test 712 test 459 test 438 test 184 test 163 test 910 test 889 test 868 test 615 test 594 test 341 test 320 test 67 test 46 test 793 test 771 test 518 test 497 test 244 test 223 test 202 test 19 test 766 test 745 test 492 test 471 test 218 test 197 test 944 test 923 test 670 test 648 test 627 test 374 test 353 test 100 test 79 test 826 test 805 test 552 test 531 test 278 test 257 test 236 test 982 test 961 test 708 test 687 test 434 test 413 test 230 test 977 test 956 test 703 test 682 test 661 test 408 test 387 test 134 test 113 test 859 test 838 test 585 test 564 test 311 test 290 test 269 test 16 test 995 test 742 test 721 test 468 test 446 test 193 test 172 test 919 test 898 test 645 test 694 test 441 test 420 test 167 test 146 test 893 test 872 test 619 test 598 test 345 test 323 test 70 test 49 test 28 test 775 test 754 test 501 test 480 test 227 test 206 test 953 test 932 test 679 test 657 test 636 test 383 test 362 test 109 test 88 test 905 test 652 test 631 test 378 test 357 test 104 test 83 test 62 test 809 test 788 test 534 test 513 test 260 test 239 test 986 test 965 test 712 test 691 test 438 test 417 test 396 test 143 test 121 test 868 test 847 test 594 test 573 test 320 test 137 test 116 test 95 test 842 test 821 test 568 test 547 test 294 test 273 test 20 test 998 test 745 test 724 test 471 test 450 test 429 test 176 test 155 test 902 test 881 test 628 test 607 test 354 test 332 test 79 test 58 test 37 test 784 test 763 test 580 test 327 test 306 test 53 test 32 test 779 test 758 test 505 test 484 test 463 test 209 test 188 test 935 test 914 test 661 test 640 test 387 test 366 test 113 test 92 test 839 test 818 test 796 test 543 test 522 test 269 test 248 test 995 test 974 test 791 test 538 test 517 test 264 test 243 test 222 test 969 test 948 test 695 test 673 test 420 test 399 test 146 test 125 test 872 test 851 test 830 test 577 test 556 test 303 test 282 test 29 test 7 test 754 test 733 test 480 test 459 test 276 test 255 test 2 test 981 test 728 test 707 test 454 test 433 test 180 test 159 test 906 test 884 test 631 test 610 test 589 test 336 test 315 test 62 test 41 test 788 test 767 test 514 test 493 test 239 test 218 test 36 test 15 test 761 test 740 test 487 test 466 test 213 test 192 test 939 test 918 test 665 test 644 test 623 test 370 test 348 test 95 test 74 test 821 test 800 test 547 test 526 test 273 test 252 test 231 test 978 test 957 test 774 test 521 test 500 test 247 test 225 test 972 test 951 test 698 test 677 test 656 test 403 test 382 test 129 test 108 test 855 test 834 test 581 test 559 test 306 test 285 test 32 test 11 test 990 test 737 test 716 test 463 test 442 test 259 test 6 test 985 test 732 test 711 test 458 test 436 test 415 test 162 test 141 test 888 test 867 test 614 test 593 test 340 test 319 test 66 test 45 test 23 test 770 test 749 test 496 test 475 test 222 test 201 test 948 test 927 test 674 test 491 test 470 test 449 test 196 test 175 test 922 test 900 test 647 test 626 test 373 test 352 test 99 test 78 test 57 test 804 test 783 test 530 test 509 test 256 test 234 test 981 test 960 test 707 test 686 test 433 test 412 test 391 test 138 test 117 test 864 test 681 test 660 test 407 test 386 test 133 test 111 test 858 test 837 test 816 test 563 test 542 test 289 test 268 test 15 test 994 test 741 test 720 test 466 test 445 test 424 test 171 test 150 test 897 test 876 test 216056158
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] eec::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event InternalCommand generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 216056158
    Log    ${output}
    Should Contain X Times    ${output}    === Event InternalCommand received =     1
    Should Contain    ${output}    CommandObject : 675
    Should Contain    ${output}    priority : test
