# frozen_string_literal: true

# Public entrypoint for generating XKPassword passphrases.
module XKPassword
  # Generates a random password by intializing a `XKPassword::Generator` instance.
  # This accepts argumennts identcal to the above class.
  #
  # If you are to generate multiple passwords (batch process lets say), you might as well directly
  # use the `XKPassword::Generator` class as it will be faster since it will only need to load
  # the dictionary once.
  #
  # Presets provide named defaults for common password styles, and any explicit options passed to
  # this method override the selected preset.
  #
  # @param [Hash] options The options to populate a generator
  # @option options [String, Symbol] :preset The preset to use. Supports `:xkcd`, `:web32`,
  #                                          `:wifi`, `:security`, and `:apple_id`.
  #                                          Defaults to `:xkcd`.
  #                                          - `:xkcd` uses 4 words of 4..8 letters joined by `-`
  #                                          - `:web32` uses 4 words of 4..5 letters joined by `-`
  #                                          - `:wifi` uses 6 words of 4..8 letters joined by `-`
  #                                          - `:security` uses 6 lowercase words of 4..8 letters joined by spaces
  #                                          - `:apple_id` uses 3 words of 4..7 letters joined by `-`
  # @option options [Integer] :words      The number of words to include in the generated password
  # @option options [String]  :separator  The separator symbol to use joining words used in password
  # @option options [Integer] :min_length The minimum length of a word to be used in the process
  # @option options [Integer] :max_length The maximum length of a word to be used in the process
  # @option options [String, Symbol] :case_transform The transform to apply to every generated word
  #
  # @example Generate with the default preset
  #   XKPassword.generate
  #
  # @example Generate with a preset and override one of its defaults
  #   XKPassword.generate(preset: :apple_id, separator: '.')
  def self.generate(options = nil)
    generator = XKPassword::Generator.new
    generator.generate(options)
  end
end

require 'xkpassword/version'
require 'xkpassword/generator'
