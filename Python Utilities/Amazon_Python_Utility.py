import xlrd
import os

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




#fetch_data_for_given_data_key_from_given_datasheet_of_given_datafile('D:\\Amazon Automation\\Go-Jek\\Locators\\Amazon_Locators.xlsx', 'Amazon_Url', 'Home_Page_Url')
