#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys, argparse, getpass                                                                                  
from datetime import datetime
from datetime import timedelta



parser = argparse.ArgumentParser(description='XCode Snippets | Sample Code Tool')
parser.add_argument('-l', '--list', help='List all snippets')
# parser.add_argument('-p', '--password', help='The password you use to log into iTunes Connect; if omitted you will be prompted')
# parser.add_argument('--id', metavar='VENDOR_ID', required=True, help='A value in the form 8#######, which identifies the entity for the reports you wish to download')
# parser.add_argument('--reporttype', default='Sales', choices=['Sales'], help='This is the report type you want to download.  Currently only Sales Reports are available.')
# parser.add_argument('--datetype', default='Daily', choices=['Daily', 'Weekly'], help='Selecting Weekly will provide you the Weekly version of the report. Selecting Daily will provide you the Daily version of the report.')
# parser.add_argument('--subtype', default='Summary', choices=['Summary', 'Opt-In'], help='This is the parameter for the Sales Reports.')

res = parser.parse_args()

if res.password is None:
    res.password = getpass.getpass()

if res.password is None or len(res.password) == 0:
    sys.exit(1)

print res



