require 'xkpassword/store'

describe XKPassword::Store do
  it 'loads data' do
    expect(XKPassword::Store.new.data.first).to eq('the')
  end
end
