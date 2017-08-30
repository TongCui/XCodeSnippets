#!/usr/bin/env ruby

require 'restclient'
require 'nokogiri'
require 'json'
require 'date'

day = Date.today.to_s
numbers_folder_path = File.expand_path("#{$0}/../numbers", Dir.pwd)
htmls_folder_path = File.expand_path("#{$0}/../htmls", Dir.pwd)

numbers_file_path = File.join(numbers_folder_path, "number-#{day}.json")
html_file_path = File.join(htmls_folder_path, "number-#{day}.html")
template_file_path = File.join(htmls_folder_path, "template.html")

words = ["上证指数","创业板指数"]
res = []
content = ["<h1>#{day}<h1>"]

words.each do |key|

  url = "http://www.baidu.com/s"
  params = {params: {"wd" => key} }

  puts "> Loading content of url : #{url}"

  page = Nokogiri::HTML(RestClient.get(url, params))

  number = page.css("div.op-stockdynamic-moretab-cur span.op-stockdynamic-moretab-cur-num").map{ |x| x.text.strip() }.first
  diff = page.css("div.op-stockdynamic-moretab-cur span.op-stockdynamic-moretab-cur-info").map{ |x| x.text.strip() }.first

  puts ">>>> Number is : #{number}"
  puts ">>>> Diff is : #{diff}"

  res.push [number, diff]

  content.push "<h3><strong>#{key}</strong>#{number} >>>> #{diff}</h3>"
end

puts "> Save Numbers"
dict = {
  :sh=>{:number => res[0][0], :diff= => res[0][1]},
  :sz=>{:number => res[1][0], :diff= => res[1][1]}
}
File.open(numbers_file_path, 'w') {|file| file.write dict.to_json }

puts "> Build HTML Page"

html = File.open(template_file_path){|file| file.read}
html.sub! "{content}", content.join("\n")
File.open(html_file_path, 'w') {|file| file.write html}

puts "> Open Safari"
%x[ open '/Applications/Safari.app' #{html_file_path} ]

puts "> Done"
