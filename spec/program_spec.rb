require 'nokogiri'
require 'open-uri'
require_relative '../lib/program.rb'
require_relative '../lib/webpage.rb'

describe Program do
  let(:program) { Program.new }
  let(:page) { WebPage.new('http://blank.org/') }
  let(:web_address) { 'http://blank.org/' }

  describe '#change_page' do
    it 'changes the value of @current_page to the argument passed' do
      program.current_page = nil
      program.change_page(web_address)
      expect(program.current_page.web_address).to eql(web_address)
    end
  end
end
