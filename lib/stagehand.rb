require 'yajl'
require 'stagehand/version'

class Stagehand::Client
  def initialize(attributes)
    @attributes = attributes
    @client_id = @attributes[:client_id]
    @client_secret = @attributes[:client_secret]
    @resource_host = @attributes[:resource_host]
    @client_host = @attributes[:client_host]
  end

  def authorize_url
    @resource_host + "/oauth/authorize?client_id=#{@client_id}&client_secret=#{@client_secret}&redirect_uri=#{@client_host}/callback"
  end
end
