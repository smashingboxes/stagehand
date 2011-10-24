module Stagehand::Rack
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      request = env['stagehand'] = ResourceRequest.new(env)

      response = catch :stagehand do
        if request.path == '/callback'
          params = Rack::Utils.parse_query(env['rack.input'].read, "&")
          response = HTTParty.post(access_token_url, :body => {
                                     :client_id => config.client_id, 
                                     :client_secret => config.client_secret, 
                                     :redirect_uri => redirect_uri, 
                                     :code => params["code"],
                                     :grant_type => 'authorization_code'}
                                   )
          # session[:access_token] = response["access_token"]
          # redirect_to root_url
          puts response["access_token"]
        else
          @app.call(env)
        end
      end
    rescue InvalidRequest => e
      [400, {}, e.message]
    end
  end
end
