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
    identifiers = {
      search: ['AZLyrics - Search: ', 'cf_page_artist = "";'],
      artist: [' Lyrics', '<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->'],
      lyrics: [' | AZLyrics.com', '<!-- MxM banner -->']
    }

    identifiers.each do |key, arr|
      next unless @nokogiri.title.include?(arr[0]) && @nokogiri.to_s.include?(arr[1])
      @type_of_page = key
    end
  end

  WebPage::PREFIXES = {
    search: 'https://search.azlyrics.com/search',
    artist: 'https://www.azlyrics.com/', 
    lyrics: 'https://www.azlyrics.com/lyrics/'
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
