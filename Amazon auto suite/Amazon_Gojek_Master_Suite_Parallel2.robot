*** Settings ***
Suite Setup       Open browser
Suite Teardown    Browser Close
Test Setup        Refresh the page
Library           D:\\Amazon Automation\\Go-Jek\\Python Utilities\\CustomSeleniumLibrary.py
Library           D:\\Amazon Automation\\Go-Jek\\Python Utilities\\Amazon_Python_Utility.py
Library           String

*** Variables ***
${driver}         ${EMPTY}
${locators_file_path}    D:\\Amazon Automation\\Go-Jek\\Locators\\Amazon_Locators.xlsx
${Urls_File_Path}    D:\\Amazon Automation\\Go-Jek\\URLs\\Url.xlsx
${Credentials_file_path}    D:\\Amazon Automation\\Go-Jek\\Credentials\\Amazon_Credentials.xlsx
${chrome_exe_path}    D:\\Amazon Automation\\Go-Jek\\Driver for chrome\\chromedriver.exe

*** Test Cases ***
TC_Search_MacBookPro_Add_Second_Product_To_Cart
    [Tags]    TC1    Sanity
    ${Amazon_Search_Text_Box_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Search_Text_Box_xpath
    ${Amazon_Search_Submit_Button_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Search_Submit_Button_xpath
    ${Amazon_Search_Second_Product_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Search_Second_Product_xpath
    ${Amazon_Product_Quantity_Drop_Down_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Product_Quantity_Drop_Down_xpath
    ${Amazon_Product_Quantity_2_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Product_Quantity_2_xpath
    ${Verify_Amazon_Added_To_Cart_Text_Message_Macbook_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Verification_Entities    Verify_Amazon_Added_To_Cart_Text_Message_Macbook_xpath
    ${Amazon_Add_To_Cart_Button_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Add_To_Cart_Button_xpath
    ${Amazon_Cart_Close_Button_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Cart_Close_Button_xpath
    ${Amazon_Macbook_Order_Close_Button_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Macbook_Order_Close_Button_xpath
    ${Amazon_Macbook_Order_Continue_Button_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Macbook_Order_Continue_Button_xpath
    ${Amazon_Macbook_Order_Iframe_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Macbook_Order_Iframe_xpath
    Wait Keyword    ${Amazon_Search_Text_Box_xpath}    Search Text Box
    Input Text    ${Amazon_Search_Text_Box_xpath}    Macbook pro
    Wait Keyword    ${Amazon_Search_Submit_Button_xpath}    Headphones
    Click Element    ${Amazon_Search_Submit_Button_xpath}
    Wait Keyword    ${Amazon_Search_Second_Product_xpath}    Macbook second product
    Click Element    ${Amazon_Search_Second_Product_xpath}
    Wait Keyword    ${Amazon_Product_Quantity_Drop_Down_xpath}    Quantity dropdown
    Select From List By Value    ${Amazon_Product_Quantity_Drop_Down_xpath}    2
    Wait Keyword    ${Amazon_Add_To_Cart_Button_xpath}    Amazon Add to cart button
    Click Element    ${Amazon_Add_To_Cart_Button_xpath}
    Comment    ${status}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${Amazon_Macbook_Order_Close_Button_xpath}
    Comment    Run Keyword If    ${status}==True    Click Element    ${Amazon_Macbook_Order_Close_Button_xpath}
    Comment    Wait Keyword    ${Amazon_Macbook_Order_Close_Button_xpath}    Macbook Close button
    Comment    Click Element    ${Amazon_Macbook_Order_Close_Button_xpath}
    Select Frame    ${Amazon_Macbook_Order_Iframe_xpath}
    Wait Keyword    ${Amazon_Macbook_Order_Continue_Button_xpath}    Continue button
    Click Element    ${Amazon_Macbook_Order_Continue_Button_xpath}
    Wait Keyword    ${Verify_Amazon_Added_To_Cart_Text_Message_Macbook_xpath}    Added to Cart Message


TC_Reduce_The_Quantity_Of_MacBook_Pro_And_Checkout
    [Tags]    TC2    Sanity
    ${Amazon_Product_Cart_Link_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Product_Cart_Link_xpath
    ${Amazon_Product_MacBook_Titles_Added_In_Cart_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Product_MacBook_Titles_Added_In_Cart_xpath
    ${Amazon_Product_Quantity_Drop_Down_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Product_Quantity_Drop_Down_xpath
    ${Amazon_Cart_Proceed_To_Checkout_Button_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Cart_Proceed_To_Checkout_Button_xpath
    ${Amazon_Checkout_Shipping_Address_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Checkout_Shipping_Address_xpath
    Wait Keyword    ${Amazon_Product_Cart_Link_xpath}    Cart Icon
    Click Element    ${Amazon_Product_Cart_Link_xpath}
    Wait Keyword    ${Amazon_Product_MacBook_Titles_Added_In_Cart_xpath}    Product Titles
    ${amazon_product_macbook}=    Strip String    ${Amazon_Product_MacBook_Titles_Added_In_Cart_xpath}    characters=xpath=
    ${product_titles}=    Get Matching Xpath Count    ${amazon_product_macbook}
    ${product_titles}=    Evaluate    ${product_titles}+1
    :FOR    ${i}     IN RANGE    1    ${product_titles}
    \    ${change_quantity}=    Set Variable    ${EMPTY}
    \    ${change_quantity}=    Catenate    SEPARATOR=    ${Amazon_Product_Quantity_Drop_Down_xpath}    [${i}]
    \    Wait Keyword    ${change_quantity}    Change Quantity Macbook pro
    \    Select From List By Value    ${change_quantity}    1
    Wait Keyword    ${Amazon_Cart_Proceed_To_Checkout_Button_xpath}    Proceed to checkout
    Click Element    ${Amazon_Cart_Proceed_To_Checkout_Button_xpath}
    Wait Keyword    ${Amazon_Checkout_Shipping_Address_xpath}    Shipping Address

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
    ${username}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${Credentials_file_path}    cred    username
    ${password}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${Credentials_file_path}    cred    password
    Wait Keyword    ${Amazon_Home_Page_Sign_In_Text_xpath}    Amazon sign in Text
    Click Element    ${Amazon_Home_Page_Sign_In_Text_xpath}
    Wait Keyword    ${Verify_Amazon_Sign_In_Text_xpath}    Amazon sign in header text
    Wait Keyword    ${Amazon_Sign_In_Email_id_css}    Sign In Email Id
    Input Text Custom    ${driver}    ${Amazon_Sign_In_Email_id_css}    ${username}
    Wait Keyword    ${Amazon_Sign_In_Password_css}    Sign In Password
    Input Text Custom    ${driver}    ${Amazon_Sign_In_Password_css}    ${password}
    Wait Keyword    ${Amazon_Sign_In_Button_css}    Sign In button
    Click Element    ${Amazon_Sign_In_Button_css}
    Wait Keyword    ${Verify_Amazon_Home_Page_Logo_css}    Amazon logo

Logout
    ${websites homepage url}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${Urls_File_Path}    Amazon_Url    Home_Page_Url
    ${Amazon_Home_Page_Sign_In_Text_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Home_Page_Sign_In_Text_xpath
    ${Amazon_Hello_Text_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Hello_Text_xpath
    ${Amazon_Sign_Out_Button_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Locator_ids    Amazon_Sign_Out_Button_xpath
    ${Verify_Amazon_Sign_In_Text_xpath}=    fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile    ${locators_file_path}    Verification_Entities    Verify_Amazon_Sign_In_Text_xpath
    Go To    ${websites homepage url}
    Run Keyword And Continue On Failure    Wait Keyword    ${Amazon_Hello_Text_xpath}    Amazon sign in Text
    Run Keyword And Continue On Failure    Mouse Over    ${Amazon_Hello_Text_xpath}
    Run Keyword And Continue On Failure    Wait Keyword    ${Amazon_Sign_Out_Button_xpath}    Amazon Sign Out Button
    Run Keyword And Continue On Failure    Click Element    ${Amazon_Sign_Out_Button_xpath}
    Run Keyword And Continue On Failure    Wait Keyword    ${Verify_Amazon_Sign_In_Text_xpath}    Amazon sign in header text
