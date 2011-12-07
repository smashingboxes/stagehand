module Stagehand
  module Helper
    def current_user
      @current_user ||= Stagehand::Account.new
    end

    def logged_in?
      return true if Stagehand.access_token
    end

    def log_out_link(text)
      html = "<a href=\"#\" id=\"log_out\">#{text}</a>"
      html
    end
  end
end
