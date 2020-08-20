#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative '../lib/program'

program = Program.new

while program.active

  # STEP 1
  while program.current_page.nil?
    puts program.request_artist
    program.process_input(gets)
  end

  # STEP 2
  while program.current_page.type_of_page == :search
    puts program.display_content
    puts program.request_artist
    program.process_input(gets)
  end

  # STEP 2a
  while program.current_page.type_of_page == :artist && program.viewing_preference.nil?
    puts program.request_viewing_preference
    program.process_input(gets)
  end

  # STEP 3
  while program.current_page.type_of_page == :artist && !program.viewing_preference.nil?
    puts program.display_content
    puts program.request_title
    program.process_input(gets)
  end

  puts program.display_content

  # STEP 4
  while program.current_page.type_of_page == :lyrics
    puts program.request_onward_path
    program.process_input(gets)
    break if program.current_page.nil? || !program.active
  end


end

puts 'Thanks for using Icebreaker! See you next time!'
