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
end
