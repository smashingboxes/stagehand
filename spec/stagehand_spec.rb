require 'spec_helper'

RSpec.configure do |c|
  c.before(:each) do
    Stagehand.configure do |config|
      config.client_id = 'test_app'
      config.client_secret = 'abcdef123456'
      config.resource_host = 'http://0.0.0.0:3000'
      config.client_host = 'http://0.0.0.0:4000'
    end
  end
end

describe Stagehand do
  describe "initialization" do
    it "can create an OAuth 2.0 authorize url" do
      Stagehand.authorize_url.should == "http://0.0.0.0:3000/oauth/authorize?client_id=test_app&client_secret=abcdef123456&redirect_uri=http://0.0.0.0:4000/callback"
    end
  end

  describe "url helpers" do
    it "can get the access token url" do
      Stagehand.access_token_url.should == "http://0.0.0.0:3000/oauth/access_token"
    end

    it "can get the redirect uri" do
      Stagehand.redirect_uri.should == "http://0.0.0.0:4000/callback"
    end

    it "can get the logout url" do
      Stagehand.logout_url.should == "http://0.0.0.0:3000/logout?redirect_uri=http://0.0.0.0:4000"
    end

    it "can get the access token" do
      Stagehand.access_token == session[:access_token]
    end
  end

  describe "current user" do
    it "can see his profile" do
      Stagehand.profile == { username: "Test" }
    end
  end
end
