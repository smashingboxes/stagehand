module Stagehand
  class Client
    # Methods for users
    module User
      include HTTParty

      def profile
        response = get(Stagehand.config.resource_host + "/profile.json")
      end
    end
  end
end
