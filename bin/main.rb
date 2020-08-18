#!/usr/bin/env ruby
require 'open-uri'
require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative '../lib/interface'

interface = Interface.new

# Introduction
puts interface.introduce

puts interface.request_artist

interface.receive_artist(gets)
puts interface.chosen_artist.original_input

# Ask which song they would like to view
puts interface.request_title

# Display some popular songs
puts interface.suggest_popular_titles

# Offer to display entire discography
puts interface.offer_discography

# Offer to display lyrics
puts interface.request_display_style
