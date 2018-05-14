*** Settings ***
Documentation    M1M3_RejectedForces sender/logger tests.
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
${component}    RejectedForces
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
    Should Contain    ${output}   ERROR : Invalid or missing arguments : Timestamp XForces YForces ZForces Fx Fy Fz Mx My Mz ForceMagnitude priority

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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 65.7681 0.444904644493 0.700853990382 0.453913457263 0.932936796235 0.37277540834 0.295952541177 0.26259873931 0.826928967491 0.520665456903 0.643373648817 0.990449382836 0.606471684887 0.0527919422109 0.653552672832 0.971646116661 0.157719683347 0.390913467257 0.596968006565 0.53541322117 0.750612897396 0.507834308613 0.148168641046 0.405430286318 0.989309475035 0.0980327928137 0.21367251084 0.538035058703 0.210139971356 0.768561926452 0.904691572088 0.331394748634 0.981338681714 0.658507597157 0.487986421628 0.664082810652 0.0549405319062 0.589572179341 0.326425424259 0.0842892501626 0.973726418314 0.491222590193 0.593786706911 0.342078095224 0.686825163583 0.588562012432 0.466809567356 0.747321502561 0.0533158227416 0.925793748326 0.0688294186665 0.930429483385 0.385167522534 0.46535191301 0.265514157683 0.1061492978 0.365081161838 0.568555296873 0.179757010024 0.176396357258 0.498108254468 0.634127822826 0.801491457889 0.258695951346 0.645835689464 0.050815565671 0.0899037387332 0.389103441027 0.233058474647 0.017396795392 0.886866769536 0.422338658621 0.702264898627 0.921908031136 0.527945762826 0.697039291425 0.39167603126 0.15019045672 0.389532871676 0.864879317511 0.0592979540172 0.675460150474 0.218758362799 0.746929668604 0.0186865974082 0.00913536728189 0.387639608882 0.266142003785 0.062279049767 0.181652918826 0.228976641806 0.386378782846 0.670529800435 0.318889186997 0.0880957976649 0.834573856247 0.9759038309 0.0109288383975 0.889050025979 0.842497081336 0.486979983756 0.228727883615 0.384017103923 0.0815950712956 0.260456415295 0.752042003066 0.215802404834 0.019657540013 0.541393913552 0.752078367924 0.907466803689 0.952859601926 0.718280310617 0.519214666397 0.988348111799 0.192547352266 0.850876023948 0.0994117769743 0.449538993697 0.964748974442 0.248383590459 0.839739389263 0.510792842847 0.415448360384 0.859029139093 0.940223613638 0.536710877458 0.881738658461 0.380206404647 0.190585930298 0.571840448701 0.288277357614 0.0102107632096 0.296797997945 0.0154754775862 0.523136965854 0.743604073565 0.375832593156 0.111711905587 0.646759025278 0.0477927290514 0.0171858380623 0.63323806862 0.288846815626 0.121926119594 0.499473689566 0.102493301477 0.287058448857 0.850794315563 0.559991649409 0.517675426548 0.418827024122 0.632819616044 0.837647965971 0.384516066912 0.131559958374 0.830035312375 0.0484965258489 0.446726992726 0.918041419799 0.0714187211893 0.740646617337 0.246038509572 0.120154075672 0.634370332622 0.6706317054 0.956096740226 0.139389105187 0.316428051288 0.138847815347 0.720779323632 0.948487834741 0.729036819797 0.705555216653 0.577750975551 0.38166951452 0.643592609707 0.387380144105 0.124501771196 0.348524026504 0.125581062985 0.750265386708 0.551205196087 0.701221361684 0.644662128048 0.757751288129 0.69007669402 0.980407401733 0.809547525674 0.892981829849 0.947348770509 0.253263774576 0.55907083754 0.078538900587 0.14165310444 0.550002865739 0.834212371625 0.499599733982 0.44579056194 0.78213906474 0.87343231922 0.498462278535 0.529324177668 0.66963042483 0.158270843415 0.899736820678 0.761814591987 0.829947561243 0.269582453885 0.607439731617 0.625623317282 0.338139922558 0.109530900917 0.392399521512 0.437212110435 0.0935409713751 0.562244363627 0.110936960917 0.707876656667 0.022133141866 0.839419982911 0.50702208784 0.730757456735 0.802407982237 0.492710908612 0.884122033124 0.275720461032 0.233378067061 0.702709475395 0.557498277342 0.442544277756 0.443902114008 0.659871215631 0.0611546060952 0.464707080956 0.82217457524 0.901069242212 0.555515191685 0.634146703623 0.975186022522 0.60828364608 0.070163136556 0.804314911268 0.168531811196 0.00538242782139 0.751779561293 0.740383530305 0.26227223553 0.234875356399 0.686567513573 0.108008208005 0.429363788478 0.0547118259487 0.685602140063 0.275052208428 0.184719373343 0.268433480683 0.614974023973 0.588634993717 0.419173482266 0.919117616448 0.693307552529 0.985701877352 0.833657004835 0.719550496369 0.95438527705 0.141079085421 0.119640236616 0.261702013328 0.0525409020763 0.913098049229 0.220796036886 0.821427378729 0.277211314899 0.861954190767 0.644440100051 -1732735108
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_RejectedForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
