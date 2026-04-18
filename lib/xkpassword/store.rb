# frozen_string_literal: true

module XKPassword
  class Store
    SOURCE = 'google-10000-english-no-swears.txt'

    attr_reader :data

    def initialize
      load_data
    end

    private

    def load_data
      path = "#{File.dirname(__FILE__)}/data/#{SOURCE}"
      @data = File.readlines(path).map { |item| item.delete("\n") }
    end
  end
end
