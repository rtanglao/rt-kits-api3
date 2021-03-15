#!/usr/bin/env ruby
require 'rubygems'
require 'typhoeus'
require 'amazing_print'
require 'json'
require 'time'
require 'date'
require 'csv'
require 'logger'

logger = Logger.new(STDERR)
logger.level = Logger::DEBUG

def KludgeTimeFromBogusZtoUTC(pst_in_utc_str)
  pst_in_utc = Time.parse(pst_in_utc_str)
  old_tz = ENV['TZ']
  ENV['TZ'] = 'America/Vancouver'
  t = Time.local(
    pst_in_utc.year,
    pst_in_utc.month,
    pst_in_utc.day,
    pst_in_utc.hour,
    pst_in_utc.min,
    pst_in_utc.sec)
  # https://github.com/rtanglao/rt-kits-api3/issues/1
  fixed_time = t.dst? ?
              Time.parse(pst_in_utc_str.gsub("Z", "PDT")) :
              Time.parse(pst_in_utc_str.gsub("Z", "PST"))
  ENV['TZ'] = old_tz
  return fixed_time
end

def getKitsuneResponse(url, params, logger)
  logger.debug url
  logger.debug params
  try_count = 0
  begin
    result = Typhoeus::Request.get(
        url,
        :params => params )
    x = JSON.parse(result.body)
  rescue JSON::ParserError => e
    try_count += 1
    if try_count < 4
      $stderr.printf("JSON::ParserError exception, retry:%d\n",\
                     try_count)
      sleep(10)
      retry
    else
      $stderr.printf("JSON::ParserError exception, retrying FAILED\n")
      x = nil
    end
  end
  return x
end

if ARGV.length < 6
  puts "usage: #{$0} yyyy mm dd end-yyyy mm id" 
  exit
end

# because of issue 3686, https://github.com/mozilla/kitsune/issues/3686, 
# go back one day and forward one day
created_time = Time.gm(ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i)
greater_than_time = (created_time - 3600 * 24).strftime("%Y-%-m-%-e")
less_than = Time.gm(ARGV[3].to_i, ARGV[4].to_i, ARGV[5].to_i)
end_time = Time.gm(ARGV[3].to_i, ARGV[4].to_i, ARGV[5].to_i, 23, 59, 59)

less_than_time = (less_than + 3600 * 24).strftime("%Y-%-m-%-e")
less_than_time_parsed = Time.parse(less_than_time + " 00:00:00 UTC")
logger.debug "created_time" + created_time.to_s
logger.debug "greater than time" + greater_than_time.to_s
logger.debug "less than" + less_than.to_s
logger.debug "less than time" + less_than_time.to_s

url_params = {
  :format => "json",
  :product => "firefox", 
  :created__gt => greater_than_time,
  :created__lt => less_than_time,
  :ordering => "+created",
} 

url = "https://support.mozilla.org/api/2/question/"
end_program = false
question_number = 0
issue_3686_offset = 7 * 3600 # 7 hours off
csv = []  
while !end_program
  sleep(1.0) # sleep 1 second between API calls
  questions  = getKitsuneResponse(url, url_params, logger)
  url = questions["next"]
  if url.nil?
    logger.debug "nil next url"
  else
    logger.debug "next url:" + url
  end
  url_params = nil
  questions["results"].each do|q|
    logger.ap q
    #logger.debug "question:" + q.ai(options = {html: true})
    updated = q["updated"]
    logger.debug "created from API:" + q["created"] + "<-- this is PST not UTC despite the 'Z'"
    # All times returned by the API are in PST not PDT and not UTC
    # All URL parameters for time are also in PST not UTC
    # See https://github.com/mozilla/kitsune/issues/3961 and
    # https://github.com/mozilla/kitsune/issues/3946
    # The above may change in the future if we migrate the Kitsune database to UTC

    created = KludgeTimeFromBogusZtoUTC(q["created"])
    logger.debug "created with PST correction:" + created.to_s

    if !updated.nil?
      logger.debug "updated from API:" + updated + "<-- this is PST not UTC despite the 'Z'"
      updated = KludgeTimeFromBogusZtoUTC(q["updated"])
      logger.debug "updated with PST correction:" + updated.to_s
    end
    
    id = q["id"]
    logger.debug "QUESTION id:" + id.to_s
    question_number += 1
    logger.debug "QUESTION number:" + question_number.to_s
    tags = q["tags"]
    tag_str = ""
    tags.each { |t| tag_str = tag_str + t["slug"] + ";"   }
    answers = q["answers"]
    answers_str = ""
    answers.each { |a| answers_str = answers_str + a.to_s + ";"   }
    creator = q["creator"]["username"]
    logger.debug 'createdtop:' + created.to_i.to_s
    logger.debug 'created_time:' + created_time.to_i.to_s
    logger.debug 'less_than_time_parsed:' + less_than_time_parsed.to_i.to_s
    logger.debug 'answers_str:' + answers_str
    logger.debug 'creator:' + creator

    if created.to_i >= created_time.to_i && created.to_i <= end_time.to_i
      logger.debug "NOT skipping"
      csv.push(
        [
        id, created.to_s, updated.to_s, q["title"], q["content"].tr("\n"," "), 
        tag_str, q["product"], q["topic"], q["locale"],
        answers_str, creator
          ])
    else
      logger.debug "SKIPPING"
    end
    if !url.nil?
      logger.debug 'url:' + url
    else
      logger.debug 'url is nil'
    end
    logger.debug 'created:' + q["created"].to_i.to_s
    logger.debug'created_time:' + created_time.to_i.to_s
    if (created.to_i < created_time.to_i) || url.nil?
      end_program = true
      break
    end
  end 
end
headers = ['id', 'created', 'updated', 'title', 'content', 'tags', 'product', 'topic', 
  'locale', 'answers', 'creator']
FILENAME = sprintf("%4.4d-%2.2d-%2.2d-%4.4d-%2.2d-%2.2d-firefox-creator-answers-desktop-all-locales.csv", 
  ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i,
  ARGV[3].to_i, ARGV[4].to_i, ARGV[5].to_i)
CSV.open(FILENAME, "w", write_headers: true, headers: headers) do |csv_object|
  csv.each {|row_array| csv_object << row_array }
end

