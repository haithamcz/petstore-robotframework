*** Settings ***
Resource    ../../resources/imports.robot

*** Keywords ***

Response Body "${key}" Should Be "${value}"
    [Documentation]    Check whether key=value in response body
    ${json}=    To Json    ${response.text}
    Should Be Equal As Strings    ${json['${key}']}    ${value}

Get Pets
    Create Session	petstore	${api-url}
    ${response}=	Get Request	petstore	/api/pets
    Set Test Variable    ${response}    ${response}

Get Pet ById
    [Arguments]   ${Id}=0
    Create Session	petstore	${api-url}
    ${response}=	Get Request	petstore	/api/pets/${Id}
    Set Test Variable    ${response}    ${response}


Response Body Should Contain Data
    Log     ${response.json()}
    Should Not Be Empty  ${response.json()}
