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

      # Public: Generates a login token on the resource server
      #
      # email   - The email address for the person/account to login
      # options - The Hash options used to refine the selection (default: {}):
      #   :expired_message  - message to show when token is expired (optional).
      #   :message          - message to show upon following the link (optional).
      #   :new_user_message - message to show to new users (optional).
      #   :role             - role to add to account (optional).
      #   :url              - destination url (optional).
      #
      # Examples
      #
      #   login_token("test@example.com", 4)
      #   # => "yXsVOBYv0XPLi4-nOTXcLQ"
      #
      # Returns a login token
      def login_token(email, options = {})
        params = { :login_link => options }
        params[:login_link][:email] = email
        post_with_access_token("/login_links", params)
      end

      def password_token
        params = {:redirect_uri => Stagehand.config.client_host}
        get_with_access_token("/generate_password_reset_token", params)
      end
      
      def change_password_url(token)
        Stagehand.config.resource_host + "/password_resets/#{token}/edit" + "?redirect_uri=#{Stagehand.config.client_host}"
      end

      def go(token)
        Stagehand.config.resource_host + "/go/" + token + "?client_id=#{Stagehand.config.client_id}&client_secret=#{Stagehand.config.client_secret}&redirect_uri=#{Stagehand.config.client_host}/callback"
      end

      # Public: Registers a new user
      #
      # email    - user's email
      # password - user's password
      #
      # Examples
      #
      #   register("test@example.com", "foo")
      #
      # Logs a new user in or redirects to the remember password page 
      # if that user already exists.
      def register(email, password)
        params = {:account => {:email => email, :password => password, :password_confirmation => password}, :client_id => Stagehand.config.client_id}
        url = Stagehand.config.resource_host + "/accounts"
        headers = { 'Accept' => 'application/json' }
        response = HTTParty.post(url, body: params, headers: headers).parsed_response
      end
    end
  end
end
