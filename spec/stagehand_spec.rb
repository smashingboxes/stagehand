require 'spec_helper'

describe Stagehand do
  describe "initialization" do
    it "creates an OAuth 2.0 authorize url" do
      Stagehand::Client.new(
                  { client_id: 'test_app',
                    client_secret: 'abcdef123456',
                    resource_host: 'http://0.0.0.0:3000',
                    client_host: 'http://0.0.0.0:4000' }
                    ).authorize_url.should == "http://0.0.0.0:3000/oauth/authorize?client_id=test_app&client_secret=abcdef123456&redirect_uri=http://0.0.0.0:4000/callback"
    end
  end
end
