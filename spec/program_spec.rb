require_relative '../lib/program.rb'
require_relative '../lib/webpage.rb'

describe Program do

  let(:program) { Program.new }
  let(:page) { WebPage.new('https://www.azlyrics.com/b/beatles.html') }

  describe '#change_page' do
    it 'changes the value of @current_page to the argument passed' do
      program.change_page(:page)
      expect(program.current_page).to eql(page)
    end
  end
end
