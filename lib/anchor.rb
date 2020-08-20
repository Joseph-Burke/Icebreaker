#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require 'pry'
class Anchor
  attr_accessor :href, :anchor_text, :full_element, :node
  def initialize(node)
    @node = node
    @href = node.at_css('a')['href']
    @anchor_text = node.at_css('a').inner_text
  end
end

# test_node = Nokogiri::XML(
#   '<a href="https://www.azlyrics.com/b/beatles.html#10996"><b>The Beatles - "The Beatles (The White Album)"</b></a>'
# )
# test_anchor = Anchor.new(test_node)

# puts test_node.class
# puts test_anchor.href
# puts test_anchor.anchor_text
