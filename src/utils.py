#!/usr/bin/python
# -*- coding: utf-8 -*-

from datetime import datetime
import time
import json
import os.path
import os

###########################

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[37m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

###########################    

debug = False

def get_project_base_folder():
    path = os.path.abspath(os.path.curdir)
    if not path.endswith('wescores-python'):
        path = os.path.abspath(os.path.pardir)
    return path

def get_project_file_path(path):
    return get_project_base_folder() + path

def timestamp_from_datestr(datestr):
	atime = time.strptime(datestr, '%m/%d/%Y')
	return int(time.mktime(atime) * 1000)

def datestr_from_timestamp(timestamp):
	return datetime.fromtimestamp(timestamp / 1000).strftime('%m/%d/%Y')

def lines_of_file(file_path):
    if os.path.isfile(file_path):
        with open(file_path, 'r') as file:
            lines = [line.rstrip() for line in file.readlines()]
        return lines
    else:
        return []

def first_line_of_file(file_path):
    lines = lines_of_file(file_path)
    if len(lines) > 0:
        return lines[0]
    else:
        return ''

def write_line_into_file(line, file_path):
    os.system('touch %s'%(file_path))
    with open(file_path, 'w') as file:
        file.write(line)


###########################
# Folder
###########################

def get_dirs_in_folder(folder_path):
    return [f for f in os.listdir(folder_path) if os.path.isdir(folder_path + '/' + f)]

def get_files_in_folder(folder_path):
    return [f for f in os.listdir(folder_path) if os.path.isfile(folder_path + '/' + f) and not f.startswith('.')]


if __name__ == "__main__":
    print get_project_base_folder()

    print get_dirs_in_folder(get_project_base_folder() + "/doc")
    print get_files_in_folder(get_project_base_folder() + "/doc/how/pod")

    # print get_project_file_path('/file.log')
    # print get_project_file_path('/aaa/file.log')

    # print "utils"
    # timestamp = timestamp_from_datestr('5/16/2014')
    # print timestamp
    # timestr = datestr_from_timestamp(timestamp)
    # print timestr



