#!/usr/bin/env ruby

require 'json'
require 'restclient'
require 'oga'

module JSONable
  def to_s
    to_json
  end
  def to_json
    to_dict.to_json
  end

  def to_dict
    hash = {}
    self.instance_variables.each do |var|
      key = var[1..-1]
      hash[key] = self.instance_variable_get var
    end
    hash
  end

  def from_dict! dict
    dict.each do |var, val|
      key = "@#{var}"
      self.instance_variable_set key, val
    end
  end

  def from_json! string
    from_dict! JSON.load(string)
  end
end

class WWDCModel
  include JSONable
  attr_accessor :url, :content_url, :name

end

def file_path(name)
  File.expand_path("#{$0}/../#{name}", Dir.pwd)
end

class WWDC2018 < WWDCModel
  def initialize  
    @name = "wwdc2018"
    @url = "https://developer.apple.com/wwdc/schedule/"
    @content_url = "https://devimages-cdn.apple.com/wwdc-services/j06970e2/296E57DA-8CE8-4526-9A3E-F0D0E8BD6543/contents.json"
  end 

  def load_sessions
    response = RestClient.get(@content_url)
    json = JSON.load(response)
    infoEvents = json["contents"].select{|e| e["eventId"] == "wwdc2018"}
    File.open(session_file_path, 'w'){|f| f.write infoEvents.to_json}
  end

  def session_file_path
    file_path("#{@name}.json")
  end

  def get_sessions
    infos = File.open(session_file_path, 'r') {|f| JSON.load(f.read) }
    sessions = infos.map { |info| Session.new(info)}
    sessions.reject!{|s| s.media.nil? }
    sessions
  end
end

class WWDC2017 < WWDCModel
  def initialize  
    @url = "https://developer.apple.com/videos/wwdc2017/"
  end 

  def get_sessions
    
  end
end

class Session
  include JSONable
  attr_accessor :id, :link, :title, :media

  def initialize(info)
    @link = info["webPermalink"]
    @title = info["title"]
    @id = info["eventContentId"]
    @media = info["media"]
  end
end

wwdc = WWDC2018.new
# wwdc.load_sessions
wwdc.get_sessions

