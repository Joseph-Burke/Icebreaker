#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative '../lib/interface'

interface = Interface.new

# Introduction
puts interface.introduce

puts interface.request_artist

interface.receive_artist(gets)

# Ask which song they would like to view
puts interface.request_title

# Display some popular songs
puts interface.suggest_popular_titles
puts interface.offer_discography
interface.receive_title(gets)

# Get display style
puts interface.request_display_style
