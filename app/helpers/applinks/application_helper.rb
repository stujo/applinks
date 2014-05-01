module Applinks
  module ApplicationHelper
    def demo_data
      {
          ios: {
              url: 'applinks://docs',
              app_store_id: '12345',
              app_name: 'App Links'
          },
          android: {
              url: 'applinks://docs',
              package: 'org.applinks',
              app_name: 'App Links'
          }
      }
    end
    def applinks(data = demo_data, template = 'applinks/head')
      builder = Applinks::Builder.new(Applinks::Config.config, data)
      render(:partial => template,
             :locals => {applinks_builder: builder})
    end

  end
end
