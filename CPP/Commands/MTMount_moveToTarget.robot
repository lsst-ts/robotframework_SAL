*** Settings ***
Documentation    MTMount_moveToTarget communications tests.
Force Tags    cpp    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Commander    AND    Create Session    Controller
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    MTMount
${component}    moveToTarget
${timeout}    30s

*** Test Cases ***
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 25.0961 15.988 GaisyjTuZTALsYDgClUaeWhJSuNFidHSUSdKPMiaIIiLtztreNqxwzMOVGuXVmjNrpIRwfOWuxUnRVAlnkDvMrazNFSdrJIcaKwdOqzJzeundmgbpQEjqrblEHhearyQaozgpxwZtljFOsPRJHngSXtxzuKsXUyfIjIfEAcFuljqwEQqAWAlzdfkuItlyNgZQRkzfYTqSRQHAKoHESlzFBpQimzyUyieZyWPPuMVKXdlgwFJvasFNQAxxowHrTIUKAuJFDbKfplbjkbyisXKlOSenEbVgFWwspWlOhAhYYNJfytuCsOKapdpebcnpPvyNoWxfLlgoQFsuMDWtNZPArzXGyXtgAiVFwNvRRhRJWAcZyyXBuOqcOhabnwLfPSqkPRyAKRvbcnxZyVMwTEXrFIKvfWbpvhGUjOEzRzPmIFpiQaickEPCqYydEvkxXtUxchexKSMtdWpSuMJAqXIOMPTquioKtdZvzhaJewnbCghxLUdBIiiPlDLxUtIsOYbyysGoeKojGNAiTVByrACzfHkOqmslhIICaIecAVABXQEPoxwNMGkMDxjKGWhDsAEMjWfUpaNksRMfuPFfJAreNeuhKfJCUVKksdjdPQsGmRsfdbZoJXgKGymBaXAKyQEvppbRUAwFWbgdOcWVVVHdPBYISRNzvUHslOVpepTaFlcoQNaFpwpbBVUIlCEGckEMjKEyhZmJFbQAbjWvTRYIvhnaXPdLuiPSGrTNwR
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_commander 25.0961 15.988 GaisyjTuZTALsYDgClUaeWhJSuNFidHSUSdKPMiaIIiLtztreNqxwzMOVGuXVmjNrpIRwfOWuxUnRVAlnkDvMrazNFSdrJIcaKwdOqzJzeundmgbpQEjqrblEHhearyQaozgpxwZtljFOsPRJHngSXtxzuKsXUyfIjIfEAcFuljqwEQqAWAlzdfkuItlyNgZQRkzfYTqSRQHAKoHESlzFBpQimzyUyieZyWPPuMVKXdlgwFJvasFNQAxxowHrTIUKAuJFDbKfplbjkbyisXKlOSenEbVgFWwspWlOhAhYYNJfytuCsOKapdpebcnpPvyNoWxfLlgoQFsuMDWtNZPArzXGyXtgAiVFwNvRRhRJWAcZyyXBuOqcOhabnwLfPSqkPRyAKRvbcnxZyVMwTEXrFIKvfWbpvhGUjOEzRzPmIFpiQaickEPCqYydEvkxXtUxchexKSMtdWpSuMJAqXIOMPTquioKtdZvzhaJewnbCghxLUdBIiiPlDLxUtIsOYbyysGoeKojGNAiTVByrACzfHkOqmslhIICaIecAVABXQEPoxwNMGkMDxjKGWhDsAEMjWfUpaNksRMfuPFfJAreNeuhKfJCUVKksdjdPQsGmRsfdbZoJXgKGymBaXAKyQEvppbRUAwFWbgdOcWVVVHdPBYISRNzvUHslOVpepTaFlcoQNaFpwpbBVUIlCEGckEMjKEyhZmJFbQAbjWvTRYIvhnaXPdLuiPSGrTNwR
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [issueCommand_${component}] writing a command containing :    1
    Should Contain X Times    ${output}    device : target    1
    Should Contain X Times    ${output}    property : position    1
    Should Contain X Times    ${output}    action :     1
    Should Contain X Times    ${output}    value :     1
    Should Contain X Times    ${output}    az_angle : 25.0961    1
    Should Contain X Times    ${output}    el_angle : 15.988    1
    Should Contain X Times    ${output}    cablewrap_orientation : GaisyjTuZTALsYDgClUaeWhJSuNFidHSUSdKPMiaIIiLtztreNqxwzMOVGuXVmjNrpIRwfOWuxUnRVAlnkDvMrazNFSdrJIcaKwdOqzJzeundmgbpQEjqrblEHhearyQaozgpxwZtljFOsPRJHngSXtxzuKsXUyfIjIfEAcFuljqwEQqAWAlzdfkuItlyNgZQRkzfYTqSRQHAKoHESlzFBpQimzyUyieZyWPPuMVKXdlgwFJvasFNQAxxowHrTIUKAuJFDbKfplbjkbyisXKlOSenEbVgFWwspWlOhAhYYNJfytuCsOKapdpebcnpPvyNoWxfLlgoQFsuMDWtNZPArzXGyXtgAiVFwNvRRhRJWAcZyyXBuOqcOhabnwLfPSqkPRyAKRvbcnxZyVMwTEXrFIKvfWbpvhGUjOEzRzPmIFpiQaickEPCqYydEvkxXtUxchexKSMtdWpSuMJAqXIOMPTquioKtdZvzhaJewnbCghxLUdBIiiPlDLxUtIsOYbyysGoeKojGNAiTVByrACzfHkOqmslhIICaIecAVABXQEPoxwNMGkMDxjKGWhDsAEMjWfUpaNksRMfuPFfJAreNeuhKfJCUVKksdjdPQsGmRsfdbZoJXgKGymBaXAKyQEvppbRUAwFWbgdOcWVVVHdPBYISRNzvUHslOVpepTaFlcoQNaFpwpbBVUIlCEGckEMjKEyhZmJFbQAbjWvTRYIvhnaXPdLuiPSGrTNwR    1
    Should Contain    ${output}    === command moveToTarget issued =
    ${CmdComplete}=    Get Line    ${output}    -2
    Should Match Regexp    ${CmdComplete}    (=== \\[waitForCompletion_${component}\\] command )[0-9]+( completed ok :)

Read Controller
    [Tags]    functional
    Switch Connection    Controller
    ${output}=    Read Until    result \ \ : Done : OK
    Log    ${output}
    Should Contain    ${output}    === command moveToTarget received =
    Should Contain    ${output}    device : target
    Should Contain    ${output}    property : position
    Should Contain    ${output}    action : 
    Should Contain    ${output}    value : 
    Should Contain X Times    ${output}    az_angle : 25.0961    1
    Should Contain X Times    ${output}    el_angle : 15.988    1
    Should Contain X Times    ${output}    cablewrap_orientation : GaisyjTuZTALsYDgClUaeWhJSuNFidHSUSdKPMiaIIiLtztreNqxwzMOVGuXVmjNrpIRwfOWuxUnRVAlnkDvMrazNFSdrJIcaKwdOqzJzeundmgbpQEjqrblEHhearyQaozgpxwZtljFOsPRJHngSXtxzuKsXUyfIjIfEAcFuljqwEQqAWAlzdfkuItlyNgZQRkzfYTqSRQHAKoHESlzFBpQimzyUyieZyWPPuMVKXdlgwFJvasFNQAxxowHrTIUKAuJFDbKfplbjkbyisXKlOSenEbVgFWwspWlOhAhYYNJfytuCsOKapdpebcnpPvyNoWxfLlgoQFsuMDWtNZPArzXGyXtgAiVFwNvRRhRJWAcZyyXBuOqcOhabnwLfPSqkPRyAKRvbcnxZyVMwTEXrFIKvfWbpvhGUjOEzRzPmIFpiQaickEPCqYydEvkxXtUxchexKSMtdWpSuMJAqXIOMPTquioKtdZvzhaJewnbCghxLUdBIiiPlDLxUtIsOYbyysGoeKojGNAiTVByrACzfHkOqmslhIICaIecAVABXQEPoxwNMGkMDxjKGWhDsAEMjWfUpaNksRMfuPFfJAreNeuhKfJCUVKksdjdPQsGmRsfdbZoJXgKGymBaXAKyQEvppbRUAwFWbgdOcWVVVHdPBYISRNzvUHslOVpepTaFlcoQNaFpwpbBVUIlCEGckEMjKEyhZmJFbQAbjWvTRYIvhnaXPdLuiPSGrTNwR    1
    Should Contain X Times    ${output}    === [ackCommand_moveToTarget] acknowledging a command with :    2
    Should Contain    ${output}    seqNum   :
    Should Contain    ${output}    ack      : 301
    Should Contain X Times    ${output}    error \ \ \ : 0    2
    Should Contain    ${output}    result   : Ack : OK
    Should Contain    ${output}    ack      : 303
    Should Contain    ${output}    result   : Done : OK
