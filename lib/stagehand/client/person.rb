module Stagehand
  class Client
    # Methods for people
    module Person
      # Public: Finds a person by email address
      #
      # email   - The person's email address
      #
      # Examples
      #
      #   find_by_email("test@example.com")
      #   # => "{\"id\":\"4e691653fc595d0001000002\",\"account_id\"
      #      :\"4ede1caf9a811123ca000001\"}"
      #
      # Returns a person JSON object
      def find_by_email(email)
        get_with_access_token("/people/find_by_email/#{email}")
      end

      # Public: Creates a person with an email address
      #
      # email   - The person's email address
      #
      # Examples
      #
      #   create_by_email("test@example.com")
      #   # => "{\"id\":\"4e691653fc595d0001000002\"}"
      #
      # Returns a person JSON object
      def create_by_email(email)
        post_with_access_token("/people", { "person" => { "email" => email } })
      end
    end
  end
end
