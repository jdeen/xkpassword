# frozen_string_literal: true

require 'tmpdir'

require 'xkpassword/config_file'

RSpec.describe XKPassword::ConfigFile, '#load without a config file' do
  it 'returns an empty hash when the config file does not exist' do
    Dir.mktmpdir do |dir|
      config_file = described_class.new(File.join(dir, '.xkpassword'))

      expect(config_file.load).to eq({})
    end
  end
end

RSpec.describe XKPassword::ConfigFile, '#load with yaml config' do
  it 'loads yaml config and ignores comments' do
    Dir.mktmpdir do |dir|
      config_path = File.join(dir, '.xkpassword')
      config_file = described_class.new(config_path)

      File.write(config_path, <<~YAML)
        # Try different defaults by commenting entries in and out.
        preset: wifi
        words: 6
        min-length: "4"
        max_length: 8
        separator: "."
        # case_transform: capitalize
      YAML

      expect(config_file.load).to eq(
        preset: 'wifi',
        words: 6,
        min_length: 4,
        max_length: 8,
        separator: '.'
      )
    end
  end
end

RSpec.describe XKPassword::ConfigFile, '#load with unsupported keys' do
  it 'rejects unsupported config keys' do
    Dir.mktmpdir do |dir|
      config_file = described_class.new(File.join(dir, '.xkpassword'))
      File.write(config_file.path, "dictionary: custom.txt\n")

      expect { config_file.load }
        .to raise_error(XKPassword::ConfigFile::Error, /Unsupported config option/)
    end
  end
end

RSpec.describe XKPassword::ConfigFile, '#load with non-mapping yaml' do
  it 'rejects non-mapping yaml content' do
    Dir.mktmpdir do |dir|
      config_file = described_class.new(File.join(dir, '.xkpassword'))
      File.write(config_file.path, "- wifi\n")

      expect { config_file.load }
        .to raise_error(XKPassword::ConfigFile::Error, /must contain a YAML mapping/)
    end
  end
end

RSpec.describe XKPassword::ConfigFile, '#init!' do
  it 'writes a commented starter config file' do
    Dir.mktmpdir do |dir|
      config_path = File.join(dir, '.xkpassword')
      config_file = described_class.new(config_path)

      config_file.init!

      expect(File.read(config_path)).to include('# preset: wifi')
      expect(File.read(config_path)).to include('# case_transform: capitalize')
    end
  end

  it 'does not overwrite an existing config file' do
    Dir.mktmpdir do |dir|
      config_path = File.join(dir, '.xkpassword')
      config_file = described_class.new(config_path)
      File.write(config_path, "preset: security\n")

      expect { config_file.init! }
        .to raise_error(XKPassword::ConfigFile::Error, /already exists/)
    end
  end
end
