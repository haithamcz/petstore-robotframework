*** Settings ***
Resource    ../../../resources/imports.robot

*** Keywords ***
Open Browsers
    [Arguments]    ${url}    ${browser}
    Open Browser    ${url}   browser=${browser}
    Run Keyword If  ${default_width}>0      Set custom window size      ELSE    Maximize Browser Window

Set custom window size
    Set Window Size     ${default_width}    ${default_height}


Open Chrome Headless Browser
    [Arguments]    ${url}
    [Documentation]    Open Chrome Browser with headless mode
    Create Webdriver    Chrome
    Go To    ${url}

Set Chrome Options
    [Documentation]    Set Chrome Options for headless mode
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    : FOR    ${option}    IN    @{chrome_options}
    \    Call Method    ${options}    add_argument    ${option}
    [Return]    ${options}


The page is rendered on the user's browser
    Wait Until Element Is Visible   btn-create  2 seconds

