#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require 'pry'

class WebPage
  attr_accessor :web_address, :type_of_page, :nokogiri, :content, :links
  def initialize(web_address)
    @web_address = process_address(web_address)
    @nokogiri = Nokogiri::HTML(URI.open(@web_address))
    @type_of_page = nil
    @content = nil
    @links = {}
    determine_type_of_page
    fetch_page_content
    fetch_links
  end

  def determine_type_of_page
    WebPage::TYPES.each do |type, hooks|
      prefix_match = @web_address.include?(hooks[:prefix])
      title_match = @nokogiri.title.include?(hooks[:title_hook])
      body_match = @nokogiri.to_s.include?(hooks[:body_hook])
      next unless prefix_match && title_match && body_match

      @type_of_page = type
    end
  end

  def fetch_page_content
    fetch_lyrics_content if type_of_page == :lyrics
    fetch_artist_content if type_of_page == :artist
    fetch_search_content if type_of_page == :search
  end

  def fetch_links
    if type_of_page == :artist
      content.each do |_key, value_arr|
        value_arr.each { |element| @links[element.inner_text] = element['href'] }
      end
    elsif type_of_page == :search
      content.each do |e|
        @links[e.inner_text] = e['href'] unless links.length >= 5
      end
    end
  end

  def fetch_lyrics_content
    @content = {}
    @content[:lyrics_title] = fetch_lyrics_title
    @content[:lyrics_text] = fetch_lyrics_text
  end

  def fetch_lyrics_title
    @nokogiri.css('.row > .col-xs-12 > b').inner_text.split('"')[1]
  end

  def fetch_lyrics_text
    text_string = @nokogiri.css('.container.main-page > div.row > div.col-xs-12 > div')[4].inner_text
    text_array = text_string
    text_array = text_array.delete("\r").split("\n\n")
    text_array.map! { |string| string.split("\n") }
    text_array.inject { |memo, array| memo.push("\n").concat(array) }
  end

  def fetch_artist_content
    @content = {}
    current_album = nil
    @nokogiri.css('#listAlbum > div').each do |e|
      case e['class']
      when 'album'
        current_album = e.css('b').inner_text.delete_suffix('"').delete_prefix('"')
        @content[current_album] = []
      when 'listalbum-item'
        @content[current_album].push(e.css('a')[0])
      end
    end
  end

  def fetch_search_content
    @content = []
    artist_results_panel = nil
    search_panels = @nokogiri.css('div.panel')
    search_panels.each do |panel|
      heading = panel.css('div.panel-heading').inner_text
      artist_results_panel = panel if heading.include?('Artist results:')
    end
    return if artist_results_panel.nil?

    artist_links = artist_results_panel.css('table tr a')
    artist_links.each { |e| @content.push(e) unless content.length >= 5 }
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

  private

  def process_address(address)
    return address if address.include?('https://')

    address.gsub('../', 'https://www.azlyrics.com/') if address.start_with?('../')
  end
end
