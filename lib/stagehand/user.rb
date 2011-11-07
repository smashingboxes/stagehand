require 'active_model'

module Stagehand
  class Account < ActiveModel
    include ActiveModel::Validations

    validates_presence_of :username, :email

    attr_accessor :username, :email
    def initialize(username, email)
      @username, @email = username, email
      @account ||= Stagehand.get_with_access_token("/profile.json", { page: 1 }).parsed_response
    end
  end
end
