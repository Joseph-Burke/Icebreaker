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

# test_page = WebPage.new('https://search.azlyrics.com/search.php?q=the+beatles')

# puts test_page.nokogiri.class

search_page = WebPage.new('https://search.azlyrics.com/search.php?q=the+kinks')
artist_page = WebPage.new('https://www.azlyrics.com/b/beachboys.html')
lyrics_page = WebPage.new('https://www.azlyrics.com/lyrics/kinks/youreallygotme.html')

# puts search_page.content
# puts
artist_page.content.each { |album, tracklist| puts album; puts "\n"; puts tracklist; puts "\n" }

# puts lyrics_page.content[:lyrics_text]
