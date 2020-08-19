require 'nokogiri'
require 'open-uri'
require_relative '../lib/program.rb'
require_relative '../lib/webpage.rb'

describe Program do
  let(:program) { Program.new }
  let(:page) { WebPage.new('http://blank.org/') }
  let(:web_address) { 'http://blank.org/' }
  let(:search_terms) { %w[the beatles] }
  let(:search_page_address) { 'https://search.azlyrics.com/search.php?q=the+beatles' }
  let(:html_link_tag) { "<a href='#{search_page_address}'>The Beatles</a>" }

  # describe '#change_page' do
  #   it 'changes the value of @current_page to the argument passed' do
  #     program.current_page = nil
  #     program.change_page(web_address)
  #     expect(program.current_page.web_address).to eql(web_address)
  #   end
  # end

  # describe '#go_to_search_page' do
  #   it 'changes the value of @current_page to a search results page produced by the methods argument' do
  #     program.current_page = nil
  #     program.go_to_search_page([search_terms])
  #     expect(program.current_page.web_address).to eql(search_page_address)
  #   end
  # end

  # describe '#follow_link' do
  #   it "changes the value of @current_page to the web_address saved in an <a> element's href attribute" do
  #     program.current_page = nil
  #     program.follow_link(html_link_tag)
  #     expect(program.current_page.web_address).to eql(search_page_address)
  #   end
  # end
end
