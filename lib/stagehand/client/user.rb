module Stagehand
  class Client
    # Methods for users
    module User
      def register_url
        Stagehand.config.resource_host + "/register?client_id=#{Stagehand.config.client_id}&redirect_uri=#{Stagehand.config.client_host}/callback"
      end

      def logout_url
        Stagehand.config.resource_host + "/logout?redirect_uri=#{Stagehand.config.client_host}"
      end
    end
  end
end
