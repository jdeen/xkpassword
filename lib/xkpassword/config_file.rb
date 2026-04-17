# frozen_string_literal: true

require 'psych'

module XKPassword
  # Loads and initializes the CLI config file stored at ~/.xkpassword.
  class ConfigFile
    Error = Class.new(StandardError)

    ALLOWED_OPTIONS = %i[
      preset
      words
      min_length
      max_length
      separator
      case_transform
    ].freeze
    INTEGER_OPTIONS = %i[words min_length max_length].freeze
    TEMPLATE = <<~YAML
      # Global defaults for the xkpassword CLI.
      # Remove the leading "#" from any setting you want to enable.
      #
      # Supported keys:
      #   preset: xkcd, web32, wifi, security, apple_id
      #   words: integer
      #   min_length: integer
      #   max_length: integer
      #   separator: string
      #   case_transform: upcase, downcase, capitalize
      #
      # Example:
      # preset: wifi
      # words: 6
      # min_length: 4
      # max_length: 8
      # separator: "-"
      # case_transform: capitalize
    YAML

    attr_reader :path

    def initialize(path = self.class.default_path)
      @path = path
    end

    def self.default_path(env = ENV)
      home = env['HOME'] || Dir.home
      File.expand_path('.xkpassword', home)
    end

    def load
      return {} unless File.exist?(path)

      data = Psych.safe_load(File.read(path), aliases: false)
      return {} if data.nil?
      raise Error, "#{path} must contain a YAML mapping of options" unless data.is_a?(Hash)

      normalize_options(data)
    rescue Psych::SyntaxError => e
      raise Error, "Could not parse #{path}: #{e.message}"
    end

    def init!
      raise Error, "#{path} already exists" if File.exist?(path)

      File.write(path, TEMPLATE)
      path
    end

    private

    def normalize_options(data)
      data.each_with_object({}) do |(key, value), normalized|
        normalized_key = normalize_key(key)

        unless ALLOWED_OPTIONS.include?(normalized_key)
          raise Error, "Unsupported config option #{key.inspect} in #{path}"
        end

        normalized[normalized_key] = normalize_value(normalized_key, value)
      end
    end

    def normalize_key(key)
      key.to_s.strip.downcase.tr(' -', '_').to_sym
    end

    def normalize_value(key, value)
      return normalize_integer(key, value) if INTEGER_OPTIONS.include?(key)

      return value if value.nil? || value.is_a?(String) || value.is_a?(Symbol)

      raise Error, "#{key} in #{path} should be a string or left unset"
    end

    def normalize_integer(key, value)
      integer_value = value.is_a?(String) ? Integer(value, 10) : value
      return integer_value if integer_value.is_a?(Integer)

      raise Error, "#{key} in #{path} should be an integer"
    rescue ArgumentError, TypeError
      raise Error, "#{key} in #{path} should be an integer"
    end
  end
end
