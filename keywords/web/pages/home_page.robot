*** Settings ***
Resource    ../../../resources/imports.robot



*** Keywords ***
He sees the date of the day displayed on the top right part of the page
    Element Should Contain  css=${container}    Hello stranger

The date format is : DD-MM-YYYY
    ${current_date}=    Get Current Date    result_format=%d-%m-%Y
    Element Text Should Be      css=${banner-date}   ${current_date}

The background color of the banner is black
    # get element style color for parent because css is inherited for child elements
    ${background_color}=  Execute Javascript  return window.getComputedStyle(document.getElementsByClassName("assignment-masthead")[0]).getPropertyValue('background-color');
    Should Be Equal As Strings  ${background_color}     rgb(0, 0, 0)   #rgb(0, 0, 0) represent black color, however this will fail as background color of this element is set to rgb(51, 51, 51)

The user tries to add a new pet
    Click Button    btn-create

Pet Name and Pet Status are both mandatory fields
    Page Should Contain  Pet Name is required       # check on required field message
    Page Should Contain  Pet Status is required     # check on required field message



The user has entered "${Name}" and "${Status}"
    Wait Until Element Is Enabled   ${petname-input}
    Input Text  ${petname-input}    ${Name}
    Input Text  ${petstatus-input}   ${Status}

Click create button
    Click Button    btn-create

Press enter key
    Press Keys     ${petstatus-input}     ENTER

New pet "${Name}" is added to the list
#todo fix table should contain pet name
    Table Should Contain    css=.table  ${Name}

The user has focus on the "${Field}" field
    Set Focus To Element  ${Field}

Press tab key on "${Field}"
    Press Keys   ${Field}     TAB

The "${field}" should be in focus
    Element Should Be Focused   ${field}

The user has pressed the keys SHIFT + TAB
    Press Keys   btn-create     SHIFT+TAB

Pet list is displayed
    Page Should Contain Element    css=.pet-list       # check if the pet list contain some items thats how we could learn that the table is not empty display.

User can click on pet name "${petname}"
    Wait Until Element Is Enabled   xpath=(//*[.='${petname}']) [1]
    Click Element   xpath=(//*[.='${petname}']) [1]

User click pet status "${petstatus}"
    Wait Until Element Is Enabled   xpath=(//*[.='${petstatus}']) [1]
    Click Element   xpath=(//*[.='${petstatus}']) [1]

Edit pet name "${petname}" and click outside of the table
    Wait Until Element Is Enabled   xpath=(//*[@value='${petname}']) [1]
    Click Element       css=.edit > td:nth-child(1) > input
    Press Key   css=.edit > td:nth-child(1) > input     ${petname4_edit}
    Click Element   css=.card-title

Pet changes are saved
    Table Should Contain    css=.pet-list > div > table    ${petname4}${petname4_edit}

Status changes are saved
    Table Should Contain    css=.pet-list > div > table    ${petstatus4}${petstatus4_edit}

Edit pet status "${petstatus}" and press enter
    Wait Until Element Is Enabled   xpath=(//*[@value='${petstatus}']) [1]
    Click Element       css=.edit > td:nth-child(2) > input
    Press Key  css=.edit > td:nth-child(2) > input     ${petstatus4_edit}
    Press Key   css=.edit > td:nth-child(2) > input     \\13

Edit pet status and press escape
    Wait Until Element Is Enabled   xpath=(//*[@value='${petstatus4}${petstatus4_edit}']) [1]
    Click Element       css=.edit > td:nth-child(2) > input
    Press Key  css=.edit > td:nth-child(2) > input     those Changes should not be saved
    Press Keys   css=.edit > td:nth-child(2) > input     ESC
    Page Should Not Contain     Changes should not be saved

Status changes should not be saved
    Page Should Not Contain     Changes should not be saved

The page is reloaded
    Reload Page

Page load in less than 2 seconds
     Wait Until Element Is Visible   xpath=(//tr[@class='pet-item'])[100]      2 seconds     #last element in the list should be loaded in less than two seconds
















