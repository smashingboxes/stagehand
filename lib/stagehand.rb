require 'active_support/core_ext/hash/indifferent_access'
require 'active_model'
require 'httparty'
require 'multi_json'
require 'stagehand/account'
require 'stagehand/client'
require 'stagehand/rack/middleware'
require 'stagehand/railtie' if defined? ::Rails::Railtie
require 'stagehand/version'

module Stagehand
  mattr_accessor :access_token

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
    def new(options={})
      Stagehand::Client.new(options)
    end

    # Delegate to Stagehand::Client
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end
  end
end
