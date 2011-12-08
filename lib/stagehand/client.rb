module Stagehand
  # Wrapper for Personas REST API
  class Client
    require 'stagehand/client/account'
    require 'stagehand/client/oauth'
    require 'stagehand/client/person'
    require 'stagehand/client/request'
    require 'stagehand/client/user'
    include Stagehand::Client::Account
    include Stagehand::Client::OAuth
    include Stagehand::Client::Person
    include Stagehand::Client::Request
    include Stagehand::Client::User
  end
end
