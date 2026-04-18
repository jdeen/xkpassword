# frozen_string_literal: true

module XKPassword
  # Loads the bundled word list from disk.
  class Store
    SOURCE = 'google-10000-english-no-swears.txt'

    attr_reader :data

    def initialize
      load_data
    end

    private

    def load_data
      path = File.expand_path("data/#{SOURCE}", __dir__)
      @data = File.readlines(path, chomp: true)
    end
  end
end
