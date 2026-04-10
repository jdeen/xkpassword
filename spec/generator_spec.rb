require 'xkpassword/generator'

describe XKPassword::Generator do
  let(:generator) { XKPassword::Generator.new }

  context '#generate' do
    it 'generates password' do
      expect(generator.generate(min_length: 3, max_length: 5, separator: '-')).to_not be(nil)
    end

    it 'upcases every generated word' do
      allow(generator.words).to receive(:random).and_return('alpha', 'bravo', 'charlie', 'delta')

      password = generator.generate(words: 4, separator: '-', case_transform: :upcase)

      expect(password).to eq('ALPHA-BRAVO-CHARLIE-DELTA')
    end

    it 'downcases every generated word' do
      allow(generator.words).to receive(:random).and_return('Alpha', 'Bravo')

      password = generator.generate(words: 2, separator: ' ', case_transform: :downcase)

      expect(password).to eq('alpha bravo')
    end

    it 'capitalizes every generated word' do
      allow(generator.words).to receive(:random).and_return('alpha', 'bravo', 'charlie', 'delta')

      password = generator.generate(words: 4, separator: '-', case_transform: :capitalize)

      expect(password).to eq('Alpha-Bravo-Charlie-Delta')
    end

    it 'accepts case_transform as a string' do
      allow(generator.words).to receive(:random).and_return('alpha', 'bravo')

      password = generator.generate(words: 2, separator: '-', case_transform: 'upcase')

      expect(password).to eq('ALPHA-BRAVO')
    end

    it 'rejects unsupported case transforms' do
      expect { generator.generate(case_transform: :swapcase) }
        .to raise_error(ArgumentError, /case_transform should be one of/)
    end
  end
end
