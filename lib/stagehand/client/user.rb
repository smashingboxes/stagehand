module Stagehand
  class Client
    include HTTParty

    # Methods for users
    module User
      def profile
        response = get(Stagehand.config.resource_host + "/profile.json")
      end
    end
  end
end
