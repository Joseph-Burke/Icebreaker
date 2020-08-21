module Printable
  def introduce
    [
      "\nWelcome to Icebreaker!\n",
      "Icebreaker caters to all your song lyric needs, right here in the the Terminal. Less searching, more singing!\n\n"
    ]
  end

  def request_artist
    [
      'Please enter the name of the artist whose lyrics you would like:',
      "\n"
    ]
  end

  def invalid_search
    [
      "\n",
      'Oh, fiddlesticks!',
      'Your input did not return any artists.',
      "\n",
      'Try again.',
      "\n"
    ]
  end

  def request_artist_selection
    [
      "\n",
      'Look! The little lyrics elves have brought back a list of artists!',
      'Which of the above artists would you like to see lyrics for?',
      'Enter your chosen artist below:',
      "\n"
    ]
  end

  def invalid_artist
    [
      "\n",
      '"To err is human - but to really foul things up you need a computer."',
      "\t - Anonymous",
      "\n",
      'Your input does not match any of the artists in the list!',
      'Try entering the name of the artist again, exactly as you see it displayed.',
      "\n"
    ]
  end

  def invalid_song
    [
      'Your input does not match any of the songs in the list!',
      'Try entering the name of the song again, exactly as you see it displayed.',
      "\n",
      '"To err is human - but to really foul things up you need a computer."',
      "\t - Anonymous",
      "\n"
    ]
  end

  def invalid_webpage
    [
      "\n",
      "What's that, little lyrics elves? ",
      'The lyrics that the nice user wanted are on a webpage that does not conform to the patterns you use to identify and analyse webpages?! Oh no!',
      "\n",
      'Thanks for letting us know, little elves!',
      'Initiate reboot!',
      "\n"
    ]
  end


  def request_title
    [
      "\n",
      '"Music is enough for a lifetime, but a lifetime is not enough for music."',
      "\t- Sergei Rachmaninov",
      "\n",
      'Enter the title of one of the songs listed above to see its lyrics.'
    ]
  end

  def request_onward_path
    [
      "\n",
      "\n",
      'That song really is a classic! Fancy another?',
      'Choose an option below:',
      "\n",
      '1. Make another search',
      '2. Pick another song by the same artist',
      '3. Call it a day and close the program',
      "\n",
      'Enter 1, 2 or 3 to indicate your preference.',
      "\n"
    ]
  end

  def invalid_onward_path
    [
      "\n",
      "That's not a number between 1 and 3.",
      "Trust me, I'm a computer"
    ]
  end

  def farewell
    "\nThanks for using Icebreaker! See you next time!\n\n"
  end
end
