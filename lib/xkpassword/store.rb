class XKPassword::Store
  SOURCE = 'google-10000-english.txt'

  attr_reader :data

  def initialize
    load_data
  end

  private

  def load_data
    path = "#{ File.dirname(__FILE__) }/data/#{ SOURCE }"
    @data = IO.readlines(path).map{ |item| item.delete("\n") }
  end
end
