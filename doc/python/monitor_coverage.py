#!/usr/bin/python
# -*- coding: utf-8 -*-

from optparse import OptionParser
from BeautifulSoup import BeautifulSoup
import os.path
import urllib
import urllib2
import json

def parse_params():
  parser = OptionParser()
  parser.add_option("-n", "--new", dest="new", type="string",
                    help="New cobertura.xml file")
  parser.add_option("-o", "--old", dest="old", type="string",
                    help="Old cobertura.xml file")
  parser.add_option("-l", "--line", dest="line_rate", type="float", 
                    default=0.7,
                    help="Line rate threshold, default (0.7)")
  parser.add_option("-b", "--branch", dest="branch_rate", type="float",
                    default=1,
                    help="Branch rate threshold, default (1)")
  parser.add_option("-p", "--platform", dest="platform", type="string",
                    default="ios",
                    help="Platform Name")

  (options, args) = parser.parse_args()

  if options.new == None:
    parser.print_help()
    parser.error("New file is not given")

  if options.old == None:
    parser.print_help()
    parser.error("Old file is not given")

  if not os.path.isfile(options.new):
    parser.print_help()
    parser.error("Cannot find new file <%s>."%(options.new))  

  if not os.path.isfile(options.old):
    parser.print_help()
    parser.error("Cannot find old file <%s> ."%(options.old))  

  return options

class CoberturaReport:
  def __init__(self, file_name):
    with open(file_name, 'r') as file:
      soup = BeautifulSoup(file.read())
      self.classReports = [CoberturaClassReport(info.attrs) for info in soup.findAll('class')]
      self.classNameReportsMap = {}
      for report in self.classReports:
        self.classNameReportsMap[report.name] = report
      self.diffResults = []

  def __str__(self):
    return "\n".join([str(report) for report in self.classReports])

  def compare_old(self, old_report):
    for name, new_class_report in self.classNameReportsMap.iteritems():
      old_class_report = old_report.classNameReportsMap.get(name)
      self.diffResults.append(ClassDiffResult(new_class_report, old_class_report))

  def get_line_diff_result_bad(self, threshold):
    return [r for r in self.diffResults if (r.isNewFile and r.line_rate_diff < threshold) or r.line_rate_diff < 0]
  
  def get_branch_diff_result_bad(self, threshold):
    return [r for r in self.diffResults if (r.isNewFile and r.branch_rate_diff < threshold) or r.branch_rate_diff < 0]

  def get_line_diff_result_good(self, threshold):
    return [r for r in self.diffResults if (r.isNewFile and r.line_rate_diff >= threshold) or r.line_rate_diff > 0]
  
  def get_branch_diff_result_good(self, threshold):
    return [r for r in self.diffResults if (r.isNewFile and r.branch_rate_diff >= threshold) or r.branch_rate_diff > 0]

class ClassDiffResult:
  def __init__(self, new, old):
    self.name = new.name
    self.filename = new.filename
    if not old:
      self.isNewFile = True
      self.line_rate_diff = new.line_rate
      self.branch_rate_diff = new.branch_rate
    else:
      self.isNewFile = False
      self.line_rate_diff = new.line_rate - old.line_rate
      self.branch_rate_diff = new.branch_rate - old.branch_rate

  def __str__(self):
    isNewFile = "New" if self.isNewFile else "Old"
    return "[%s(%s)]line rate diff: <%f> branch rate diff: <%f>"%(self.name, isNewFile, self.line_rate_diff, self.branch_rate_diff)


class CoberturaClassReport:

  def __init__(self, values_array):
    self.name = values_array[0][1]
    self.filename = values_array[1][1]
    self.line_rate = float(values_array[2][1])
    self.branch_rate = float(values_array[3][1])
    self.complexity = values_array[4][1]

  def __str__(self):
    return "%s %.2f" % (self.name, self.line_rate)


def slack_line_result(isNew, filename, threshold, rate_diff):
    if isNew:
      return "<%.0f%%\t%s"%(threshold * 100, filename)
    else:
      return "%.0f%%\t%s"%(rate_diff * 100, filename)
    
def send_slack_message(title, text, color):
  SLACK_TOKEN='xoxb-1xxxxx-Nxxxx'
  SLACK_API_URL='https://slack.com/api/chat.postMessage'
  CHANNEL_NAME='dev-mob-bj-ci'

  post_data = {
      'token': SLACK_TOKEN,
      'channel': CHANNEL_NAME,
      'username': 'Reviews Monitor',
      'attachments': json.dumps([{
          'color': color,
          'title': unicode(title, 'utf-8'),
          'text': unicode(text, 'utf-8'),
          'fallback': unicode(title, 'utf-8')
      }])
  }
  post_data = urllib.urlencode(post_data)
  req = urllib2.Request(url=SLACK_API_URL, data=post_data)
  urllib2.urlopen(req)

if __name__ == '__main__':
  options = parse_params()
  print "Parameters:"
  print options
  
  print "Parsing old report : %s.........." % (options.old)
  old_report = CoberturaReport(options.old)
  print "Parsing new report : %s.........." % (options.new)
  new_report = CoberturaReport(options.new)
  print "Comparing reports.........."
  new_report.compare_old(old_report)
  
  print "Generating diff reports.........."
  line_results_bad = new_report.get_line_diff_result_bad(options.line_rate)
  if len(line_results_bad) > 0:
    print "Sending line rate slack message."
    title = "%d %s code coverage warning(s) [line rate]"%(len(line_results_bad), options.platform)
    text = '\n'.join([slack_line_result(result.isNewFile, result.filename, options.line_rate, result.line_rate_diff) for result in line_results_bad])
    print text
    send_slack_message(title, str(text), 'danger')
  else:
    print "There are no bad results."

  print "Done"
  

  
