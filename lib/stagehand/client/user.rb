module Stagehand
  class Client
    # Methods for users
    module User
      def account
        response = HTTParty.get(Stagehand.config.resource_host + "/profile.json", :query => {:oauth_token => Stagehand.access_token})
        MultiJson.decode(response.body)
      end

      def register_url
        Stagehand.config.resource_host + "/register?client_id=#{Stagehand.config.client_id}&redirect_uri=#{Stagehand.config.client_host}/callback"
      end

      def logout_url
        Stagehand.config.resource_host + "/logout?redirect_uri=#{Stagehand.config.client_host}"
      end
    end
  end
end
