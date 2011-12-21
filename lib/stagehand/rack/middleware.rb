require 'addressable/uri'

module Stagehand::Rack
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      request = env['stagehand'] = Rack::Request.new(env)

      response = catch :stagehand do
        # Make sure Stagehand.access_token is always the current session
        Stagehand.access_token = env['rack.session'][:access_token]
        case request.path
        when '/sign_in'
          # redirect to OAuth login
          [302, {'Location'=>Stagehand.authorize_url}, []]
        when '/callback'
          # process OAuth token
          token_response = HTTParty.post(Stagehand.access_token_url, :body => {
            :client_id => Stagehand.config.client_id, 
            :client_secret => Stagehand.config.client_secret,
            :redirect_uri => Stagehand.redirect_uri, 
            :code => request.params['code'],
            :grant_type => 'authorization_code'}
          )
          # set cookie and access_token
          Stagehand.access_token = env['rack.session'][:access_token] = token_response["access_token"]
          if request.params['link_url'].present? && request.params['message'].present?
            params = {:message => request.params['message']}
            [302, {'Location'=> append_to_uri(request.params['link_url'],params)}, []]
          else
            [302, {'Location'=>'/'}, []]
          end
        when '/log_out'
          # clear cookie and access_token
          env['rack.session'] = nil
          # redirect to root
          [302, {'Location'=>'/'}, []]
        when '/change_password'
          change_password
        when '/register_user'
          response = Stagehand.register(request.params['email'],request.params['password'])
          if response == {"success"=>"true"}
            # Created a new user, now to log in...
            options = {:url => Stagehand.config.client_host}
            options[:email] = request.params['email']
            options[:message] = "Thank you for registering."
            response = Stagehand.login_token(request.params['email'], options)
            [302, {'Location'=>Stagehand.go(response['token'])}, []]
          elsif response == {"email"=>["is already taken"]}
            params = {:message => "Email address is already taken. If you have forgotten your password, please fill out this form:"}
            url = Stagehand.config.resource_host + "/password_resets/new"
            [302, {'Location'=> append_to_uri(url,params)}, []]
          end
        when /\/go\/(.+)$/
          [302, {'Location'=>Stagehand.go($1)}, []]
        when '/env'
          [200,{"Content-Type"=> "text/html"}, [env.inspect]]
        else
          @app.call(env)
        end
      end
    rescue InvalidRequest => e
      [400, {}, e.message]
    end


    private

    def change_password
      token = Stagehand.password_token
      if token.empty?
        [302, {'Location'=>Stagehand.authorize_url}, []]
      else
        [302, {'Location'=>Stagehand.change_password_url(token)}, []]
      end
    end

    def append_to_uri(uri, parameters = {})
      u = Addressable::URI.parse(uri)
      u.query_values = (u.query_values || {}).merge(parameters)
      u.to_s
    end
  end


  class InvalidRequest < StandardError
  end
end
