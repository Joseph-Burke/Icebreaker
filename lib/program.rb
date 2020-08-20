require 'nokogiri'
require 'open-uri'
require_relative '../lib/string'
require_relative '../lib/webpage'
require_relative '../lib/printable'

class Program
  include Printable
  attr_accessor :current_page, :viewing_preference, :active
  def initialize
    @current_page = nil
    @active = true
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
      title = "\n" << current_page.content[:lyrics_title] << "\n"
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
      if input == song_title
        change_page(val)
        break
      end
    end
  end

  def go_to_search_page(search_terms_arr)
    new_address = WebPage::TYPES[:search][:prefix]
    new_address += search_terms_arr.join('+')
    change_page(new_address)
  end

  def return_to_artist_page
    return unless current_page.type_of_page == :lyrics

    artist_page_anchor = current_page.nokogiri.css('.col-xs-12 > .lyricsh > h2 > a')[0]
    artist_web_address = artist_page_anchor['href'].prepend('https:')
    change_page(artist_web_address)
  end

  def process_input(input)
    page_type = @current_page.type_of_page if @current_page

    process_search_terms(input) if page_type.nil?
    process_search_selection(input) if page_type == :search
    process_track_selection(input) if page_type == :artist
    process_onward_path(input) if page_type == :lyrics
  end

  def process_search_terms(input)
    go_to_search_page(input.make_search_term_array)
  end

  def process_search_selection(input)
    follow_link(input)
  end

  def process_track_selection(input)
    follow_link(input)
  end

  def process_onward_path(input)
    input = input.clean.to_i
    valid = [1, 2, 3]
    return unless valid.include?(input)

    case input
    when 1
      @current_page = nil
      @viewing_preference = nil
    when 2
      return_to_artist_page
      @viewing_preference = nil
    when 3
      self.active = false
    end
  end
end
