#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import os.path
sys.path.append(os.path.abspath(os.path.pardir))
sys.path.append(os.path.abspath(os.path.curdir))

import argparse
import getpass                                                                                  
from utils import *

class ShowFolder(object):

    def __init__(self, folder_name, folder_path, level=0):
        super(ShowFolder, self).__init__()
    
        self.level = level

        self.folder_name = folder_name
        self.folder_path = folder_path

        self.subfolder_names =  get_dirs_in_folder(folder_path)
        self.filenames = get_files_in_folder(folder_path)

        # self.test_print()

        self.show_folders = [ShowFolder(subfolder_name, self.folder_path + '/' + subfolder_name, self.level + 1) for subfolder_name in self.subfolder_names]

    def test_print(self):
        print '---------'
        print 'Name ' + self.folder_name
        print 'Path ' + self.folder_path
        print 'SubFolders ' + ','.join(self.subfolder_names)
        print 'Files ' + ','.join(self.filenames)
        print '---------' 

    def short_desc(self):
        pass

    def __str__(self):
        descs = ['  ' * self.level + '- ' + filename for filename in self.filenames]
        for show_folder in self.show_folders:
            descs.append('  ' * self.level + '* ' + show_folder.folder_name)
            descs.append(str(show_folder))


        return '\n'.join(descs)


show_folder = None

def get_doc_base_folder():
    return get_project_base_folder() + "/doc"

def list_true():
    print 'echo'

def get_all_show_options():
    docfolder = get_doc_base_folder()

def tool_list():
    print show_folder

def tool_list_short():
    print show_folde

def tool_show(path):
    lines = lines_of_file(path)
    for line in lines:
        print line

def tool_print_seperatorline():
    print bcolors.OKGREEN + "-" * 60 + bcolors.ENDC

def tool_print_instruction(instruction):
    print bcolors.BOLD + '> ' + instruction + bcolors.ENDC    

def tool_print_warning(warning):
    print bcolors.FAIL + '> Warning: - ' + warning + bcolors.ENDC 



if __name__ == "__main__":
    
    print "This is a tools for some copy and paste code. Sorry, I am lazy..."
    tool_print_seperatorline()
    show_folder = ShowFolder('doc', get_doc_base_folder())

    parser = argparse.ArgumentParser()
    parser.add_argument("-v", "--verbose", help="output verbosity", action="store_true")
    parser.add_argument("-l", "--list", help="show all options", action="store_true")
    parser.add_argument("-s", "--short", help="show all options for short", action="store_true")
    parser.add_argument("--show", help="show option detail")
    args = parser.parse_args()

    
    tool_print_instruction("Arguments:")
    print args
    tool_print_seperatorline()

    if args.verbose:
        print("verbosity turned on")

    if args.list:
        if args.short:
            tool_list_short()
        else:
            tool_list()
        
        tool_print_instruction("Done - Use --show next e.g. --show :how:pod:repair")
        tool_print_seperatorline()

    if args.show:
        path = args.show.replace(':', '/')
        file_path = get_doc_base_folder() + path

        if os.path.isfile(file_path):
            tool_print_instruction('Content')
            tool_show(file_path)
            tool_print_instruction('Done')
        else:
            tool_print_warning('Path is wrong')
            exit(1)

        tool_print_seperatorline()

        



    



