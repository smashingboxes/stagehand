Stagehand
=========

Stagehand is a client-side library for manipulating RESTful resources provided by Personas, a Rails + Backbone user managment service.

Usage
=====

    YourApp::Application.configure do           
      config.stagehand.client_id = 'YOUR_APP_CLIENT_ID'
      config.stagehand.client_secret = 'YOUR_APP_CLIENT_SECRET'
      config.stagehand.resource_host = 'YOUR_APP_RESOURCE_HOST'
      config.stagehand.client_host = 'YOUR_APP_HOST_WITH_PORT'
    end                          
    
    class SessionsController < ApplicationController
      # stagehand.authorize_url is an OAuth 2.0 url created by the 
      # configuration variables above. After the user is authenticated
      # and grants the client app access, the resource host performs
      # a callback setting the session[:access_token] and redirects
      # to the client app's root_url.
      def new  
        redirect_to Stagehand.authorize_url
      end  
      
      # Destroy the access_token (but leave the OAuth host cookie intact)  
      def destroy
        session[:access_token] = nil
        redirect_to root_url, :notice => "Logged out!"
      end
    end
