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
    ${Verify_Amazon_Home_Page_Logo_css}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Verification_Entities    Verify_Amazon_Home_Page_Logo_css
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
    Maximize Browser Window
    Run Keyword And Continue On Failure    Wait Keyword    ${Verify_Amazon_Home_Page_Logo_css}    Amazon Logo
    Login

Browser Close
    Logout
    Close All Browsers

Refresh the page
    Reload Page

Wait Keyword
    [Arguments]    ${locator}    ${Message}
    #log    ${locator}
    ${Delay} =    Convert To String    30s
    Wait Until Page Contains Element    ${locator}    ${Delay}    Page does not contain the ${Message}
    Wait Until Element Is Visible    ${locator}    ${Delay}    ${Message} is not displayed on the page
    Wait Until Element Is Enabled    ${locator}    ${Delay}    ${Message} is not enabled

Login
    ${Verify_Amazon_Home_Page_Logo_css}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Verification_Entities    Verify_Amazon_Home_Page_Logo_css
    ${Amazon_Home_Page_Sign_In_Text_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Home_Page_Sign_In_Text_xpath
    ${Amazon_Sign_In_Email_id_css}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Sign_In_Email_id_css
    ${Amazon_Sign_In_Password_css}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Sign_In_Password_css
    ${Amazon_Sign_In_Button_css}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Sign_In_Button_css
    ${Verify_Amazon_Sign_In_Text_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Verification_Entities    Verify_Amazon_Sign_In_Text_xpath
    Wait Keyword    ${Amazon_Home_Page_Sign_In_Text_xpath}    Amazon sign in Text
    Click Element    ${Amazon_Home_Page_Sign_In_Text_xpath}
    Wait Keyword    ${Verify_Amazon_Sign_In_Text_xpath}    Amazon sign in header text
    Wait Keyword    ${Amazon_Sign_In_Email_id_css}    Sign In Email Id
    Input Text Custom    ${driver}    ${Amazon_Sign_In_Email_id_css}    syprusgojek@gmail.com
    Wait Keyword    ${Amazon_Sign_In_Password_css}    Sign In Password
    Input Text Custom    ${driver}    ${Amazon_Sign_In_Password_css}    RoBotFra@432
    Wait Keyword    ${Amazon_Sign_In_Button_css}    Sign In button
    Click Element    ${Amazon_Sign_In_Button_css}
    Wait Keyword    ${Verify_Amazon_Home_Page_Logo_css}    Amazon logo

Logout
    ${Amazon_Home_Page_Sign_In_Text_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Home_Page_Sign_In_Text_xpath
    ${Amazon_Hello_Text_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Hello_Text_xpath
    ${Amazon_Sign_Out_Button_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Sign_Out_Button_xpath
    ${Verify_Amazon_Sign_In_Text_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Verification_Entities    Verify_Amazon_Sign_In_Text_xpath
    Run Keyword And Continue On Failure    Wait Keyword    ${Amazon_Hello_Text_xpath}    Amazon sign in Text
    Run Keyword And Continue On Failure    Mouse Over    ${Amazon_Hello_Text_xpath}
    Run Keyword And Continue On Failure    Wait Keyword    ${Amazon_Sign_Out_Button_xpath}    Amazon Sign Out Button
    Run Keyword And Continue On Failure    Click Element    ${Amazon_Sign_Out_Button_xpath}
    Run Keyword And Continue On Failure    Wait Keyword    ${Verify_Amazon_Sign_In_Text_xpath}    Amazon sign in header text
