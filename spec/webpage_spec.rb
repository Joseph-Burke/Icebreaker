require_relative '../lib/webpage.rb'

describe WebPage do
  let(:search_page) { WebPage.new('https://search.azlyrics.com/search.php?q=the+beatles') }
  let(:artist_page) { WebPage.new('https://www.azlyrics.com/b/beatles.html') }
  let(:lyrics_page) { WebPage.new('https://www.azlyrics.com/lyrics/beatles/misery.html') }
  let(:lyrics_title) { 'Misery' }
  let(:lyrics_text) do
    [
      "\n",
      'The world is treating me bad... Misery',
      "\n",
      "I'm the kind of guy",
      'Who never used to cry',
      'The world is treating me bad... Misery!',
      "\n",
      "I've lost her now for sure",
      "I won't see her no more",
      "It's gonna be a drag... Misery!",
      "\n",
      "I'll remember all the little things we've done",
      "Can't she see she'll always be the only one, only one",
      "\n",
      'Send her back to me',
      'Cos everyone can see',
      'Without her I will be in misery',
      "\n",
      "I'll remember all the little things we've done",
      "She'll remember and she'll miss her only one, lonely one",
      "\n",
      'Send her back to me',
      'Cos everyone can see',
      'Without her I will be in misery (Oh oh oh)',
      'In misery (Ooh ee ooh ooh)',
      'My misery (La la la la la la)'
    ]
  end

  describe '#determine_type_of_page' do
    it 'changes @type_of_page to :search, :artist or :lyrics if the page meets certain criteria' do
      [search_page, artist_page, lyrics_page].each_with_index do |page, i|
        page.type_of_page = nil
        page.determine_type_of_page
        expect(page.type_of_page).to eql(%i[search artist lyrics][i])
      end
    end
  end

  describe '#fetch_lyrics_content' do
    it 'sets @content equal to a hash with two key-value pairs: song_title and song_lyrics' do
      expect(lyrics_page.content[:lyrics_title]).to eql(lyrics_title)
      expect(lyrics_page.content[:lyrics_text]).to eql(lyrics_text)
    end
  end

  describe '#fetch_lyrics_title' do
    it "sets @content[:song_title] to the title of the lyrics page's song" do
      expect(lyrics_page.content[:lyrics_title]).to eql(lyrics_title)
    end
  end

  describe '#fetch_lyrics_text' do
    it "sets @content[:song_text] to the text of the lyrics page's song" do
      expect(lyrics_page.content[:lyrics_text]).to eql(lyrics_text)
    end
  end

  describe '#fetch_artist_content' do
    it 'sets @content equal to an array of hashes.' do
      artist_page.fetch_artist_content
      expect(artist_page.content.is_a?(Hash)).to eql(true)
      artist_page.content.each { |key, val| expect(key.is_a?(String) && val.is_a?(Array)).to eql(true) }
    end
  end

  describe '#fetch_search_content' do
    it 'sets @content equal to an array of links in Nokogiri::XML::Element format.' do
      search_page.fetch_search_content
      expect(search_page.content.is_a?(Array)).to eql(true)
      search_page.content.each { |e| expect(e.is_a?(Nokogiri::XML::Element)).to eql(true) }
    end
  end
end
