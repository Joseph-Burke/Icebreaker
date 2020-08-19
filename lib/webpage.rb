#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require 'pry'

class WebPage
  attr_accessor :web_address, :type_of_page, :nokogiri, :content
  def initialize(web_address)
    @web_address = web_address
    @nokogiri = Nokogiri::HTML(URI.open(web_address))
    @type_of_page = nil
    @content = nil
    determine_type_of_page
    fetch_content
  end

  def determine_type_of_page
    WebPage::TYPES.each do |key, hash|
      prefix_match = @web_address.include?(hash[:prefix])
      title_match = @nokogiri.title.include?(hash[:title_hook])
      body_match = @nokogiri.to_s.include?(hash[:body_hook])
      next unless prefix_match && title_match && body_match

      @type_of_page = key
    end
  end

  def fetch_content
    return fetch_search_results if @type_of_page == :search
    return fetch_artist_songs if @type_of_page == :artist
    return fetch_lyrics if @type_of_page == :lyrics
  end

  def fetch_search_results
    return unless @type_of_page == :search

    arr = @nokogiri.css('table.table a:not(.btn)')
  end

  def fetch_artist_songs
    return unless @type_of_page == :artist
  end

  def fetch_lyrics
    return unless @type_of_page == :lyrics
  end

  WebPage::TYPES = {
    search: {
      prefix: 'https://search.azlyrics.com/search.php?q=',
      title_hook: 'AZLyrics - Search: ',
      body_hook: 'cf_page_artist = "";'
    },
    artist: {
      prefix: 'https://www.azlyrics.com/',
      title_hook: ' Lyrics',
      body_hook: '<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* '
    },
    lyrics: {
      prefix: 'https://www.azlyrics.com/lyrics/',
      title_hook: ' | AZLyrics.com',
      body_hook: '<!-- MxM banner -->'
    }
  }.freeze
end
