require 'yajl'
require 'stagehand/version'
require 'stagehand/railtie' if defined? ::Rails::Railtie

module Stagehand
  class Config
    attr_accessor :client_id, :client_secret, :client_host, :resource_host
  end

  def self.config
    @@config ||= Config.new
  end

  def self.configure
    yield self.config
  end

  def initialize(attributes)
    @attributes = attributes
  end

  def self.authorize_url
    config.resource_host + "/oauth/authorize?client_id=#{config.client_id}&client_secret=#{config.client_secret}&redirect_uri=#{config.client_host}/callback"
  end
end
