require 'xkpassword/words'

class XKPassword::Generator
  DEFAULTS = {
    max_length: 8,
    min_length: 4,
    separator: '-',
    words: 4,
  }

  attr_reader :words

  def initialize
    @words = XKPassword::Words.new
  end

  # options = {
  #   separator: ' ',
  #   words: 4,
  #   min_length: 4,
  #   max_length: 8
  # }
  #
  # generator = XKPassword::Generator.new
  # generator.generate(options)
  def generate(options)
    options = DEFAULTS.merge(options)
    length_vals = (options[:min_length]..options[:max_length]).to_a
    data = options[:words].times.map{ words.with_length(length_vals.sample) }
    data.join(options[:separator])
  end
  
end
