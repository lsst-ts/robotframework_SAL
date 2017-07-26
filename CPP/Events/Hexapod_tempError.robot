*** Settings ***
Documentation    Hexapod_tempError sender/logger tests.
Force Tags    cpp
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    hexapod
${component}    tempError
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
    ${input}=    Write    ./sacpp_${subSystem}_${component}_send cvyiuilqdVGynDcvQFwKKxmvCKYDtPdoemxsFUrafcrGZlGpUjIRYMDUcDNNobWbyceiglIBuNFdPCZsovEuZqfDfOWJGWfqGtQzlWDBvjOfFtYGwjVABJrxKeDHfAGoHHGClzuZPJYiNwXWEZlDTWJrzRRhNOwjIhLVgpbtqqtIgKlRxzBNJQjcnXioBOvqUghPOVrflVNWeTAIzpCaRROegBrjVDZGMzuUFeIOdCJpUlMmqpoeKzAZRvlEWgGUwKQ CDNiZZvJeyMDAQLvZfcBoFoOrEktoBlMavPWdfHmfNlsVlISdioUltmqDywrBbCYZmLOUbRKzLmsxNzpsPgqcoRXwkCjIcOPXlvBpwQLxWjVLyeUSraqVMmpZiEofvDwCeDgNWEMnnWLGJYhkAkcrpMjjsNRSNEkHeGoUCLThhbCyTMlBHbWMZgejlOMuRESsuanIjNfLVrgsVWeiuCVUraHuRtnThEVlaJhnfEaIQVhAauXfDyZEJPrIgJVGIlZFHlWRVpUkZpKiawAuEzDoUtvMldrqRQjXhQGhrUNWlzaMHodgpLTCArJfquGzWipBIYXAUGsJrOPGHcUTdxtIxAJELBpVhXIHkTkmnnhrnjtjlufPVQZAcJkXvVPhNBakLLPBaoEXbvvttwBUQDCYhjfAGkZwbAWZSzWOwVxUcaXXNJknbRnyXFtdvoHbjPxKUlGLOdwJrfTXupJBQrsPJgIJnPUXyPLhsPfKwPqqKiYLOaNZqZwUGqzbIp -1453252094 70.198 1560259154
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] hexapod::logevent_tempError writing a message containing :    1
    Should Contain    ${output}    revCode \ :
    Should Contain    ${output}    === Event tempError generated =

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    priority : 1560259154
    Log    ${output}
    Should Contain X Times    ${output}    === Event tempError received =     1
    Should Contain    ${output}    axis : cvyiuilqdVGynDcvQFwKKxmvCKYDtPdoemxsFUrafcrGZlGpUjIRYMDUcDNNobWbyceiglIBuNFdPCZsovEuZqfDfOWJGWfqGtQzlWDBvjOfFtYGwjVABJrxKeDHfAGoHHGClzuZPJYiNwXWEZlDTWJrzRRhNOwjIhLVgpbtqqtIgKlRxzBNJQjcnXioBOvqUghPOVrflVNWeTAIzpCaRROegBrjVDZGMzuUFeIOdCJpUlMmqpoeKzAZRvlEWgGUwKQ
    Should Contain    ${output}    device : CDNiZZvJeyMDAQLvZfcBoFoOrEktoBlMavPWdfHmfNlsVlISdioUltmqDywrBbCYZmLOUbRKzLmsxNzpsPgqcoRXwkCjIcOPXlvBpwQLxWjVLyeUSraqVMmpZiEofvDwCeDgNWEMnnWLGJYhkAkcrpMjjsNRSNEkHeGoUCLThhbCyTMlBHbWMZgejlOMuRESsuanIjNfLVrgsVWeiuCVUraHuRtnThEVlaJhnfEaIQVhAauXfDyZEJPrIgJVGIlZFHlWRVpUkZpKiawAuEzDoUtvMldrqRQjXhQGhrUNWlzaMHodgpLTCArJfquGzWipBIYXAUGsJrOPGHcUTdxtIxAJELBpVhXIHkTkmnnhrnjtjlufPVQZAcJkXvVPhNBakLLPBaoEXbvvttwBUQDCYhjfAGkZwbAWZSzWOwVxUcaXXNJknbRnyXFtdvoHbjPxKUlGLOdwJrfTXupJBQrsPJgIJnPUXyPLhsPfKwPqqKiYLOaNZqZwUGqzbIp
    Should Contain    ${output}    severity : -1453252094
    Should Contain    ${output}    temp : 70.198
    Should Contain    ${output}    priority : 1560259154
