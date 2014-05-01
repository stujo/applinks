module Applinks
  class Builder
    def initialize config, data
      @config = config
      @data = data
    end

    def ios &block
      app_block :ios, IOSBlock do |block|
        yield block
      end
    end

    def ipad &block
      app_block :ipad, IOSBlock do |block|
        yield block
      end
    end

    def iphone &block
      app_block :iphone, IOSBlock do |block|
        yield block
      end
    end

    def android &block
      app_block :android, AndroidBlock do |block|
        yield block
      end
    end

    def windows_phone &block
      app_block :windows_phone, WindowsPhoneBlock do |block|
        yield block
      end
    end

    def web &block
      app_block :web, WebBlock do |block|
        yield block
      end
    end


    private
    def app_block key, block_class
      if block_given?
        if @data.has_key? key

          suppliedAppData= @data[key]
          suppliedAppData = [@data[key]] unless suppliedAppData.instance_of? Array

          suppliedAppData.each do |versionData|
            appData = block_class.new versionData, suppliedAppData.length > 1
            if appData.valid?
              if @config.debug
                puts "Applinks: applying invalid block #{key} as #{appData.class.name} -> #{@data[key]} "
              end
              yield appData
            else
              if @config.debug
                puts "Applinks: skipping invalid block #{key} -> #{@data[key]}"
              end
            end
          end
        end
      end
    end

    class MetaBlock
      attr_reader :url

      def initialize hsh = {}
        @url = hsh[:url] if hsh.has_key?(:url)
      end

      def valid?
        false
      end
    end

    class AppBlock < MetaBlock
      attr_reader :app_name, :versioned

      def initialize hsh, versioned
        super(hsh)
        @versioned = versioned
        @app_name = hsh[:app_name] if hsh.has_key?(:app_name)
      end
    end

    class IOSBlock < AppBlock
      attr_reader :app_store_id, :app_name

      def initialize hsh, versioned
        super
        @app_store_id = hsh[:app_store_id] if hsh.has_key?(:app_store_id)
      end

      def valid?
        !@url.nil?
      end
    end
    class AndroidBlock < AppBlock
      attr_reader :package, :app_name

      def initialize hsh, versioned
        super
        @package = hsh[:package] if hsh.has_key?(:package)
      end

      def valid?
        !@package.nil?
      end
    end
    class WindowsPhoneBlock < AppBlock
      attr_reader :app_id, :app_name

      def initialize hsh, versioned
        super
        @app_id = hsh[:app_id] if hsh.has_key?(:app_id)
      end

      def valid?
        !@url.nil?
      end
    end
    class WebBlock < MetaBlock
      def initialize hsh = {}
        super
        @should_fallback = hsh.has_key?(:should_fallback) ? hsh[:should_fallback] : false
      end

      def should_fallback?
        @should_fallback
      end

      def valid?
        !@url.nil?
      end
    end
  end
end