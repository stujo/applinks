module Applinks
  class Engine < ::Rails::Engine
    isolate_namespace Applinks
    initializer "applinks" do |app|
      ::ApplicationHelper.send :include, Applinks::ApplicationHelper
    end
  end
end
