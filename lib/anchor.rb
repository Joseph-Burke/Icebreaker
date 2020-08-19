#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
class Anchor
  attr_accessor :href, :anchor_text, :full_element, :node
  def initialize(anchor_tag)
    @full_element = anchor_tag
    @node = Nokogiri::XML(@full_element)
    @href = @node.at_css('a')['href']
    @anchor_text = @node.at_css('a').inner_text
  end

end

anchor = Anchor.new('<a href="https://www.azlyrics.com/b/beatles.html#10996"><b>The Beatles - "The Beatles (The White Album)"</b></a>')

# puts anchor.href
# puts anchor.anchor_text

test_anchor_tag = Nokogiri::XML('<a href="https://www.azlyrics.com/b/beatles.html#10996"><b>The Beatles - "The Beatles (The White Album)"</b></a>')

puts anchor.href
puts anchor.anchor_text
