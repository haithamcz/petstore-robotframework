*** Settings ***
Resource    ../../resources/imports.robot
Resource    ../../resources/imports.robot

*** Keywords ***
Update Pet "${id}" Status "${status}"
    ${Header}=   Create Dictionary   Content-Type   application/json
    ${json}=    To Json  {"name": "Donald","status": "${status}"}
    ${response}=    Put Request  petstore     /api/pets/${id}       data=${json}    headers=${Header}
    Set Test Variable    ${response}    ${response}