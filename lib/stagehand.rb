require 'active_support/core_ext/module/attribute_accessors'
require 'httparty'
require 'multi_json'
require 'stagehand/client'
require 'stagehand/helper'
require 'stagehand/rack/middleware'
require 'stagehand/railtie' if defined? ::Rails::Railtie
require 'stagehand/account'
require 'stagehand/version'

module Stagehand
  mattr_accessor :access_token, :client_token, :current_profile


  class Config
    attr_accessor :client_id, :client_secret, :client_host, :resource_host
  end

  class << self
    def config
      @@config ||= Config.new
    end

    def configure
      yield self.config
    end

    # return Stagehand::Client
    def new
      Stagehand::Client.new
    end

    # Delegate to Stagehand::Client
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end
  end
end
