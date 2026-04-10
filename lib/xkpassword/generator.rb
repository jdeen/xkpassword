require 'xkpassword/words'

# The Generator class which finds words based on the requirement and using the provided options to build a
# new random passowrd.
# 
# @attr_reader [XKPassword::Words] words  A word database that gen provide you words for the length required
class XKPassword::Generator
  DEFAULTS = {
    case_transform: nil,
    max_length: 8,
    min_length: 4,
    separator: '-',
    words: 4,
  }

  attr_reader :words

  def initialize
    @words = XKPassword::Words.new
  end

  # Generates a password absed on the configuration provided.
  #
  # @param [Hash] options The options to populate a generator
  # @option options [Integer] :words      The number of words to include in the generated password
  # @option options [String]  :separator  The separator symbol to use joining words used in password
  # @option options [Integer] :min_length The minimum length of a word to be used in the process
  # @option options [Integer] :max_length The maximum length of a word to be used in the process
  # @option options [String, Symbol] :case_transform The transform to apply to every generated word
  #
  # @return [String]                      The generated password
  #
  # @example Populating the method with all options (current default)
  #   options = {
  #     separator: ' ',
  #     words: 4,
  #     min_length: 4,
  #     max_length: 8,
  #     case_transform: :capitalize
  #   }
  #
  #   generator = XKPassword::Generator.new
  #   generator.generate(options)
  def generate(options = nil)
    options ||= {}
    options = DEFAULTS.merge(options)
    case_transform = normalize_case_transform(options[:case_transform])
    length_vals = (options[:min_length]..options[:max_length]).to_a

    data = options[:words].times.map do
      word = words.random(length_vals.sample)
      transform_word(word, case_transform)
    end
    
    data.join(options[:separator])
  end

  private

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
    valid_case_transforms = [:upcase, :downcase, :capitalize]

    return case_transform if valid_case_transforms.include?(case_transform)

    fail ArgumentError, "case_transform should be one of: #{ valid_case_transforms.join(', ') }"
  end

end
