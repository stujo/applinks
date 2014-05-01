module Applinks
  class Config
    attr_accessor :debug
    @@configuration = Applinks::Config.new

    def self.config
      yield @@configuration if block_given?
      @@configuration
    end


  end
end