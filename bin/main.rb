#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative '../lib/program'

program = Program.new
loop_is_active = true

while loop_is_active

  # STEP 1
  while program.current_page.nil?
    puts program.request_artist
    program.process_input(gets)
  end
  puts "STEP 1 COMPLETE"

  # STEP 2
  while program.current_page.type_of_page == :search
    puts program.display_content
    puts program.request_artist
    program.process_input(gets)
  end
  puts "STEP 2 COMPLETE"


  # STEP 2a
  while program.current_page.type_of_page == :artist && program.viewing_preference.nil?
    puts program.request_viewing_preference
    program.process_input(gets)
  end
  puts "STEP 2a COMPLETE"

  # STEP 3
  while program.current_page.type_of_page == :artist && !program.viewing_preference.nil?
    puts program.display_content
    puts program.request_title
    program.process_input(gets)
  end
  puts "STEP 3 COMPLETE"

  binding.pry

  # STEP 4
  while program.current_page.type_of_page == :lyrics
    puts program.display_content
    puts program.request_onward_path
    program.process_input(gets)
  end
  puts program.display_content





  # program.go_to_search_page(input.chomp.split)



  # puts program.display_content
  # puts program.request_artist
  # input = gets
  # program.follow_link(input)
  # puts program.display_content
  # puts program.request_title
  # input = gets
  # program.follow_link(input)
  # puts program.display_content
  loop_is_active = false
end
