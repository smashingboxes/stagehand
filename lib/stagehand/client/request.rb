module Stagehand
  class Client
    # Methods for people
    module Request
      # Public: GETs a resource with authorization
      #
      # path   - The GET path
      # params - The GET params (optional)
      #
      # Examples
      #
      #   get_with_access_token("/generate_password_reset_token", params)
      #   # => "KWg5kkjkQvhJNnTGhibJ7w"
      #
      # Returns a person JSON object
      def get_with_access_token(path, params = {})
        params[:oauth_token] = Stagehand.access_token
        HTTParty.get(Stagehand.config.resource_host + path, query: params).parsed_response
      end

      # Public: POSTs an authorized request
      #
      # path   - The path to POST to
      # params - The POST body (optional)
      #
      # Examples
      #
      #   post_with_stagehand_token("/login_links", params)
      #   # => "yXsVOBYv0XPLi4-nOTXcLQ"
      #
      # Returns the body of the response
      def post_with_access_token(path, params = {})
        params[:oauth_token] = Stagehand.access_token
        url = Stagehand.config.resource_host + path
        HTTParty.post(url, body: params, headers: { 'Accept' => 'application/json' }).parsed_response
      end

      # Public: PUTs an authorized request
      #
      # path   - The path
      # params - The POST params (optional)
      #
      # Examples
      #
      #   put_with_access_token("/people/1", params)
      #   # => "{'message':'success'}"
      #
      # Returns a JSON object
      def put_with_access_token(path, params = {})
        params[:oauth_token] = Stagehand.access_token
        HTTParty.put(Stagehand.config.resource_host + path, body: params).parsed_response
      end

    end
  end
end
