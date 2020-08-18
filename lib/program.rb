require 'nokogiri'
require 'open-uri'
require_relative '../lib/input'
require_relative '../lib/webpage'

class Program
  attr_accessor :chosen_artist, :current_page
  def initialize
    @chosen_artist = nil
    @chosen_song = nil
    @current_page = nil
  end

  def introduce
    "Welcome to Icebreaker, the application that allows instant access to the Internet's repository of song lyrics!"
  end

  def request_artist
    "Which artist's songs would you like to view?"
  end

  def receive_artist(string)
    @chosen_artist = Input.new(string)
  end

  def request_title
    'Which song of theirs would you like to see the lyrics for?'
  end

  def receive_title(string)
    @chosen_song = Input.new(string)
  end

  def suggest_popular_titles
    'Here are some of their most popular songs:'
  end

  def offer_discography
    "Short on ideas? To view this artist's entire discography, enter 'disc'"
  end

  def request_display_style
    'Finally, to view lyrics karaoke-style, hit k. For a simple read-out, enter R'
  end

  def change_page(web_address)
    @current_page = WebPage.new(web_address)
  end

  def go_to_search_page(search_terms_arr)
    new_address = WebPage::TYPES[:search][:prefix]
    new_address += search_terms_arr.join('+')
    change_page(new_address)
  end

  def follow_link(html_element)
    output = html_element
    output = output.slice(output.index('https')...-1)
    output = output.split("'")[0].split('"')[0]
    change_page(output)
  end
end
