module Applinks
  class Builder
    def initialize config, data
      @config = config
      @data = data
    end

    def ios &block
      app_block :ios, IOSBlock do |data|
        yield data
      end
    end

    def ipad &block
      app_block :ipad, IOSBlock do |data|
        yield data
      end
    end

    def iphone &block
      app_block :iphone, IOSBlock do |data|
        yield data
      end
    end

    def android &block
      app_block :android, AndroidBlock do |data|
        yield data
      end
    end

    def windows_phone &block
      app_block :windows_phone, WindowsPhoneBlock do |data|
        yield data
      end
    end

    def web &block
      app_block :web, WebBlock do |data|
        yield data
      end
    end

    private
    def arrayize_data key
      arrayData = @data[key]

      if arrayData.instance_of? Hash
        [arrayData]
      elsif arrayData.nil?
        []
      else
        arrayData
      end
    end

    def app_block key, block_class
      if block_given?
        if @data.has_key? key
          suppliedAppData = arrayize_data(key)
          suppliedAppData.each do |versionData|
            appData = block_class.new versionData, suppliedAppData.length > 1
            if appData.valid?
              yield appData
            end
          end
        end
      end
    end

    class MetaBlock
      def initialize hsh
        @hash = hsh
      end

      def url
        @hash[:url]
      end
    end

    class AppBlock < MetaBlock
      attr_reader :versioned

      def initialize hsh, versioned
        super(hsh)
        @versioned = versioned
      end

      def app_name
        @hash[:app_name]
      end
    end

    class IOSBlock < AppBlock
      def initialize hsh, versioned
        super
      end

      def app_store_id
        @hash[:app_store_id]
      end

      def valid?
        !url.nil?
      end
    end
    class AndroidBlock < AppBlock
      def initialize hsh, versioned
        super
      end

      def package
        @hash[:package]
      end

      def valid?
        !package.nil?
      end
    end
    class WindowsPhoneBlock < AppBlock
      def initialize hsh, versioned
        super
      end
      def app_id
        @hash[:app_id]
      end
      def valid?
        !url.nil?
      end
    end
    class WebBlock < MetaBlock
      def initialize hsh, _unused
        super(hsh)
        @should_fallback = hsh.has_key?(:should_fallback) ? hsh[:should_fallback] : true
      end

      def should_fallback?
        @should_fallback
      end

      def valid?
        !should_fallback? || !url.nil?
      end
    end
  end
end