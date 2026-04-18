# frozen_string_literal: true

require 'xkpassword/words'

module XKPassword
  # Builds passphrases from the bundled word list.
  #
  # Presets provide convenient defaults for common password styles, and callers can
  # override any preset-derived value by passing explicit generation options.
  #
  # @attr_reader [XKPassword::Words] words A word database that can provide words for the
  #   requested length.
  class Generator
    # The preset used when `:preset` is omitted.
    DEFAULT_PRESET = :xkcd

    # Built-in password presets.
    #
    # - `:xkcd` generates 4 words between 4 and 8 letters separated by `-`, preserving the gem's
    #   original default behavior.
    # - `:web32` generates 4 shorter words between 4 and 5 letters separated by `-`.
    # - `:wifi` generates 6 words between 4 and 8 letters separated by `-`.
    # - `:security` generates 6 lowercase words between 4 and 8 letters separated by spaces.
    # - `:apple_id` generates 3 words between 4 and 7 letters separated by `-`.
    PRESETS = {
      xkcd: {
        case_transform: nil,
        max_length: 8,
        min_length: 4,
        separator: '-',
        words: 4
      },
      web32: {
        case_transform: nil,
        max_length: 5,
        min_length: 4,
        separator: '-',
        words: 4
      },
      wifi: {
        case_transform: nil,
        max_length: 8,
        min_length: 4,
        separator: '-',
        words: 6
      },
      security: {
        case_transform: :downcase,
        max_length: 8,
        min_length: 4,
        separator: ' ',
        words: 6
      },
      apple_id: {
        case_transform: nil,
        max_length: 7,
        min_length: 4,
        separator: '-',
        words: 3
      }
    }.freeze
    VALID_CASE_TRANSFORMS = %i[upcase downcase capitalize].freeze

    attr_reader :words

    def initialize
      @words = XKPassword::Words.new
    end

    # Generates a password absed on the configuration provided.
    # A preset supplies a base configuration and any explicit options passed in `options` override
    # those preset defaults.
    #
    # @param [Hash] options The options to populate a generator
    # @option options [String, Symbol] :preset The preset to use. Supports `:xkcd`, `:web32`,
    #                                          `:wifi`, `:security`, and `:apple_id`.
    #                                          String values like `"apple_id"` and `"apple-id"`
    #                                          are normalized to `:apple_id`. Defaults to `:xkcd`.
    # @option options [Integer] :words      The number of words to include in the generated password
    # @option options [String]  :separator  The separator symbol to use joining words used in password
    # @option options [Integer] :min_length The minimum length of a word to be used in the process
    # @option options [Integer] :max_length The maximum length of a word to be used in the process
    # @option options [String, Symbol] :case_transform The transform to apply to every generated word
    #
    # @return [String]                      The generated password
    #
    # @example Using the default xkcd preset
    #   generator = XKPassword::Generator.new
    #   generator.generate
    #
    # @example Using the security preset
    #   generator = XKPassword::Generator.new
    #   generator.generate(preset: :security)
    #
    # @example Populating the method with a preset and explicit overrides
    #   options = {
    #     preset: :security,
    #     separator: ' ',
    #     words: 6,
    #     min_length: 4,
    #     max_length: 8,
    #     case_transform: :downcase
    #   }
    #
    #   generator = XKPassword::Generator.new
    #   generator.generate(options)
    #
    # @example Built-in preset defaults
    #   :xkcd     # 4 words, 4..8 letters, "-" separator, random per-word uppercasing
    #   :web32    # 4 words, 4..5 letters, "-" separator, random per-word uppercasing
    #   :wifi     # 6 words, 4..8 letters, "-" separator, random per-word uppercasing
    #   :security # 6 words, 4..8 letters, " " separator, lowercase
    #   :apple_id # 3 words, 4..7 letters, "-" separator, random per-word uppercasing
    def generate(options = nil)
      resolved_options = resolve_options(options)
      generated_words = build_words(resolved_options)

      generated_words.join(resolved_options[:separator])
    end

    private

    def resolve_options(options)
      normalized_options = (options || {}).dup
      preset = normalize_preset(normalized_options.delete(:preset))

      PRESETS.fetch(preset).merge(normalized_options)
    end

    def build_words(options)
      case_transform = normalize_case_transform(options[:case_transform])
      length_values = (options[:min_length]..options[:max_length]).to_a

      options[:words].times.map do
        word = words.random(length_values.sample)
        transform_word(word, case_transform)
      end
    end

    def transform_word(word, case_transform)
      return randomly_upcase(word) unless case_transform

      word.public_send(case_transform)
    end

    def randomly_upcase(word)
      upcase = [true, false].sample
      word = word.upcase if upcase
      word
    end

    def normalize_case_transform(case_transform)
      return nil if case_transform.nil?

      case_transform = case_transform.to_sym if case_transform.is_a?(String)

      return case_transform if VALID_CASE_TRANSFORMS.include?(case_transform)

      raise ArgumentError, "case_transform should be one of: #{VALID_CASE_TRANSFORMS.join(', ')}"
    end

    def normalize_preset(preset)
      return DEFAULT_PRESET if preset.nil?

      preset = preset.strip.downcase.tr(' -', '_').to_sym if preset.is_a?(String)

      return preset if PRESETS.key?(preset)

      raise ArgumentError, "preset should be one of: #{PRESETS.keys.join(', ')}"
    end
  end
end
