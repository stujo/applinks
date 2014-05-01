module Applinks
  module Config
    @@configuration = {}

    def self.config
      yield @@configuration if block_given?
      @@configuration
    end
  end
end