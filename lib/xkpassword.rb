module XKPassword
  def self.generate(options = nil)
    generator = XKPassword::Generator.new
    generator.generate(options)
  end
end

require 'xkpassword/version'
require 'xkpassword/generator'


