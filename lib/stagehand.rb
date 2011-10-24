require 'httparty'
require 'yajl'
require 'stagehand/rack/middleware'
require 'stagehand/railtie' if defined? ::Rails::Railtie
require 'stagehand/version'

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

  def self.access_token_url
    config.resource_host + "/oauth/access_token"
  end

  def self.redirect_uri
    config.client_host + "/callback"
  end

  def self.logout_url
    config.resource_host + "/logout?redirect_uri=#{config.client_host}"
  end

  def self.access_token
    request = ActionDispatch::Request.new(env)
    request.cookie_jar.signed[:user_id]
    session[:access_token]
  end

  def self.get_with_access_token(path, params)
    params[:oauth_token] = access_token
    HTTParty.get(config.resource_host + path, query: params)
  end

end
