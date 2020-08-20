module Printable
  def introduce
    "Welcome to Icebreaker, the application that allows instant access to the Internet's repository of song lyrics!"
  end

  def request_artist
    "Which artist's songs would you like to view?"
  end

  def request_title
    'Which song of theirs would you like to see the lyrics for?'
  end

  def request_viewing_preference
    [
      "Would you like to view this artist's songs...",
      "\n",
      '1. By album',
      '2. Alphabetically',
      "\n",
      'Enter 1 or 2 to indicate your preference.',
      "\n"
  ]
  end

  def request_onward_path
    [
      'That song really is a classic! Fancy another?',
      "\n",
      'Choose an option below:',
      "\n",
      "\n",
      '1. Make another search',
      '2. Pick another song by the same artist',
      '3. Call it a day and close the program',
      'Enter 1, 2 or 3 to indicate your preference.',
      "\n"
    ]
  end
end
