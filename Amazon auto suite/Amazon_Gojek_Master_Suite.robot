*** Settings ***
Suite Setup       Open browser
Suite Teardown    Browser Close
Test Setup        Refresh the page
Library           D:\\Amazon Automation\\Go-Jek\\Python Utilities\\CustomSeleniumLibrary.py
Library           D:\\Amazon Automation\\Go-Jek\\Python Utilities\\Amazon_Python_Utility.py

*** Variables ***
${driver}         ${EMPTY}
${locators_file_path}    D:\\Amazon Automation\\Go-Jek\\Locators\\Amazon_Locators.xlsx
${Urls_File_Path}    D:\\Amazon Automation\\Go-Jek\\URLs\\Url.xlsx
${Credentials_file_path}    D:\\Amazon Automation\\Go-Jek\Credentials\\Amazon_Credentials.xlsx
${chrome_exe_path}    D:\\Amazon Automation\\Go-Jek\\Driver for chrome\\chromedriver.exe

*** Test Cases ***
TC_Select_Available_Headphone_And_Add_to_Cart
    [Tags]    TC1    Sanity
    log    hi

*** Keywords ***
Open browser
    ${websites homepage url}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${Urls_File_Path}    Amazon_Url    Home_Page_Url
    Set Selenium Timeout    30
    Set Selenium Implicit Wait    5 Seconds
    Log    ${websites homepage url}
    ${cred}=    Convert To String    credentials_enable_service
    ${val}=    Convert To Boolean    False
    Comment    ${prefs}=    Create Dictionary    ${geo}    ${val}
    ${prefs}=    Create Dictionary    ${cred}    ${val}
    ${chrome_options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    allow-running-insecure-content
    Call Method    ${chrome_options}    add_argument    disable-web-notification-custom-layouts
    Call Method    ${chrome_options}    add_argument    disable-notifications
    Call Method    ${chrome_options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${chrome_options}    executable_path=${chrome_exe_path}
    Go To    ${websites homepage url}
    ${w}    ${h}=    Get Window Size
    ${a}    ${b}=    Get Window Size
    ${Width}=    Convert To Integer    1044
    ${Height}=    Convert To Integer    788
    Set Window Size    ${Width}    ${Height}
    ${driverInstance} =    Get Webdriver Instance
    Set Suite Variable    ${driver}    ${driverInstance}
    sleep    10s
    Login

Browser Close

Refresh the page
    Reload Page

Wait Keyword
    #log    ${locator}
    ${Delay} =    Convert To String    30s
    Wait Until Page Contains Element    ${locator}    ${Delay}    Page does not contain the ${Message}
    Wait Until Element Is Visible    ${locator}    ${Delay}    ${Message} is not displayed on the page
    Wait Until Element Is Enabled    ${locator}    ${Delay}    ${Message} is not enabled

Login

Logout
