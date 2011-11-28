module Stagehand
  class Client
    # Methods for OAuth 2.0 authentication
    module OAuth
      # URL used for initial OAuth login and authorization
      def authorize_url
        Stagehand.config.resource_host + "/oauth/authorize?client_id=#{Stagehand.config.client_id}&client_secret=#{Stagehand.config.client_secret}&redirect_uri=#{Stagehand.config.client_host}/callback"
      end

      def access_token_url
        Stagehand.config.resource_host + "/oauth/access_token"
      end

      def redirect_uri
        Stagehand.config.client_host + "/callback"
      end

      def get_with_access_token(path, params = {})
        params[:oauth_token] = Stagehand.access_token
        HTTParty.get(Stagehand.config.resource_host + path, query: params)
      end

      def password_token
        params = {}
        params[:redirect_uri] = Stagehand.config.client_host
        get_with_access_token("/generate_password_reset_token", params).body
      end
      
      def change_password_url(token)
        Stagehand.config.resource_host + "/password_resets/#{token}/edit" + "?redirect_uri=#{Stagehand.config.client_host}"
      end
    end
  end
end
