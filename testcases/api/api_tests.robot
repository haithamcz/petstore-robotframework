*** Settings ***
Resource    ../../resources/imports.robot
Suite Setup     Run Keywords     Environment cleanout     Ingest test data "5"   #cleanout environment and prepare test data for the test
Suite Teardown  Environment cleanout
Documentation  CRUD API tests to cover US05 - Exposing a REST API

*** Test Cases ***
TestGetPets_200
    [Documentation]  test to verify Get all pets from the store (getPets)
    When Get Pets
    Then HTTP Response Status Code Should Be "200"
    And Response Body Should Contain Data


TestGetPetById_200
    [Documentation]  test to verify get pet by ID (getPetById)
    When Get Pet ById   1
    Then HTTP Response Status Code Should Be "200"
    And Response Body "name" Should Be "${dog_name}"

TestGetPetById_404
    [Documentation]  test to verify get pet by for non existing ID
    When Get Pet ById   300
    Then HTTP Response Status Code Should Be "404"


TestPostPet_201
    [Documentation]  test to verify a new pet can be added to the store (addPet)
    When Post Pet   ${id_dog}  ${dog_name_b}   ${status_a}
    Then HTTP Response Status Code Should Be "201"
    [Teardown]  Delete Pet "1000"

#Todo add negative post scenario like invalid body json

TestUpdatePet_200
    [Documentation]  test to verify pet update in the store with form data (updatePetWithForm)
    When Update Pet "1" Status "Not Available"
    Then HTTP Response Status Code Should Be "200"
    [Teardown]  Update Pet "1" Status "Available"

#Todo add negative put scenario like non existing pet id

TestDeletePet_200
    [Documentation]  test to verify pet deletion API (deletePet)
    [Setup]  Post Pet   20001  Robin   Avialable
    When Delete Pet by "20001"
    Then HTTP Response Status Code Should Be "200"

TestDeletePet_404
    [Documentation]  test to verify pet deletion API for non existing pet
    When Delete Pet by "3000"
    Then HTTP Response Status Code Should Be "404"

