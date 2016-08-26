module XKPassword

  # Generates a random password by intializing a `XKPassword::Generator` instance.
  # This accepts argumennts identcal to the above class.
  #
  # If you are to generate multiple passwords (batch process lets say), you might as well directly
  # use the `XKPassword::Generator` class as it will be faster since it will only need to load
  # the dictionary once.
  #
  # @param [Hash] options The options to populate a generator
  # @option options [Integer] :words      The number of words to include in the generated password
  # @option options [String]  :separator  The separator symbol to use joining words used in password
  # @option options [Integer] :min_length The minimum length of a word to be used in the process
  # @option options [Integer] :max_length The maximum length of a word to be used in the process
  def self.generate(options = nil)
    generator = XKPassword::Generator.new
    generator.generate(options)
  end

end

require 'xkpassword/version'
require 'xkpassword/generator'


