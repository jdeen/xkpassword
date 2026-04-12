require 'xkpassword/generator'

describe XKPassword::Generator do
  let(:generator) { XKPassword::Generator.new }

  context '#generate' do
    it 'generates password' do
      expect(generator.generate(min_length: 3, max_length: 5, separator: '-')).to_not be(nil)
    end

    it 'defaults to the xkcd preset' do
      allow(generator.words).to receive(:random).and_return('alpha', 'bravo', 'charlie', 'delta',
                                                            'alpha', 'bravo', 'charlie', 'delta')
      allow(generator).to receive(:randomly_upcase) { |word| word }

      expect(generator.generate).to eq(generator.generate(preset: :xkcd))
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

    {
      xkcd: { words: 4, length_range: 4..8, separator: '-', expected_word: 'Alpha' },
      web32: { words: 4, length_range: 4..5, separator: '-', expected_word: 'Alpha' },
      wifi: { words: 6, length_range: 4..8, separator: '-', expected_word: 'Alpha' },
      security: { words: 6, length_range: 4..8, separator: ' ', expected_word: 'alpha' },
      apple_id: { words: 3, length_range: 4..7, separator: '-', expected_word: 'Alpha' },
    }.each do |preset, config|
      it "supports the #{ preset } preset" do
        allow(generator).to receive(:randomly_upcase) { |word| word }
        expect(generator.words).to receive(:random)
          .with(satisfy { |length| config[:length_range].cover?(length) })
          .exactly(config[:words]).times
          .and_return(*Array.new(config[:words], 'Alpha'))

        password = generator.generate(preset: preset)

        expect(password).to eq(Array.new(config[:words], config[:expected_word]).join(config[:separator]))
      end
    end

    it 'accepts presets as strings and lets explicit options override the preset' do
      allow(generator).to receive(:randomly_upcase) { |word| word }
      expect(generator.words).to receive(:random).with(satisfy { |length| (4..7).cover?(length) }).twice
        .and_return('alpha', 'bravo')

      password = generator.generate(preset: 'apple-id', words: 2, separator: '.', case_transform: :capitalize)

      expect(password).to eq('Alpha.Bravo')
    end

    it 'rejects unsupported presets' do
      expect { generator.generate(preset: :temporary) }
        .to raise_error(ArgumentError, /preset should be one of/)
    end

    it 'does not mutate the provided options hash' do
      options = { preset: :security, separator: '.' }

      allow(generator.words).to receive(:random).and_return('alpha', 'bravo', 'charlie', 'delta', 'echo', 'foxtrot')

      generator.generate(options)

      expect(options).to eq({ preset: :security, separator: '.' })
    end
  end
end
