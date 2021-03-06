module Stagehand
  class Client
    # Methods for OAuth 2.0 authentication
    module OAuth
      # URL used for initial OAuth login and authorization
      def authorize_url(link)
        Stagehand.config.resource_host + "/oauth/authorize?client_id=#{Stagehand.config.client_id}&client_secret=#{Stagehand.config.client_secret}&redirect_uri=#{Stagehand.config.client_host}/callback&link_url=#{link}"
      end

      def access_token_url
        Stagehand.config.resource_host + "/oauth/access_token"
      end

      def redirect_uri
        Stagehand.config.client_host + "/callback"
      end
    end
  end
end
