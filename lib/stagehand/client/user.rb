module Stagehand
  class Client
    # Methods for users
    module User
      def account
        response = HTTParty.get(Stagehand.config.resource_host + "/profile.json", :query => {:oauth_token => Stagehand.access_token})
        MultiJson.decode(response.body)
      end

      def register_url
        Stagehand.config.resource_host + "/register"
      end
    end
  end
end
