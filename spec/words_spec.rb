require 'xkpassword/words'

describe XKPassword::Words do
  let(:words) { XKPassword::Words.new() }

  context '#with_length' do
    it 'gives an array of words for a given length' do
      expect(words.with_length(5).first.length).to eq(5)
    end
  end

  context '#random' do
    it 'gives a random word for the length provided' do
      expect(words.random(5).length).to eq(5)
    end
  end
end
