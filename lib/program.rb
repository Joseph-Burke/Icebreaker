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

  def display_content
    page = current_page
    content = page.content
    type = page.type_of_page
    case type
    when :search
      content.map(&:inner_text)

    when :artist
      arr = []
      content.each do |key, value|
        arr.push("\n")
        arr.push(key)
        arr.push("\n")
        value.each { |element| arr.push(element.inner_text) }
        arr.push("\n")
      end
      arr

    when :lyrics
      title = "\n" << content[:lyrics_title] << "\n"
      content[:lyrics_text].unshift(title)
    end
  end

  def change_page(web_address)
    @current_page = WebPage.new(web_address)
  end

  def follow_link(string_input)
    input = string_input.clean
    current_page.links.each do |key, val|
      song_title = key.clean
      change_page(val) if input == song_title
    end
  end

  def go_to_search_page(search_terms_arr)
    new_address = WebPage::TYPES[:search][:prefix]
    new_address += search_terms_arr.join('+')
    change_page(new_address)
  end
end

