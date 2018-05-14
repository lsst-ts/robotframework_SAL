*** Settings ***
Documentation    M1M3_AppliedAzimuthForces sender/logger tests.
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
${component}    AppliedAzimuthForces
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 36.945 0.532967181653 0.737997467218 0.216244732585 0.917730655208 0.405131587982 0.120145461278 0.407899513724 0.75747943542 0.088604315253 0.374178464797 0.913811401836 0.730328894285 0.172641162609 0.57228624279 0.249897237662 0.321156010333 0.556474036348 0.686734795394 0.207651142665 0.128366672642 0.721658041361 0.959574797281 0.22093247434 0.139097267484 0.524740756175 0.384284877885 0.644765742087 0.951937010495 0.105985627474 0.879302832647 0.37906840335 0.677713440878 0.347896367606 0.113715559199 0.499211865881 0.125762931275 0.385166273922 0.462092885409 0.787882948728 0.319694961286 0.54758401402 0.869344110209 0.413955634785 0.769957522698 0.787476029782 0.300715116699 0.750921948002 0.982547349909 0.263572446492 0.194619270275 0.293530543645 0.817524785546 0.743227077071 0.0801375780146 0.832854432823 0.976418664236 0.247321074907 0.775189483166 0.463926045642 0.700767924499 0.373138069191 0.12427937731 0.200121145232 0.704473399724 0.271533076839 0.21935313083 0.0927172335405 0.478294338784 0.564449691609 0.703158144095 0.366936893535 0.808128096148 0.154631102391 0.306178145397 0.0867754598826 0.642482898021 0.0102195452316 0.575720357803 0.693973459166 0.528035740106 0.505981114006 0.541259860712 0.477280520231 0.63271738638 0.750735291823 0.200924333265 0.861139299555 0.925831998099 0.611678103986 0.898282422987 0.21068292054 0.770156201096 0.800780802094 0.0342080473262 0.0374268526179 0.834387803103 0.32515271267 0.232525426802 0.64056792558 0.22186414033 0.749395934733 0.842792995012 0.246505780914 0.559380347199 0.176425410728 0.379933106704 0.16371467709 0.298635289419 0.350303926943 0.900564453764 0.150517833922 0.62809707605 0.422890839907 0.390219099467 0.224535392751 0.00668705046136 0.0956286721702 0.358932711214 0.00450445976402 0.992130123716 0.0475048756662 0.896149124936 0.838064434977 0.244116963154 0.709010470993 0.212089832583 0.421855213722 0.99341557025 0.81358076274 0.53478264797 0.175631318653 0.509782688808 0.470002546424 0.879399426878 0.37367928704 0.432131421607 0.933415583142 0.198644199707 0.0821397641643 0.987246950616 0.889555925042 0.87351366582 0.0828132143934 0.219284909116 0.756312442808 0.264841415013 0.917568849907 0.868574656992 0.251721730623 0.262203636934 0.811662534102 0.228405752341 0.662572697666 0.631201939412 0.129935134531 0.863887074515 0.626532820707 0.528715550612 0.97691452962 0.904135513059 0.958476227799 0.486508657675 0.737008934861 0.618466614768 0.120778004336 0.28964755038 0.00866374961765 0.823740015396 0.863696184646 0.399370939783 0.320431823877 0.311472122073 0.961092754942 0.236455681843 0.3356648136 0.976931319805 0.858967271562 0.563468550373 0.536691781696 0.467727872573 0.495269223411 0.696341149144 0.619008122588 0.908114642433 0.734816870606 0.98549193113 0.669725637554 0.458873598852 0.431095628913 0.213398839841 0.571939301069 0.185168247808 0.609105988371 0.883982596022 0.420679749159 0.853659862556 0.0421902982433 0.218048440674 0.701650198653 0.539255854103 0.537917181494 0.281819996166 0.525834691579 0.817022796186 0.0268986274478 0.489129353204 0.822363343837 0.622673689431 0.151968927502 0.434283699312 0.0359111776094 0.60469974746 0.6720161116 0.939557296825 0.923136931996 0.390948193716 0.865156230266 0.712416814141 0.551415476236 0.127412047409 0.50070917916 0.671570954093 0.772266339556 0.881452785135 0.290717294719 0.0253905708911 0.271581615349 0.528054519226 0.0730288753646 0.374239579249 0.802731212305 0.676696724524 0.356999767303 0.71639107866 0.629238680861 0.736949699757 0.485898256048 0.452635088126 0.769308662205 0.767079070216 0.298727831296 0.0796965118645 0.882271211985 0.0812825754788 0.807166338178 0.541761285673 0.614570848444 0.203073257942 0.833018870913 0.971889754504 0.941703834728 0.977149087053 0.386101143599 0.136496208665 0.148296952446 0.141155661894 0.409869016668 0.786424442391 0.060226318453 0.504372736273 0.621188862829 0.0635030133397 0.342713968611 0.747116026323 0.240671129935 0.0855837661069 0.44865746657 0.145128549177 0.9646621277 0.855014528979 0.249575915773 0.172176081755 0.512484542667 0.263927995428 0.688653664887 -331016845
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] m1m3::logevent_AppliedAzimuthForces writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
