module Stagehand
  # Wrapper for Personas REST API
  class Client
    include HTTParty

    require 'stagehand/client/oauth'
    require 'stagehand/client/user'

    include Stagehand::Client::OAuth
    include Stagehand::Client::User
  end
end
