*** Settings ***
Resource    ../../resources/imports.robot

*** Keywords ***
Delete Pet by "${id}"
        Create Session	petstore	${api-url}
        ${response}=	Delete Request	petstore	/api/pets/${Id}
        Set Test Variable    ${response}    ${response}

Clean out pets
    Create Session	petstore	${api-url}
    Delete Request	petstore	/api/pets/100
    Delete Request	petstore	/api/pets/101
    Delete Request	petstore	/api/pets/102

Environment cleanout
    Create Session	petstore	${api-url}
    ${response}=	Get Request	petstore	/api/pets
    ${json}=    To Json    ${response.text}
    ${jsonlenth}=   Get Length  ${json}
    Log   ${jsonlenth}
    :FOR    ${member}     IN      @{json}
        \    ${id}=    Get From Dictionary   ${member}     id
        \    Delete Request 	petstore	/api/pets/${Id}
    Log     env cleaned out

Loop in "${json}" list
    Log     ${json}
    ${json1}=   To Json     ${json}"
    :FOR    ${member}     IN      @{json}
    \    ${id}=    Get From Dictionary   ${member}     id
    \    Log    ${id}


