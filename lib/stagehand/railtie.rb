require 'rails'

class Stagehand::Railtie < Rails::Railtie
  config.stagehand = ActiveSupport::OrderedOptions.new

  initializer "staghand.configure" do |app|
    Stagehand.configure do |config|
      config.client_id = app.config.stagehand[:client_id]
      config.client_secret = app.config.stagehand[:client_secret]
      config.resource_host = app.config.stagehand[:resource_host]
      config.client_host = app.config.stagehand[:client_host]
    end
  end
end
