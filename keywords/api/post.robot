*** Settings ***
Resource    ../../resources/imports.robot

*** Keywords ***
Load test data
    Create Session	petstore	${api-url}
    ${json}=    To Json  {"id": 1,"name": "${dog_name}","status": "Available"}
    ${header}=   Create Dictionary   Content-Type   application/json
    Log    ${json}
    ${response}=	Post Request    petstore    /api/pets   data=${json}    headers=${Header}
    Log  ${response}

Post Pet
    [arguments]  ${id}=0    ${name}=0   ${status}=0
    Create Session	petstore	${api-url}
    ${json}=    To Json  {"id": ${id},"name": "${name}","status": "${status}"}
    ${header}=   Create Dictionary   Content-Type   application/json
    Log    ${json}
    ${response}=	Post Request    petstore    /api/pets   data=${json}    headers=${Header}
    Set Test Variable    ${response}    ${response}

Ingest test data "${number_pets}"
    Run Keyword If   ${number_pets}>0    Load Pets  ${number_pets}

Load Pets
    [Arguments]  ${number_pets}=0
    Create Session	petstore	${api-url}
    ${header}=   Create Dictionary   Content-Type   application/json
    :FOR    ${INDEX}     IN RANGE  1     ${number_pets}+1
            \       ${json}=    To Json  {"id": ${INDEX},"name": "${pet_name}+${INDEX}","status": "Available"}
            \       Log    ${json}
            \       ${response}=	Post Request    petstore    /api/pets   data=${json}    headers=${Header}
            \       Log  ${response}
    Log     ${number_pets} pets loaded


Ingest one pet
    [Arguments]   ${id}=0
    Create Session	petstore	${api-url}
    ${json}=    To Json  {"id": ${id},"name": "${pet_name}+${id}","status": "Available"}
    ${header}=   Create Dictionary   Content-Type   application/json
    Log    ${json}
    ${response}=	Post Request    petstore    /api/pets   data=${json}    headers=${Header}
    Log  ${response}
