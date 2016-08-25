require 'xkpassword/store'

class XKPassword::Words
  attr_reader :words

  def initialize
    @words = {}
    setup
  end

  def with_length(length)
    fail ArgumentError 'Length should be a numeric' unless length.is_a? Numeric
    words[key(length)]
  end

  def random(length)
    fail ArgumentError, 'Length should be numeric' unless length.is_a? Numeric
    with_length(length).sample
  end

  def lengths
    words.keys.map{ |key| gsub(/l/, '').to_i }
  end

  def min_length
    lengths.min
  end

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
    "l#{ length }"
  end
end
