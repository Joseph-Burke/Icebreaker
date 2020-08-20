#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative '../lib/program'

program = Program.new

puts program.introduce

while program.active

  # STEP 1: Search for an artist
  while program.current_page.nil?
    puts program.request_artist
    program.process_input(gets)

    if program.current_page.content.empty?
      puts program.invalid_search
      program.current_page = nil
    end
  end

  # STEP 2: Choose one of the artists listed in the search results
  while program.current_page.type_of_page == :search
    puts "\n"
    puts program.display_content
    puts program.request_artist_selection
    program.process_input(gets)
    puts program.invalid_artist unless program.current_page.type_of_page == :artist
  end

  # STEP 3: Choose one of the artist's songs
  puts program.display_content if program.current_page.type_of_page == :artist
  while program.current_page.type_of_page == :artist
    puts program.request_title
    program.process_input(gets)
    if program.current_page.type_of_page == :artist
      puts program.display_content
      puts program.invalid_song
    end
    next unless program.current_page.type_of_page.nil?

    puts program.invalid_webpage
    program.current_page = nil
    break
  end
  next if program.current_page.nil?

  puts program.display_content if program.current_page.type_of_page == :lyrics

  # STEP 4 Choose what to do after printing the lyrics.
  while program.current_page.type_of_page == :lyrics
    puts program.request_onward_path
    program.process_input(gets)
    break if program.current_page.nil? || !program.active
  end

end

puts program.farewell
