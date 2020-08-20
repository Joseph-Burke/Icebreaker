require 'nokogiri'
require 'open-uri'
require_relative '../lib/string'
require_relative '../lib/webpage'
require_relative '../lib/printable'

class Program
  include Printable
  attr_accessor :current_page, :viewing_preference
  def initialize
    @current_page = nil
    @viewing_preference = nil
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
    process_viewing_preference(input) if page_type == :artist && viewing_preference.nil?
    process_track_selection(input) if page_type == :artist && !viewing_preference.nil?
    process_onward_path(input) if page_type == :lyrics

  end

  def process_search_terms(input)
    go_to_search_page(input.make_search_term_array)
  end

  def process_search_selection(input)
    follow_link(input)
  end

  def process_viewing_preference(input)
    input = input.clean.to_i
    valid = [1, 2]
    return unless valid.include?(input)
    case input
    when 1
      @viewing_preference = :alpha
    when 2
      @viewing_preference = :album
    end
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
      # Pick another song by the same artist
    when 3
      # Close the program
    end

  end


end

prog = Program.new
prog.change_page('https://www.azlyrics.com/lyrics/benlee/popqueen.html')

prog.return_to_artist_page

puts prog.current_page.type_of_page



puts prog.process_input('jisjs')
