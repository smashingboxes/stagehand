module Stagehand::Rack
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      request = env['stagehand'] = Rack::Request.new(env)

      response = catch :stagehand do
        if request.path == '/callback'
          token_response = HTTParty.post(Stagehand.access_token_url, :body => {
                                     :client_id => Stagehand.config.client_id, 
                                     :client_secret => Stagehand.config.client_secret, 
                                     :redirect_uri => Stagehand.redirect_uri, 
                                     :code => request.params['code'],
                                     :grant_type => 'authorization_code'}
                                   )
          # session[:access_token] = token_response["access_token"]
          # redirect_to root_url
          [200, {"Content-Type" => "text/html"}, [request.params['code']]]
        else
          @app.call(env)
        end
      end
    rescue InvalidRequest => e
      [400, {}, e.message]
    end
  end

  class InvalidRequest < StandardError
  end
end
