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

      # Public: Updates a person's info
      #
      # id      - The person's id
      # attrs   - The hash of attributes to be updated.
      #
      # Examples
      #
      #   create_by_email("4e691653fc595d0001000002", attrs)
      #   # => "{\"id\":\"4e691653fc595d0001000002\"}"
      #
      # Returns a person JSON object
      def update_info(id, attrs)
        put_with_access_token("/people/#{id}", attrs)
      end
    end
  end
end
