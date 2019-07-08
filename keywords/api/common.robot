*** Settings ***
Resource    ../../resources/imports.robot

*** Keywords ***

HTTP Response Status Code Should Be "${code}"
    [Documentation]    Check whether response status code is 201 OK
    Should Be Equal As Strings    ${response.status_code}    ${code}


Response Body Should Contain
    [Arguments]   ${name}=0
    ${str}=    Get From Dictionary  ${response.json()}  name
    Should Be Equal As Strings  ${str}  ${name}


Delete Pet "${id}"
    Delete Request    petstore    /api/pets/${id}






