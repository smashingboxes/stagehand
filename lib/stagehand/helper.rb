module Stagehand
  module Helper
    def current_user
      if Stagehand.access_token
        @current_user ||= Stagehand::Account.new
      end
    end
    def log_out_link(text)
      html = "<a href=\"#\" id=\"log_out\">#{text}</a>"
      html
    end
  end
end
