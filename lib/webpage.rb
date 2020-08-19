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
    fetch_page_content
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
  end

  def fetch_lyrics_content
    @content = {}
    @content[:lyrics_title] = fetch_lyrics_title
    @content[:lyrics_text] = fetch_lyrics_text
  end

  def fetch_lyrics_title
    @nokogiri.css('.col-xs-12 :nth-child(5)').text.split('"')[1]
  end

  def fetch_lyrics_text
    text_array = @nokogiri.css('.col-xs-12 :nth-child(8)')[0..-2].text.split("\r")
    text_array = text_array.join('').split("\n\n")
    text_array.map! { |string| string.split("\n") }
    text_array.inject { |memo, array| memo.push("\n").concat(array) }
  end

  def fetch_artist_content
    @content = {}
    current_album = nil
    @nokogiri.css('#listAlbum > div').each do |e|
      case e['class']
      when 'album'
        current_album = e.css('b').inner_text
        @content[current_album] = []
      when 'listalbum-item'
        @content[current_album].push(e.css('a').inner_text)
      end
    end
  end

# Have a single method to fetch content that behaves differently according to the value of
# @type_of_page.

=begin
  FETCH CONTENT

    SEARCH
      I want a Hash with three key-value pairs.

      Keys: artist_results, album_results, song_results
      Values: An array of Anchor items.

    ARTIST
      I want a Hash of Hashes.

        Each Hash will have a string as its key and an array of Anchors as its value

    LYRICS
      I want a Hash with two key-value pairs.

      Keys: song_title, song_lyrics
      Values: A string containing the song title and an array of strings containing each line of the lyrics.

=end

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
