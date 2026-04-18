# frozen_string_literal: true

require 'xkpassword/store'

module XKPassword
  # Indexes the bundled dictionary by word length.
  #
  # @attr_reader [Hash] words A collection of words stored in a hash keyed by a
  #   normalized representation of word length.
  class Words
    attr_reader :words

    def initialize
      @words = {}
      setup
    end

    # Provide an array of words having the specified number of characters in it
    #
    # @param length   [String]      The number of characters of words should contain
    #
    # @return [Array<String>]       Words from the source that match the length requirement.
    def with_length(length)
      raise ArgumentError, 'Length should be numeric' unless length.is_a?(Numeric)

      words[key(length)]
    end

    # Provides a random word with the specified length
    #
    # @param length   [Integer]     The number of characters the word should contain
    #
    # @return [String]              A random word with length
    def random(length)
      raise ArgumentError, 'Length should be numeric' unless length.is_a?(Numeric)

      with_length(length).sample
    end

    # Provide lengths available in the databse
    #
    # @return [Array<Integer>]      A collection of lengths of words available
    def lengths
      words.keys.map { |key| key.delete('l').to_i }
    end

    # The lenght of the shortest word
    #
    # @return [Integer]             The length of the shortest word
    def min_length
      lengths.min
    end

    # The length of the longest word
    #
    # @return [Integer]             The length of the longest word
    def max_length
      lengths.max
    end

    private

    def setup
      store = XKPassword::Store.new
      data = store.data

      data.each do |datum|
        k = key(datum.length)
        words[k] = [] unless words[k]
        words[k] << datum
      end
    end

    def key(length)
      "l#{length}"
    end
  end
end
