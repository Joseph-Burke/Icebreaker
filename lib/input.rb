#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'

class Input
  attr_accessor :search_terms
  attr_reader :original_input

  def initialize(string)
    @original_input = string
    @search_terms = string.strip.chomp.downcase.split(' ')
  end

  def generate_search_address
    suffix = search_terms.join('+')
    "https://search.azlyrics.com/search.php?q=#{suffix}"
  end
end
