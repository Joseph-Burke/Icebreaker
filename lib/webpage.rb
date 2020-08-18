#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require 'pry'

class WebPage
  attr_accessor :web_address, :type_of_page, :nokogiri
  def initialize(web_address)
    @web_address = web_address
    @nokogiri = Nokogiri::HTML(URI.open(web_address))
    @type_of_page = nil
    determine_type
  end

  def determine_type
    WebPage::TYPES.each do |key, hash|
      prefix_match = @web_address.include?(hash[:prefix])
      title_match = @nokogiri.title.include?(hash[:title_hook])
      body_match = @nokogiri.to_s.include?(hash[:body_hook])
      next unless prefix_match && title_match && body_match

      @type_of_page = key
    end
  end

  WebPage::TYPES = {
    search: {
      prefix: 'https://search.azlyrics.com/search',
      title_hook: 'AZLyrics - Search: ',
      body_hook: 'cf_page_artist = "";'
    },
    artist: {
      prefix: 'https://www.azlyrics.com/',
      title_hook: ' Lyrics',
      body_hook: '<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->'
    },
    lyrics: {
      prefix: 'https://www.azlyrics.com/lyrics/',
      title_hook: ' | AZLyrics.com',
      body_hook: '<!-- MxM banner -->'
    }
  }.freeze
end

search_webpage = Nokogiri::HTML(URI.open('https://search.azlyrics.com/search.php?q=michael+jackson'))
artist_webpage = Nokogiri::HTML(URI.open('https://www.azlyrics.com/b/beatles.html'))
lyrics_webpage = Nokogiri::HTML(URI.open('https://www.azlyrics.com/lyrics/beatles/misery.html'))

# Identifying characteristics of each page
puts search_webpage.title.include?('AZLyrics - Search: ') && search_webpage.to_s.include?('cf_page_artist = "";')
puts artist_webpage.title.include?(' Lyrics') && artist_webpage.to_s.include?('<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->')
puts lyrics_webpage.title.include?(' | AZLyrics.com') && lyrics_webpage.to_s.include?('<!-- MxM banner -->')

webpage = WebPage.new('https://search.azlyrics.com/search.php?q=michael+jackson')
puts webpage.type_of_page
webpage = WebPage.new('https://www.azlyrics.com/b/beatles.html')
puts webpage.type_of_page
webpage = WebPage.new('https://www.azlyrics.com/lyrics/beatles/misery.html')
puts webpage.type_of_page
