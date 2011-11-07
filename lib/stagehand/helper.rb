module Stagehand
  module Helper
    def current_user
      if Stagehand.access_token
        @current_user ||= Stagehand::Account.new
      end
    end
  end
end
