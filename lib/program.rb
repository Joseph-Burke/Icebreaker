require 'nokogiri'
require 'open-uri'
require_relative '../lib/input'
require_relative '../lib/webpage'
require_relative '../lib/printable'

class Program
  include Printable
  attr_accessor :chosen_artist, :current_page
  def initialize
    @chosen_artist = nil
    @chosen_song = nil
    @current_page = nil
  end

  def receive_artist(string)
    @chosen_artist = Input.new(string)
  end

  def receive_title(string)
    @chosen_song = Input.new(string)
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
