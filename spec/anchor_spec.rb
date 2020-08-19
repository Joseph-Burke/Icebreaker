require 'nokogiri'
require 'open-uri'
require_relative '../lib/anchor.rb'

describe Anchor do
  let(:search_page_address) { 'https://search.azlyrics.com/search.php?q=the+beatles' }
  let(:anchor_text) { 'The Beatles' }
  let(:anchor_tag) { "<a href='#{search_page_address}'>#{anchor_text}</a>" }
  let(:anchor_object) { Anchor.new(anchor_tag) }

  describe '#process_anchor' do
    it 'sets @href and @anchor_text attributes equal to the corresponding substrings of an anchor_tag argument' do
      [anchor_object.href, anchor_object.anchor_text].each { |e| expect(e).not_to be_nil}
    end
  end

  describe '#isolate_href' do
    it '' do
    end
  end

  describe '#isolate_text' do
    it "" do

    end
  end
end
