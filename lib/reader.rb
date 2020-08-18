#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
doc = Nokogiri::HTML(URI.open("https://www.azlyrics.com/"))

puts doc
