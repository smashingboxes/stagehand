Stagehand
=========

Stagehand is a client-side library for manipulating RESTful resources provided by Personas, a Rails + Backbone user managment service.

Usage
=====

    stagehand = Stagehand.new(
      :client_id = 'YOUR_APP_CLIENT_ID',
      :client_secret = 'YOUR_APP_CLIENT_SECRET',
      :resource_host = 'YOUR_APP_RESOURCE_HOST'
    )
    
    class SessionsController < ApplicationController
      # stagehand.authorize_url is an OAuth 2.0 url created by the 
      # configuration variables above. After the user is authenticated
      # and grants the client app access, the resource host performs
      # a callback setting the session[:access_token] and redirects
      # to the client app's root_url.
      def new  
        redirect_to stagehand.authorize_url
      end  
      
      # Destroy the access_token (but leave the OAuth host cookie intact)  
      def destroy
        session[:access_token] = nil
        redirect_to root_url, :notice => "Logged out!"
      end
    end
