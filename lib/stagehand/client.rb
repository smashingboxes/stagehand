module Stagehand
  # Wrapper for Personas REST API
  class Client
    require 'stagehand/client/oauth'
    include Stagehand::Client::OAuth
  end
end
