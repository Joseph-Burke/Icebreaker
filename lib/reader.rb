#!/usr/bin/env ruby
require 'open-uri'
require 'nokogiri'
require 'open-uri'
doc = Nokogiri::HTML(URI.open("https://www.azlyrics.com/"))

doc.css('.hotsongs .list-group-item').each { |e| puts e.inner_text}
