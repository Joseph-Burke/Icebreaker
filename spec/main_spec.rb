require_relative '../main.rb'

describe String do
  describe '#shout' do
    it 'returns a string with all characters capitalized' do
      expect('hello'.shout).to eql('HELLO')  
    end
  end
end