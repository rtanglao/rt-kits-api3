#!/usr/bin/env ruby
require 'json'
require 'rubygems'
require 'typhoeus'
require 'amazing_print'
require 'time'

# This script tests: https://github.com/mozilla/kitsune/issues/3686

def getKitsuneResponse(url, params)
  result = Typhoeus::Request.get(url,
    :params => params )
  try_count = 0
  begin
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
      # raise e
      x = nil
    end
  end
  return x
end

 url_params = {
} 

url = "https://support.mozilla.org/api/2/question/1259114/"
question  = getKitsuneResponse(url, url_params)
ap question
ap question["created"]
api_time_in_seconds = Time.parse(question["created"]).to_i
puts  "integer time in API:"+api_time_in_seconds.to_s
sumo_website_time_in_seconds =
  Time.parse("2019-05-13T07:53:40-0700").to_i
puts "integer time in SUMO website:" + sumo_website_time_in_seconds.to_s
difference = sumo_website_time_in_seconds - api_time_in_seconds
if difference == 0
  puts("TEST PASSED")
else
  puts("TEST FAILED! Difference in seconds sumo time - api time:" + 
       (sumo_website_time_in_seconds - api_time_in_seconds).to_s)
   puts("TEST FAILED! Difference in hours:" + 
       ((sumo_website_time_in_seconds - api_time_in_seconds)/3600).to_s)
  
end
