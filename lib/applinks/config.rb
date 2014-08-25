module Applinks
  class Config
    attr_accessor :debug
    attr_accessor :defaults

    @@configuration = Applinks::Config.new

    def Config
      @defaults = {}
    end

    def self.config
      yield @@configuration if block_given?
      @@configuration
    end


  end
end