#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative '../lib/program'

program = Program.new
program.change_page('https://search.azlyrics.com/search.php?q=beatles')
loop_is_active = true


while loop_is_active
  puts program.request_artist
  input = gets
  program.go_to_search_page(input.chomp.split)
  puts program.display_content
  puts program.request_artist
  input = gets
  program.follow_link(input)
  puts program.display_content
  puts program.request_title
  input = gets
  program.follow_link(input)
  puts program.display_content
  loop_is_active = false
end


