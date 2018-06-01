*** Settings ***
Documentation    OCS_ocsScriptError communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    ocs
${component}    ocsScriptError
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send CMhHWhfBmRkQYlRaILQvdRhZQneXJVRXNRdWZqGwhthnlsdQOhPPmiWAXaLCHsZXmGsMttyrNdfHwPxxDaDpYaoLFzMkbkzpLOgviQiFBfJsNXFQUTLVRmNqevnfZMgBMHSGLTrUqEoSoYiXQFmMQWxETogpJnwfULZtwnFPNiZZmAXdjmkfYjyxNvQXEKKMLovNrbUBuOATacPmBryZFcLduFGZsbhcIlVbTIHEdvdXMSQxUaRwRjwwunTYecAo 29.0592 PpZsUrMalnskzhUqdAPOSDRBleGlonlnUGuWsYKpDTSPHwYvXbeJimhIInfACmyeHYjMtcKYVTzlqPApUaoXlbCymvyrvkmDEyAzrXcInozvCWOcjhfNdZyHigrFfwToFvjjGnYWoYlINncBAatCERrJnYYGobomLMArueLjtidDPAknonQbeSjKHmDZQwfjRheRFBrSEkqImiDbmubNAQiOMgiakYSGdNYLSQagARwuoVsOZSGAiqYGfFxiOLsN -497244406 637679137 NpHrsFFxuayDmvfagPGGsIFAweWnPNpVdmoTZVfIaBoRIBfjQhskfVblWUnKlFTdvRhDypNRLAFhtZkXlcrslZtoZaSBXocAKAtGdTsFvcqIuwWlSsEeXCuPhCkXWyvVLTqfbzfRPCnutmIihQvfxehCSVcwobceMAWdaEeGsQyGCpsTkYDbHrvtjIrhfvimOhdOuGoNnHEkXKfLEpsKLdtGgVSUeCeHElfcfuCnMhkmlRMccxJbtPoKYmyloAak 756442264
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] ocs::logevent_ocsScriptError writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event ocsScriptError generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 756442264
    Log    ${output}
    Should Contain X Times    ${output}    === Event ocsScriptError received =     1
    Should Contain    ${output}    ocsScriptName : CMhHWhfBmRkQYlRaILQvdRhZQneXJVRXNRdWZqGwhthnlsdQOhPPmiWAXaLCHsZXmGsMttyrNdfHwPxxDaDpYaoLFzMkbkzpLOgviQiFBfJsNXFQUTLVRmNqevnfZMgBMHSGLTrUqEoSoYiXQFmMQWxETogpJnwfULZtwnFPNiZZmAXdjmkfYjyxNvQXEKKMLovNrbUBuOATacPmBryZFcLduFGZsbhcIlVbTIHEdvdXMSQxUaRwRjwwunTYecAo
    Should Contain    ${output}    ocsScriptIdentifier : 29.0592
    Should Contain    ${output}    ocsScriptTimestamp : PpZsUrMalnskzhUqdAPOSDRBleGlonlnUGuWsYKpDTSPHwYvXbeJimhIInfACmyeHYjMtcKYVTzlqPApUaoXlbCymvyrvkmDEyAzrXcInozvCWOcjhfNdZyHigrFfwToFvjjGnYWoYlINncBAatCERrJnYYGobomLMArueLjtidDPAknonQbeSjKHmDZQwfjRheRFBrSEkqImiDbmubNAQiOMgiakYSGdNYLSQagARwuoVsOZSGAiqYGfFxiOLsN
    Should Contain    ${output}    ocsScriptLineNumber : -497244406
    Should Contain    ${output}    ocsScriptErrorCode : 637679137
    Should Contain    ${output}    ocsScriptErrorText : NpHrsFFxuayDmvfagPGGsIFAweWnPNpVdmoTZVfIaBoRIBfjQhskfVblWUnKlFTdvRhDypNRLAFhtZkXlcrslZtoZaSBXocAKAtGdTsFvcqIuwWlSsEeXCuPhCkXWyvVLTqfbzfRPCnutmIihQvfxehCSVcwobceMAWdaEeGsQyGCpsTkYDbHrvtjIrhfvimOhdOuGoNnHEkXKfLEpsKLdtGgVSUeCeHElfcfuCnMhkmlRMccxJbtPoKYmyloAak
    Should Contain    ${output}    priority : 756442264
