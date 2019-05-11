from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
import selenium.webdriver.support.ui as ui
from selenium.common.exceptions import NoSuchElementException, TimeoutException
from selenium.common.exceptions import ElementNotVisibleException
from selenium.common.exceptions import WebDriverException
from Selenium2Library import Selenium2Library
import re
import locale
from selenium.webdriver.support.ui import Select
import datetime
import os
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
import xlrd



def fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile(datafile, datasheet, datakey):
    value = "NONE"
    #print datafile
    print "datafile" , datafile
    # First ensure the Data file exists
    if os.path.exists(datafile):
        print "File exists"
        # Open the given workbook
        workbook = xlrd.open_workbook(datafile)
        print "workbook" , workbook
        # Open the given worksheet
        worksheet = workbook.sheet_by_name(datasheet)
        for row in range(worksheet.nrows):
            value = worksheet.cell_value(row, 0)
            if (value == datakey):
                value = worksheet.cell_value(row, 1)
                print "value" , value
                break
            else:
                pass
    else:
        pass
    return value


def Input_Text_Custom(driver,Locator,Text):
    try:
        if 'css=' in Locator:
            Locator = Locator.replace("css=", "")
            Element = driver.find_element_by_css_selector(Locator)
            Element.clear()
            Element.send_keys(Text)
            print "CSS is inputed"
        elif 'xpath'in Locator:
            Locator = Locator.replace('xpath=','')
            Element = driver.find_element_by_xpath(Locator)
            Element.clear()
            Element.send_keys(Text)
            print "xpath is inputed"
        else:
            print "provide correct element locating technique type"
    except Exception as e:
        print "Some exception has Occur"
        print "Exception is : ", e
    return None



#fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile('D:\\Amazon Automation\\Go-Jek\\Locators\\Amazon_Locators.xlsx', 'Amazon_Url', 'Home_Page_Url')
