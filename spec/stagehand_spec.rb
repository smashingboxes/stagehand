require 'spec_helper'

describe Stagehand do
  describe "initialization" do
    it "creates an OAuth 2.0 authorize url" do
      Stagehand.configure do |config|
        config.client_id = 'test_app'
        config.client_secret = 'abcdef123456'
        config.resource_host = 'http://0.0.0.0:3000'
        config.client_host = 'http://0.0.0.0:4000'
      end
      Stagehand.authorize_url.should == "http://0.0.0.0:3000/oauth/authorize?client_id=test_app&client_secret=abcdef123456&redirect_uri=http://0.0.0.0:4000/callback"
    end
  end
end
