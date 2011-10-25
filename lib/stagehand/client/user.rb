module Stagehand
  class Client
    # Methods for users
    module User
      def profile
        response = HTTParty.get(Stagehand.config.resource_host + "/profile.json")
      end
    end
  end
end
