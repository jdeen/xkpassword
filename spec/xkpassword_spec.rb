require 'xkpassword'

describe XKPassword do
  context '#generate' do
    it 'generates password' do
      expect(XKPassword.generate).to_not be(nil)
    end

    it 'passes preset options through to the generator' do
      generator = instance_double(XKPassword::Generator)
      allow(XKPassword::Generator).to receive(:new).and_return(generator)
      allow(generator).to receive(:generate).with({ preset: :security, case_transform: :capitalize }).and_return('Alpha Bravo')

      expect(XKPassword.generate(preset: :security, case_transform: :capitalize)).to eq('Alpha Bravo')
    end
  end
end
