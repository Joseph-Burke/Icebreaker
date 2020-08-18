#!/usr/bin/env ruby
require 'open-uri'
require 'nokogiri'
require 'open-uri'
doc = Nokogiri::HTML(URI.open("http://www.threescompany.com/"))

puts doc



puts 'hi'
