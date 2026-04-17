# frozen_string_literal: true

require 'optparse'
require 'artii'

require 'xkpassword'
require 'xkpassword/config_file'

module XKPassword
  # Command-line entrypoint for the xkpassword executable.
  class CLI
    INFO_MESSAGE = <<~TEXT.freeze
      #{Artii::Base.new(font: 'standard').asciify('XKPassword')}
      by Ziyan Junaideen

      How many times have you changed your password just because you forgot it?
      Well, you are not alone. In todays security requirements, passwords need
      to be secure and difficult to break. Passwords need to be secure, sure,
      but they can also be easy to remember. Follow up this XKCD article for more
      information - http://xkcd.com/936/

      This does exactly what the picture predicts. You can use this in your Ruby
      applications (Ex: Rails, Sinatra) or standalone if you install the gem (as
      you have done here).

      Wish you all the best keeping things secure.

      Ziyan Junaideen
      ziyan@jdeen.com
    TEXT

    def initialize(argv = ARGV, stdout: $stdout, stderr: $stderr, env: ENV)
      @argv = argv.dup
      @stdout = stdout
      @stderr = stderr
      @config_file = XKPassword::ConfigFile.new(XKPassword::ConfigFile.default_path(env))
      @options = {}
    end

    def run
      option_parser.parse!(@argv)

      return initialize_config if @options[:init]
      return write_special_output if special_output?

      options = @config_file.load.merge(@options)
      write_line(XKPassword.generate(options))
    rescue OptionParser::ParseError, XKPassword::ConfigFile::Error, ArgumentError => e
      @stderr.puts(e.message)
      1
    end

    private

    def option_parser
      @option_parser ||= OptionParser.new do |opts|
        opts.banner = 'Usage: xkpassword [options]'

        add_command_options(opts)
        add_generation_options(opts)
      end
    end

    def add_command_options(opts)
      opts.on('-v', '--version', 'Gem version') { @options[:version] = true }
      opts.on('-i', '--info', 'Gem info') { @options[:info] = true }
      opts.on('--init', "Create #{@config_file.path} with commented defaults") { @options[:init] = true }
      opts.on('-h', '--help', 'Show help') { @options[:help] = true }
    end

    def add_generation_options(opts)
      add_numeric_generation_options(opts)
      add_text_generation_options(opts)
    end

    def add_numeric_generation_options(opts)
      opts.on(
        '--words [INTEGER]',
        'Number of words to use in the generated password'
      ) { |words| @options[:words] = words.to_i }
      opts.on('--min-length [INTEGER]', 'Minimum length of a word') { |min| @options[:min_length] = min.to_i }
      opts.on('--max-length [INTEGER]', 'Maximum length of a word') { |max| @options[:max_length] = max.to_i }
    end

    def add_text_generation_options(opts)
      opts.on(
        '--separator [STRING]',
        'The separator between generated words'
      ) { |separator| @options[:separator] = separator }
      opts.on(
        '--case-transform [STRING]',
        'Transform each word using upcase, downcase, or capitalize'
      ) { |case_transform| @options[:case_transform] = case_transform }
      add_preset_option(opts)
    end

    def add_preset_option(opts)
      opts.on(
        '--preset [STRING]',
        'Preset to use: xkcd, web32, wifi, security, or apple_id'
      ) { |preset| @options[:preset] = preset }
    end

    def special_output?
      @options[:help] || @options[:info] || @options[:version]
    end

    def write_special_output
      write_line(option_parser) if @options[:help]
      write_line(INFO_MESSAGE) if @options[:info]
      write_line(XKPassword::VERSION) if @options[:version]
      0
    end

    def initialize_config
      path = @config_file.init!
      write_line("Created #{path}")
    end

    def write_line(message)
      @stdout.puts(message)
      0
    end
  end
end
