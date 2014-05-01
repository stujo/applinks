module Applinks
  module ApplicationHelper
    def applinks(data = {}, template = 'applinks/head')
      builder = Applinks::Builder.new(Applinks::Config.config, data)
      render(:partial => template,
             :locals => {applinks_builder: builder})
    end

  end
end
