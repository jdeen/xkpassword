# frozen_string_literal: true

require 'stringio'
require 'tmpdir'

require 'xkpassword/cli'

RSpec.describe XKPassword::CLI, '--init' do
  let(:stdout) { StringIO.new }
  let(:stderr) { StringIO.new }

  it 'initializes a commented config file with --init' do
    Dir.mktmpdir do |home|
      env = { 'HOME' => home }
      status = described_class.new(['--init'], stdout: stdout, stderr: stderr, env: env).run

      expect(status).to eq(0)
      expect(File.read(File.join(home, '.xkpassword'))).to include('# Global defaults for the xkpassword CLI.')
      expect(stdout.string).to include(File.join(home, '.xkpassword'))
    end
  end
end

RSpec.describe XKPassword::CLI, 'config defaults' do
  let(:stdout) { StringIO.new }
  let(:stderr) { StringIO.new }

  it 'uses config values as defaults and lets flags override them' do
    Dir.mktmpdir do |home|
      File.write(File.join(home, '.xkpassword'), <<~YAML)
        preset: security
        words: 6
        separator: "."
      YAML

      allow(XKPassword).to receive(:generate).and_return('alpha-bravo')

      status = described_class.new(
        ['--words', '4', '--separator', '-'],
        stdout: stdout,
        stderr: stderr,
        env: { 'HOME' => home }
      ).run

      expect(status).to eq(0)
      expect(XKPassword).to have_received(:generate).with(
        preset: 'security',
        words: 4,
        separator: '-'
      )
      expect(stdout.string).to eq("alpha-bravo\n")
    end
  end
end

RSpec.describe XKPassword::CLI, 'invalid config' do
  let(:stdout) { StringIO.new }
  let(:stderr) { StringIO.new }

  it 'reports config errors on stderr' do
    Dir.mktmpdir do |home|
      File.write(File.join(home, '.xkpassword'), "words: many\n")

      status = described_class.new([], stdout: stdout, stderr: stderr, env: { 'HOME' => home }).run

      expect(status).to eq(1)
      expect(stderr.string).to include('words')
    end
  end
end
