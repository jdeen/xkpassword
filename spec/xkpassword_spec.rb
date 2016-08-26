require 'xkpassword'

describe XKPassword do
  context '#generate' do
    it 'generates password' do
      expect(XKPassword.generate).to_not be(nil)
    end
  end
end
