module Applinks
  class Builder
    def initialize config, data
      @config = config
      @data = data
    end

    def ios &block
      if @data.has_key? :ios
        appData = IOSBlock.new @data[:ios]
        yield appData if block_given?
      end
    end

    def android &block
      if @data.has_key? :android
        appData = AndroidBlock.new @data[:android]
        yield appData if block_given?
      end
    end

    def web &block
#      yield @config if block_given?
    end
  end

  class IOSBlock
    attr_reader :url, :app_store_id, :app_name
    def initialize hsh = {}
      @url = hsh[:url]
      @app_store_id = hsh[:app_store_id]
      @app_name = hsh[:app_name]
    end
  end
  class AndroidBlock
    attr_reader :url, :package, :app_name
    def initialize hsh = {}
      @url = hsh[:url]
      @package = hsh[:package]
      @app_name = hsh[:app_name]
    end
  end
end