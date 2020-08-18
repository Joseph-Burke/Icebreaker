require_relative '../lib/input'

class Interface
  attr_accessor :chosen_artist
  def initialize
    @chosen_artist = nil
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

  def suggest_popular_titles
    'Here are some of their most popular songs:'
  end

  def offer_discography
    "Short on ideas? To view this artist's entire discography, enter 'disc'"
  end

  def request_display_style
    "Finally, to view lyrics karaoke-style, hit k. For a simple read-out, enter R"
  end
end
