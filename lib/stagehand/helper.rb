module Stagehand
  module Helper
    def current_user
      if Stagehand.access_token
        @current_user ||= Stagehand.get_with_access_token("/profile.json", { page: 1 }).parsed_response
      end
    end
  end
end
