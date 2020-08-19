require_relative '../lib/webpage.rb'

describe WebPage do
  let(:search_page) { WebPage.new('https://search.azlyrics.com/search.php?q=the+beatles') }
  let(:artist_page) { WebPage.new('https://www.azlyrics.com/b/beatles.html') }
  let(:lyrics_page) { WebPage.new('https://www.azlyrics.com/lyrics/beatles/misery.html') }
  let(:google) { WebPage.new('www.google.com') }

  describe '#determine_type_of_page' do
    it 'changes @type_of_page to :search, :artist or :lyrics if the page meets certain criteria' do
      [search_page, artist_page, lyrics_page].each_with_index do |page, i|
        page.type_of_page = nil
        page.determine_type_of_page
        expect(page.type_of_page).to eql([:search, :artist, :lyrics, nil][i])
      end
    end
  end

  # describe '#fetch_content' do
  #   it 'returns the relevant content of webpage as an array of strings ready to be printed' do

  #   end
  # end

  # describe '#fetch_search_results' do
  #   it 'returns all results of a search page as a hash with each value being an array of strings' do

  #   end
  # end

  # describe '#fetch_artist_songs' do
  #   it "returns all of the songs listed on an artist's page as a hash, with each value being a an array of strings" do

  #   end
  # end

  # describe '#fetch_lyrics' do
  #   it 'returns the relevant content of webpage as an array of strings ready to be printed' do

  #   end
  # end
end
