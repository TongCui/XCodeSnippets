#!/usr/bin/env ruby
require 'date'
require 'json'

# kFonts = [
#   "Baoli TC",
#   "BiauKai",
#   "GB18030 Bitmap", 
#   "Hannotate SC", 
#   "HanziPen SC",
#   "Heiti SC",
#   "Hiragino Sans GB",
#   "Kaiti SC",
#   "Lantinghei SC",
#   "Libian SC",
#   "LingWai SC",
#   "PingFang SC",
#   "Songti SC",
#   "Wawati SC",
#   "Weibei SC",
#   "Xingkai SC",
#   "Yuanti SC",
#   "Yuppy SC",
# ]

kFonts = [
  "Baoli TC",
  "BiauKai",
  "Hannotate SC", 
  "HanziPen SC",
  "Kaiti SC",
  "Libian SC",
  "PingFang SC",
  "Songti SC",
  "Weibei SC",
  "Yuppy SC",
]

kRowColors = [
  "success",
  "info",
  "warning",
  "active",
]

ARGV.each {|x| puts x}

words = ARGV[0]
offset = ARGV[1] ? ARGV[1] : -1

puts "Words are : #{words}" 
puts "Day offset is : #{offset}"

words_folder_path = File.expand_path("#{$0}/../words", Dir.pwd)
htmls_folder_path = File.expand_path("#{$0}/../htmls", Dir.pwd)
day = (Date.today + offset.to_i).to_s
words_file_path = File.join(words_folder_path, "words-#{day}.json")
html_file_path = File.join(htmls_folder_path, "htmls-#{day}.html")
template_file_path = File.join(htmls_folder_path, "template.html")

puts "> Backup words"
puts "> Going to write #{words} into #{words_file_path}"

dict = {:day => day, :words => words}
File.open(words_file_path, 'w') {|file| file.write dict.to_json}

puts "> Generate words html..."
puts ">>> Generate css"

css = []
css.push ".container { font-size: 52px }"
kFonts.each_with_index do |font, idx|
  css.push ".font#{idx} { font-family: \"#{font}\"}"
end

puts ">>> Generate content"

content = []
# content.push "<h4>#{day}</h4>"
content.push "<table class=\"table\">"
content.push "<tbody>"
words.chars.each_with_index do |word, idx|
  content.push "<tr class=\"#{kRowColors[idx % kRowColors.size]}\">"
  kFonts.each_with_index do |font, idx|
    content.push "<td class=\"font#{idx}\">#{word}</td>"
  end
  content.push "</tr>"
end
content.push "</tbody>"
content.push "</table>"

puts ">>> Generate html"

html = File.open(template_file_path){|file| file.read}
html.sub! "{font-css}", css.join("\n")
html.sub! "{content-table}", content.join("\n")

File.open(html_file_path, "w") {|file| file.write html}

puts "> Done"

