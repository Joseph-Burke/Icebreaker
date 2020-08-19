#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
class Anchor
  attr_accessor :href, :anchor_text
  def initialize(anchor_tag)
    @full_element = anchor_tag
    @href = nil
    @anchor_text = nil
    process_anchor(anchor_tag)
  end

  private

  def process_anchor(anchor_tag)
    @href = isolate_href(anchor_tag)
    @anchor_text = isolate_text(anchor_tag)
  end

  def isolate_href(anchor_tag)
    output = anchor_tag
    output = output.slice(output.index('https')...-1)
    output.split("'")[0].split('"')[0]
  end

  def isolate_text(anchor_tag)
    output = Nokogiri::XML(anchor_tag)
    output.css('a').text
  end
end

anchor = Anchor.new('<a href="https://www.azlyrics.com/b/beatles.html#10996"><b>The Beatles - "The Beatles (The White Album)"</b></a>')

# puts anchor.href 
# puts anchor.anchor_text
