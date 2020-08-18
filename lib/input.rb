#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'

class Input < String
  attr_accessor :search_terms

  def initialize(string)
    @search_terms = string.strip.chomp.downcase.split(' ')
  end

  def generate_search_address
    suffix = search_terms.join('+')
    "https://search.azlyrics.com/search.php?q=#{suffix}" 
  end
end

input = Input.new('Miley Cyrus')

puts input.search_terms
address = input.generate_search_address
puts Nokogiri::HTML(URI.open(address))
