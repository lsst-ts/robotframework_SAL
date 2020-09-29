*** Settings ***
Documentation    This resource file defines common keywords used by all the SAL test suites.
Library          OperatingSystem

*** Keywords ***
File Should Contain
    [Arguments]    ${file}    ${string}
    [Documentation]    Takes a file and a string and checks the file contains the given string.
    ${output}=    Get File    ${file}
    Should Contain    ${output}    ${string}
