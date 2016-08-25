require 'xkpassword/generator'

describe XKPassword::Generator do
  let(:generator) { XKPassword::Generator.new }

  context '#generate' do
    it 'generates password' do
      expect(generator.generate(min_length: 3, max_length: 5, separator: '-')).to_not be(nil)
    end
  end
end
