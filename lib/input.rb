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

  def clean_input
    strip.chomp.downcase
  end

end


class String
  def clean
    chomp.strip.downcase
  end

  def remove_definite_article
    sub('the', '')
  end

  def make_search_term_array
    self.clean.split('')
  end
end

dirty_string = "  HeY JuDe   "

puts dirty_string.clean