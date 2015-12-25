#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import os.path
sys.path.append(os.path.abspath(os.path.pardir))
sys.path.append(os.path.abspath(os.path.curdir))

from utils import *
import commands
import collections
import json

key_title = 'IDECodeSnippetTitle'
key_summary = 'IDECodeSnippetSummary'
key_content = 'IDECodeSnippetContents'
key_language = 'IDECodeSnippetLanguage'

class Snippet(object):

	def __init__(self, filepath, fromplist = True):
		super(Snippet, self).__init__()

		self.filepath = filepath
		self.fromplist = fromplist

		if plist :
			self.title = snippet_get_plist_value(filepath, key_title)
			self.summary = snippet_get_plist_value(filepath, key_summary)
			self.content = snippet_get_plist_value(filepath, key_content)
			self.language = snippet_get_plist_value(filepath, key_language)
		else :
			line = first_line_of_file()
			json = json.loads(line)
			self.title = json.get(key_title)
			self.summary = json.get(key_summary)
			self.content = json.get(key_content)
			self.language = json.get(key_language)


	def __str__(self):
		return 'Snippet object: %s - %s - %s - %s' % (self.title, self.description, self.shortabbr, self.code)

	def isSwift(self):
		return True

	def save(self):
		dict = {}
		dict[key_title] = self.title
		dict[key_summary] = self.summary
		dict[key_content] = self.content
		dict[key_language] = self.language

		target_folder = snippet_folder()

		write_line_into_file(json.dumps(dict), target_folder + self.title)




def snippet_folder():
	return get_project_file_path("/codesnippets/")

def snippet_save():
	print "Save"

def snippet_init():
	folder = '~/Library/Developer/Xcode/UserData/CodeSnippets/'
	os.system('mkdir -p %s' % (folder))

	# Copy files Into Memory
	files = commands.getoutput('find %s -name "*.codesnippet"' % (folder)).split('\n')
	
	for filepath in files:
		if not os.path.exists(filepath):
			continue
		print '(Init) Will create snippet object - ' + filepath + '!'
		theSnippet = Snippet(filepath)

	

def snippet_list():
	folder = snippet_folder()
	os.system('mkdir -p %s' % (folder))

	filepaths = commands.getoutput('find %s -name "*.xcs"' % (folder)).split('\n')

	filenames = [os.path.splitext(filepath)[0] for filepath in filepaths]

	if 0 == len(filenames):
		print "(List) Empty !! Run snippet_init to load files"

	print '--------------'
	for index, filename in enumerate(filenames):
		print '(List)\t\d - \s' % (index, filename)

def snippet_create():
	print "create"
	pass

def snippet_delete(title):
	print "delete"
	pass

def snippet_rename(old, new):
	print "r.title"
	pass

def snippet_update(title):
	print "update"
	pass

def snippet_search(keyword):
	print "search"
	pass

def snippet_get_plist_value(plist_file, key):
	return commands.getoutput('/usr/libexec/PlistBuddy -c "Print :%s" %s' % (key, plist_file))





if __name__ == "__main__":
	snippet_init()
	print snippet_list()

    



