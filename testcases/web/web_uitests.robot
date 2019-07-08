*** Variables ***


*** Settings ***
Documentation     Web acceptance tests for pet store
Resource          ../../resources/imports.robot
Suite Setup     Run Keywords     Environment cleanout    #cleanout environment
Test Setup      Open Browsers    ${url}    ${browser}  #Given the user has accessed the webapp and open browser
Test Teardown   Close Browser
Suite Teardown  Environment cleanout


*** Test Cases ***

US01_DisplayCurrentDate
    [Documentation]     System should display current date formated DD-MM-YYYY on top right section of the page
    When the page is rendered on the user's browser
    Then He sees the date of the day displayed on the top right part of the page
    And the date format is : DD-MM-YYYY
    And the background color of the banner is black

US02_View_List_100_Pets
    [Documentation]    System should display list of pet and page load in less than 2 seconds
    When the page is rendered on the user's browser
    And Ingest test data "100"
    And the page is reloaded
    And page load in less than 2 seconds
    [Teardown]  Run Keywords    Environment cleanout    Close Browser

US03_Mandatory_Fields_Check
    [Documentation]     Pet name and status should not be empty for new pet
    When the page is rendered on the user's browser
    Then the user tries to add a new pet
    Then Pet Name and Pet Status are both mandatory fields

US03_Input_Validation_Click_Create
    [Documentation]  user enter pet name and status and press create then the newly created pet should display on the list of pets
    When the page is rendered on the user's browser
    And the user has entered "${petname}" and "${petstatus}"
    And click create button
    Then new pet "${petname}" is added to the list

US03_Input_Validation_Keyboard_CreateButton
    [Documentation]  user enter pet name and status and press enter key then the newly created pet should display on the list of pets
    When the page is rendered on the user's browser
    And the user has entered "${petname}" and "${petstatus}"
    And press enter key
    Then new pet "${petname}" is added to the list

US03_Input_Accessibility
    [Documentation]  System should implement accessiblity rules
    When the page is rendered on the user's browser
    And the user has focus on the "${petname-input}" field
    And press tab key on "${petname-input}"
    Then the "${petstatus-input}" should be in focus
    And press tab key on "${petstatus-input}"
    Then the "btn-create" should be in focus

    When the user has focus on the "${petstatus-input}" field
    And the user has pressed the keys SHIFT + TAB
    Then the "${petname-input}" should be in focus

US04_Pet_Edit
    [Documentation]  edit pet and it should cover first Acceptance Criteria of US02
    When the page is rendered on the user's browser
    And pet list is displayed
    And the user has entered "${petname4}" and "${petstatus4}"
    And click create button

    Then user can click on pet name "${petname4}"
    And edit pet name "${petname4}" and click outside of the table
    Then pet changes are saved

    And user click pet status "${petstatus4}"
    And edit pet status "${petstatus4}" and press enter
    Then status changes are saved

    And user click pet status "${petstatus4}${petstatus4_edit}"
    And edit pet status and press escape
    Then status changes should not be saved

