#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative '../lib/program'

program = Program.new

# Introduction
# puts program.introduce

# puts program.request_artist
# program.receive_artist(gets)

# # Ask which song they would like to view
# puts program.request_title

# # Display some popular songs
# puts program.suggest_popular_titles
# puts program.offer_discography
# program.receive_title(gets)

# # Get display style
# puts program.request_display_style

test_page = WebPage.new('https://search.azlyrics.com/search.php?q=the+beatles')

# puts test_page.nokogiri.class